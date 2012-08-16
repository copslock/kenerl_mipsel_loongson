Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 10:44:12 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:62343 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903487Ab2HPIoG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2012 10:44:06 +0200
Received: by ghbf20 with SMTP id f20so2837495ghb.36
        for <linux-mips@linux-mips.org>; Thu, 16 Aug 2012 01:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TtIEsHZVhV37HmYQDTamjT3dmTPgH/Ca8tUXInEg8ow=;
        b=CBibF8g4xLUdK4k4cBNUnna/F+IGVZStAjx8BxQDVcmx3vYdJUrSSE2c2/OsIycY7l
         aDAVmLXuLvWBfC28rUX1k2C/spshKDk4rhJj2SFnpzEhehwCvI/EU6dCnKdqnrL3dzYD
         SpzKkog+c7A0FwD9aUKHFF+Gtkiwr9BfEjwobBhxaAend2RRrPn0CZepk8XiVrOEqcz1
         3u7+A01bIaHIfJ+ZWsIi80LRIjdueIcC4bRHmQFF//dkcXhfM9fT9IoZRHqQ+FgInFef
         Da1Fl4a26d7Fz577GSaXGJwu7jjfWS1usIW5Evq+oXMCNuAByrHdWQ0IaxVFEAfAxwJX
         xh+A==
MIME-Version: 1.0
Received: by 10.50.171.100 with SMTP id at4mr1306271igc.47.1345106639352; Thu,
 16 Aug 2012 01:43:59 -0700 (PDT)
Received: by 10.43.44.7 with HTTP; Thu, 16 Aug 2012 01:43:59 -0700 (PDT)
In-Reply-To: <1345102448-4612-1-git-send-email-blogic@openwrt.org>
References: <1345102448-4612-1-git-send-email-blogic@openwrt.org>
Date:   Thu, 16 Aug 2012 14:13:59 +0530
Message-ID: <CAM=Q2cvCmKMkQjWd0nvuvMMkNt3sH-AcupCq_KzM7EXDuD_-wQ@mail.gmail.com>
Subject: Re: [PATCH] I2C: MIPS: lantiq: add FALC-ON i2c bus master
From:   Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: omaplinuxkernel@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi John ,

On Thu, Aug 16, 2012 at 1:04 PM, John Crispin <blogic@openwrt.org> wrote:
> This patch adds the driver needed to make the I2C bus work on FALC-ON SoCs.
>
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  drivers/i2c/busses/Kconfig      |   10 +
>  drivers/i2c/busses/Makefile     |    1 +
>  drivers/i2c/busses/i2c-lantiq.c |  752 +++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-lantiq.h |  234 ++++++++++++
>  4 files changed, 997 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-lantiq.c
>  create mode 100644 drivers/i2c/busses/i2c-lantiq.h
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index b4aaa1b..1e80198 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -449,6 +449,16 @@ config I2C_IOP3XX
>           This driver can also be built as a module.  If so, the module
>           will be called i2c-iop3xx.
>
> +config I2C_LANTIQ
> +       tristate "Lantiq I2C interface"
> +       depends on LANTIQ && SOC_FALCON
> +       help
> +         If you say yes to this option, support will be included for the
> +         Lantiq I2C core.
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called i2c-lantiq.
> +
>  config I2C_MPC
>         tristate "MPC107/824x/85xx/512x/52xx/83xx/86xx"
>         depends on PPC
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index ce3c2be..da72247 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_I2C_IBM_IIC)     += i2c-ibm_iic.o
>  obj-$(CONFIG_I2C_IMX)          += i2c-imx.o
>  obj-$(CONFIG_I2C_INTEL_MID)    += i2c-intel-mid.o
>  obj-$(CONFIG_I2C_IOP3XX)       += i2c-iop3xx.o
> +obj-$(CONFIG_I2C_LANTIQ)       += i2c-lantiq.o
>  obj-$(CONFIG_I2C_MPC)          += i2c-mpc.o
>  obj-$(CONFIG_I2C_MV64XXX)      += i2c-mv64xxx.o
>  obj-$(CONFIG_I2C_MXS)          += i2c-mxs.o
> diff --git a/drivers/i2c/busses/i2c-lantiq.c b/drivers/i2c/busses/i2c-lantiq.c
> new file mode 100644
> index 0000000..e0afa8c
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-lantiq.c
> @@ -0,0 +1,752 @@
> +/*
> + * Lantiq I2C bus adapter
> + *
> + * Parts based on i2c-designware.c and other i2c drivers from Linux 2.6.33
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * Copyright (C) 2012 Thomas Langer <thomas.langer@lantiq.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h> /* for kzalloc, kfree */
> +#include <linux/i2c.h>
> +#include <linux/errno.h>
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_i2c.h>
> +
> +#include <lantiq_soc.h>
> +#include "i2c-lantiq.h"
> +
> +/* CURRENT ISSUES:
> + * - no high speed support
> + * - ten bit mode is not tested (no slave devices)
> + */
> +
> +/* access macros */
> +#define i2c_r32(reg)   \
> +       __raw_readl(&(priv->membase)->reg)
> +#define i2c_w32(val, reg)      \
> +       __raw_writel(val, &(priv->membase)->reg)
> +#define i2c_w32_mask(clear, set, reg)  \
> +       i2c_w32((i2c_r32(reg) & ~(clear)) | (set), reg)
> +
> +#define DRV_NAME "i2c-lantiq"
> +#define DRV_VERSION "1.00"
> +
> +#define LTQ_I2C_BUSY_TIMEOUT           20 /* ms */
> +
> +#ifdef DEBUG
> +#define LTQ_I2C_XFER_TIMEOUT           (25*HZ)
> +#else
> +#define LTQ_I2C_XFER_TIMEOUT           HZ
> +#endif
> +#if defined(DEBUG) && 0
> +#define PRINTK(arg...) pr_debug(arg)
> +#else
> +#define PRINTK(arg...) do {} while (0)
> +#endif
> +
> +#define LTQ_I2C_IMSC_DEFAULT_MASK      (I2C_IMSC_I2C_P_INT_EN | \
> +                                        I2C_IMSC_I2C_ERR_INT_EN)
> +
> +#define LTQ_I2C_ARB_LOST               (1 << 0)
> +#define LTQ_I2C_NACK                   (1 << 1)
> +#define LTQ_I2C_RX_UFL                 (1 << 2)
> +#define LTQ_I2C_RX_OFL                 (1 << 3)
> +#define LTQ_I2C_TX_UFL                 (1 << 4)
> +#define LTQ_I2C_TX_OFL                 (1 << 5)
> +
> +struct lantiq_i2c {
> +       struct mutex mutex;
> +
> +       /* active clock settings */
> +       unsigned int input_clock;       /* clock input for i2c hardware block */
> +       unsigned int i2c_clock;         /* approximated bus clock in kHz */
> +
> +       struct clk *clk_gate;
> +       struct clk *clk_input;
> +
> +       /* resources (memory and interrupts) */
> +       struct lantiq_reg_i2c __iomem *membase; /* base of mapped registers */
> +       int irq_lb, irq_b, irq_err, irq_p;      /* last burst, burst, error,
> +                                                  protocol IRQs */
> +
> +       struct i2c_adapter adap;
> +       struct device *dev;
> +
> +       struct completion cmd_complete;
> +
> +       /* message transfer data */
> +       /* current message */
> +       struct i2c_msg *current_msg;
> +       /* number of messages to handle */
> +       int msgs_num;
> +       /* current buffer */
> +       u8 *msg_buf;
> +       /* remaining length of current buffer */
> +       u32 msg_buf_len;
> +       /* error status of the current transfer */
> +       int msg_err;
> +
> +       /* master status codes */
> +       enum {
> +               STATUS_IDLE,
> +               STATUS_ADDR,    /* address phase */
> +               STATUS_WRITE,
> +               STATUS_READ,
> +               STATUS_READ_END,
> +               STATUS_STOP
> +       } status;
> +};
> +
> +static irqreturn_t lantiq_i2c_isr(int irq, void *dev_id);
> +
> +static inline void enable_burst_irq(struct lantiq_i2c *priv)
> +{
> +       i2c_w32_mask(0, I2C_IMSC_LBREQ_INT_EN | I2C_IMSC_BREQ_INT_EN, imsc);
> +}
> +static inline void disable_burst_irq(struct lantiq_i2c *priv)
> +{
> +       i2c_w32_mask(I2C_IMSC_LBREQ_INT_EN | I2C_IMSC_BREQ_INT_EN, 0, imsc);
> +}
> +
> +static void prepare_msg_send_addr(struct lantiq_i2c *priv)
> +{
> +       struct i2c_msg *msg = priv->current_msg;
> +       int rd = !!(msg->flags & I2C_M_RD);     /* extends to 0 or 1 */
> +       u16 addr = msg->addr;
> +
> +       /* new i2c_msg */
> +       priv->msg_buf = msg->buf;
> +       priv->msg_buf_len = msg->len;
> +       if (rd)
> +               priv->status = STATUS_READ;
> +       else
> +               priv->status = STATUS_WRITE;
> +
> +       /* send slave address */
> +       if (msg->flags & I2C_M_TEN) {
> +               i2c_w32(0xf0 | ((addr & 0x300) >> 7) | rd, txd);
> +               i2c_w32(addr & 0xff, txd);
> +       } else
> +               i2c_w32((addr & 0x7f) << 1 | rd, txd);
> +}
> +
> +static void lantiq_i2c_set_tx_len(struct lantiq_i2c *priv)
> +{
> +       struct i2c_msg *msg = priv->current_msg;
> +       int len = (msg->flags & I2C_M_TEN) ? 2 : 1;
> +
> +       PRINTK("set_tx_len %cX\n", (msg->flags & I2C_M_RD) ? 'R' : 'T');
> +
> +       priv->status = STATUS_ADDR;
> +
> +       if (!(msg->flags & I2C_M_RD)) {
> +               len += msg->len;
> +       } else {
> +               /* set maximum received packet size (before rx int!) */
> +               i2c_w32(msg->len, mrps_ctrl);
> +       }
> +       i2c_w32(len, tps_ctrl);
> +       enable_burst_irq(priv);
> +}
> +
> +static int lantiq_i2c_hw_set_clock(struct i2c_adapter *adap)
> +{
> +       struct lantiq_i2c *priv = i2c_get_adapdata(adap);
> +       unsigned int input_clock = clk_get_rate(priv->clk_input);
> +       u32 dec, inc = 1;
> +
> +       /* clock changed? */
> +       if (priv->input_clock == input_clock)
> +               return 0;
> +
> +       /*
> +        * this formula is only an approximation, found by the recommended
> +        * values in the "I2C Architecture Specification 1.7.1"
> +        */
> +       dec = input_clock / (priv->i2c_clock * 2);
> +       if (dec <= 6)
> +               return -ENXIO;
> +
> +       i2c_w32(0, fdiv_high_cfg);
> +       i2c_w32((inc << I2C_FDIV_CFG_INC_OFFSET) |
> +               (dec << I2C_FDIV_CFG_DEC_OFFSET),
> +               fdiv_cfg);
> +
> +       dev_info(priv->dev, "setup clocks (in %d kHz, bus %d kHz, dec=%d)\n",
> +               input_clock, priv->i2c_clock, dec);
> +
> +       priv->input_clock = input_clock;
> +       return 0;
> +}
> +
> +static int lantiq_i2c_hw_init(struct i2c_adapter *adap)
> +{
> +       int ret = 0;
> +       struct lantiq_i2c *priv = i2c_get_adapdata(adap);
> +
> +       /* disable bus */
> +       i2c_w32_mask(I2C_RUN_CTRL_RUN_EN, 0, run_ctrl);
> +
> +#ifndef DEBUG
> +       /* set normal operation clock divider */
> +       i2c_w32(1 << I2C_CLC_RMC_OFFSET, clc);
> +#else
> +       /* for debugging a higher divider value! */
> +       i2c_w32(0xF0 << I2C_CLC_RMC_OFFSET, clc);
> +#endif
> +
> +       /* setup clock */
> +       ret = lantiq_i2c_hw_set_clock(adap);
> +       if (ret != 0) {
> +               dev_warn(priv->dev, "invalid clock settings\n");
> +               return ret;
> +       }
> +
> +       /* configure fifo */
> +       i2c_w32(I2C_FIFO_CFG_TXFC | /* tx fifo as flow controller */
> +               I2C_FIFO_CFG_RXFC | /* rx fifo as flow controller */
> +               I2C_FIFO_CFG_TXFA_TXFA2 | /* tx fifo 4-byte aligned */
> +               I2C_FIFO_CFG_RXFA_RXFA2 | /* rx fifo 4-byte aligned */
> +               I2C_FIFO_CFG_TXBS_TXBS0 | /* tx fifo burst size is 1 word */
> +               I2C_FIFO_CFG_RXBS_RXBS0,  /* rx fifo burst size is 1 word */
> +               fifo_cfg);
> +
> +       /* configure address */
> +       i2c_w32(I2C_ADDR_CFG_SOPE_EN |  /* generate stop when no more data in
> +                                          the fifo */
> +               I2C_ADDR_CFG_SONA_EN |  /* generate stop when NA received */
> +               I2C_ADDR_CFG_MnS_EN |   /* we are master device */
> +               0,                      /* our slave address (not used!) */
> +               addr_cfg);
> +
> +       /* enable bus */
> +       i2c_w32_mask(0, I2C_RUN_CTRL_RUN_EN, run_ctrl);
> +
> +       return 0;
> +}
> +
> +static int lantiq_i2c_wait_bus_not_busy(struct lantiq_i2c *priv)
> +{
> +       int timeout = LTQ_I2C_BUSY_TIMEOUT;
> +
> +       while ((i2c_r32(bus_stat) & I2C_BUS_STAT_BS_MASK)
> +                                != I2C_BUS_STAT_BS_FREE) {
> +               if (timeout <= 0) {
> +                       dev_err(priv->dev, "timeout waiting for bus ready\n");
> +                       return -ETIMEDOUT;
> +               }
> +               timeout--;
> +               mdelay(1);
does it need to be busy?

> +       }
> +
> +       return 0;
> +}
> +
> +static void lantiq_i2c_tx(struct lantiq_i2c *priv, int last)
> +{
> +       if (priv->msg_buf_len && priv->msg_buf) {
> +               i2c_w32(*priv->msg_buf, txd);
> +
> +               if (--priv->msg_buf_len)
> +                       priv->msg_buf++;
> +               else
> +                       priv->msg_buf = NULL;
> +       } else
> +               last = 1;
> +
> +       if (last)
> +               disable_burst_irq(priv);
> +}
> +
> +static void lantiq_i2c_rx(struct lantiq_i2c *priv, int last)
> +{
> +       u32 fifo_stat, timeout;
> +       if (priv->msg_buf_len && priv->msg_buf) {
> +               timeout = 5000000;
> +               do {
> +                       fifo_stat = i2c_r32(ffs_stat);
> +               } while (!fifo_stat && --timeout);
> +               if (!timeout) {
> +                       last = 1;
> +                       PRINTK("\nrx timeout\n");
> +                       goto err;
> +               }
> +               while (fifo_stat) {
> +                       *priv->msg_buf = i2c_r32(rxd);
> +                       if (--priv->msg_buf_len)
> +                               priv->msg_buf++;
> +                       else {
> +                               priv->msg_buf = NULL;
> +                               last = 1;
> +                               break;
> +                       }
> +                       #if 0
> +                       fifo_stat = i2c_r32(ffs_stat);
> +                       #else
> +                       /* do not read more than burst size, otherwise no "last
> +                       burst" is generated and the transaction is blocked! */
> +                       fifo_stat = 0;
> +                       #endif
> +               }
> +       } else {
> +               last = 1;
> +       }
> +err:
> +       if (last) {
> +               disable_burst_irq(priv);
> +
> +               if (priv->status == STATUS_READ_END) {
> +                       /* do the STATUS_STOP and complete() here, as sometimes
> +                          the tx_end is already seen before this is finished */
> +                       priv->status = STATUS_STOP;
> +                       complete(&priv->cmd_complete);
> +               } else {
> +                       i2c_w32(I2C_ENDD_CTRL_SETEND, endd_ctrl);
> +                       priv->status = STATUS_READ_END;
> +               }
> +       }
> +}
> +
> +static void lantiq_i2c_xfer_init(struct lantiq_i2c *priv)
> +{
> +       /* enable interrupts */
> +       i2c_w32(LTQ_I2C_IMSC_DEFAULT_MASK, imsc);
> +
> +       /* trigger transfer of first msg */
> +       lantiq_i2c_set_tx_len(priv);
> +}
> +
> +static void dump_msgs(struct i2c_msg msgs[], int num, int rx)
> +{
> +#if defined(DEBUG)
> +       int i, j;
> +       pr_debug("Messages %d %s\n", num, rx ? "out" : "in");
> +       for (i = 0; i < num; i++) {
> +               pr_debug("%2d %cX Msg(%d) addr=0x%X: ", i,
> +                       (msgs[i].flags & I2C_M_RD) ? 'R' : 'T',
> +                       msgs[i].len, msgs[i].addr);
> +               if (!(msgs[i].flags & I2C_M_RD) || rx) {
> +                       for (j = 0; j < msgs[i].len; j++)
> +                               pr_debug("%02X ", msgs[i].buf[j]);
> +               }
> +               pr_debug("\n");
> +       }
> +#endif
> +}
> +
> +static void lantiq_i2c_release_bus(struct lantiq_i2c *priv)
> +{
> +       if ((i2c_r32(bus_stat) & I2C_BUS_STAT_BS_MASK) == I2C_BUS_STAT_BS_BM)
> +               i2c_w32(I2C_ENDD_CTRL_SETEND, endd_ctrl);
> +}
> +
> +static int lantiq_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
> +                          int num)
> +{
> +       struct lantiq_i2c *priv = i2c_get_adapdata(adap);
> +       int ret;
> +
> +       dev_dbg(priv->dev, "xfer %u messages\n", num);
> +       dump_msgs(msgs, num, 0);
> +
> +       mutex_lock(&priv->mutex);
> +
> +       INIT_COMPLETION(priv->cmd_complete);
> +       priv->current_msg = msgs;
> +       priv->msgs_num = num;
> +       priv->msg_err = 0;
> +       priv->status = STATUS_IDLE;
> +
> +       /* wait for the bus to become ready */
> +       ret = lantiq_i2c_wait_bus_not_busy(priv);
> +       if (ret)
> +               goto done;
> +
> +       while (priv->msgs_num) {
> +               /* start the transfers */
> +               lantiq_i2c_xfer_init(priv);
> +
> +               /* wait for transfers to complete */
> +               ret = wait_for_completion_interruptible_timeout(
> +                       &priv->cmd_complete, LTQ_I2C_XFER_TIMEOUT);
> +               if (ret == 0) {
> +                       dev_err(priv->dev, "controller timed out\n");
> +                       lantiq_i2c_hw_init(adap);
> +                       ret = -ETIMEDOUT;
> +                       goto done;
> +               } else if (ret < 0)
> +                       goto done;
> +
> +               if (priv->msg_err) {
> +                       if (priv->msg_err & LTQ_I2C_NACK)
> +                               ret = -ENXIO;
> +                       else
> +                               ret = -EREMOTEIO;
> +                       goto done;
> +               }
> +               if (--priv->msgs_num)
> +                       priv->current_msg++;
> +       }
> +       /* no error? */
> +       ret = num;
> +
> +done:
> +       lantiq_i2c_release_bus(priv);
> +
> +       mutex_unlock(&priv->mutex);
> +
> +       if (ret >= 0)
> +               dump_msgs(msgs, num, 1);
> +
> +       PRINTK("XFER ret %d\n", ret);
> +       return ret;
> +}
> +
> +static irqreturn_t lantiq_i2c_isr_burst(int irq, void *dev_id)
> +{
> +       struct lantiq_i2c *priv = dev_id;
> +       struct i2c_msg *msg = priv->current_msg;
> +       int last = (irq == priv->irq_lb);
> +
> +       if (last)
> +               PRINTK("LB ");
> +       else
> +               PRINTK("B ");
> +
> +       if (msg->flags & I2C_M_RD) {
> +               switch (priv->status) {
> +               case STATUS_ADDR:
> +                       PRINTK("X");
> +                       prepare_msg_send_addr(priv);
> +                       disable_burst_irq(priv);
> +                       break;
> +               case STATUS_READ:
> +               case STATUS_READ_END:
> +                       PRINTK("R");
> +                       lantiq_i2c_rx(priv, last);
> +                       break;
> +               default:
> +                       disable_burst_irq(priv);
> +                       pr_warn("Status R %d\n", priv->status);
> +                       break;
> +               }
> +       } else {
> +               switch (priv->status) {
> +               case STATUS_ADDR:
> +                       PRINTK("x");
> +                       prepare_msg_send_addr(priv);
> +                       break;
> +               case STATUS_WRITE:
> +                       PRINTK("w");
> +                       lantiq_i2c_tx(priv, last);
> +                       break;
> +               default:
> +                       disable_burst_irq(priv);
> +                       pr_warn("Status W %d\n", priv->status);
> +                       break;
> +               }
> +       }
> +
> +       i2c_w32(I2C_ICR_BREQ_INT_CLR | I2C_ICR_LBREQ_INT_CLR, icr);
> +       return IRQ_HANDLED;
> +}
> +
> +static void lantiq_i2c_isr_prot(struct lantiq_i2c *priv)
> +{
> +       u32 i_pro = i2c_r32(p_irqss);
> +
> +       PRINTK("i2c-p");
> +
> +       /* not acknowledge */
> +       if (i_pro & I2C_P_IRQSS_NACK) {
> +               priv->msg_err |= LTQ_I2C_NACK;
> +               PRINTK(" nack");
> +       }
> +
> +       /* arbitration lost */
> +       if (i_pro & I2C_P_IRQSS_AL) {
> +               priv->msg_err |= LTQ_I2C_ARB_LOST;
> +               PRINTK(" arb-lost");
> +       }
> +       /* tx -> rx switch */
> +       if (i_pro & I2C_P_IRQSS_RX)
> +               PRINTK(" rx");
> +
> +       /* tx end */
> +       if (i_pro & I2C_P_IRQSS_TX_END)
> +               PRINTK(" txend");
> +       PRINTK("\n");
> +
> +       if (!priv->msg_err) {
> +               /* tx -> rx switch */
> +               if (i_pro & I2C_P_IRQSS_RX) {
> +                       priv->status = STATUS_READ;
> +                       enable_burst_irq(priv);
> +               }
> +               if (i_pro & I2C_P_IRQSS_TX_END) {
> +                       if (priv->status == STATUS_READ)
> +                               priv->status = STATUS_READ_END;
> +                       else {
> +                               disable_burst_irq(priv);
> +                               priv->status = STATUS_STOP;
> +                       }
> +               }
> +       }
> +
> +       i2c_w32(i_pro, p_irqsc);
> +}
> +
> +static irqreturn_t lantiq_i2c_isr(int irq, void *dev_id)
> +{
> +       u32 i_raw, i_err = 0;
> +       struct lantiq_i2c *priv = dev_id;
> +
> +       i_raw = i2c_r32(mis);
> +       PRINTK("i_raw 0x%08X\n", i_raw);
using the dev_dbg ??
> +
> +       /* error interrupt */
> +       if (i_raw & I2C_RIS_I2C_ERR_INT_INTOCC) {
> +               i_err = i2c_r32(err_irqss);
> +               PRINTK("i_err 0x%08X bus_stat 0x%04X\n",
> +                       i_err, i2c_r32(bus_stat));
> +
> +               /* tx fifo overflow (8) */
> +               if (i_err & I2C_ERR_IRQSS_TXF_OFL)
> +                       priv->msg_err |= LTQ_I2C_TX_OFL;
> +
> +               /* tx fifo underflow (4) */
> +               if (i_err & I2C_ERR_IRQSS_TXF_UFL)
> +                       priv->msg_err |= LTQ_I2C_TX_UFL;
> +
> +               /* rx fifo overflow (2) */
> +               if (i_err & I2C_ERR_IRQSS_RXF_OFL)
> +                       priv->msg_err |= LTQ_I2C_RX_OFL;
> +
> +               /* rx fifo underflow (1) */
> +               if (i_err & I2C_ERR_IRQSS_RXF_UFL)
> +                       priv->msg_err |= LTQ_I2C_RX_UFL;
> +
> +               i2c_w32(i_err, err_irqsc);
> +       }
> +
> +       /* protocol interrupt */
> +       if (i_raw & I2C_RIS_I2C_P_INT_INTOCC)
> +               lantiq_i2c_isr_prot(priv);
> +
> +       if ((priv->msg_err) || (priv->status == STATUS_STOP))
> +               complete(&priv->cmd_complete);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static u32 lantiq_i2c_functionality(struct i2c_adapter *adap)
> +{
> +       return  I2C_FUNC_I2C |
> +               I2C_FUNC_10BIT_ADDR |
> +               I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static struct i2c_algorithm lantiq_i2c_algorithm = {
> +       .master_xfer    = lantiq_i2c_xfer,
> +       .functionality  = lantiq_i2c_functionality,
> +};
> +
> +static int __devinit lantiq_i2c_probe(struct platform_device *pdev)
> +{
> +       struct device_node *node = pdev->dev.of_node;
> +       struct lantiq_i2c *priv;
> +       struct i2c_adapter *adap;
> +       struct resource *mmres, irqres[4];
> +       int ret = 0;
> +
> +       dev_dbg(&pdev->dev, "probing\n");
> +
> +       mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       ret = of_irq_to_resource_table(node, irqres, 4);
> +       if (!mmres || (ret != 4)) {
> +               dev_err(&pdev->dev, "no resources\n");
> +               return -ENODEV;
> +       }
> +
> +       /* allocate private data */
> +       priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv) {
> +               dev_err(&pdev->dev, "can't allocate private data\n");
> +               return -ENOMEM;
> +       }
> +
> +       adap = &priv->adap;
> +       i2c_set_adapdata(adap, priv);
> +       adap->owner = THIS_MODULE;
> +       adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +       strlcpy(adap->name, DRV_NAME "-adapter", sizeof(adap->name));
> +       adap->algo = &lantiq_i2c_algorithm;
> +
> +       if (of_property_read_u32(node, "clock-frequency", &priv->i2c_clock)) {
> +               dev_warn(&pdev->dev, "No I2C speed selected, using 100kHz\n");
> +               priv->i2c_clock = 100000;
> +       }
> +
> +       init_completion(&priv->cmd_complete);
> +       mutex_init(&priv->mutex);
> +
> +       priv->membase = devm_request_and_ioremap(&pdev->dev, mmres);
> +       if (priv->membase == NULL)
> +               return -ENOMEM;
> +
> +       priv->clk_input = clk_get_fpi();
> +       if (IS_ERR(priv->clk_input)) {
> +               dev_err(&pdev->dev, "failed to get fpi clk\n");
> +               return -ENOENT;
> +       }
> +
> +       priv->clk_gate = clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(priv->clk_gate)) {
> +               dev_err(&pdev->dev, "failed to get i2c clk\n");
> +               return -ENOENT;
> +       }
> +       clk_activate(priv->clk_gate);
> +
> +       priv->dev = &pdev->dev;
> +       priv->irq_lb = irqres[0].start;
> +       ret = request_irq(priv->irq_lb, lantiq_i2c_isr_burst, IRQF_DISABLED,
> +                         "i2c lb", priv);
> +       if (ret) {
> +               dev_err(&pdev->dev, "can't get last burst IRQ %d\n",
> +                       irqres[0].start);
> +               return -ENODEV;
> +       }
> +
> +       priv->irq_b = irqres[1].start;
> +       ret = request_irq(priv->irq_b, lantiq_i2c_isr_burst, IRQF_DISABLED,
> +                         "i2c b", priv);
> +       if (ret) {
> +               dev_err(&pdev->dev, "can't get burst IRQ %d\n",
> +                       irqres[1].start);
Shouldnt lb be freed here ? Or how about using   devm_ instead

> +               return -ENODEV;
> +       }
> +
> +       priv->irq_err = irqres[2].start;
> +       ret = request_irq(priv->irq_err, lantiq_i2c_isr, IRQF_DISABLED,
> +                         "i2c err", priv);
> +       if (ret) {
> +               dev_err(&pdev->dev, "can't get error IRQ %d\n",
> +                       irqres[2].start);
same here .
> +               return -ENODEV;
> +       }
> +
> +       priv->irq_p = irqres[3].start;
> +       ret = request_irq(priv->irq_p, lantiq_i2c_isr, IRQF_DISABLED,
> +                         "i2c p", priv);
> +       if (ret) {
> +               dev_err(&pdev->dev, "can't get protocol IRQ %d\n",
> +                       irqres[3].start);
same here
> +               return -ENODEV;
> +       }
> +
> +       dev_dbg(&pdev->dev, "mapped io-space to %p\n", priv->membase);
> +       dev_dbg(&pdev->dev, "use IRQs %d, %d, %d, %d\n", irqres[0].start,
> +               irqres[1].start, irqres[2].start, irqres[3].start);
> +
> +       /* add our adapter to the i2c stack */
> +       ret = i2c_add_numbered_adapter(adap);
> +       if (ret) {
> +               dev_err(&pdev->dev, "can't register I2C adapter\n");
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, priv);
> +       i2c_set_adapdata(adap, priv);
> +
> +       /* print module version information */
> +       dev_dbg(&pdev->dev, "module id=%u revision=%u\n",
> +               (i2c_r32(id) & I2C_ID_ID_MASK) >> I2C_ID_ID_OFFSET,
> +               (i2c_r32(id) & I2C_ID_REV_MASK) >> I2C_ID_REV_OFFSET);
> +
> +       /* initialize HW */
> +       ret = lantiq_i2c_hw_init(adap);
> +       if (ret) {
> +               dev_err(&pdev->dev, "can't configure adapter\n");
> +               i2c_del_adapter(adap);
> +               platform_set_drvdata(pdev, NULL);
> +       } else {
> +               dev_info(&pdev->dev, "version %s\n", DRV_VERSION);
> +       }
> +
> +       of_i2c_register_devices(adap);
> +
> +       return ret;
> +}
> +
> +static int __devexit lantiq_i2c_remove(struct platform_device *pdev)
> +{
> +       struct lantiq_i2c *priv = platform_get_drvdata(pdev);
> +       struct resource *mmres;
> +
> +       /* disable bus */
> +       i2c_w32_mask(I2C_RUN_CTRL_RUN_EN, 0, run_ctrl);
> +
> +       /* remove driver */
> +       platform_set_drvdata(pdev, NULL);

Can you move this below as you are accessing it below right ?
You could consider  rmmod to test this.

> +       i2c_del_adapter(&priv->adap);
> +
> +       free_irq(priv->irq_lb, priv);
> +       free_irq(priv->irq_b, priv);
> +       free_irq(priv->irq_err, priv);
> +       free_irq(priv->irq_p, priv);
> +
> +       iounmap(priv->membase);

you used devm this shouldnt be needed?

> +
> +       kfree(priv);
> +
> +       mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       release_mem_region(mmres->start, resource_size(mmres));
> +
> +       dev_dbg(&pdev->dev, "removed\n");
> +
> +       return 0;
> +}
> +static const struct of_device_id ltq_i2c_match[] = {
> +       { .compatible = "lantiq,lantiq-i2c" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, ltq_i2c_match);
> +
> +static struct platform_driver lantiq_i2c_driver = {
> +       .probe  = lantiq_i2c_probe,
> +       .remove = __devexit_p(lantiq_i2c_remove),
> +       .driver = {
> +               .name   = DRV_NAME,
> +               .owner  = THIS_MODULE,
> +               .of_match_table = ltq_i2c_match,
> +       },
> +};
> +
> +module_platform_driver(lantiq_i2c_driver);
> +
> +MODULE_DESCRIPTION("Lantiq I2C bus adapter");
> +MODULE_AUTHOR("Thomas Langer <thomas.langer@lantiq.com>");
> +MODULE_ALIAS("platform:" DRV_NAME);
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> diff --git a/drivers/i2c/busses/i2c-lantiq.h b/drivers/i2c/busses/i2c-lantiq.h
> new file mode 100644
> index 0000000..7a86b89
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-lantiq.h
> @@ -0,0 +1,234 @@
> +#ifndef I2C_LANTIQ_H
> +#define I2C_LANTIQ_H
> +
> +/* I2C register structure */
> +struct lantiq_reg_i2c {
> +       /* I2C Kernel Clock Control Register */
> +       unsigned int clc; /* 0x00000000 */
> +       /* Reserved */
> +       unsigned int res_0; /* 0x00000004 */
> +       /* I2C Identification Register */
> +       unsigned int id; /* 0x00000008 */
> +       /* Reserved */
> +       unsigned int res_1; /* 0x0000000C */
> +       /*
> +        * I2C RUN Control Register
> +        * This register enables and disables the I2C peripheral. Before
> +        * enabling, the I2C has to be configured properly. After enabling
> +        * no configuration is possible
> +        */
> +       unsigned int run_ctrl; /* 0x00000010 */
> +       /*
> +        * I2C End Data Control Register
> +        * This register is used to either turn around the data transmission
> +        * direction or to address another slave without sending a stop
> +        * condition. Also the software can stop the slave-transmitter by
> +        * sending a not-accolade when working as master-receiver or even
> +        * stop data transmission immediately when operating as
> +        * master-transmitter. The writing to the bits of this control
> +        * register is only effective when in MASTER RECEIVES BYTES, MASTER
> +        * TRANSMITS BYTES, MASTER RESTART or SLAVE RECEIVE BYTES state
> +        */
> +       unsigned int endd_ctrl; /* 0x00000014 */
> +       /*
> +        * I2C Fractional Divider Configuration Register
> +        * These register is used to program the fractional divider of the I2C
> +        * bus. Before the peripheral is switched on by setting the RUN-bit the
> +        * two (fixed) values for the two operating frequencies are programmed
> +        * into these (configuration) registers. The Register FDIV_HIGH_CFG has
> +        * the same layout as I2C_FDIV_CFG.
> +        */
> +       unsigned int fdiv_cfg; /* 0x00000018 */
> +       /*
> +        * I2C Fractional Divider (highspeed mode) Configuration Register
> +        * These register is used to program the fractional divider of the I2C
> +        * bus. Before the peripheral is switched on by setting the RUN-bit the
> +        * two (fixed) values for the two operating frequencies are programmed
> +        * into these (configuration) registers. The Register FDIV_CFG has the
> +        * same layout as I2C_FDIV_CFG.
> +        */
> +       unsigned int fdiv_high_cfg; /* 0x0000001C */
> +       /* I2C Address Configuration Register */
> +       unsigned int addr_cfg; /* 0x00000020 */
> +       /* I2C Bus Status Register
> +        * This register gives a status information of the I2C. This additional
> +        * information can be used by the software to start proper actions.
> +        */
> +       unsigned int bus_stat; /* 0x00000024 */
> +       /* I2C FIFO Configuration Register */
> +       unsigned int fifo_cfg; /* 0x00000028 */
> +       /* I2C Maximum Received Packet Size Register */
> +       unsigned int mrps_ctrl; /* 0x0000002C */
> +       /* I2C Received Packet Size Status Register */
> +       unsigned int rps_stat; /* 0x00000030 */
> +       /* I2C Transmit Packet Size Register */
> +       unsigned int tps_ctrl; /* 0x00000034 */
> +       /* I2C Filled FIFO Stages Status Register */
> +       unsigned int ffs_stat; /* 0x00000038 */
> +       /* Reserved */
> +       unsigned int res_2; /* 0x0000003C */
> +       /* I2C Timing Configuration Register */
> +       unsigned int tim_cfg; /* 0x00000040 */
> +       /* Reserved */
> +       unsigned int res_3[7]; /* 0x00000044 */
> +       /* I2C Error Interrupt Request Source Mask Register */
> +       unsigned int err_irqsm; /* 0x00000060 */
> +       /* I2C Error Interrupt Request Source Status Register */
> +       unsigned int err_irqss; /* 0x00000064 */
> +       /* I2C Error Interrupt Request Source Clear Register */
> +       unsigned int err_irqsc; /* 0x00000068 */
> +       /* Reserved */
> +       unsigned int res_4; /* 0x0000006C */
> +       /* I2C Protocol Interrupt Request Source Mask Register */
> +       unsigned int p_irqsm; /* 0x00000070 */
> +       /* I2C Protocol Interrupt Request Source Status Register */
> +       unsigned int p_irqss; /* 0x00000074 */
> +       /* I2C Protocol Interrupt Request Source Clear Register */
> +       unsigned int p_irqsc; /* 0x00000078 */
> +       /* Reserved */
> +       unsigned int res_5; /* 0x0000007C */
> +       /* I2C Raw Interrupt Status Register */
> +       unsigned int ris; /* 0x00000080 */
> +       /* I2C Interrupt Mask Control Register */
> +       unsigned int imsc; /* 0x00000084 */
> +       /* I2C Masked Interrupt Status Register */
> +       unsigned int mis; /* 0x00000088 */
> +       /* I2C Interrupt Clear Register */
> +       unsigned int icr; /* 0x0000008C */
> +       /* I2C Interrupt Set Register */
> +       unsigned int isr; /* 0x00000090 */
> +       /* I2C DMA Enable Register */
> +       unsigned int dmae; /* 0x00000094 */
> +       /* Reserved */
> +       unsigned int res_6[8154]; /* 0x00000098 */
> +       /* I2C Transmit Data Register */
> +       unsigned int txd; /* 0x00008000 */
> +       /* Reserved */
> +       unsigned int res_7[4095]; /* 0x00008004 */
> +       /* I2C Receive Data Register */
> +       unsigned int rxd; /* 0x0000C000 */
> +       /* Reserved */
> +       unsigned int res_8[4095]; /* 0x0000C004 */
> +};
> +
> +/*
> + * Clock Divider for Normal Run Mode
> + * Max 8-bit divider value. IF RMC is 0 the module is disabled. Note: As long
> + * as the new divider value RMC is not valid, the register returns 0x0000 00xx
> + * on reading.
> + */
> +#define I2C_CLC_RMC_MASK 0x0000FF00
> +/* field offset */
> +#define I2C_CLC_RMC_OFFSET 8
> +
> +/* Fields of "I2C Identification Register" */
> +/* Module ID */
> +#define I2C_ID_ID_MASK 0x0000FF00
> +/* field offset */
> +#define I2C_ID_ID_OFFSET 8
> +/* Revision */
> +#define I2C_ID_REV_MASK 0x000000FF
> +/* field offset */
> +#define I2C_ID_REV_OFFSET 0
> +
> +/* Fields of "I2C Interrupt Mask Control Register" */
> +/* Enable */
> +#define I2C_IMSC_BREQ_INT_EN 0x00000008
> +/* Enable */
> +#define I2C_IMSC_LBREQ_INT_EN 0x00000004
> +
> +/* Fields of "I2C Fractional Divider Configuration Register" */
> +/* field offset */
> +#define I2C_FDIV_CFG_INC_OFFSET 16
> +
> +/* Fields of "I2C Interrupt Mask Control Register" */
> +/* Enable */
> +#define I2C_IMSC_I2C_P_INT_EN 0x00000020
> +/* Enable */
> +#define I2C_IMSC_I2C_ERR_INT_EN 0x00000010
> +
> +/* Fields of "I2C Error Interrupt Request Source Status Register" */
> +/* TXF_OFL */
> +#define I2C_ERR_IRQSS_TXF_OFL 0x00000008
> +/* TXF_UFL */
> +#define I2C_ERR_IRQSS_TXF_UFL 0x00000004
> +/* RXF_OFL */
> +#define I2C_ERR_IRQSS_RXF_OFL 0x00000002
> +/* RXF_UFL */
> +#define I2C_ERR_IRQSS_RXF_UFL 0x00000001
> +
> +/* Fields of "I2C Raw Interrupt Status Register" */
> +/* Read: Interrupt occurred. */
> +#define I2C_RIS_I2C_ERR_INT_INTOCC 0x00000010
> +/* Read: Interrupt occurred. */
> +#define I2C_RIS_I2C_P_INT_INTOCC 0x00000020
> +
> +/* Fields of "I2C FIFO Configuration Register" */
> +/* TX FIFO Flow Control */
> +#define I2C_FIFO_CFG_TXFC 0x00020000
> +/* RX FIFO Flow Control */
> +#define I2C_FIFO_CFG_RXFC 0x00010000
> +/* Word aligned (character alignment of four characters) */
> +#define I2C_FIFO_CFG_TXFA_TXFA2 0x00002000
> +/* Word aligned (character alignment of four characters) */
> +#define I2C_FIFO_CFG_RXFA_RXFA2 0x00000200
> +/* 1 word */
> +#define I2C_FIFO_CFG_TXBS_TXBS0 0x00000000
> +
> +/* Fields of "I2C FIFO Configuration Register" */
> +/* 1 word */
> +#define I2C_FIFO_CFG_RXBS_RXBS0 0x00000000
> +/* Stop on Packet End Enable */
> +#define I2C_ADDR_CFG_SOPE_EN 0x00200000
> +/* Stop on Not Acknowledge Enable */
> +#define I2C_ADDR_CFG_SONA_EN 0x00100000
> +/* Enable */
> +#define I2C_ADDR_CFG_MnS_EN 0x00080000
> +
> +/* Fields of "I2C Interrupt Clear Register" */
> +/* Clear */
> +#define I2C_ICR_BREQ_INT_CLR 0x00000008
> +/* Clear */
> +#define I2C_ICR_LBREQ_INT_CLR 0x00000004
> +
> +/* Fields of "I2C Fractional Divider Configuration Register" */
> +/* field offset */
> +#define I2C_FDIV_CFG_DEC_OFFSET 0
> +
> +/* Fields of "I2C Bus Status Register" */
> +/* Bus Status */
> +#define I2C_BUS_STAT_BS_MASK 0x00000003
> +/* Read from I2C Bus. */
> +#define I2C_BUS_STAT_RNW_READ 0x00000004
> +/* I2C Bus is free. */
> +#define I2C_BUS_STAT_BS_FREE 0x00000000
> +/*
> + * The device is working as master and has claimed the control on the
> + * I2C-bus (busy master).
> + */
> +#define I2C_BUS_STAT_BS_BM 0x00000002
> +
> +/* Fields of "I2C RUN Control Register" */
> +/* Enable */
> +#define I2C_RUN_CTRL_RUN_EN 0x00000001
> +
> +/* Fields of "I2C End Data Control Register" */
> +/*
> + * Set End of Transmission
> + * Note:Do not write '1' to this bit when bus is free. This will cause an
> + * abort after the first byte when a new transfer is started.
> + */
> +#define I2C_ENDD_CTRL_SETEND 0x00000002
> +
> +/* Fields of "I2C Protocol Interrupt Request Source Status Register" */
> +/* NACK */
> +#define I2C_P_IRQSS_NACK 0x00000010
> +/* AL */
> +#define I2C_P_IRQSS_AL 0x00000008
> +/* RX */
> +#define I2C_P_IRQSS_RX 0x00000040
> +/* TX_END */
> +#define I2C_P_IRQSS_TX_END 0x00000020
> +
> +
> +#endif /* I2C_LANTIQ_H */
> --
> 1.7.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
