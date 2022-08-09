import { history } from 'umi'

import styles from './index.less';
import {Button} from "antd"
import {createGame} from '../../../../flow/transactions'



const jump = () => {
  history.push({
    pathname: '/edit-page'
  })
}
export default function IndexPage() {
  return (
    <div>
      <h1 className={styles.title}>B端</h1>
      <p className=' text-2xl text-red-500'>测试tailwindcss</p>
      <Button type="primary" onClick={jump}>测试antd</Button>
      <Button type="primary" onClick={createGame}>测试交易</Button>
    </div>
  );
}
