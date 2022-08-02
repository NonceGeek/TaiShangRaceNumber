import './index.less'
import React from 'react';

export default class CustomTitle extends React.Component<any>{

    constructor(props: any) {
      super(props);
    }
    render() {
      return (
        <div className='title'>
          <div className='first fontProperty'>{this.props.title}</div>
        </div>
      )
    }
  }