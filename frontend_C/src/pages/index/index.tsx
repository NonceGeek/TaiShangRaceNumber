import styles from './index.less';
import { Button } from "antd";
export default function IndexPage() {
  return (
    <div>
      <h1 className={styles.title}>C端</h1>
      <p className=' text-red-500 text-4xl'>测试tailwindcss</p>
      <Button type='primary'>测试antd</Button>
    </div>
  );
}
