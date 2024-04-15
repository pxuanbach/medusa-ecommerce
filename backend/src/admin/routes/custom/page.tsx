import { RouteConfig } from "@medusajs/admin"
// import { CustomIcon } from "../../icons/custom"

const CustomPage = () => {
  return (
    <div>
      This is my custom route
    </div>
  )
}

export const config: RouteConfig = {
  link: {
    label: "Custom Route",
    // icon: CustomIcon,
  },
}

export default CustomPage