'use strict'

import React, {PureComponent} from 'react'
import ConnectionSelectorContainer from './ConnectionSelectorContainer'
import DatabaseContainer from './DatabaseContainer'
import Modal from './Modal'
import {CSSTransition, TransitionGroup} from 'react-transition-group'

class InstanceContent extends PureComponent {
  constructor() {
    super()
    this.state = {}
  }

  componentDidMount() {
    window.showModal = modal => {
      this.activeElement = document.activeElement
      this.setState({modal})

      return new Promise((resolve, reject) => {
        this.promise = {resolve, reject}
      })
    }
  }

  modalSubmit(result) {
    this.promise.resolve(result)
    this.setState({modal: null})
    if (this.activeElement) {
      this.activeElement.focus()
    }
  }

  modalCancel() {
    this.promise.reject()
    this.setState({modal: null})
    if (this.activeElement) {
      this.activeElement.focus()
    }
  }

  componentWillUnmount() {
    delete window.showModal
  }

  render() {
    const {instances, activeInstanceKey} = this.props
    const contents = instances.map(instance => (
      <div
        key={instance.get('key')}
        style={{display: instance.get('key') === activeInstanceKey ? 'block' : 'none'}}
        >
        {
        instance.get('redis')
          ? <DatabaseContainer instance={instance}/>
          : <ConnectionSelectorContainer instance={instance}/>
      }
      </div>
    ))

    return (
      <div className="main">
        <TransitionGroup component={null}>
          {
          this.state.modal &&
          <CSSTransition
            key="modal"
            classNames="modal"
            timeout={{enter: 150, exit: 150}}
            >
            <Modal
              {...this.state.modal}
              onSubmit={this.modalSubmit.bind(this)}
              onCancel={this.modalCancel.bind(this)}
              />
          </CSSTransition>
        }
        </TransitionGroup>
        {contents}
      </div>
    )
  }
}

export default InstanceContent
