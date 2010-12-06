Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 07:38:51 +0100 (CET)
Received: from mail-gw0-f41.google.com ([74.125.83.41]:51686 "EHLO
        mail-gw0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491080Ab0LFGiq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Dec 2010 07:38:46 +0100
Received: by gwj22 with SMTP id 22so4071562gwj.28
        for <multiple recipients>; Sun, 05 Dec 2010 22:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=oqfhufoZ44rYAE7c4I8EjKtqJ282+eUpilaiFc/z6uw=;
        b=r49B/mUc1cc74Fj994nhIiMgGQkmHjv0ON0bv2KMLZMdyZ7zRGl/kF3zyFYZEzR/sS
         Yhz0VHRpkoQ3j+sZ+WaktfEn8csx4FJ7M94lxBf1U/ZBKcVnX/A9jicYevJ+js1o+qU1
         x07pSCNinkV3BvvRrd1yEkv12+qK1GtQUMikM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=v3z/XSuRMiS4IKPie0gtAR0rPau6fVOhP3EuWrtFi2Nj74gCsckU3NDXogFzS16yO1
         7naG6vukSahlJ/J5KvUKi9icii4oXmMXB5Y3Y2bOjv+ZxvMj3/bomRs0d8Cb0bzct6EE
         WP8P4fpRhT70nX0ja+SRuxKSXwDRWglYf039o=
Received: by 10.151.41.17 with SMTP id t17mr8657175ybj.373.1291617518134;
        Sun, 05 Dec 2010 22:38:38 -0800 (PST)
Received: from localhost (cpe-065-190-173-137.nc.res.rr.com [65.190.173.137])
        by mx.google.com with ESMTPS id f2sm1425754ybh.5.2010.12.05.22.38.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 22:38:37 -0800 (PST)
From:   Matt Turner <mattst88@gmail.com>
To:     Jean Delvare <khali@linux-fr.org>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH] I2C: SiByte: Convert the driver to make use of interrupts
Date:   Mon,  6 Dec 2010 01:38:14 -0500
Message-Id: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.2.2
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

From: Maciej W. Rozycki <macro@linux-mips.org>

This is a rewrite of large parts of the driver mainly so that it uses
SMBus interrupts to offload the CPU from busy-waiting on status inputs.
As a part of the overhaul of the init and exit calls, all accesses to the
hardware got converted to use accessory functions via an ioremap() cookie.

Minimally rebased by Matt Turner.

Tested-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
This patch was originally sent in May 2008 [1], but appears to have been lost.

I believe this patch depends on
[PATCH 1/3] RTC: SMBus support for the M41T80, etc. driver

Please review the change in return values (search for ENXIO). I wasn't entirely
sure how this code should look. (The code the original patch was against just
returned -1 on error. See 102b59c6d6d30fb6560177fd1ae8a34c4c163897). Please
apply if acceptable.

[1] http://lists.lm-sensors.org/pipermail/i2c/2008-May/003638.html

 drivers/i2c/busses/i2c-sibyte.c |  278 +++++++++++++++++++++++++++++----------
 1 files changed, 208 insertions(+), 70 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-sibyte.c
index 0fe505d..283747c 100644
--- a/drivers/i2c/busses/i2c-sibyte.c
+++ b/drivers/i2c/busses/i2c-sibyte.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2004 Steven J. Hill
  * Copyright (C) 2001,2002,2003 Broadcom Corporation
  * Copyright (C) 1995-2000 Simon G. Vogl
+ * Copyright (C) 2008 Maciej W. Rozycki
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -18,104 +19,159 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 
+#include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/param.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/wait.h>
 #include <linux/io.h>
+#include <asm/sibyte/sb1250_int.h>
 #include <asm/sibyte/sb1250_regs.h>
 #include <asm/sibyte/sb1250_smbus.h>
 
 
 struct i2c_algo_sibyte_data {
-	void *data;		/* private data */
-	int   bus;		/* which bus */
-	void *reg_base;		/* CSR base */
+	wait_queue_head_t	wait;		/* IRQ queue */
+	void __iomem		*csr;		/* mapped CSR handle */
+	phys_t			base;		/* physical CSR base */
+	char			*name;		/* IRQ handler name */
+	spinlock_t		lock;		/* atomiser */
+	int			irq;		/* IRQ line */
+	int			status;		/* IRQ status */
 };
 
-/* ----- global defines ----------------------------------------------- */
-#define SMB_CSR(a,r) ((long)(a->reg_base + r))
 
+static irqreturn_t i2c_sibyte_interrupt(int irq, void *dev_id)
+{
+	struct i2c_adapter *i2c_adap = dev_id;
+	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
+	void __iomem *csr = adap->csr;
+	u8 status;
+
+	/*
+	 * Ugh, no way to detect the finish interrupt,
+	 * but if busy it is obviously not one.
+	 */
+	status = __raw_readq(csr + R_SMB_STATUS);
+	if ((status & (M_SMB_ERROR | M_SMB_BUSY)) == M_SMB_BUSY)
+		return IRQ_NONE;
 
-static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
-		      unsigned short flags, char read_write,
-		      u8 command, int size, union i2c_smbus_data * data)
+	/*
+	 * Clear the error interrupt (write 1 to clear);
+	 * the finish interrupt was cleared by the read above.
+	 */
+	__raw_writeq(status, csr + R_SMB_STATUS);
+
+	/* Post the status. */
+	spin_lock_irq(&adap->lock);
+	adap->status = status & (M_SMB_ERROR_TYPE | M_SMB_ERROR | M_SMB_BUSY);
+	wake_up(&adap->wait);
+	spin_unlock_irq(&adap->lock);
+
+	return IRQ_HANDLED;
+}
+
+static s32 i2c_sibyte_smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
+				 unsigned short cflags,
+				 char read_write, u8 command, int size,
+				 union i2c_smbus_data *data)
 {
 	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
+	void __iomem *csr = adap->csr;
+	unsigned long flags;
 	int data_bytes = 0;
 	int error;
 
-	while (csr_in32(SMB_CSR(adap, R_SMB_STATUS)) & M_SMB_BUSY)
-		;
+	spin_lock_irqsave(&adap->lock, flags);
+
+	if (adap->status < 0) {
+		error = -EIO;
+		goto out_unlock;
+	}
 
 	switch (size) {
 	case I2C_SMBUS_QUICK:
-		csr_out32((V_SMB_ADDR(addr) |
-			   (read_write == I2C_SMBUS_READ ? M_SMB_QDATA : 0) |
-			   V_SMB_TT_QUICKCMD), SMB_CSR(adap, R_SMB_START));
+		__raw_writeq(V_SMB_ADDR(addr) |
+			     (read_write == I2C_SMBUS_READ ? M_SMB_QDATA : 0) |
+			     V_SMB_TT_QUICKCMD,
+			     csr + R_SMB_START);
 		break;
 	case I2C_SMBUS_BYTE:
 		if (read_write == I2C_SMBUS_READ) {
-			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_RD1BYTE),
-				  SMB_CSR(adap, R_SMB_START));
+			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_RD1BYTE,
+				     csr + R_SMB_START);
 			data_bytes = 1;
 		} else {
-			csr_out32(V_SMB_CMD(command), SMB_CSR(adap, R_SMB_CMD));
-			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR1BYTE),
-				  SMB_CSR(adap, R_SMB_START));
+			__raw_writeq(V_SMB_CMD(command), csr + R_SMB_CMD);
+			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_WR1BYTE,
+				     csr + R_SMB_START);
 		}
 		break;
 	case I2C_SMBUS_BYTE_DATA:
-		csr_out32(V_SMB_CMD(command), SMB_CSR(adap, R_SMB_CMD));
+		__raw_writeq(V_SMB_CMD(command), csr + R_SMB_CMD);
 		if (read_write == I2C_SMBUS_READ) {
-			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD1BYTE),
-				  SMB_CSR(adap, R_SMB_START));
+			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD1BYTE,
+				     csr + R_SMB_START);
 			data_bytes = 1;
 		} else {
-			csr_out32(V_SMB_LB(data->byte),
-				  SMB_CSR(adap, R_SMB_DATA));
-			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE),
-				  SMB_CSR(adap, R_SMB_START));
+			__raw_writeq(V_SMB_LB(data->byte), csr + R_SMB_DATA);
+			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE,
+				     csr + R_SMB_START);
 		}
 		break;
 	case I2C_SMBUS_WORD_DATA:
-		csr_out32(V_SMB_CMD(command), SMB_CSR(adap, R_SMB_CMD));
+		__raw_writeq(V_SMB_CMD(command), csr + R_SMB_CMD);
 		if (read_write == I2C_SMBUS_READ) {
-			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD2BYTE),
-				  SMB_CSR(adap, R_SMB_START));
+			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD2BYTE,
+				     csr + R_SMB_START);
 			data_bytes = 2;
 		} else {
-			csr_out32(V_SMB_LB(data->word & 0xff),
-				  SMB_CSR(adap, R_SMB_DATA));
-			csr_out32(V_SMB_MB(data->word >> 8),
-				  SMB_CSR(adap, R_SMB_DATA));
-			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE),
-				  SMB_CSR(adap, R_SMB_START));
+			__raw_writeq(V_SMB_LB(data->word & 0xff),
+				     csr + R_SMB_DATA);
+			__raw_writeq(V_SMB_MB(data->word >> 8),
+				     csr + R_SMB_DATA);
+			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE,
+				     csr + R_SMB_START);
 		}
 		break;
 	default:
-		return -EOPNOTSUPP;
+		error = -EOPNOTSUPP;
+		goto out_unlock;
 	}
+	mmiowb();
+	__raw_readq(csr + R_SMB_START);
+	adap->status = -1;
+
+	spin_unlock_irqrestore(&adap->lock, flags);
+
+	wait_event_timeout(adap->wait, (adap->status >= 0), HZ);
 
-	while (csr_in32(SMB_CSR(adap, R_SMB_STATUS)) & M_SMB_BUSY)
-		;
+	spin_lock_irqsave(&adap->lock, flags);
 
-	error = csr_in32(SMB_CSR(adap, R_SMB_STATUS));
-	if (error & M_SMB_ERROR) {
-		/* Clear error bit by writing a 1 */
-		csr_out32(M_SMB_ERROR, SMB_CSR(adap, R_SMB_STATUS));
-		return (error & M_SMB_ERROR_TYPE) ? -EIO : -ENXIO;
+	if (adap->status < 0 || (adap->status & (M_SMB_ERROR | M_SMB_BUSY))) {
+		error = -EIO;
+		goto out_unlock;
 	}
 
 	if (data_bytes == 1)
-		data->byte = csr_in32(SMB_CSR(adap, R_SMB_DATA)) & 0xff;
+		data->byte = __raw_readq(csr + R_SMB_DATA) & 0xff;
 	if (data_bytes == 2)
-		data->word = csr_in32(SMB_CSR(adap, R_SMB_DATA)) & 0xffff;
+		data->word = __raw_readq(csr + R_SMB_DATA) & 0xffff;
 
-	return 0;
+	error = 0;
+
+out_unlock:
+	spin_unlock_irqrestore(&adap->lock, flags);
+
+	return error;
 }
 
-static u32 bit_func(struct i2c_adapter *adap)
+static u32 i2c_sibyte_bit_func(struct i2c_adapter *adap)
 {
 	return (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA);
@@ -125,8 +181,8 @@ static u32 bit_func(struct i2c_adapter *adap)
 /* -----exported algorithm data: -------------------------------------	*/
 
 static const struct i2c_algorithm i2c_sibyte_algo = {
-	.smbus_xfer	= smbus_xfer,
-	.functionality	= bit_func,
+	.smbus_xfer	= i2c_sibyte_smbus_xfer,
+	.functionality	= i2c_sibyte_bit_func,
 };
 
 /*
@@ -135,37 +191,108 @@ static const struct i2c_algorithm i2c_sibyte_algo = {
 static int __init i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
 {
 	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
+	void __iomem *csr;
+	int err;
 
-	/* Register new adapter to i2c module... */
-	i2c_adap->algo = &i2c_sibyte_algo;
+	adap->status = 0;
+	init_waitqueue_head(&adap->wait);
+	spin_lock_init(&adap->lock);
+
+	csr = ioremap(adap->base, R_SMB_PEC + SMB_REGISTER_SPACING);
+	if (!csr) {
+		err = -ENOMEM;
+		goto out;
+	}
+	adap->csr = csr;
 
 	/* Set the requested frequency. */
-	csr_out32(speed, SMB_CSR(adap,R_SMB_FREQ));
-	csr_out32(0, SMB_CSR(adap,R_SMB_CONTROL));
+	__raw_writeq(speed, csr + R_SMB_FREQ);
+
+	/* Clear any pending error interrupt. */
+	__raw_writeq(__raw_readq(csr + R_SMB_STATUS), csr + R_SMB_STATUS);
+	/* Disable interrupts. */
+	__raw_writeq(0, csr + R_SMB_CONTROL);
+	mmiowb();
+	__raw_readq(csr + R_SMB_CONTROL);
+
+	err = request_irq(adap->irq, i2c_sibyte_interrupt, IRQF_SHARED,
+			  adap->name, i2c_adap);
+	if (err < 0)
+		goto out_unmap;
+
+	/* Enable finish and error interrupts. */
+	__raw_writeq(M_SMB_FINISH_INTR | M_SMB_ERR_INTR, csr + R_SMB_CONTROL);
+
+	/* Register new adapter to i2c module... */
+	err = i2c_add_numbered_adapter(i2c_adap);
+	if (err < 0)
+		goto out_unirq;
 
-	return i2c_add_numbered_adapter(i2c_adap);
+	return 0;
+
+out_unirq:
+	/* Disable interrupts. */
+	__raw_writeq(0, csr + R_SMB_CONTROL);
+	mmiowb();
+	__raw_readq(csr + R_SMB_CONTROL);
+
+	free_irq(adap->irq, i2c_adap);
+
+	/* Clear any pending error interrupt. */
+	__raw_writeq(__raw_readq(csr + R_SMB_STATUS), csr + R_SMB_STATUS);
+out_unmap:
+	iounmap(csr);
+out:
+	return err;
 }
 
+static void i2c_sibyte_remove_bus(struct i2c_adapter *i2c_adap)
+{
+	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
+	void __iomem *csr = adap->csr;
+
+	i2c_del_adapter(i2c_adap);
+
+	/* Disable interrupts. */
+	__raw_writeq(0, csr + R_SMB_CONTROL);
+	mmiowb();
+	__raw_readq(csr + R_SMB_CONTROL);
+
+	free_irq(adap->irq, i2c_adap);
+
+	/* Clear any pending error interrupt. */
+	__raw_writeq(__raw_readq(csr + R_SMB_STATUS), csr + R_SMB_STATUS);
+
+	iounmap(csr);
+}
 
-static struct i2c_algo_sibyte_data sibyte_board_data[2] = {
-	{ NULL, 0, (void *) (CKSEG1+A_SMB_BASE(0)) },
-	{ NULL, 1, (void *) (CKSEG1+A_SMB_BASE(1)) }
+static struct i2c_algo_sibyte_data i2c_sibyte_board_data[2] = {
+	{
+		.name	= "sb1250-smbus-0",
+		.base	= A_SMB_0,
+		.irq	= K_INT_SMB_0,
+	},
+	{
+		.name	= "sb1250-smbus-1",
+		.base	= A_SMB_1,
+		.irq	= K_INT_SMB_1,
+	}
 };
 
-static struct i2c_adapter sibyte_board_adapter[2] = {
+static struct i2c_adapter i2c_sibyte_board_adapter[2] = {
 	{
 		.owner		= THIS_MODULE,
 		.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
-		.algo		= NULL,
-		.algo_data	= &sibyte_board_data[0],
+		.algo		= &i2c_sibyte_algo,
+		.algo_data	= &i2c_sibyte_board_data[0],
 		.nr		= 0,
 		.name		= "SiByte SMBus 0",
 	},
 	{
 		.owner		= THIS_MODULE,
 		.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
-		.algo		= NULL,
-		.algo_data	= &sibyte_board_data[1],
+		.algo		= &i2c_sibyte_algo,
+		.algo_data	= &i2c_sibyte_board_data[1],
 		.nr		= 1,
 		.name		= "SiByte SMBus 1",
 	},
@@ -173,21 +300,32 @@ static struct i2c_adapter sibyte_board_adapter[2] = {
 
 static int __init i2c_sibyte_init(void)
 {
+	int err;
+
 	pr_info("i2c-sibyte: i2c SMBus adapter module for SiByte board\n");
-	if (i2c_sibyte_add_bus(&sibyte_board_adapter[0], K_SMB_FREQ_100KHZ) < 0)
-		return -ENODEV;
-	if (i2c_sibyte_add_bus(&sibyte_board_adapter[1],
-			       K_SMB_FREQ_400KHZ) < 0) {
-		i2c_del_adapter(&sibyte_board_adapter[0]);
-		return -ENODEV;
-	}
+
+	err = i2c_sibyte_add_bus(&i2c_sibyte_board_adapter[0],
+				 K_SMB_FREQ_100KHZ);
+	if (err < 0)
+		goto out;
+
+	err = i2c_sibyte_add_bus(&i2c_sibyte_board_adapter[1],
+				 K_SMB_FREQ_400KHZ);
+	if (err < 0)
+		goto out_remove;
+
 	return 0;
+
+out_remove:
+	i2c_sibyte_remove_bus(&i2c_sibyte_board_adapter[0]);
+out:
+	return err;
 }
 
 static void __exit i2c_sibyte_exit(void)
 {
-	i2c_del_adapter(&sibyte_board_adapter[0]);
-	i2c_del_adapter(&sibyte_board_adapter[1]);
+	i2c_sibyte_remove_bus(&i2c_sibyte_board_adapter[1]);
+	i2c_sibyte_remove_bus(&i2c_sibyte_board_adapter[0]);
 }
 
 module_init(i2c_sibyte_init);
-- 
1.7.2.2
