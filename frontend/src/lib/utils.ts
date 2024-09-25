import { clsx, ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"
 
export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export const apiPath = "https://21bakowg31.execute-api.us-east-1.amazonaws.com"
export const plantsPath = `${apiPath}/plants`

// const plantData = [
  // { 
  //   id: 1, 
  //   name: "Ficus", 
  //   image: "/placeholder.svg?height=100&width=100", 
  //   wateringFrequency: 7, 

  //   lastWatered: new Date(2023, 5, 15),
  //   wateringHistory: [
  //     new Date(2023, 5, 15),
  //     new Date(2023, 5, 8),
  //     new Date(2023, 5, 1),
  //     new Date(2023, 4, 24),
  //   ]
  // },
//   { 
//     id: 2, 
//     name: "Cactus", 
//     image: "/placeholder.svg?height=100&width=100", 
//     wateringFrequency: 14, 
//     lastWatered: new Date(2023, 5, 10),
//     wateringHistory: [
//       new Date(2023, 5, 10),
//       new Date(2023, 4, 27),
//       new Date(2023, 4, 13),
//     ]
//   },
//   { 
//     id: 3, 
//     name: "Orquídea", 
//     image: "/placeholder.svg?height=100&width=100", 
//     wateringFrequency: 3, 
//     lastWatered: new Date(2023, 5, 14),
//     wateringHistory: [
//       new Date(2023, 5, 14),
//       new Date(2023, 5, 11),
//       new Date(2023, 5, 8),
//       new Date(2023, 5, 5),
//       new Date(2023, 5, 2),
//     ]
//   },
// ]