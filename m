Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 12:12:49 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:41000 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903788Ab1KPLMo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 12:12:44 +0100
Received: by vws15 with SMTP id 15so9096492vws.36
        for <linux-mips@linux-mips.org>; Wed, 16 Nov 2011 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OTac6j2PsYpVo8Gacr9Cfm1WyVqmIq2HwVjPVLIxuZI=;
        b=H7xfOwZRY8il7/UFhttgO17fKoojkxoC+Kntu3t9ocmohaejxDlR975Orcciryxrxp
         JmK5WT+nPOcP8BgrbzJDRHeEPqcN1KuDf3csy3+IO40nr5UMhWrhV/2ksPmH1EEHp0Ls
         +KPgqJIkCd+ctSZh0KpnHFaEUwT3MQn7nL/RA=
MIME-Version: 1.0
Received: by 10.52.90.228 with SMTP id bz4mr49819249vdb.74.1321441957594; Wed,
 16 Nov 2011 03:12:37 -0800 (PST)
Received: by 10.220.186.70 with HTTP; Wed, 16 Nov 2011 03:12:37 -0800 (PST)
In-Reply-To: <1321379685-475-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <1321379685-475-1-git-send-email-jayachandranc@netlogicmicro.com>
Date:   Wed, 16 Nov 2011 16:42:37 +0530
Message-ID: <CAM=Q2ctWy4HbnO_KaXhJtNXHNF1KnMbLk9D6HfpjifS9QzxtYQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: Support for Netlogic XLR/XLS I2C controller.
From:   Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     linux-i2c@vger.kernel.org, ben-linux@fluff.org,
        linux-mips@linux-mips.org,
        Ganesan Ramalingam <ganesanr@netlogicmicro.com>
Content-Type: multipart/alternative; boundary=20cf307d060e79460804b1d82e99
X-archive-position: 31644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: omaplinuxkernel@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13301

--20cf307d060e79460804b1d82e99
Content-Type: text/plain; charset=ISO-8859-1

Hi Ganeshan,
Some minor comments.

On Tue, Nov 15, 2011 at 11:24 PM, Jayachandran C. <
jayachandranc@netlogicmicro.com> wrote:

> From: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
>
> Add support for the intergrated I2C controller on Netlogic
> XLR/XLS MIPS SoC.
>
> The changes are to add a new file i2c/buses/i2c-xlr.c, containing the
> i2c bus implementation, and to update i2c/buses/{Kconfig,Makefile} to
> add the CONFIG_I2C_XLR option.
>
> Signed-off-by: Ganesan Ramalingam <ganesanr@netlogicmicro.com>
> Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
> ---
>
> Changes from the last version is to remove the custom IO functions from
> netlogic headers and use __raw_readl/__raw_writel
>
> This has been sent out too many times now, please let me know if there
> are any comments.
>
>  drivers/i2c/busses/Kconfig   |   11 ++
>  drivers/i2c/busses/Makefile  |    1 +
>  drivers/i2c/busses/i2c-xlr.c |  318
> ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 330 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-xlr.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index a3afac4..c9f3db3 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -308,6 +308,17 @@ config I2C_AU1550
>          This driver can also be built as a module.  If so, the module
>          will be called i2c-au1550.
>
> +config I2C_XLR
> +       tristate "XLR I2C support"
> +       depends on CPU_XLR
> +       help
> +         This driver enables support for the on-chip I2C interface of
> +         the Netlogic XLR/XLS MIPS processors.
> +
> +         Say yes to this option if you have a Netlogic XLR/XLS based
> +         board and you need to access the I2C devices (typically the
> +         RTC, sensors, EEPROM) connected to this interface.
>

You already have tristate how about the module support

> +
>  config I2C_BLACKFIN_TWI
>        tristate "Blackfin TWI I2C support"
>        depends on BLACKFIN
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index fba6da6..4372dee 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_I2C_TEGRA)               += i2c-tegra.o
>  obj-$(CONFIG_I2C_VERSATILE)    += i2c-versatile.o
>  obj-$(CONFIG_I2C_OCTEON)       += i2c-octeon.o
>  obj-$(CONFIG_I2C_XILINX)       += i2c-xiic.o
> +obj-$(CONFIG_I2C_XLR)           += i2c-xlr.o
>  obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
>
>  # External I2C/SMBus adapter drivers
> diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
> new file mode 100644
> index 0000000..cc2f0a5
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-xlr.c
> @@ -0,0 +1,318 @@
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
> +
> +/* XLR I2C REGISTERS */
> +#define XLR_I2C_CFG            0x00
> +#define XLR_I2C_CLKDIV         0x01
> +#define XLR_I2C_DEVADDR                0x02
> +#define XLR_I2C_ADDR           0x03
> +#define XLR_I2C_DATAOUT                0x04
> +#define XLR_I2C_DATAIN         0x05
> +#define XLR_I2C_STATUS         0x06
> +#define XLR_I2C_STARTXFR       0x07
> +#define XLR_I2C_BYTECNT                0x08
> +#define XLR_I2C_HDSTATIM       0x09
> +
> +/* XLR I2C REGISTERS FLAGS */
> +#define XLR_I2C_BUS_BUSY       0x01
> +#define XLR_I2C_SDOEMPTY       0x02
> +#define XLR_I2C_RXRDY          0x04
> +#define XLR_I2C_ACK_ERR                0x08
> +#define XLR_I2C_ARB_STARTERR   0x30
> +
> +/* Register Programming Values!! Change as required */
> +#define XLR_I2C_CFG_ADDR       0xF8    /* 8-Bit dev Addr + POR Values */
> +#define XLR_I2C_CFG_NOADDR     0xFA    /* 8-Bit reg Addr + POR Values */
> +#define XLR_I2C_STARTXFR_ND    0x02    /* No data , only addr */
> +#define XLR_I2C_STARTXFR_RD    0x01    /* Read */
> +#define XLR_I2C_STARTXFR_WR    0x00    /* Write */
> +#define XLR_I2C_CLKDIV_DEF     0x14A   /* 0x00000052 */
> +#define XLR_I2C_HDSTATIM_DEF   0x107   /* 0x00000000 */
> +
> +#define XLR_I2C_IO_SIZE                0x1000
> +
> +
> +/*
> + * Need un-swapped IO for the SoC I2C registers, use __raw_ IO
> + */
> +static inline void xlr_i2c_wreg(u32 __iomem *base, unsigned int reg, u32
> val)
> +{
> +       base += reg;
> +       __raw_writel(val, base);
> +}
> +
> +static inline u32 xlr_i2c_rdreg(u32 __iomem *base, unsigned int reg)
> +{
> +       base += reg;
> +       return __raw_readl(base);
> +}
> +
> +struct xlr_i2c_private {
> +       struct i2c_adapter adap;
> +       u32 __iomem *iobase;
> +};
> +
> +static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
> +               u8 *buf, u16 addr)
> +{
> +       u32 i2c_status = 0x00;
> +       u8 nb;
> +       int pos, timeout = 0;
> +       struct i2c_adapter *adap = &priv->adap;
> +       u8 offset = buf[0];
> +
> +       xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
> +       xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
> +       xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
> +       xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len-1);
> +
> +retry:
> +       timeout = 0;
> +       pos = 1;
> +       if (len == 1) {
> +               xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
> +                               XLR_I2C_STARTXFR_ND);
> +       } else {
> +               xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[pos]);
> +               xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
> +                               XLR_I2C_STARTXFR_WR);
> +       }
> +
> +       while (1) {
> +               if (timeout++ > 0x1000) {
>

Could this be a macro?



> +                       dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD Rx
> Timeout\n");
> +                       return -ETIMEDOUT;
> +               }
> +
> +               i2c_status = xlr_i2c_rdreg(priv->iobase,
> +                               XLR_I2C_STATUS);
> +
> +               if (i2c_status & XLR_I2C_SDOEMPTY) {
> +                       pos++;
> +                       nb = (pos < len) ? buf[pos] : 0;
> +                       xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, nb);
> +               }
> +
> +               if (i2c_status & XLR_I2C_ARB_STARTERR)
> +                       goto retry;
> +
> +               if (i2c_status & XLR_I2C_ACK_ERR) {
> +                       return -EIO;
> +               }
> +
> +               if (i2c_status & XLR_I2C_BUS_BUSY) {
> +                       udelay(1);
> +                       continue;
> +               }
> +
> +               if (pos >= len)
> +                       break;
> +       }
> +
> +       return 0;
> +}
> +
> +static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len,
> +               u8 *buf, u16 addr)
> +{
> +       u32 i2c_status = 0x00;
> +       int pos = 0;
> +       int timeout = 0;
> +       struct i2c_adapter *adap = &priv->adap;
> +
> +       xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_NOADDR);
> +       xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len);
> +       xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
> +
> +retry:
> +       timeout = 0;
> +       xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
> +                       XLR_I2C_STARTXFR_RD);
> +
> +       while (1) {
> +               if (timeout++ > 0x1000) {
> +                       dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD Rx
> Timeout\n");
> +                       return -ETIMEDOUT;
> +               }
> +
> +               i2c_status = xlr_i2c_rdreg(priv->iobase,
> +                               XLR_I2C_STATUS);
> +               if (i2c_status & XLR_I2C_RXRDY) {
> +                       buf[pos++] = (u8)xlr_i2c_rdreg(priv->iobase,
> +                                       XLR_I2C_DATAIN);
> +               }
> +
> +               if (i2c_status & XLR_I2C_ARB_STARTERR)
> +                       goto retry;
> +
> +               if (i2c_status & XLR_I2C_ACK_ERR) {
> +                       dev_err(&adap->dev, "XLR_I2C_STARTXFR_RD ACK
> ERR\n");
> +                       return -EIO;
> +               }
> +
> +               if ((i2c_status & XLR_I2C_BUS_BUSY) == 0)
> +                       break;
> +               udelay(1);
> +       }
> +       return 0;
> +}
> +
> +static int xlr_i2c_xfer(struct i2c_adapter *adap,
> +               struct i2c_msg *msgs, int num)
> +{
> +       struct i2c_msg *msg;
> +       int i;
> +       int ret = 0;
> +       struct xlr_i2c_private *priv = i2c_get_adapdata(adap);
> +
> +       for (i = 0; ret == 0 && i < num; i++) {
> +               msg = &msgs[i];
> +               if (msg->flags & I2C_M_RD)
> +                       ret = xlr_i2c_rx(priv, msg->len, &msg->buf[0],
> +                                       msg->addr);
> +               else
> +                       ret = xlr_i2c_tx(priv, msg->len, &msg->buf[0],
> +                                       msg->addr);
> +       }
> +
> +       return (ret != 0) ? ret : num;
> +}
> +
> +static u32 xlr_func(struct i2c_adapter *adap)
> +{
> +       /* Emulate SMBUS over I2C */
> +       return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
> +}
> +
> +static struct i2c_algorithm xlr_i2c_algo = {
> +       .master_xfer    = xlr_i2c_xfer,
> +       .functionality  = xlr_func,
> +};
> +
> +static int xlr_i2c_add_bus(struct xlr_i2c_private *priv)
> +{
> +       priv->adap.owner        = THIS_MODULE;
> +       priv->adap.algo_data    = priv;
> +       priv->adap.nr           = 1;
> +       priv->adap.algo         = &xlr_i2c_algo;
> +       priv->adap.class        = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +       snprintf(priv->adap.name, sizeof(priv->adap.name),
> +                       "SMBus XLR I2C Adapter");
> +       i2c_set_adapdata(&priv->adap, priv);
> +       /* register new adapter to i2c module... */
> +       if (i2c_add_numbered_adapter(&priv->adap))
> +               return -1;
> +
> +       return 0;
> +}
> +
> +static int __devinit xlr_i2c_probe(struct platform_device *pdev)
> +{
> +       struct xlr_i2c_private  *priv;
> +       struct resource *res;
> +       int ret;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +       if (!res) {
> +               ret = -ENXIO;
> +               goto err1;
> +       }
> +
> +       if (!request_mem_region(res->start, XLR_I2C_IO_SIZE, pdev->name)) {
> +               dev_err(&pdev->dev, "request_mem_region failed\n");
> +               ret = -ENOMEM;
> +               goto err1;
>
The names could be more meaningful like err_req_mem or err_get_res etc.

> +       }
> +
> +       priv = kzalloc(sizeof(struct xlr_i2c_private), GFP_KERNEL);
> +       if (!priv) {
> +               ret = -ENOMEM;
> +               goto err2;
> +       }
> +
> +       priv->adap.dev.parent = &pdev->dev;
> +       priv->iobase = (u32 *)ioremap(res->start, XLR_I2C_IO_SIZE);
> +       if (!priv->iobase) {
> +               ret = -ENOMEM;
> +               goto err3;
> +       }
> +
> +       platform_set_drvdata(pdev, priv);
> +       ret = xlr_i2c_add_bus(priv);
> +
> +       if (ret < 0) {
> +               dev_err(&priv->adap.dev, "Failed to add i2c bus\n");
> +               ret = -ENXIO;
> +               goto err4;
> +       } else
> +               dev_info(&priv->adap.dev, "Added I2C Bus.\n");
> +
> +       return 0;
> +err4:
> +       iounmap(priv->iobase);
> +       platform_set_drvdata(pdev, NULL);
> +err3:
> +       kfree(priv);
> +err2:
> +       release_mem_region(res->start, IORESOURCE_MEM);
> +err1:
> +       return ret;
> +}
> +
> +static int __devexit xlr_i2c_remove(struct platform_device *pdev)
> +{
> +       struct xlr_i2c_private *priv = platform_get_drvdata(pdev);
> +       struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM,
> 0);
> +
> +       i2c_del_adapter(&priv->adap);
> +       iounmap(priv->iobase);
> +       kfree(priv);
> +       release_mem_region(res->start, IORESOURCE_MEM);
> +       platform_set_drvdata(pdev, NULL);
> +       return 0;
> +}
> +
> +static struct platform_driver xlr_i2c_driver = {
> +       .probe  = xlr_i2c_probe,
> +       .remove = __devexit_p(xlr_i2c_remove),
> +       .driver = {
> +               .owner  = THIS_MODULE,
> +               .name   = "xlr-i2cbus",
> +       },
> +};
> +
> +static int __init xlr_i2c_init(void)
> +{
> +       return platform_driver_register(&xlr_i2c_driver);
> +}
> +
> +static void __exit xlr_i2c_exit(void)
> +{
> +       platform_driver_unregister(&xlr_i2c_driver);
> +}
> +
> +MODULE_AUTHOR("Ganesan Ramalingam <ganesanr@netlogicmicro.com>");
> +MODULE_DESCRIPTION("XLR I2C SMBus driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:xlr-i2cbus");
> +
> +module_init(xlr_i2c_init);
> +module_exit(xlr_i2c_exit);
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--20cf307d060e79460804b1d82e99
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ganeshan,<br>Some minor comments.<br><br><div class=3D"gmail_quote">On T=
ue, Nov 15, 2011 at 11:24 PM, Jayachandran C. <span dir=3D"ltr">&lt;<a href=
=3D"mailto:jayachandranc@netlogicmicro.com">jayachandranc@netlogicmicro.com=
</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">From: Ganesan Ram=
alingam &lt;<a href=3D"mailto:ganesanr@netlogicmicro.com">ganesanr@netlogic=
micro.com</a>&gt;<br>

<br>
Add support for the intergrated I2C controller on Netlogic<br>
XLR/XLS MIPS SoC.<br>
<br>
The changes are to add a new file i2c/buses/i2c-xlr.c, containing the<br>
i2c bus implementation, and to update i2c/buses/{Kconfig,Makefile} to<br>
add the CONFIG_I2C_XLR option.<br>
<br>
Signed-off-by: Ganesan Ramalingam &lt;<a href=3D"mailto:ganesanr@netlogicmi=
cro.com">ganesanr@netlogicmicro.com</a>&gt;<br>
Signed-off-by: Jayachandran C &lt;<a href=3D"mailto:jayachandranc@netlogicm=
icro.com">jayachandranc@netlogicmicro.com</a>&gt;<br>
---<br>
<br>
Changes from the last version is to remove the custom IO functions from<br>
netlogic headers and use __raw_readl/__raw_writel<br>
<br>
This has been sent out too many times now, please let me know if there<br>
are any comments.<br>
<br>
=A0drivers/i2c/busses/Kconfig =A0 | =A0 11 ++<br>
=A0drivers/i2c/busses/Makefile =A0| =A0 =A01 +<br>
=A0drivers/i2c/busses/i2c-xlr.c | =A0318 ++++++++++++++++++++++++++++++++++=
++++++++<br>
=A03 files changed, 330 insertions(+), 0 deletions(-)<br>
=A0create mode 100644 drivers/i2c/busses/i2c-xlr.c<br>
<br>
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig<br>
index a3afac4..c9f3db3 100644<br>
--- a/drivers/i2c/busses/Kconfig<br>
+++ b/drivers/i2c/busses/Kconfig<br>
@@ -308,6 +308,17 @@ config I2C_AU1550<br>
 =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, th=
e module<br>
 =A0 =A0 =A0 =A0 =A0will be called i2c-au1550.<br>
<br>
+config I2C_XLR<br>
+ =A0 =A0 =A0 tristate &quot;XLR I2C support&quot;<br>
+ =A0 =A0 =A0 depends on CPU_XLR<br>
+ =A0 =A0 =A0 help<br>
+ =A0 =A0 =A0 =A0 This driver enables support for the on-chip I2C interface=
 of<br>
+ =A0 =A0 =A0 =A0 the Netlogic XLR/XLS MIPS processors.<br>
+<br>
+ =A0 =A0 =A0 =A0 Say yes to this option if you have a Netlogic XLR/XLS bas=
ed<br>
+ =A0 =A0 =A0 =A0 board and you need to access the I2C devices (typically t=
he<br>
+ =A0 =A0 =A0 =A0 RTC, sensors, EEPROM) connected to this interface.<br></b=
lockquote><div><br>You already have tristate how about the module support <=
br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

+<br>
=A0config I2C_BLACKFIN_TWI<br>
 =A0 =A0 =A0 =A0tristate &quot;Blackfin TWI I2C support&quot;<br>
 =A0 =A0 =A0 =A0depends on BLACKFIN<br>
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile<br>
index fba6da6..4372dee 100644<br>
--- a/drivers/i2c/busses/Makefile<br>
+++ b/drivers/i2c/busses/Makefile<br>
@@ -68,6 +68,7 @@ obj-$(CONFIG_I2C_TEGRA) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D =
i2c-tegra.o<br>
=A0obj-$(CONFIG_I2C_VERSATILE) =A0 =A0+=3D i2c-versatile.o<br>
=A0obj-$(CONFIG_I2C_OCTEON) =A0 =A0 =A0 +=3D i2c-octeon.o<br>
=A0obj-$(CONFIG_I2C_XILINX) =A0 =A0 =A0 +=3D i2c-xiic.o<br>
+obj-$(CONFIG_I2C_XLR) =A0 =A0 =A0 =A0 =A0 +=3D i2c-xlr.o<br>
=A0obj-$(CONFIG_I2C_EG20T) =A0 =A0 =A0 =A0 +=3D i2c-eg20t.o<br>
<br>
=A0# External I2C/SMBus adapter drivers<br>
diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c<br=
>
new file mode 100644<br>
index 0000000..cc2f0a5<br>
--- /dev/null<br>
+++ b/drivers/i2c/busses/i2c-xlr.c<br>
@@ -0,0 +1,318 @@<br>
+/*<br>
+ * Copyright 2011, Netlogic Microsystems Inc.<br>
+ * Copyright 2004, Matt Porter &lt;<a href=3D"mailto:mporter@kernel.crashi=
ng.org">mporter@kernel.crashing.org</a>&gt;<br>
+ *<br>
+ * This file is licensed under the terms of the GNU General Public<br>
+ * License version 2. =A0This program is licensed &quot;as is&quot; withou=
t any<br>
+ * warranty of any kind, whether express or implied.<br>
+ */<br>
+<br>
+#include &lt;linux/kernel.h&gt;<br>
+#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/slab.h&gt;<br>
+#include &lt;linux/init.h&gt;<br>
+#include &lt;linux/ioport.h&gt;<br>
+#include &lt;linux/delay.h&gt;<br>
+#include &lt;linux/errno.h&gt;<br>
+#include &lt;linux/i2c.h&gt;<br>
+#include &lt;linux/io.h&gt;<br>
+#include &lt;linux/platform_device.h&gt;<br>
+<br>
+/* XLR I2C REGISTERS */<br>
+#define XLR_I2C_CFG =A0 =A0 =A0 =A0 =A0 =A00x00<br>
+#define XLR_I2C_CLKDIV =A0 =A0 =A0 =A0 0x01<br>
+#define XLR_I2C_DEVADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x02<br>
+#define XLR_I2C_ADDR =A0 =A0 =A0 =A0 =A0 0x03<br>
+#define XLR_I2C_DATAOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x04<br>
+#define XLR_I2C_DATAIN =A0 =A0 =A0 =A0 0x05<br>
+#define XLR_I2C_STATUS =A0 =A0 =A0 =A0 0x06<br>
+#define XLR_I2C_STARTXFR =A0 =A0 =A0 0x07<br>
+#define XLR_I2C_BYTECNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x08<br>
+#define XLR_I2C_HDSTATIM =A0 =A0 =A0 0x09<br>
+<br>
+/* XLR I2C REGISTERS FLAGS */<br>
+#define XLR_I2C_BUS_BUSY =A0 =A0 =A0 0x01<br>
+#define XLR_I2C_SDOEMPTY =A0 =A0 =A0 0x02<br>
+#define XLR_I2C_RXRDY =A0 =A0 =A0 =A0 =A00x04<br>
+#define XLR_I2C_ACK_ERR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x08<br>
+#define XLR_I2C_ARB_STARTERR =A0 0x30<br>
+<br>
+/* Register Programming Values!! Change as required */<br>
+#define XLR_I2C_CFG_ADDR =A0 =A0 =A0 0xF8 =A0 =A0/* 8-Bit dev Addr + POR V=
alues */<br>
+#define XLR_I2C_CFG_NOADDR =A0 =A0 0xFA =A0 =A0/* 8-Bit reg Addr + POR Val=
ues */<br>
+#define XLR_I2C_STARTXFR_ND =A0 =A00x02 =A0 =A0/* No data , only addr */<b=
r>
+#define XLR_I2C_STARTXFR_RD =A0 =A00x01 =A0 =A0/* Read */<br>
+#define XLR_I2C_STARTXFR_WR =A0 =A00x00 =A0 =A0/* Write */<br>
+#define XLR_I2C_CLKDIV_DEF =A0 =A0 0x14A =A0 /* 0x00000052 */<br>
+#define XLR_I2C_HDSTATIM_DEF =A0 0x107 =A0 /* 0x00000000 */<br>
+<br>
+#define XLR_I2C_IO_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1000<br>
+<br>
+<br>
+/*<br>
+ * Need un-swapped IO for the SoC I2C registers, use __raw_ IO<br>
+ */<br>
+static inline void xlr_i2c_wreg(u32 __iomem *base, unsigned int reg, u32 v=
al)<br>
+{<br>
+ =A0 =A0 =A0 base +=3D reg;<br>
+ =A0 =A0 =A0 __raw_writel(val, base);<br>
+}<br>
+<br>
+static inline u32 xlr_i2c_rdreg(u32 __iomem *base, unsigned int reg)<br>
+{<br>
+ =A0 =A0 =A0 base +=3D reg;<br>
+ =A0 =A0 =A0 return __raw_readl(base);<br>
+}<br>
+<br>
+struct xlr_i2c_private {<br>
+ =A0 =A0 =A0 struct i2c_adapter adap;<br>
+ =A0 =A0 =A0 u32 __iomem *iobase;<br>
+};<br>
+<br>
+static int xlr_i2c_tx(struct xlr_i2c_private *priv, =A0u16 len,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *buf, u16 addr)<br>
+{<br>
+ =A0 =A0 =A0 u32 i2c_status =3D 0x00;<br>
+ =A0 =A0 =A0 u8 nb;<br>
+ =A0 =A0 =A0 int pos, timeout =3D 0;<br>
+ =A0 =A0 =A0 struct i2c_adapter *adap =3D &amp;priv-&gt;adap;<br>
+ =A0 =A0 =A0 u8 offset =3D buf[0];<br>
+<br>
+ =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_ADDR, offset);<br>
+ =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_DEVADDR, addr);<br>
+ =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);=
<br>
+ =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_BYTECNT, len-1);<br>
+<br>
+retry:<br>
+ =A0 =A0 =A0 timeout =3D 0;<br>
+ =A0 =A0 =A0 pos =3D 1;<br>
+ =A0 =A0 =A0 if (len =3D=3D 1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_STARTXF=
R,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XLR_I2C_START=
XFR_ND);<br>
+ =A0 =A0 =A0 } else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_DATAOUT=
, buf[pos]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_STARTXF=
R,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XLR_I2C_START=
XFR_WR);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 while (1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout++ &gt; 0x1000) {<br></blockquote>=
<div><br>Could this be a macro?<br><br>=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, =
204, 204); padding-left: 1ex;">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;adap-&gt;dev, &q=
uot;XLR_I2C_STARTXFR_RD Rx Timeout\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_status =3D xlr_i2c_rdreg(priv-&gt;iobase,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XLR_I2C_STATU=
S);<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_status &amp; XLR_I2C_SDOEMPTY) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pos++;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nb =3D (pos &lt; len) ? buf[p=
os] : 0;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase,=
 XLR_I2C_DATAOUT, nb);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_status &amp; XLR_I2C_ARB_STARTERR)<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto retry;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_status &amp; XLR_I2C_ACK_ERR) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_status &amp; XLR_I2C_BUS_BUSY) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pos &gt;=3D len)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 *buf, u16 addr)<br>
+{<br>
+ =A0 =A0 =A0 u32 i2c_status =3D 0x00;<br>
+ =A0 =A0 =A0 int pos =3D 0;<br>
+ =A0 =A0 =A0 int timeout =3D 0;<br>
+ =A0 =A0 =A0 struct i2c_adapter *adap =3D &amp;priv-&gt;adap;<br>
+<br>
+ =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_CFG, XLR_I2C_CFG_NOADDR=
);<br>
+ =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_BYTECNT, len);<br>
+ =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_DEVADDR, addr);<br>
+<br>
+retry:<br>
+ =A0 =A0 =A0 timeout =3D 0;<br>
+ =A0 =A0 =A0 xlr_i2c_wreg(priv-&gt;iobase, XLR_I2C_STARTXFR,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XLR_I2C_STARTXFR_RD);<br>
+<br>
+ =A0 =A0 =A0 while (1) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout++ &gt; 0x1000) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;adap-&gt;dev, &q=
uot;XLR_I2C_STARTXFR_RD Rx Timeout\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_status =3D xlr_i2c_rdreg(priv-&gt;iobase,=
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 XLR_I2C_STATU=
S);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_status &amp; XLR_I2C_RXRDY) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[pos++] =3D (u8)xlr_i2c_rd=
reg(priv-&gt;iobase,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 XLR_I2C_DATAIN);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_status &amp; XLR_I2C_ARB_STARTERR)<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto retry;<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_status &amp; XLR_I2C_ACK_ERR) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;adap-&gt;dev, &q=
uot;XLR_I2C_STARTXFR_RD ACK ERR\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i2c_status &amp; XLR_I2C_BUS_BUSY) =3D=
=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int xlr_i2c_xfer(struct i2c_adapter *adap,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_msg *msgs, int num)<br>
+{<br>
+ =A0 =A0 =A0 struct i2c_msg *msg;<br>
+ =A0 =A0 =A0 int i;<br>
+ =A0 =A0 =A0 int ret =3D 0;<br>
+ =A0 =A0 =A0 struct xlr_i2c_private *priv =3D i2c_get_adapdata(adap);<br>
+<br>
+ =A0 =A0 =A0 for (i =3D 0; ret =3D=3D 0 &amp;&amp; i &lt; num; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg =3D &amp;msgs[i];<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msg-&gt;flags &amp; I2C_M_RD)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D xlr_i2c_rx(priv, msg-=
&gt;len, &amp;msg-&gt;buf[0],<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 msg-&gt;addr);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D xlr_i2c_tx(priv, msg-=
&gt;len, &amp;msg-&gt;buf[0],<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 msg-&gt;addr);<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 return (ret !=3D 0) ? ret : num;<br>
+}<br>
+<br>
+static u32 xlr_func(struct i2c_adapter *adap)<br>
+{<br>
+ =A0 =A0 =A0 /* Emulate SMBUS over I2C */<br>
+ =A0 =A0 =A0 return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;<br>
+}<br>
+<br>
+static struct i2c_algorithm xlr_i2c_algo =3D {<br>
+ =A0 =A0 =A0 .master_xfer =A0 =A0=3D xlr_i2c_xfer,<br>
+ =A0 =A0 =A0 .functionality =A0=3D xlr_func,<br>
+};<br>
+<br>
+static int xlr_i2c_add_bus(struct xlr_i2c_private *priv)<br>
+{<br>
+ =A0 =A0 =A0 priv-&gt;adap.owner =A0 =A0 =A0 =A0=3D THIS_MODULE;<br>
+ =A0 =A0 =A0 priv-&gt;adap.algo_data =A0 =A0=3D priv;<br>
+ =A0 =A0 =A0 priv-&gt;<a href=3D"http://adap.nr" target=3D"_blank">adap.nr=
</a> =A0 =A0 =A0 =A0 =A0 =3D 1;<br>
+ =A0 =A0 =A0 priv-&gt;adap.algo =A0 =A0 =A0 =A0 =3D &amp;xlr_i2c_algo;<br>
+ =A0 =A0 =A0 priv-&gt;adap.class =A0 =A0 =A0 =A0=3D I2C_CLASS_HWMON | I2C_=
CLASS_SPD;<br>
+ =A0 =A0 =A0 snprintf(priv-&gt;<a href=3D"http://adap.name" target=3D"_bla=
nk">adap.name</a>, sizeof(priv-&gt;<a href=3D"http://adap.name" target=3D"_=
blank">adap.name</a>),<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;SMBus XLR I2C Adapter&q=
uot;);<br>
+ =A0 =A0 =A0 i2c_set_adapdata(&amp;priv-&gt;adap, priv);<br>
+ =A0 =A0 =A0 /* register new adapter to i2c module... */<br>
+ =A0 =A0 =A0 if (i2c_add_numbered_adapter(&amp;priv-&gt;adap))<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int __devinit xlr_i2c_probe(struct platform_device *pdev)<br>
+{<br>
+ =A0 =A0 =A0 struct xlr_i2c_private =A0*priv;<br>
+ =A0 =A0 =A0 struct resource *res;<br>
+ =A0 =A0 =A0 int ret;<br>
+<br>
+ =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);<br>
+<br>
+ =A0 =A0 =A0 if (!res) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (!request_mem_region(res-&gt;start, XLR_I2C_IO_SIZE, pdev-=
&gt;name)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;request_mem_=
region failed\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err1;<br></blockquote><div>The names cou=
ld be more meaningful like err_req_mem or err_get_res etc. <br></div><block=
quote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left=
: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 priv =3D kzalloc(sizeof(struct xlr_i2c_private), GFP_KERNEL);=
<br>
+ =A0 =A0 =A0 if (!priv) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err2;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 priv-&gt;adap.dev.parent =3D &amp;pdev-&gt;dev;<br>
+ =A0 =A0 =A0 priv-&gt;iobase =3D (u32 *)ioremap(res-&gt;start, XLR_I2C_IO_=
SIZE);<br>
+ =A0 =A0 =A0 if (!priv-&gt;iobase) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err3;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 platform_set_drvdata(pdev, priv);<br>
+ =A0 =A0 =A0 ret =3D xlr_i2c_add_bus(priv);<br>
+<br>
+ =A0 =A0 =A0 if (ret &lt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;priv-&gt;adap.dev, &quot;Failed =
to add i2c bus\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err4;<br>
+ =A0 =A0 =A0 } else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&amp;priv-&gt;adap.dev, &quot;Added =
I2C Bus.\n&quot;);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+err4:<br>
+ =A0 =A0 =A0 iounmap(priv-&gt;iobase);<br>
+ =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);<br>
+err3:<br>
+ =A0 =A0 =A0 kfree(priv);<br>
+err2:<br>
+ =A0 =A0 =A0 release_mem_region(res-&gt;start, IORESOURCE_MEM);<br>
+err1:<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static int __devexit xlr_i2c_remove(struct platform_device *pdev)<br>
+{<br>
+ =A0 =A0 =A0 struct xlr_i2c_private *priv =3D platform_get_drvdata(pdev);<=
br>
+ =A0 =A0 =A0 struct resource *res =3D platform_get_resource(pdev, IORESOUR=
CE_MEM, 0);<br>
+<br>
+ =A0 =A0 =A0 i2c_del_adapter(&amp;priv-&gt;adap);<br>
+ =A0 =A0 =A0 iounmap(priv-&gt;iobase);<br>
+ =A0 =A0 =A0 kfree(priv);<br>
+ =A0 =A0 =A0 release_mem_region(res-&gt;start, IORESOURCE_MEM);<br>
+ =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static struct platform_driver xlr_i2c_driver =3D {<br>
+ =A0 =A0 =A0 .probe =A0=3D xlr_i2c_probe,<br>
+ =A0 =A0 =A0 .remove =3D __devexit_p(xlr_i2c_remove),<br>
+ =A0 =A0 =A0 .driver =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D &quot;xlr-i2cbus&quot;,<br>
+ =A0 =A0 =A0 },<br>
+};<br>
+<br>
+static int __init xlr_i2c_init(void)<br>
+{<br>
+ =A0 =A0 =A0 return platform_driver_register(&amp;xlr_i2c_driver);<br>
+}<br>
+<br>
+static void __exit xlr_i2c_exit(void)<br>
+{<br>
+ =A0 =A0 =A0 platform_driver_unregister(&amp;xlr_i2c_driver);<br>
+}<br>
+<br>
+MODULE_AUTHOR(&quot;Ganesan Ramalingam &lt;<a href=3D"mailto:ganesanr@netl=
ogicmicro.com">ganesanr@netlogicmicro.com</a>&gt;&quot;);<br>
+MODULE_DESCRIPTION(&quot;XLR I2C SMBus driver&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
+MODULE_ALIAS(&quot;platform:xlr-i2cbus&quot;);<br>
+<br>
+module_init(xlr_i2c_init);<br>
+module_exit(xlr_i2c_exit);<br>
--<br>
1.7.5.4<br>
<font color=3D"#888888"><br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-i2c&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></blockquote></div><br>

--20cf307d060e79460804b1d82e99--
