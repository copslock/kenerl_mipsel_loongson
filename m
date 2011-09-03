Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2011 10:31:01 +0200 (CEST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:10951 "EHLO
        services.gcu-squad.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491103Ab1ICIa4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Sep 2011 10:30:56 +0200
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
        by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1QzmnN-0004T2-Rb
        (TLSv1:AES128-SHA:128)
        (envelope-from <khali@linux-fr.org>)
        ; Sat, 03 Sep 2011 11:45:50 +0200
Date:   Sat, 3 Sep 2011 10:30:36 +0200
From:   Jean Delvare <khali@linux-fr.org>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Message-ID: <20110903103036.161616a5@endymion.delvare>
In-Reply-To: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 31035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Matt,

On Thu, 18 Aug 2011 19:43:11 -0400, Matt Turner wrote:
> From: Maciej W. Rozycki <macro@linux-mips.org>
> 
> This is a rewrite of large parts of the driver mainly so that it uses
> SMBus interrupts to offload the CPU from busy-waiting on status inputs.
> As a part of the overhaul of the init and exit calls, all accesses to the
> hardware got converted to use accessory functions via an ioremap() cookie.

This could have been split into incremental patches, to make review
easier.

> [mattst88] Added BCM1480 interrupts and rebased minimally.

Ditto.

checkpatch complains about this, please fix:

WARNING: line over 80 characters
#257: FILE: drivers/i2c/busses/i2c-sibyte.c:157:
+	if (adap->status > 0 && ((adap->status & (M_SMB_ERROR | M_SMB_ERROR_TYPE)) == M_SMB_ERROR)) {

Very nice patch overall, I only have minor comments, see below inline.

> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> This is the second version of this patch that I've sent. This version
> fixes the problem with the ENXIO return.
> 
>  drivers/i2c/busses/i2c-sibyte.c |  296 +++++++++++++++++++++++++++++---------
>  1 files changed, 226 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sibyte.c b/drivers/i2c/busses/i2c-sibyte.c
> index 0fe505d..d2f1cf1 100644
> --- a/drivers/i2c/busses/i2c-sibyte.c
> +++ b/drivers/i2c/busses/i2c-sibyte.c
> @@ -2,6 +2,7 @@
>   * Copyright (C) 2004 Steven J. Hill
>   * Copyright (C) 2001,2002,2003 Broadcom Corporation
>   * Copyright (C) 1995-2000 Simon G. Vogl
> + * Copyright (C) 2008 Maciej W. Rozycki

Wow, looks like this patch has been sleeping for quite some time...

>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
> @@ -18,104 +19,164 @@
>   * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
>   */
>  
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/i2c.h>
> +#include <linux/param.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
>  #include <linux/io.h>
> +#include <asm/sibyte/sb1250_int.h>
>  #include <asm/sibyte/sb1250_regs.h>
>  #include <asm/sibyte/sb1250_smbus.h>
> +#include <asm/sibyte/bcm1480_int.h>
>  
>  
>  struct i2c_algo_sibyte_data {
> -	void *data;		/* private data */
> -	int   bus;		/* which bus */
> -	void *reg_base;		/* CSR base */
> +	wait_queue_head_t	wait;		/* IRQ queue */
> +	void __iomem		*csr;		/* mapped CSR handle */
> +	phys_t			base;		/* physical CSR base */
> +	char			*name;		/* IRQ handler name */

Should be a const pointer. Also, if the name is only for the IRQ, then
irq_name would be a better name.

> +	spinlock_t		lock;		/* atomiser */

A more useful comment would explain what exactly is being protected by
the lock.

> +	int			irq;		/* IRQ line */
> +	int			status;		/* IRQ status */

You could document than -1 means error.

>  };
>  
> -/* ----- global defines ----------------------------------------------- */
> -#define SMB_CSR(a,r) ((long)(a->reg_base + r))
>  
> +static irqreturn_t i2c_sibyte_interrupt(int irq, void *dev_id)
> +{
> +	struct i2c_adapter *i2c_adap = dev_id;
> +	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
> +	void __iomem *csr = adap->csr;
> +	u8 status;
> +
> +	/*
> +	 * Ugh, no way to detect the finish interrupt,
> +	 * but if busy it is obviously not one.
> +	 */
> +	status = __raw_readq(csr + R_SMB_STATUS);
> +	if ((status & (M_SMB_ERROR | M_SMB_BUSY)) == M_SMB_BUSY)
> +		return IRQ_NONE;
> +
> +	/*
> +	 * Clear the error interrupt (write 1 to clear);
> +	 * the finish interrupt was cleared by the read above.
> +	 */
> +	__raw_writeq(status, csr + R_SMB_STATUS);
> +
> +	/* Post the status. */
> +	spin_lock(&adap->lock);
> +	adap->status = status & (M_SMB_ERROR_TYPE | M_SMB_ERROR | M_SMB_BUSY);
> +	wake_up(&adap->wait);
> +	spin_unlock(&adap->lock);
> +
> +	return IRQ_HANDLED;
> +}
>  
> -static int smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
> -		      unsigned short flags, char read_write,
> -		      u8 command, int size, union i2c_smbus_data * data)
> +static s32 i2c_sibyte_smbus_xfer(struct i2c_adapter *i2c_adap, u16 addr,
> +				 unsigned short cflags,
> +				 char read_write, u8 command, int size,
> +				 union i2c_smbus_data *data)
>  {
>  	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
> +	void __iomem *csr = adap->csr;
> +	unsigned long flags;
>  	int data_bytes = 0;
>  	int error;
>  
> -	while (csr_in32(SMB_CSR(adap, R_SMB_STATUS)) & M_SMB_BUSY)
> -		;
> +	spin_lock_irqsave(&adap->lock, flags);
> +
> +	if (adap->status < 0) {
> +		error = -EIO;
> +		goto out_unlock;
> +	}

Well, this can only happen if the previous transaction ended up with a
failure, right? This means that a single error will break the SMBus
forever. Is there no way to reset the controller to a sane state if
this happens?

>  
>  	switch (size) {
>  	case I2C_SMBUS_QUICK:
> -		csr_out32((V_SMB_ADDR(addr) |
> -			   (read_write == I2C_SMBUS_READ ? M_SMB_QDATA : 0) |
> -			   V_SMB_TT_QUICKCMD), SMB_CSR(adap, R_SMB_START));
> +		__raw_writeq(V_SMB_ADDR(addr) |
> +			     (read_write == I2C_SMBUS_READ ? M_SMB_QDATA : 0) |
> +			     V_SMB_TT_QUICKCMD,
> +			     csr + R_SMB_START);
>  		break;
>  	case I2C_SMBUS_BYTE:
>  		if (read_write == I2C_SMBUS_READ) {
> -			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_RD1BYTE),
> -				  SMB_CSR(adap, R_SMB_START));
> +			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_RD1BYTE,
> +				     csr + R_SMB_START);
>  			data_bytes = 1;
>  		} else {
> -			csr_out32(V_SMB_CMD(command), SMB_CSR(adap, R_SMB_CMD));
> -			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR1BYTE),
> -				  SMB_CSR(adap, R_SMB_START));
> +			__raw_writeq(V_SMB_CMD(command), csr + R_SMB_CMD);
> +			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_WR1BYTE,
> +				     csr + R_SMB_START);
>  		}
>  		break;
>  	case I2C_SMBUS_BYTE_DATA:
> -		csr_out32(V_SMB_CMD(command), SMB_CSR(adap, R_SMB_CMD));
> +		__raw_writeq(V_SMB_CMD(command), csr + R_SMB_CMD);
>  		if (read_write == I2C_SMBUS_READ) {
> -			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD1BYTE),
> -				  SMB_CSR(adap, R_SMB_START));
> +			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD1BYTE,
> +				     csr + R_SMB_START);
>  			data_bytes = 1;
>  		} else {
> -			csr_out32(V_SMB_LB(data->byte),
> -				  SMB_CSR(adap, R_SMB_DATA));
> -			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE),
> -				  SMB_CSR(adap, R_SMB_START));
> +			__raw_writeq(V_SMB_LB(data->byte), csr + R_SMB_DATA);
> +			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE,
> +				     csr + R_SMB_START);
>  		}
>  		break;
>  	case I2C_SMBUS_WORD_DATA:
> -		csr_out32(V_SMB_CMD(command), SMB_CSR(adap, R_SMB_CMD));
> +		__raw_writeq(V_SMB_CMD(command), csr + R_SMB_CMD);
>  		if (read_write == I2C_SMBUS_READ) {
> -			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD2BYTE),
> -				  SMB_CSR(adap, R_SMB_START));
> +			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_CMD_RD2BYTE,
> +				     csr + R_SMB_START);
>  			data_bytes = 2;
>  		} else {
> -			csr_out32(V_SMB_LB(data->word & 0xff),
> -				  SMB_CSR(adap, R_SMB_DATA));
> -			csr_out32(V_SMB_MB(data->word >> 8),
> -				  SMB_CSR(adap, R_SMB_DATA));
> -			csr_out32((V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE),
> -				  SMB_CSR(adap, R_SMB_START));
> +			__raw_writeq(V_SMB_LB(data->word & 0xff),
> +				     csr + R_SMB_DATA);
> +			__raw_writeq(V_SMB_MB(data->word >> 8),
> +				     csr + R_SMB_DATA);
> +			__raw_writeq(V_SMB_ADDR(addr) | V_SMB_TT_WR2BYTE,
> +				     csr + R_SMB_START);
>  		}
>  		break;
>  	default:
> -		return -EOPNOTSUPP;
> +		error = -EOPNOTSUPP;
> +		goto out_unlock;
>  	}
> +	mmiowb();
> +	__raw_readq(csr + R_SMB_START);
> +	adap->status = -1;
> +
> +	spin_unlock_irqrestore(&adap->lock, flags);
>  
> -	while (csr_in32(SMB_CSR(adap, R_SMB_STATUS)) & M_SMB_BUSY)
> -		;
> +	wait_event_timeout(adap->wait, (adap->status >= 0), HZ);

1 second is a rather long timeout. The driver only supports small
transactions, so even if a slave slows down the clock, I can hardly
imagine a transaction lasting more that, say, 10 ms. So I think you can
safely lower the timeout to HZ / 5 or even HZ / 10.

Also, shouldn't you check the return value? This would let you return
the right error code (-ETIMEDOUT according to
Documentation/i2c/fault-codes) and you would no longer have to check
for adap->status sign in the rest of the function.

>  
> -	error = csr_in32(SMB_CSR(adap, R_SMB_STATUS));
> -	if (error & M_SMB_ERROR) {
> -		/* Clear error bit by writing a 1 */
> -		csr_out32(M_SMB_ERROR, SMB_CSR(adap, R_SMB_STATUS));
> -		return (error & M_SMB_ERROR_TYPE) ? -EIO : -ENXIO;
> +	spin_lock_irqsave(&adap->lock, flags);
> +
> +	if (adap->status > 0 && ((adap->status & (M_SMB_ERROR | M_SMB_ERROR_TYPE)) == M_SMB_ERROR)) {
> +		error = -ENXIO;
> +		goto out_unlock;
> +	}
> +	if (adap->status < 0 || (adap->status & (M_SMB_ERROR | M_SMB_BUSY))) {
> +		error = -EIO;
> +		goto out_unlock;
>  	}
>  
>  	if (data_bytes == 1)
> -		data->byte = csr_in32(SMB_CSR(adap, R_SMB_DATA)) & 0xff;
> +		data->byte = __raw_readq(csr + R_SMB_DATA) & 0xff;
>  	if (data_bytes == 2)
> -		data->word = csr_in32(SMB_CSR(adap, R_SMB_DATA)) & 0xffff;
> +		data->word = __raw_readq(csr + R_SMB_DATA) & 0xffff;
>  
> -	return 0;
> +	error = 0;
> +
> +out_unlock:
> +	spin_unlock_irqrestore(&adap->lock, flags);
> +
> +	return error;
>  }
>  
> -static u32 bit_func(struct i2c_adapter *adap)
> +static u32 i2c_sibyte_bit_func(struct i2c_adapter *adap)

If you're renaming this then please drop the "bit" part in it, it's
most likely coming from a copy-and-paste from i2c-algo-bit and has no
meaning in the sibyte driver.

>  {
>  	return (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
>  		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA);
> @@ -125,8 +186,8 @@ static u32 bit_func(struct i2c_adapter *adap)
>  /* -----exported algorithm data: -------------------------------------	*/
>  
>  static const struct i2c_algorithm i2c_sibyte_algo = {
> -	.smbus_xfer	= smbus_xfer,
> -	.functionality	= bit_func,
> +	.smbus_xfer	= i2c_sibyte_smbus_xfer,
> +	.functionality	= i2c_sibyte_bit_func,
>  };
>  
>  /*
> @@ -135,37 +196,121 @@ static const struct i2c_algorithm i2c_sibyte_algo = {
>  static int __init i2c_sibyte_add_bus(struct i2c_adapter *i2c_adap, int speed)
>  {
>  	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
> +	void __iomem *csr;
> +	int err;
>  
> -	/* Register new adapter to i2c module... */
> -	i2c_adap->algo = &i2c_sibyte_algo;
> +	adap->status = 0;
> +	init_waitqueue_head(&adap->wait);
> +	spin_lock_init(&adap->lock);
> +
> +	csr = ioremap(adap->base, R_SMB_PEC + SMB_REGISTER_SPACING);
> +	if (!csr) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	adap->csr = csr;
>  
>  	/* Set the requested frequency. */
> -	csr_out32(speed, SMB_CSR(adap,R_SMB_FREQ));
> -	csr_out32(0, SMB_CSR(adap,R_SMB_CONTROL));
> +	__raw_writeq(speed, csr + R_SMB_FREQ);
> +
> +	/* Clear any pending error interrupt. */
> +	__raw_writeq(__raw_readq(csr + R_SMB_STATUS), csr + R_SMB_STATUS);
> +	/* Disable interrupts. */
> +	__raw_writeq(0, csr + R_SMB_CONTROL);
> +	mmiowb();
> +	__raw_readq(csr + R_SMB_CONTROL);

Shouldn't it be the other way around, disable interrupts first and then
clear any pending one? Looks racy otherwise, but maybe it makes no
difference in practice.

> +
> +	err = request_irq(adap->irq, i2c_sibyte_interrupt, IRQF_SHARED,
> +			  adap->name, i2c_adap);
> +	if (err < 0)
> +		goto out_unmap;
> +
> +	/* Enable finish and error interrupts. */
> +	__raw_writeq(M_SMB_FINISH_INTR | M_SMB_ERR_INTR, csr + R_SMB_CONTROL);
> +
> +	/* Register new adapter to i2c module... */
> +	err = i2c_add_numbered_adapter(i2c_adap);
> +	if (err < 0)
> +		goto out_unirq;
> +
> +	return 0;
>  
> -	return i2c_add_numbered_adapter(i2c_adap);
> +out_unirq:
> +	/* Disable interrupts. */
> +	__raw_writeq(0, csr + R_SMB_CONTROL);
> +	mmiowb();
> +	__raw_readq(csr + R_SMB_CONTROL);
> +
> +	free_irq(adap->irq, i2c_adap);
> +
> +	/* Clear any pending error interrupt. */
> +	__raw_writeq(__raw_readq(csr + R_SMB_STATUS), csr + R_SMB_STATUS);

You may consider moving this block to a separate function, as it is
duplicated in the i2c_sibyte_remove_bus() function below.

> +out_unmap:
> +	iounmap(csr);
> +out:
> +	return err;
>  }
>  
> +static void i2c_sibyte_remove_bus(struct i2c_adapter *i2c_adap)
> +{
> +	struct i2c_algo_sibyte_data *adap = i2c_adap->algo_data;
> +	void __iomem *csr = adap->csr;
> +
> +	i2c_del_adapter(i2c_adap);
> +
> +	/* Disable interrupts. */
> +	__raw_writeq(0, csr + R_SMB_CONTROL);
> +	mmiowb();
> +	__raw_readq(csr + R_SMB_CONTROL);
>  
> -static struct i2c_algo_sibyte_data sibyte_board_data[2] = {
> -	{ NULL, 0, (void *) (CKSEG1+A_SMB_BASE(0)) },
> -	{ NULL, 1, (void *) (CKSEG1+A_SMB_BASE(1)) }
> +	free_irq(adap->irq, i2c_adap);
> +
> +	/* Clear any pending error interrupt. */
> +	__raw_writeq(__raw_readq(csr + R_SMB_STATUS), csr + R_SMB_STATUS);
> +
> +	iounmap(csr);
> +}
> +
> +static struct i2c_algo_sibyte_data i2c_sibyte_board_data[2] = {
> +#ifdef CONFIG_SIBYTE_SB1250
> +	{
> +		.name	= "sb1250-smbus-0",
> +		.base	= A_SMB_0,
> +		.irq	= K_INT_SMB_0,
> +	},
> +	{
> +		.name	= "sb1250-smbus-1",
> +		.base	= A_SMB_1,
> +		.irq	= K_INT_SMB_1,
> +	}
> +#else
> +	{
> +		.name	= "bcm1480-smbus-0",
> +		.base	= A_SMB_0,
> +		.irq	= K_BCM1480_INT_SMB_0,
> +	},
> +	{
> +		.name	= "bcm1480-smbus-1",
> +		.base	= A_SMB_1,
> +		.irq	= K_BCM1480_INT_SMB_1,
> +	}
> +#endif
>  };
>  
> -static struct i2c_adapter sibyte_board_adapter[2] = {
> +static struct i2c_adapter i2c_sibyte_board_adapter[2] = {
>  	{
>  		.owner		= THIS_MODULE,
>  		.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
> -		.algo		= NULL,
> -		.algo_data	= &sibyte_board_data[0],
> +		.algo		= &i2c_sibyte_algo,
> +		.algo_data	= &i2c_sibyte_board_data[0],
>  		.nr		= 0,
>  		.name		= "SiByte SMBus 0",
>  	},
>  	{
>  		.owner		= THIS_MODULE,
>  		.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
> -		.algo		= NULL,
> -		.algo_data	= &sibyte_board_data[1],
> +		.algo		= &i2c_sibyte_algo,
> +		.algo_data	= &i2c_sibyte_board_data[1],
>  		.nr		= 1,
>  		.name		= "SiByte SMBus 1",
>  	},
> @@ -173,21 +318,32 @@ static struct i2c_adapter sibyte_board_adapter[2] = {
>  
>  static int __init i2c_sibyte_init(void)
>  {
> +	int err;
> +
>  	pr_info("i2c-sibyte: i2c SMBus adapter module for SiByte board\n");
> -	if (i2c_sibyte_add_bus(&sibyte_board_adapter[0], K_SMB_FREQ_100KHZ) < 0)
> -		return -ENODEV;
> -	if (i2c_sibyte_add_bus(&sibyte_board_adapter[1],
> -			       K_SMB_FREQ_400KHZ) < 0) {
> -		i2c_del_adapter(&sibyte_board_adapter[0]);
> -		return -ENODEV;
> -	}
> +
> +	err = i2c_sibyte_add_bus(&i2c_sibyte_board_adapter[0],
> +				 K_SMB_FREQ_100KHZ);
> +	if (err < 0)
> +		goto out;
> +
> +	err = i2c_sibyte_add_bus(&i2c_sibyte_board_adapter[1],
> +				 K_SMB_FREQ_400KHZ);
> +	if (err < 0)
> +		goto out_remove;
> +
>  	return 0;
> +
> +out_remove:
> +	i2c_sibyte_remove_bus(&i2c_sibyte_board_adapter[0]);
> +out:
> +	return err;
>  }
>  
>  static void __exit i2c_sibyte_exit(void)
>  {
> -	i2c_del_adapter(&sibyte_board_adapter[0]);
> -	i2c_del_adapter(&sibyte_board_adapter[1]);
> +	i2c_sibyte_remove_bus(&i2c_sibyte_board_adapter[1]);
> +	i2c_sibyte_remove_bus(&i2c_sibyte_board_adapter[0]);
>  }
>  
>  module_init(i2c_sibyte_init);

Please address my concerns where you agree and send an updated patch.

-- 
Jean Delvare
