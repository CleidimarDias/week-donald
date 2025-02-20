/*
  Warnings:

  - You are about to drop the column `restauranteId` on the `MenuCategory` table. All the data in the column will be lost.
  - You are about to drop the column `restauranteId` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the `Restaurante` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `restaurantId` to the `MenuCategory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Changed the type of `consumptionMethod` on the `Order` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Added the required column `restaurantId` to the `Product` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "ConsumptionMethod" AS ENUM ('TAKEAWAY', 'DINE_IN');

-- DropForeignKey
ALTER TABLE "MenuCategory" DROP CONSTRAINT "MenuCategory_restauranteId_fkey";

-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_restaurantId_fkey";

-- DropForeignKey
ALTER TABLE "Product" DROP CONSTRAINT "Product_restauranteId_fkey";

-- AlterTable
ALTER TABLE "MenuCategory" DROP COLUMN "restauranteId",
ADD COLUMN     "restaurantId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Order" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
DROP COLUMN "consumptionMethod",
ADD COLUMN     "consumptionMethod" "ConsumptionMethod" NOT NULL;

-- AlterTable
ALTER TABLE "Product" DROP COLUMN "restauranteId",
ADD COLUMN     "restaurantId" TEXT NOT NULL;

-- DropTable
DROP TABLE "Restaurante";

-- DropEnum
DROP TYPE "ComsunptiomMethod";

-- CreateTable
CREATE TABLE "Restaurant" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "avatarImageUrl" TEXT NOT NULL,
    "coverImageUrl" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Restaurant_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "MenuCategory" ADD CONSTRAINT "MenuCategory_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "Restaurant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "Restaurant"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "Restaurant"("id") ON DELETE CASCADE ON UPDATE CASCADE;
