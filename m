Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2011 23:57:11 +0200 (CEST)
Received: from host6.manc-digital.ifl.telecomplete.net ([86.53.204.7]:11688
        "EHLO freya" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1491187Ab1GMV5E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jul 2011 23:57:04 +0200
Received: from ben by freya with local (Exim 4.72)
        (envelope-from <ben@freya.fluff.org>)
        id 1Qh7QN-0001lf-8o; Wed, 13 Jul 2011 22:56:55 +0100
Date:   Wed, 13 Jul 2011 22:56:55 +0100
From:   Ben Dooks <ben-i2c@fluff.org>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        ganesanr@netlogicmicro.com
Subject: Re: [PATCH] i2c: Support for Netlogic XLR/XLS on-chip I2C
 controller.
Message-ID: <20110713215655.GF3369@freya.fluff.org>
References: <20110623135057.GA26772@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110623135057.GA26772@jayachandranc.netlogicmicro.com>
X-Disclaimer: These are my views alone.
X-URL:  http://www.fluff.org/
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 30619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben-i2c@fluff.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9737

On Thu, Jun 23, 2011 at 07:21:03PM +0530, Jayachandran C. wrote:
> From: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
> 
> - platform.c : add i2c platform device
> - i2c-xlr.c : algorithm and i2c adaptor
> - Kconfig/Makefile: add CONFIG_I2C_XLR option
> 
> Signed-off-by: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
> Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
> ---

snip

> diff --git a/arch/mips/netlogic/xlr/platform.c b/arch/mips/netlogic/xlr/platform.c
> index 609ec25..2cd2d3c 100644
> --- a/arch/mips/netlogic/xlr/platform.c
> +++ b/arch/mips/netlogic/xlr/platform.c
> @@ -14,6 +14,7 @@
>  #include <linux/resource.h>
>  #include <linux/serial_8250.h>
>  #include <linux/serial_reg.h>
> +#include <linux/i2c.h>
>  
>  #include <asm/netlogic/xlr/iomap.h>
>  #include <asm/netlogic/xlr/pic.h>
> @@ -66,6 +67,34 @@ void nlm_xlr_uart_out(struct uart_port *p, int offset, int value)
>  		.serial_out	= nlm_xlr_uart_out,	\
>  	}
>  
> +#ifdef CONFIG_I2C
> +static struct i2c_board_info nlm_i2c_info1[] __initdata = {
> +	/* All XLR boards have this RTC and Max6657 Temp Chip */
> +	{"ds1374",          0, 0x68, 0, 0, 0},
> +	{"lm90",            0, 0x4c, 0, 0, 0},
> +};

- named initialisers, or even the I2C_BOARD_INFO()
- no need to have the fields initialiser with 0 after the address.
- spaces betwee { and }

>  config I2C_BLACKFIN_TWI
>  	tristate "Blackfin TWI I2C support"
>  	depends on BLACKFIN

> new file mode 100644
> index 0000000..ac3d989
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-xlr.c
> @@ -0,0 +1,335 @@
> +/*
> + * Copyright 2011, Netlogic Microsystems Inc.
> + * Copyright 2004, Matt Porter <mporter@kernel.crashing.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <asm/netlogic/xlr/iomap.h>
> +
> +/* XLR I2C REGISTERS */
> +#define XLR_I2C_CFG		0x00
> +#define XLR_I2C_CLKDIV		0x01
> +#define XLR_I2C_DEVADDR		0x02
> +#define XLR_I2C_ADDR		0x03
> +#define XLR_I2C_DATAOUT		0x04
> +#define XLR_I2C_DATAIN		0x05
> +#define XLR_I2C_STATUS		0x06
> +#define XLR_I2C_STARTXFR	0x07
> +#define XLR_I2C_BYTECNT		0x08
> +#define XLR_I2C_HDSTATIM	0x09
> +
> +/* XLR I2C REGISTERS FLAGS */
> +#define XLR_I2C_BUS_BUSY	0x01
> +#define XLR_I2C_SDOEMPTY	0x02
> +#define XLR_I2C_RXRDY		0x04
> +#define XLR_I2C_ACK_ERR		0x08
> +#define XLR_I2C_ARB_STARTERR	0x30
> +
> +/* Register Programming Values!! Change as required */
> +#define XLR_I2C_CFG_ADDR	0xF8    /* 8-Bit dev Addr + POR Values */
> +#define XLR_I2C_CFG_NOADDR	0xFA    /* 8-Bit reg Addr + POR Values */
> +#define XLR_I2C_STARTXFR_ND	0x02    /* No data , only addr */
> +#define XLR_I2C_STARTXFR_RD	0x01    /* Read */
> +#define XLR_I2C_STARTXFR_WR	0x00    /* Write */
> +#define XLR_I2C_CLKDIV_DEF	0x14A   /* 0x00000052 */
> +#define XLR_I2C_HDSTATIM_DEF	0x107   /* 0x00000000 */
> +
> +struct xlr_i2c_private {
> +	struct i2c_adapter adap;
> +	u32 *iobase_i2c_regs;

this should at-least be __iomem attributed

> +};
> +static struct xlr_i2c_private  xlr_i2c_priv;
> +
> +u32 *get_i2c_base(unsigned short bus)
> +{
> +	nlm_reg_t *mmio = 0;
> +
> +	if (bus == 0)
> +		mmio = netlogic_io_mmio(NETLOGIC_IO_I2C_0_OFFSET);
> +	else
> +		mmio = netlogic_io_mmio(NETLOGIC_IO_I2C_1_OFFSET);
> +
> +	return (u32 *)mmio;
> +}

shouldn't this be in with the platform device?

> +static void xlr_i2c_write(u32 *iobase_i2c_regs, int reg, int val)
> +{
> +	netlogic_write_reg(iobase_i2c_regs, reg, val);
> +}

did you really need to wrapper these functions?

> +static u32 xlr_i2c_read(u32 *iobase_i2c_regs, int reg)
> +{
> +	u32 retVal = netlogic_read_reg(iobase_i2c_regs, reg);
> +	return retVal;
> +}
> +

> +		u16		addr,
> +		unsigned short	flags,
> +		char		read_write,
> +		u8		command,
> +		int		protocol,
> +		union i2c_smbus_data *data)
> +{
> +	struct xlr_i2c_private *priv = i2c_adap->algo_data;
> +	int err;
> +	int len;
> +
> +	switch (protocol) {
> +	case I2C_SMBUS_BYTE:
> +		if (read_write == I2C_SMBUS_READ)
> +			err = xlr_i2c_rx(priv, 1, &data->byte, addr, command);
> +		else
> +			err = xlr_i2c_tx(priv, 1, &data->byte, addr, command);
> +
> +		break;
> +	case I2C_SMBUS_BYTE_DATA:
> +		if (read_write == I2C_SMBUS_READ)
> +			err = xlr_i2c_rx(priv, 1, &data->byte, addr, command);
> +		else
> +			err = xlr_i2c_tx(priv, 1, &data->byte, addr, command);
> +		break;
> +
> +	case I2C_SMBUS_WORD_DATA:
> +	case I2C_SMBUS_PROC_CALL:
> +		if (read_write == I2C_SMBUS_READ)
> +			err = xlr_i2c_rx(priv, 2, (u8 *)&data->word,
> +					addr, command);
> +		else
> +			err = xlr_i2c_tx(priv, 2, (u8 *)&data->word,
> +					addr, command);
> +
> +		break;
> +	case I2C_FUNC_SMBUS_BLOCK_DATA:
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		len = (data->block[0] > I2C_SMBUS_BLOCK_MAX) ?
> +			I2C_SMBUS_BLOCK_MAX : data->block[0];
> +		if (read_write == I2C_SMBUS_READ)
> +			err = xlr_i2c_rx(priv, len, &data->block[1],
> +					addr, command);
> +		else
> +			err = xlr_i2c_tx(priv, len, &data->block[1],
> +					addr, command);
> +
> +		break;
> +	default:
> +		err = -1;
> +	}
> +	return err;
> +}

thought most of these case where handled by the core translating
them into the proper i2c messages?

> +
> +static u32 xlr_func(struct i2c_adapter *adap)
> +{
> +	/* We emulate SMBUS over I2C */
> +	return I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static struct i2c_algorithm xlr_i2c_algo = {
> +	.smbus_xfer	= smbus_xfer,
> +	.functionality	= xlr_func,
> +};
> +
> +int xlr_i2c_add_bus(struct xlr_i2c_private *priv)
> +{
> +	priv->adap.owner	= THIS_MODULE;
> +	priv->adap.algo_data	= priv;
> +	priv->adap.nr		= 1;
> +	priv->adap.algo		= &xlr_i2c_algo;
> +	priv->adap.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +	snprintf(priv->adap.name, sizeof(priv->adap.name),
> +			"SMBus XLR I2C Adapter");
> +
> +	/* register new adapter to i2c module... */
> +	if (i2c_add_numbered_adapter(&priv->adap))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +int xlr_i2c_del_bus(struct i2c_adapter *adap)
> +{
> +	return i2c_del_adapter(adap);
> +}
> +
> +static int __devinit xlr_i2c_probe(struct platform_device *pd)
> +{
> +	xlr_i2c_priv.iobase_i2c_regs = get_i2c_base(pd->id);
> +
> +	xlr_i2c_priv.adap.dev.parent = &pd->dev;
> +	if (xlr_i2c_add_bus(&xlr_i2c_priv) < 0) {
> +		dev_err(&xlr_i2c_priv.adap.dev, "Failed to add i2c bus\n");
> +		goto out;
> +	} else
> +		dev_info(&xlr_i2c_priv.adap.dev, "Added I2C Bus.\n");
> +
> +	return 0;
> +out:
> +	return -ENODEV;

-ENODEV will get ignored by the upper layer. Need to find a better
error code.

> +}

> +MODULE_AUTHOR("Netlogic Microsystems Inc.");
> +MODULE_DESCRIPTION("XLR I2C SMBus driver");
> +MODULE_LICENSE("GPL");

no module alias for the platform device?

> +module_init(xlr_i2c_init);
> +module_exit(xlr_i2c_exit);
> -- 
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
