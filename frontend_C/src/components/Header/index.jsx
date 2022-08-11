import React from 'react'
import { history } from 'umi'

import styles from "./index.less"

import logo from "@/assets/images/logo.png"


export default function index() {
  return (
    <div>
        <div onClick={() => history.push({ pathname: '/' })} className={styles.header}>
          <img src={logo} alt="" />
        </div>
    </div>
  )
}
