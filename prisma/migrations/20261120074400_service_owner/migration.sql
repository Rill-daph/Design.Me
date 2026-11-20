-- AlterTable
ALTER TABLE `services`
    ADD COLUMN `pemilikId` INTEGER NULL;

-- CreateIndex
CREATE INDEX `services_pemilikId_idx` ON `services`(`pemilikId`);

-- AddForeignKey
ALTER TABLE `services`
    ADD CONSTRAINT `services_pemilikId_fkey`
    FOREIGN KEY (`pemilikId`) REFERENCES `users`(`id`)
    ON DELETE SET NULL ON UPDATE CASCADE;
