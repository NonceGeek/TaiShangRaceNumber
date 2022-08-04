import React from 'react';
import styles from "./index.less"
import Button from "@/components/Button";
export default function () {
  return (
    <div>
      <div className={styles.title}>RaceNumber Marathon</div>
      <div className={styles.time}>
        <div className={styles.days}>
          <p>52</p>
          <span>days</span>
        </div>
        <div className={styles.hours}>
          <p>23</p>
          <span>hours</span>
        </div>
        <div className={styles.mins}>
          <p>41</p>
          <span>mins</span>
        </div>
      </div>
      <div className={styles.text}>
        1month left before deadline of registration
      </div>
      <div className={styles.button}>
        <Button content="Sign up"></Button>
      </div>
    </div>
  );
}
