Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2007 12:12:23 +0100 (BST)
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:5572 "EHLO
	kraid.nerim.net") by ftp.linux-mips.org with ESMTP
	id S20021913AbXFYLMU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 25 Jun 2007 12:12:20 +0100
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
	by kraid.nerim.net (Postfix) with ESMTP id E4D6FCF0A9;
	Mon, 25 Jun 2007 11:12:17 +0000 (UTC)
Date:	Mon, 25 Jun 2007 13:13:48 +0200
From:	Jean Delvare <khali@linux-fr.org>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	akpm@linux-foundation.org, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 8/12] drivers: PMC MSP71xx TWI driver
Message-ID: <20070625131348.100abfa3@hyperion.delvare>
In-Reply-To: <200704272008.l3RK8ajD001656@pasqua.pmc-sierra.bc.ca>
References: <200704272008.l3RK8ajD001656@pasqua.pmc-sierra.bc.ca>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <khali@linux-fr.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips

Hi Marc,

On Fri, 27 Apr 2007 14:08:36 -0600, Marc St-Jean wrote:
> [PATCH 8/12] drivers: PMC MSP71xx TWI driver
> 
> Patch to add TWI driver for the PMC-Sierra MSP71xx devices.

Better late than never, here's my review.

> Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
> ---
> Changes since last posting:
> -Removed i2c-algo-pmctwi from Kconfig and Makefile as the file
> was previously dropped.
> 
>  algos/Kconfig       |    0 
>  algos/Makefile      |    0 
>  busses/Kconfig      |    6 
>  busses/Makefile     |    1 
>  busses/i2c-pmcmsp.c |  689 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 696 insertions(+)
> 
> diff --git a/drivers/i2c/algos/Kconfig b/drivers/i2c/algos/Kconfig
> diff --git a/drivers/i2c/algos/Makefile b/drivers/i2c/algos/Makefile
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 4d44a2d..108e3b6 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -573,4 +573,10 @@ config I2C_PNX
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-pnx.
>  
> +config I2C_PMCMSP
> +	tristate "PMC MSP I2C Controller"
> +	depends on I2C && PMC_MSP

Dependency on I2C is now handled at menu level, so you can omit it here.

> +	help
> +	  Supports the special PMC TWI SoC chip on the MSP platform

How "special"? Missing trailing dot.

> +
>  endmenu
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 03505aa..8923878 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_I2C_PARPORT_LIGHT)	+= i2c-parport-light.o
>  obj-$(CONFIG_I2C_PASEMI)	+= i2c-pasemi.o
>  obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
>  obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
> +obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
>  obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
>  obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
>  obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
> diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
> new file mode 100644
> index 0000000..4a15290
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-pmcmsp.c
> @@ -0,0 +1,689 @@
> +/*
> + * Specific bus support for PMC-TWI compliant implementation on MSP71xx.
> + *
> + * Copyright 2005-2007 PMC-Sierra, Inc.
> + *
> + *  This program is free software; you can redistribute  it and/or modify it
> + *  under  the terms of  the GNU General  Public License as published by the
> + *  Free Software Foundation;  either version 2 of the  License, or (at your
> + *  option) any later version.
> + *
> + *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
> + *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
> + *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
> + *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
> + *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
> + *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
> + *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
> + *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
> + *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + *  You should have received a copy of the  GNU General Public License along
> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
> + *  675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/completion.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +
> +#include <asm/io.h>
> +
> +#include <msp_regs.h>
> +#include <msp_cic_int.h>
> +
> +#define MSP_TWI_SF_CLK_REG_OFFSET	0x00
> +#define MSP_TWI_HS_CLK_REG_OFFSET	0x04
> +#define MSP_TWI_CFG_REG_OFFSET		0x08
> +#define MSP_TWI_CMD_REG_OFFSET		0x0c
> +#define MSP_TWI_ADD_REG_OFFSET		0x10
> +#define MSP_TWI_DAT_0_REG_OFFSET	0x14
> +#define MSP_TWI_DAT_1_REG_OFFSET	0x18
> +#define MSP_TWI_INT_STS_REG_OFFSET	0x1c
> +#define MSP_TWI_INT_MSK_REG_OFFSET	0x20
> +#define MSP_TWI_BUSY_REG_OFFSET		0x24
> +#define MSP_TWI_REG_SIZE		0x28
> +
> +#define MSP_TWI_INT_STS_DONE			(1 << 0)
> +#define MSP_TWI_INT_STS_LOST_ARBITRATION	(1 << 1)
> +#define MSP_TWI_INT_STS_NO_RESPONSE		(1 << 2)
> +#define MSP_TWI_INT_STS_DATA_COLLISION		(1 << 3)
> +#define MSP_TWI_INT_STS_BUSY			(1 << 4)
> +#define MSP_TWI_INT_STS_ALL			0x1f
> +
> +#define MSP_MAX_BYTES_PER_RW		8
> +#define MSP_MAX_POLL			5
> +#define MSP_POLL_DELAY			10
> +#define MSP_IRQ_TIMEOUT			(MSP_MAX_POLL * MSP_POLL_DELAY)
> +
> +#define MSP_TWI_IRQ 			MSP_INT_2WIRE
> +/* Use the following instead to disable interrupt mode */
> +/* #define MSP_TWI_IRQ 			0 */

Space before tab (twice), please clean up.

> +
> +/* IO Operation macros */
> +#define pmcmsptwi_readl		__raw_readl
> +#define pmcmsptwi_writel	__raw_writel
> +
> +/* TWI command type */
> +enum pmcmsptwi_cmd_type {
> +	MSP_TWI_CMD_WRITE	= 0, /* Write only */
> +	MSP_TWI_CMD_READ	= 1, /* Read only */
> +	MSP_TWI_CMD_WRITE_READ	= 2, /* Write then Read */
> +	MSP_TWI_CMD_RESERVED	= 3,

Why define MSP_TWI_CMD_RESERVED as you don't use it anywhere?

> +};
> +
> +/* Corresponds to a PMCTWI clock configuration register */
> +struct pmcmsptwi_clock {
> +	u8 filter;	/* Bits 15:12,	default = 0x03 */
> +	u16 clock;	/* Bits 9:0,	default = 0x001f */
> +};
> +
> +struct pmcmsptwi_clockcfg {
> +	struct pmcmsptwi_clock standard;  /* The standard/fast clock config */
> +	struct pmcmsptwi_clock highspeed; /* The highspeed clock config */
> +};
> +
> +/* Corresponds to the main TWI configuration register */
> +struct pmcmsptwi_cfg {
> +	u8 arbf;	/* Bits 15:12,	default=0x03 */
> +	u8 nak;		/* Bits 11:8,	default=0x03 */
> +	u8 add10;	/* Bit 7,	default=0x00 */
> +	u8 mst_code;	/* Bits 6:4,	default=0x00 */
> +	u8 arb;		/* Bit 1,	default=0x01 */
> +	u8 highspeed;	/* Bit 0,	default=0x00 */
> +};
> +
> +/* A single pmctwi command to issue */
> +struct pmcmsptwi_cmd {
> +	u16 addr;	/* The slave address (7 or 10 bits) */
> +	enum pmcmsptwi_cmd_type type;	/* The command type */
> +	u8 write_len;	/* Number of bytes in the write buffer */
> +	u8 read_len;	/* Number of bytes in the read buffer */
> +	u8 *write_data;	/* Buffer of characters to send */
> +	u8 *read_data;	/* Buffer to fill with incoming data */
> +};
> +
> +/* The possible results of the xferCmd */
> +enum pmcmsptwi_xfer_result {
> +	MSP_TWI_XFER_OK	= 0,
> +	MSP_TWI_XFER_TIMEOUT,
> +	MSP_TWI_XFER_BUSY,
> +	MSP_TWI_XFER_DATA_COLLISION,
> +	MSP_TWI_XFER_NO_RESPONSE,
> +	MSP_TWI_XFER_LOST_ARBITRATION,
> +};
> +
> +/* The default settings */
> +const static struct pmcmsptwi_clockcfg pmcmsptwi_defclockcfg = {
> +	.standard = {
> +		.filter = 0x3,
> +		.clock = 0x1f,
> +	},
> +	.highspeed = {
> +		.filter = 0x3,
> +		.clock = 0x1f,
> +	},
> +};
> +
> +const static struct pmcmsptwi_cfg pmcmsptwi_defcfg = {
> +	.arbf		= 0x03,
> +	.nak		= 0x03,
> +	.add10		= 0x00,
> +	.mst_code	= 0x00,
> +	.arb		= 0x01,
> +	.highspeed	= 0x00,
> +};
> +
> +/* The set of operations each bus must implement to use this algorithm */
> +struct pmcmsptwi_algo_data {
> +	void __iomem *iobase;			/* iomapped base for IO */
> +	enum pmcmsptwi_xfer_result last_result;	/* result of last xfer */
> +	int irq;				/* IRQ to use (0 disables) */
> +	struct completion wait;			/* Completion for xfer */
> +	struct mutex lock;			/* Used for threadsafeness */
> +
> +	/* Get both clock configuration registers */
> +	void (*get_clock_config)(struct pmcmsptwi_clockcfg *cfg, void *data);
> +
> +	/* Set both clock configuration registers */
> +	void (*set_clock_config)(const struct pmcmsptwi_clockcfg *cfg,
> +					void *data);
> +
> +	/* Get the TWI configuration register */
> +	void (*get_twi_config)(struct pmcmsptwi_cfg *cfg, void *data);
> +
> +	/* Set the TWI configuration register */
> +	void (*set_twi_config)(const struct pmcmsptwi_cfg *cfg, void *data);
> +
> +	/* Send the command, reading and/or writing all data specified */
> +	enum pmcmsptwi_xfer_result (*xfer_cmd)(struct pmcmsptwi_cmd *cmd,
> +						void *data);
> +};

Now that you have everything in the same driver (as opposed to a
separate i2c algorithm driver), you can remove all these function
pointers from this structure and simply call the functions directly.

> +
> +static struct i2c_adapter pmcmsptwi_adapter;
> +
> +static inline u32 pmcmsptwi_clock_to_reg(
> +			const struct pmcmsptwi_clock *clock)
> +{
> +	return (u32)(((clock->filter & 0xf) << 12) |
> +			(clock->clock & 0x03ff));
> +}

Useless cast to u32.

> +
> +static inline void pmcmsptwi_reg_to_clock(
> +			u32 reg, struct pmcmsptwi_clock *clock)
> +{
> +	clock->filter = (u8)((reg >> 12) & 0xf);
> +	clock->clock = (u16)(reg & 0x03ff);
> +}

Useless casts.

> +
> +static inline u32 pmcmsptwi_cfg_to_reg(const struct pmcmsptwi_cfg *cfg)
> +{
> +	return (u32)(((cfg->arbf & 0xf) << 12) |
> +			((cfg->nak & 0xf) << 8) |
> +			((cfg->add10 & 0x1) << 7) |
> +			((cfg->mst_code & 0x7) << 4) |
> +			((cfg->arb & 0x1) << 1) |
> +			((cfg->highspeed & 0x1) << 0));
> +}

Useless cast. Useless << 0.

> +
> +static inline void pmcmsptwi_reg_to_cfg(u32 reg, struct pmcmsptwi_cfg *cfg)
> +{
> +	cfg->arbf = (u8)((reg >> 12) & 0xf);
> +	cfg->nak = (u8)((reg >> 8) & 0xf);
> +	cfg->add10 = (u8)((reg >> 7) & 0x1);
> +	cfg->mst_code = (u8)((reg >> 4) & 0x7);
> +	cfg->arb = (u8)((reg >> 1) & 0x1);
> +	cfg->highspeed = (u8)(reg & 0x1);
> +}

Useless casts.

> +
> +/*
> + * Gets the current clock configuration
> + */
> +static void pmcmsptwi_get_clock_config(struct pmcmsptwi_clockcfg *cfg,
> +					void *data)

Why is data a void * and not a pmcmsptwi_algo_data *? It's nice to let
the compiler do the type checking, and it would save you a local
variable too. Same for the other functions below.

> +{
> +	struct pmcmsptwi_algo_data *p = data;
> +	
> +	mutex_lock(&p->lock);
> +	pmcmsptwi_reg_to_clock(pmcmsptwi_readl(p->iobase +
> +				MSP_TWI_SF_CLK_REG_OFFSET),
> +				&(cfg->standard));

Parentheses are not needed; more of the same below.

> +	pmcmsptwi_reg_to_clock(pmcmsptwi_readl(p->iobase +
> +				MSP_TWI_HS_CLK_REG_OFFSET),
> +				&(cfg->highspeed));
> +	mutex_unlock(&p->lock);
> +}

BTW, this function isn't called anywhere, so why define it?

> +
> +/*
> + * Sets the current clock configuration
> + */
> +static void pmcmsptwi_set_clock_config(const struct pmcmsptwi_clockcfg *cfg,
> +					void *data)
> +{
> +	struct pmcmsptwi_algo_data *p = data;
> +	
> +	mutex_lock(&p->lock);
> +	pmcmsptwi_writel(pmcmsptwi_clock_to_reg(&(cfg->standard)),
> +				p->iobase + MSP_TWI_SF_CLK_REG_OFFSET);
> +	pmcmsptwi_writel(pmcmsptwi_clock_to_reg(&(cfg->highspeed)),
> +				p->iobase + MSP_TWI_HS_CLK_REG_OFFSET);
> +	mutex_unlock(&p->lock);
> +}
> +
> +/*
> + * Gets the current TWI bus configuration
> + */
> +static void pmcmsptwi_get_twi_config(struct pmcmsptwi_cfg *cfg, void *data)
> +{
> +	struct pmcmsptwi_algo_data *p = data;
> +	
> +	mutex_lock(&p->lock);
> +	pmcmsptwi_reg_to_cfg(pmcmsptwi_readl(
> +				p->iobase + MSP_TWI_CFG_REG_OFFSET), cfg);
> +	mutex_unlock(&p->lock);
> +}
> +
> +/*
> + * Sets the current TWI bus configuration
> + */
> +static void pmcmsptwi_set_twi_config(const struct pmcmsptwi_cfg *cfg,
> +					void *data)
> +{
> +	struct pmcmsptwi_algo_data *p = data;
> +	
> +	mutex_lock(&p->lock);
> +	pmcmsptwi_writel(pmcmsptwi_cfg_to_reg(cfg),
> +				p->iobase + MSP_TWI_CFG_REG_OFFSET);
> +	mutex_unlock(&p->lock);
> +}
> +
> +/*
> + * Parses the 'int_sts' register and returns a well-defined error code
> + */
> +static enum pmcmsptwi_xfer_result pmcmsptwi_get_result(u32 reg)
> +{
> +	if (reg & MSP_TWI_INT_STS_LOST_ARBITRATION) {
> +		dev_dbg(&pmcmsptwi_adapter.dev,
> +			"  Result: Lost arbitration\n");
> +		return MSP_TWI_XFER_LOST_ARBITRATION;
> +	} else if (reg & MSP_TWI_INT_STS_NO_RESPONSE) {
> +		dev_dbg(&pmcmsptwi_adapter.dev,
> +			"  Result: No response\n");
> +		return MSP_TWI_XFER_NO_RESPONSE;
> +	} else if (reg & MSP_TWI_INT_STS_DATA_COLLISION) {
> +		dev_dbg(&pmcmsptwi_adapter.dev,
> +			"  Result: Data collision\n");
> +		return MSP_TWI_XFER_DATA_COLLISION;
> +	} else if (reg & MSP_TWI_INT_STS_BUSY) {
> +		dev_dbg(&pmcmsptwi_adapter.dev,
> +			"  Result: Bus busy\n");
> +		return MSP_TWI_XFER_BUSY;
> +	}
> +
> +	dev_dbg(&pmcmsptwi_adapter.dev, "  Result: Operation succeeded\n");
> +	return MSP_TWI_XFER_OK;
> +}

All these messages are redundant with the ones in
pmcmsptwi_master_xfer(). Also, some of them should probably be error
messages than debug messages. For example, data collision sounds serious
and probably should never happen?

> +
> +/*
> + * Polls the 'busy' register until the command is complete
> + * Note: Assumes p->lock is held.
> + */
> +static void pmcmsptwi_poll_complete(struct pmcmsptwi_algo_data* p)
> +{
> +	int i;
> +	u32 val = 0;
> +	
> +	for (i = 0; i < MSP_MAX_POLL; i++) {
> +		val = pmcmsptwi_readl(p->iobase + MSP_TWI_BUSY_REG_OFFSET);
> +		if (val == 0) {
> +			u32 reason = pmcmsptwi_readl(p->iobase +
> +						MSP_TWI_INT_STS_REG_OFFSET);
> +			pmcmsptwi_writel(reason, p->iobase +
> +						MSP_TWI_INT_STS_REG_OFFSET);
> +			p->last_result = pmcmsptwi_get_result(reason);
> +			return;
> +		}
> +		udelay(MSP_POLL_DELAY);
> +	}
> +
> +	dev_dbg(&pmcmsptwi_adapter.dev, "  Result: Poll timeout\n");

You can remove the leading spaces from all such messages. dev_dbg and
friends will add a space between the device name and the message
automatically.

> +	p->last_result = MSP_TWI_XFER_TIMEOUT;
> +}
> +
> +/*
> + * In interrupt mode, handle the interrupt
> + * Note: Assumes p->lock is held.
> + */
> +static irqreturn_t pmcmsptwi_interrupt(int irq, void* data)
> +{
> +	struct pmcmsptwi_algo_data *p = data;
> +	
> +	u32 reason = pmcmsptwi_readl(p->iobase + MSP_TWI_INT_STS_REG_OFFSET);
> +	pmcmsptwi_writel(reason, p->iobase + MSP_TWI_INT_STS_REG_OFFSET);
> +
> +	dev_dbg(&pmcmsptwi_adapter.dev, "    Got interrupt 0x%08x\n",
> +			reason);
> +	if (!(reason & MSP_TWI_INT_STS_DONE))
> +		return IRQ_NONE;
> +
> +	p->last_result = pmcmsptwi_get_result(reason);
> +	complete(&p->wait);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Do the transfer (low level):
> + *  - May use interrupt-driven or polling, depending on if an IRQ is
> + *  presently registered
> + * Note: Assumes p->lock is held
> + */
> +static enum pmcmsptwi_xfer_result pmcmsptwi_do_xfer(
> +			u32 reg, struct pmcmsptwi_algo_data *p)
> +{
> +	dev_dbg(&pmcmsptwi_adapter.dev, "  Writing cmd reg 0x%08x\n", reg);
> +	pmcmsptwi_writel(reg, p->iobase + MSP_TWI_CMD_REG_OFFSET);
> +	if (p->irq) {
> +		unsigned long timeleft = wait_for_completion_timeout(
> +						&p->wait, MSP_IRQ_TIMEOUT);
> +		if (timeleft == 0) {
> +			dev_dbg(&pmcmsptwi_adapter.dev,
> +				"  Result: IRQ timeout\n");
> +			complete(&p->wait);
> +			p->last_result = MSP_TWI_XFER_TIMEOUT;
> +		}
> +	} else
> +		pmcmsptwi_poll_complete(p);
> +
> +	return p->last_result;
> +}
> +
> +/*
> + * Helper routine, converts 'pmctwi_cmd' struct to register format
> + */
> +static inline u32 pmcmsptwi_cmd_to_reg(const struct pmcmsptwi_cmd *cmd)
> +{
> +	return (u32)(((cmd->type & 0x3) << 8) |
> +			(((cmd->write_len - 1) & 0x7) << 4) |
> +			(((cmd->read_len - 1) & 0x7) << 0));
> +}

Useless cast to u32, useless << 0.

What if cmd->write_len or cmd->read_len is 0?

> +
> +/*
> + * Do the transfer (high level)
> + */
> +static enum pmcmsptwi_xfer_result pmcmsptwi_xfer_cmd(
> +			struct pmcmsptwi_cmd *cmd, void *data)
> +{
> +	struct pmcmsptwi_algo_data *p = data;
> +	u64 *write_data, *read_data;
> +	enum pmcmsptwi_xfer_result retval;
> +
> +	write_data = (u64*)cmd->write_data;
> +	read_data = (u64*)cmd->read_data;

This cast increases the required alignment, this doesn't sound right.

> +
> +	if ((cmd->type == MSP_TWI_CMD_WRITE && cmd->write_len == 0) ||
> +	    (cmd->type == MSP_TWI_CMD_READ && cmd->read_len == 0) ||
> +	    (cmd->type == MSP_TWI_CMD_WRITE_READ &&
> +	    (cmd->read_len == 0 || cmd->write_len == 0))) {
> +		printk(KERN_ERR "%s: Cannot transfer less than 1 byte\n",
> +		        __FUNCTION__);

Please use dev_err(). Use a tab instead of 8 spaces.

> +		return -1;

-EINVAL would be better.

> +	}
> +
> +	if ((cmd->read_len > MSP_MAX_BYTES_PER_RW) ||
> +	    (cmd->write_len > MSP_MAX_BYTES_PER_RW)) {
> +		printk(KERN_ERR "%s: Cannot transfer more than %d bytes\n",
> +			__FUNCTION__, MSP_MAX_BYTES_PER_RW);

Same here, dev_err().

Is it OK to continue despite the error? Smells like a missing return.

> +	}
> +
> +	mutex_lock(&p->lock);
> +	dev_dbg(&pmcmsptwi_adapter.dev, "Setting address to 0x%08x\n",
> +		cmd->addr);

%08x to print a u16 is more than needed.

> +	pmcmsptwi_writel(cmd->addr, p->iobase + MSP_TWI_ADD_REG_OFFSET);
> +
> +	if ((cmd->type == MSP_TWI_CMD_WRITE) ||
> +	    (cmd->type == MSP_TWI_CMD_WRITE_READ)) {
> +		u64 tmp = be64_to_cpu(*write_data);

Looks incorrect. *write_data is in CPU order, so you should call
cpu_to_be64, right? And tmp should have type __be64.

> +		tmp >>= (8 - cmd->write_len) * 8;
> +		dev_dbg(&pmcmsptwi_adapter.dev, "Writing 0x%016llx\n", tmp);
> +		pmcmsptwi_writel((u32)(tmp & 0x00000000ffffffffLL),
> +				p->iobase + MSP_TWI_DAT_0_REG_OFFSET);
> +		if (cmd->write_len > 4)
> +			pmcmsptwi_writel((u32)(tmp >> 32),
> +					p->iobase + MSP_TWI_DAT_1_REG_OFFSET);
> +	}

The casts to u32 aren't needed as far as I can see.

> +
> +	retval = pmcmsptwi_do_xfer(pmcmsptwi_cmd_to_reg(cmd), p);

Shouldn't you return immediately if retval contains an error? Otherwise
you may be reading values which don't exist.

> +
> +	if ((cmd->type == MSP_TWI_CMD_READ) ||
> +	    (cmd->type == MSP_TWI_CMD_WRITE_READ)) {
> +		int i;
> +		u64 rmsk = ~(0xffffffffffffffffLL << (cmd->read_len*8));
> +		u64 tmp = (u64)pmcmsptwi_readl(p->iobase +
> +					MSP_TWI_DAT_0_REG_OFFSET);
> +		if (cmd->read_len > 4)
> +			tmp |= (u64)pmcmsptwi_readl(p->iobase +
> +					MSP_TWI_DAT_1_REG_OFFSET) << 32;
> +		tmp &= rmsk;
> +		dev_dbg(&pmcmsptwi_adapter.dev, "Read 0x%016llx\n", tmp);
> +		
> +		for (i = 0; i < cmd->read_len; i++)
> +			cmd->read_data[i] = (u8)((tmp >> i) & 0xff);

Cast to u8 and masking are not needed.

> +	}
> +	mutex_unlock(&p->lock);
> +	
> +	return retval;
> +}
> +
> +/* -- Algorithm functions -- */
> +
> +/* 
> + * Sends an i2c command out on the adapter
> + * Return -1 on error.

Note that you are free (and invited) to return more meaningful values.
Just because the other bus drivers stupidly return -1 doesn't mean
everyone must do the same;

> + */
> +static int pmcmsptwi_master_xfer(struct i2c_adapter *adap,
> +				struct i2c_msg *m, int num)
> +{
> +	struct pmcmsptwi_algo_data *busops = adap->algo_data;
> +	int i, ret = 0, dual, probe;
> +	struct i2c_msg *cmsg, *nmsg;
> +	u8 detect_buffer[] = { 0 };
> +
> +	for (i = 0; i < num; i++) {
> +		struct pmcmsptwi_cmd cmd;
> +		struct pmcmsptwi_cfg oldcfg, newcfg;
> +
> +		probe = 0;
> +		dual = 0;
> +		cmsg = m + i;
> +		nmsg = NULL;
> +
> +		if ((num - i) >= 2) {
> +			/* Check for a dual write-then-read command */
> +			nmsg = cmsg + 1;
> +			dual = !((cmsg->flags & I2C_M_RD)) &&
> +			       (nmsg->flags & I2C_M_RD) &&
> +			       (cmsg->addr == nmsg->addr);
> +		}

I seem to understand that the hardware simply doesn't support
transactions with an arbitrary number of messages. It only supports
simple reads, simple writes, and combined write + read. Then your
driver shouldn't attempt to hide this limitation. The hardware only
supports a subset of the I2C protocol, so be it. Simply return an error
if requested to do something the hardware doesn't support.

This will make your code much more simple. And in practice it shouldn't
change anything, because all popular I2C (and SMBus) transactions are
of one of the 3 supported types.

> +
> +		if (dual)
> +			dev_dbg(&adap->dev, "Doing ops %d&%d of %d\n",
> +				(i + 1), (i + 2), num);
> +		else
> +			dev_dbg(&adap->dev, "Doing op %d of %d\n",
> +				(i + 1), num);
> +
> +		if (dual) {
> +			cmd.type = MSP_TWI_CMD_WRITE_READ;
> +			cmd.write_len = cmsg->len;
> +			cmd.write_data = (u8*)cmsg->buf;
> +			cmd.read_len = nmsg->len;
> +			cmd.read_data = (u8*)nmsg->buf;
> +		} else if (cmsg->flags & I2C_M_RD) {
> +			cmd.type = MSP_TWI_CMD_READ;
> +			cmd.read_len = cmsg->len;
> +			cmd.read_data = (u8*)cmsg->buf;
> +			cmd.write_len = 0;
> +			cmd.write_data = NULL;
> +		} else {
> +			cmd.type = MSP_TWI_CMD_WRITE;
> +			cmd.read_len = 0;
> +			cmd.read_data = NULL;
> +			cmd.write_len = cmsg->len;
> +			cmd.write_data = (u8*)cmsg->buf;
> +		}
> +
> +		if (cmsg->len == 0) {
> +			if (cmsg->flags & I2C_M_RD) {
> +				dev_dbg(&adap->dev,
> +					"Read of 0 bytes!  (illegal!)\n");
> +				return -1;

This transaction is not illegal at all. It's not implemented by your
hardware, that's a different problem.

> +			} else {
> +				dev_dbg(&adap->dev,
> +					"Probing for slave at 0x%02x\n",
> +					(cmsg->addr & 0xff));
> +				probe = 1;

This isn't acceptable. For one thing, zero-length writes are not probes
as per the I2C or SMBus specification. The Linux i2c-core currently
uses them for this purpose, short of anything better, but this could
change. More importantly, if you are asked to do a zero-length write,
you should not do a 1-byte read. You have no idea what this 1-byte read
might do to the chip. It might have unexpected side effects. So, the
hardware doesn't support zero-length transactions, simply don't
implement them.

> +
> +				/*
> +				 * Probe is a special read of 1 byte.
> +				 * We don't care about the result, we just
> +				 * want to see that it is successful.
> +				 */
> +				cmd.write_len = 1;
> +				cmd.write_data = detect_buffer;
> +				cmd.read_len = 1;
> +				cmd.read_data = NULL;
> +			}
> +		}
> +
> +		cmd.addr = cmsg->addr;
> +
> +		if (probe || (cmsg->flags & I2C_M_TEN)) {
> +			busops->get_twi_config(&newcfg, busops);
> +			busops->get_twi_config(&oldcfg, busops);

It would be cheaper to just use memcpy() for oldcfg.

> +
> +			/* For probes, we don't want any retries */
> +			if (probe)
> +				newcfg.nak = 0;
> +
> +			/* Set the special 10-bit address flag, if required */
> +			if (cmsg->flags & I2C_M_TEN)
> +				newcfg.add10 = 1;
> +
> +			busops->set_twi_config(&newcfg, busops);
> +		}
> +
> +		ret = busops->xfer_cmd(&cmd, busops);
> +
> +		if (probe || (cmsg->flags & I2C_M_TEN))
> +			busops->set_twi_config(&oldcfg, busops);
> +
> +		switch (ret) {
> +		case MSP_TWI_XFER_LOST_ARBITRATION:
> +			dev_dbg(&adap->dev, "We lost arbitration: "
> +				"Could not become bus master\n");
> +			break;
> +		case MSP_TWI_XFER_NO_RESPONSE:
> +			dev_dbg(&adap->dev, "No response\n");
> +			break;
> +		case MSP_TWI_XFER_DATA_COLLISION:
> +			dev_dbg(&adap->dev, "Data collision\n");
> +			break;
> +		case MSP_TWI_XFER_BUSY:
> +			dev_dbg(&adap->dev, "Port was busy\n");
> +			/*
> +			 *  TODO: We could potentially loop and retry
> +			 *        in this case
> +			 */
> +			break;
> +		case MSP_TWI_XFER_TIMEOUT:
> +			dev_dbg(&adap->dev, "Transfer timeout\n");
> +			break;
> +		}
> +		
> +		if (ret != MSP_TWI_XFER_OK) {
> +			if (probe)
> +				dev_dbg(&adap->dev, "Probe failed\n");
> +			return -1;
> +		}
> +
> +		if (dual) {
> +			dev_dbg(&adap->dev,
> +				"SMBus read 0x%02x from reg 0x%02x\n",
> +				nmsg->buf[0], cmsg->buf[0]);

This message is only correct for an SMBus Read Byte transaction, while
there are many other possible combined transactions.

> +
> +			/* Skip one more ahead, since we just did 2 commands */
> +			i++;
> +		} else {
> +			if (probe)
> +				dev_dbg(&adap->dev, "Probe successful\n");
> +			else
> +				dev_dbg(&adap->dev,
> +					"I2C %s %d bytes successfully\n",
> +					(cmsg->flags & I2C_M_RD) ?
> +						"read" : "wrote",
> +					cmsg->len);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static u32 pmcmsptwi_i2c_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
> +}

You don't actually implement I2C_FUNC_I2C, nor I2C_FUNC_SMBUS_EMUL. You
only implement a subset of these. What you really implement is:
I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA
| I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_PROC_CALL

You implement I2C_FUNC_I2C, I2C_FUNC_SMBUS_WRITE_BLOCK_DATA and
I2C_FUNC_SMBUS_I2C_BLOCK only partly. It might be convenient to lie on
these, depending on the chip drivers you'll be using on this bus. But
this might also have drawbacks.

> +
> +/* -- Initialization -- */
> +
> +static struct pmcmsptwi_algo_data pmcmsptwi_algo_data = {
> +	.get_clock_config	= pmcmsptwi_get_clock_config,
> +	.set_clock_config	= pmcmsptwi_set_clock_config,
> +	.get_twi_config		= pmcmsptwi_get_twi_config,
> +	.set_twi_config		= pmcmsptwi_set_twi_config,
> +	.xfer_cmd		= pmcmsptwi_xfer_cmd,
> +};
> +
> +struct i2c_algorithm pmcmsptwi_algo = {
> +	.master_xfer	= pmcmsptwi_master_xfer,
> +	.smbus_xfer	= NULL,
> +	.algo_control	= NULL,	/* TODO: someday */
> +	.functionality	= pmcmsptwi_i2c_func,
> +};

Should be static. The NULL members should simply be omitted.

> +
> +static struct i2c_adapter pmcmsptwi_adapter = {
> +	.owner		= THIS_MODULE,
> +	.class		= I2C_CLASS_HWMON,
> +	.algo		= &pmcmsptwi_algo,
> +	.algo_data	= &pmcmsptwi_algo_data,
> +	.name		= "pmcmsptwi",
> +};
> +
> +static int __init pmcmsptwi_init(void)
> +{
> +	pmcmsptwi_algo_data.iobase = ioremap(MSP_TWI_BASE, MSP_TWI_REG_SIZE);

MSP_TWI_BASE is not defined anywhere.

> +	if (pmcmsptwi_algo_data.iobase == NULL)
> +		return -ENOMEM;
> +
> +	init_completion(&pmcmsptwi_algo_data.wait); 
> +	mutex_init(&pmcmsptwi_algo_data.lock);
> +	pmcmsptwi_algo_data.irq = MSP_TWI_IRQ;
> +
> +	if (pmcmsptwi_algo_data.irq) {
> +		int rc = request_irq(
> +				pmcmsptwi_algo_data.irq, pmcmsptwi_interrupt,
> +				SA_SHIRQ | SA_INTERRUPT | SA_SAMPLE_RANDOM,

As far as I know, these flags are deprecated and IRQF_* equivalents
should be used instead. See Documentation/feature-removal-schedule.txt
and include/linux/interrupt.h.

> +				"TWI", &pmcmsptwi_algo_data);
> +		if (rc == 0) {
> +			/*
> +			 * Enable 'DONE' interrupt only
> +			 *
> +			 * If you enable all interrupts, you will get one on
> +			 * error and another when the operation completes.
> +			 * This way you only have to handle one interrupt,
> +			 * but you can still check all result flags.
> +			 */
> +			pmcmsptwi_writel(MSP_TWI_INT_STS_DONE,
> +					pmcmsptwi_algo_data.iobase +
> +					MSP_TWI_INT_MSK_REG_OFFSET);
> +		} else {
> +			printk(KERN_WARNING
> +				"Could not assign TWI IRQ handler "
> +				"to irq %d (continuing with poll)\n",
> +				pmcmsptwi_algo_data.irq);
> +			pmcmsptwi_algo_data.irq = 0;
> +		}
> +	}
> +
> +	pmcmsptwi_set_clock_config(&pmcmsptwi_defclockcfg,
> +				   &pmcmsptwi_algo_data);
> +	pmcmsptwi_set_twi_config(&pmcmsptwi_defcfg, &pmcmsptwi_algo_data);
> +
> +	printk(KERN_WARNING "pmcmsptwi: Registering MSP71xx I2C adapter\n");

How is this a warning?

> +
> +	return i2c_add_adapter(&pmcmsptwi_adapter);

If i2c_add_adapter() fails, you leave with a mapped I/O area and a
requested interruption - not good.

> +}

This is really old-style. You should declare a platform device and
implement this driver as a platform driver. This would make it much
easier to declare (and change) the I/O base port, IRQ, etc.

> +
> +static void __exit pmcmsptwi_exit(void)
> +{
> +	if (pmcmsptwi_algo_data.irq) {
> +		pmcmsptwi_writel(0,
> +			pmcmsptwi_algo_data.iobase +
> +			MSP_TWI_INT_MSK_REG_OFFSET);
> +		free_irq(pmcmsptwi_algo_data.irq, &pmcmsptwi_algo_data);
> +	}
> +	i2c_del_adapter(&pmcmsptwi_adapter);

You should remove the adapter first.

Missing call to iounmap().

> +}
> +
> +MODULE_DESCRIPTION("PMC MSP TWI/SMB/I2C driver");

Please don't use SMB as a shortcut for SMBus. SMB is already a shortcut
for too many things, it gets confusing.

> +MODULE_LICENSE("GPL");
> +
> +module_init(pmcmsptwi_init);
> +module_exit(pmcmsptwi_exit);

-- 
Jean Delvare
