import React from 'react';
import styles from './index.less';
export default function index({ content }) {
  return (
    <div>
      <div className={styles.button}>
        <div className={styles.buttonLeft}></div>
        <div className={styles.buttonMiddle}>
          <div>{content}</div>
        </div>
        <div className={styles.buttonRight}></div>
      </div>  
    </div>
  );
}
