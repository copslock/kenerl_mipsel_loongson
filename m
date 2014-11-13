Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 09:23:28 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:51771 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011082AbaKMIXZeG0KA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 09:23:25 +0100
Received: from p4fe2408a.dip0.t-ipconnect.de ([79.226.64.138]:34450 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1XopgG-0001At-02; Thu, 13 Nov 2014 09:23:04 +0100
Date:   Thu, 13 Nov 2014 09:24:22 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Chris Dearman <chris.dearman@imgtec.com>
Subject: Re: [PATCH] MIPS/I2C: Move SEAD3 I2C driver to where it belongs.
Message-ID: <20141113082422.GB1288@katana>
References: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
 <1412847261-7930-3-git-send-email-markos.chandras@imgtec.com>
 <20141023181925.GA6719@linux-mips.org>
 <20141024122656.GC12641@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20141024122656.GC12641@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2014 at 02:26:57PM +0200, Ralf Baechle wrote:
> Fixes the following build problem if CONFIG_I2C is disabled:
>=20
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function 'i2c_platform_prob=
e':
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:345:2: error: implicit declarat=
ion of
> function 'i2c_add_numbered_adapter' [-Werror=3Dimplicit-function-declarat=
ion]
>   ret =3D i2c_add_numbered_adapter(&priv->adap);
>     ^
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c: In function
> 'i2c_platform_remove':
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:361:2: error: implicit declarat=
ion
> of function 'i2c_del_adapter' [-Werror=3Dimplicit-function-declaration]
> i2c_del_adapter(&priv->adap);
>=20

Uh, so this is already mainline? It has some issues.

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: Chris Dearman <chris.dearman@imgtec.com>

No diffstat?

> diff --git a/drivers/i2c/busses/i2c-sead3.c b/drivers/i2c/busses/i2c-sead=
3.c
> new file mode 100644
> index 0000000..1f787a6
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-sead3.c
> @@ -0,0 +1,405 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General P=
ublic
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
> + */
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>

Please sort the includes.

> +
> +#define PIC32_I2CxCON		0x0000
> +#define	 PIC32_I2CCON_ON	(1<<15)
> +#define	 PIC32_I2CCON_ACKDT	(1<<5)
> +#define	 PIC32_I2CCON_ACKEN	(1<<4)
> +#define	 PIC32_I2CCON_RCEN	(1<<3)
> +#define	 PIC32_I2CCON_PEN	(1<<2)
> +#define	 PIC32_I2CCON_RSEN	(1<<1)
> +#define	 PIC32_I2CCON_SEN	(1<<0)
> +#define PIC32_I2CxCONCLR	0x0004
> +#define PIC32_I2CxCONSET	0x0008
> +#define PIC32_I2CxSTAT		0x0010
> +#define PIC32_I2CxSTATCLR	0x0014
> +#define	 PIC32_I2CSTAT_ACKSTAT	(1<<15)
> +#define	 PIC32_I2CSTAT_TRSTAT	(1<<14)
> +#define	 PIC32_I2CSTAT_BCL	(1<<10)
> +#define	 PIC32_I2CSTAT_IWCOL	(1<<7)
> +#define	 PIC32_I2CSTAT_I2COV	(1<<6)
> +#define PIC32_I2CxBRG		0x0040
> +#define PIC32_I2CxTRN		0x0050
> +#define PIC32_I2CxRCV		0x0060
> +
> +static DEFINE_SPINLOCK(pic32_bus_lock);
> +
> +static void __iomem *bus_xfer	=3D (void __iomem *)0xbf000600;
> +static void __iomem *bus_status =3D (void __iomem *)0xbf000060;
> +
> +#define DELAY() udelay(100)
> +
> +static inline unsigned int ioready(void)
> +{
> +	return readl(bus_status) & 1;
> +}
> +
> +static inline void wait_ioready(void)
> +{
> +	do { } while (!ioready());
> +}

No timeout?

> +
> +static inline void wait_ioclear(void)
> +{
> +	do { } while (ioready());
> +}

ditto

> +
> +static inline void check_ioclear(void)
> +{
> +	if (ioready()) {
> +		do {
> +			(void) readl(bus_xfer);
> +			DELAY();
> +		} while (ioready());
> +	}
> +}
> +
> +static u32 pic32_bus_readl(u32 reg)
> +{
> +	unsigned long flags;
> +	u32 status, val;
> +
> +	spin_lock_irqsave(&pic32_bus_lock, flags);
> +
> +	check_ioclear();
> +	writel((0x01 << 24) | (reg & 0x00ffffff), bus_xfer);

Can we have names for all these magic hex-values?

> +	DELAY();
> +	wait_ioready();
> +	status =3D readl(bus_xfer);
> +	DELAY();
> +	val =3D readl(bus_xfer);
> +	wait_ioclear();
> +
> +	spin_unlock_irqrestore(&pic32_bus_lock, flags);
> +
> +	return val;
> +}
> +
> +static void pic32_bus_writel(u32 val, u32 reg)
> +{
> +	unsigned long flags;
> +	u32 status;
> +
> +	spin_lock_irqsave(&pic32_bus_lock, flags);
> +
> +	check_ioclear();
> +	writel((0x10 << 24) | (reg & 0x00ffffff), bus_xfer);
> +	DELAY();
> +	writel(val, bus_xfer);
> +	DELAY();
> +	wait_ioready();
> +	status =3D readl(bus_xfer);
> +	wait_ioclear();
> +
> +	spin_unlock_irqrestore(&pic32_bus_lock, flags);
> +}
> +
> +struct pic32_i2c_platform_data {
> +	u32	base;
> +	struct i2c_adapter adap;
> +	u32	xfer_timeout;
> +	u32	ack_timeout;
> +	u32	ctl_timeout;
> +};

priv goes to the platform instead of the adapter? Unusual, why is that?

> +
> +static inline void pic32_i2c_start(struct pic32_i2c_platform_data *adap)
> +{
> +	pic32_bus_writel(PIC32_I2CCON_SEN, adap->base + PIC32_I2CxCONSET);
> +}
> +
> +static inline void pic32_i2c_stop(struct pic32_i2c_platform_data *adap)
> +{
> +	pic32_bus_writel(PIC32_I2CCON_PEN, adap->base + PIC32_I2CxCONSET);
> +}
> +
> +static inline void pic32_i2c_ack(struct pic32_i2c_platform_data *adap)
> +{
> +	pic32_bus_writel(PIC32_I2CCON_ACKDT, adap->base + PIC32_I2CxCONCLR);
> +	pic32_bus_writel(PIC32_I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
> +}
> +
> +static inline void pic32_i2c_nack(struct pic32_i2c_platform_data *adap)
> +{
> +	pic32_bus_writel(PIC32_I2CCON_ACKDT, adap->base + PIC32_I2CxCONSET);
> +	pic32_bus_writel(PIC32_I2CCON_ACKEN, adap->base + PIC32_I2CxCONSET);
> +}
> +
> +static inline int pic32_i2c_idle(struct pic32_i2c_platform_data *adap)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < adap->ctl_timeout; i++) {
> +		if (((pic32_bus_readl(adap->base + PIC32_I2CxCON) &
> +		      (PIC32_I2CCON_ACKEN | PIC32_I2CCON_RCEN |
> +		       PIC32_I2CCON_PEN | PIC32_I2CCON_RSEN |
> +		       PIC32_I2CCON_SEN)) =3D=3D 0) &&
> +		    ((pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
> +		      (PIC32_I2CSTAT_TRSTAT)) =3D=3D 0))
> +			return 0;
> +		udelay(1);
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static inline u32 pic32_i2c_master_write(struct pic32_i2c_platform_data =
*adap,
> +		u32 byte)
> +{
> +	pic32_bus_writel(byte, adap->base + PIC32_I2CxTRN);
> +	return pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
> +			PIC32_I2CSTAT_IWCOL;
> +}
> +
> +static inline u32 pic32_i2c_master_read(struct pic32_i2c_platform_data *=
adap)
> +{
> +	pic32_bus_writel(PIC32_I2CCON_RCEN, adap->base + PIC32_I2CxCONSET);
> +	while (pic32_bus_readl(adap->base + PIC32_I2CxCON) & PIC32_I2CCON_RCEN)
> +		;
> +	pic32_bus_writel(PIC32_I2CSTAT_I2COV, adap->base + PIC32_I2CxSTATCLR);
> +	return pic32_bus_readl(adap->base + PIC32_I2CxRCV);
> +}
> +
> +static int pic32_i2c_address(struct pic32_i2c_platform_data *adap,
> +		unsigned int addr, int rd)
> +{
> +	pic32_i2c_idle(adap);
> +	pic32_i2c_start(adap);
> +	pic32_i2c_idle(adap);
> +
> +	addr <<=3D 1;
> +	if (rd)
> +		addr |=3D 1;
> +
> +	if (pic32_i2c_master_write(adap, addr))
> +		return -EIO;
> +	pic32_i2c_idle(adap);
> +	if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
> +			PIC32_I2CSTAT_ACKSTAT)
> +		return -EIO;

I'd think this is -ENXIO. Please have a look at
Documentation/i2c/fault-codes for the error codes we use.

> +	return 0;
> +}
> +
> +static int sead3_i2c_read(struct pic32_i2c_platform_data *adap,
> +		unsigned char *buf, unsigned int len)
> +{
> +	u32 data;
> +	int i;
> +
> +	i =3D 0;
> +	while (i < len) {
> +		data =3D pic32_i2c_master_read(adap);
> +		buf[i++] =3D data;
> +		if (i < len)
> +			pic32_i2c_ack(adap);
> +		else
> +			pic32_i2c_nack(adap);
> +	}
> +
> +	pic32_i2c_stop(adap);
> +	pic32_i2c_idle(adap);
> +	return 0;
> +}
> +
> +static int sead3_i2c_write(struct pic32_i2c_platform_data *adap,
> +		unsigned char *buf, unsigned int len)
> +{
> +	int i;
> +	u32 data;
> +
> +	i =3D 0;
> +	while (i < len) {
> +		data =3D buf[i];
> +		if (pic32_i2c_master_write(adap, data))
> +			return -EIO;
> +		pic32_i2c_idle(adap);
> +		if (pic32_bus_readl(adap->base + PIC32_I2CxSTAT) &
> +					PIC32_I2CSTAT_ACKSTAT)
> +			return -EIO;

ditto

> +		i++;
> +	}
> +
> +	pic32_i2c_stop(adap);
> +	pic32_i2c_idle(adap);
> +	return 0;
> +}
> +
> +static int sead3_pic32_platform_xfer(struct i2c_adapter *i2c_adap,
> +		struct i2c_msg *msgs, int num)
> +{
> +	struct pic32_i2c_platform_data *adap =3D i2c_adap->algo_data;
> +	struct i2c_msg *p;
> +	int i, err =3D 0;
> +
> +	for (i =3D 0; i < num; i++) {
> +#define __BUFSIZE 80
> +		int ii;
> +		static char buf[__BUFSIZE];
> +		char *b =3D buf;
> +
> +		p =3D &msgs[i];
> +		b +=3D sprintf(buf, " [%d bytes]", p->len);
> +		if ((p->flags & I2C_M_RD) =3D=3D 0) {
> +			for (ii =3D 0; ii < p->len; ii++) {
> +				if (b < &buf[__BUFSIZE-4]) {
> +					b +=3D sprintf(b, " %02x", p->buf[ii]);
> +				} else {
> +					strcat(b, "...");
> +					break;
> +				}
> +			}
> +		}

??? Where is buf used? And we have other debugging options and support
even tracing. Not needed.

> +	}
> +
> +	for (i =3D 0; !err && i < num; i++) {
> +		p =3D &msgs[i];
> +		err =3D pic32_i2c_address(adap, p->addr, p->flags & I2C_M_RD);
> +		if (err || !p->len)
> +			continue;

So, you don't support SMBUS_QUICK? You should remove it from the
functionality then. Or add support for it.

> +		if (p->flags & I2C_M_RD)
> +			err =3D sead3_i2c_read(adap, p->buf, p->len);
> +		else
> +			err =3D sead3_i2c_write(adap, p->buf, p->len);
> +	}
> +
> +	/* Return the number of messages processed, or the error code. */
> +	if (err =3D=3D 0)
> +		err =3D num;
> +
> +	return err;
> +}
> +
> +static u32 sead3_pic32_platform_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static const struct i2c_algorithm sead3_platform_algo =3D {
> +	.master_xfer	=3D sead3_pic32_platform_xfer,
> +	.functionality	=3D sead3_pic32_platform_func,
> +};
> +
> +static void sead3_i2c_platform_setup(struct pic32_i2c_platform_data *pri=
v)
> +{
> +	pic32_bus_writel(500, priv->base + PIC32_I2CxBRG);
> +	pic32_bus_writel(PIC32_I2CCON_ON, priv->base + PIC32_I2CxCONCLR);
> +	pic32_bus_writel(PIC32_I2CCON_ON, priv->base + PIC32_I2CxCONSET);
> +	pic32_bus_writel(PIC32_I2CSTAT_BCL | PIC32_I2CSTAT_IWCOL,
> +		priv->base + PIC32_I2CxSTATCLR);
> +}
> +
> +static int sead3_i2c_platform_probe(struct platform_device *pdev)
> +{
> +	struct pic32_i2c_platform_data *priv;
> +	struct resource *r;
> +	int ret;
> +
> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r) {
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	priv =3D kzalloc(sizeof(struct pic32_i2c_platform_data), GFP_KERNEL);
> +	if (!priv) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	priv->base =3D r->start;

OK. MIPS doesn't need ioremap?

> +	if (!priv->base) {
> +		ret =3D -EBUSY;
> +		goto out_mem;
> +	}
> +
> +	priv->xfer_timeout =3D 200;
> +	priv->ack_timeout =3D 200;
> +	priv->ctl_timeout =3D 200;

Why have three if they are all the same?

> +
> +	priv->adap.nr =3D pdev->id;
> +	priv->adap.algo =3D &sead3_platform_algo;
> +	priv->adap.algo_data =3D priv;
> +	priv->adap.dev.parent =3D &pdev->dev;
> +	strlcpy(priv->adap.name, "SEAD3 PIC32", sizeof(priv->adap.name));
> +
> +	sead3_i2c_platform_setup(priv);
> +
> +	ret =3D i2c_add_numbered_adapter(&priv->adap);
> +	if (ret =3D=3D 0) {
> +		platform_set_drvdata(pdev, priv);

No, it must be set before! If I2C gets called after add_adapter and
before the if, we have an OOPS.

> +		return 0;
> +	}
> +
> +out_mem:
> +	kfree(priv);
> +out:
> +	return ret;
> +}
> +
> +static int sead3_i2c_platform_remove(struct platform_device *pdev)
> +{
> +	struct pic32_i2c_platform_data *priv =3D platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	i2c_del_adapter(&priv->adap);
> +	kfree(priv);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int sead3_i2c_platform_suspend(struct platform_device *pdev,
> +		pm_message_t state)
> +{
> +	dev_dbg(&pdev->dev, "i2c_platform_disable\n");
> +	return 0;
> +}
> +
> +static int sead3_i2c_platform_resume(struct platform_device *pdev)
> +{
> +	struct pic32_i2c_platform_data *priv =3D platform_get_drvdata(pdev);
> +
> +	dev_dbg(&pdev->dev, "sead3_i2c_platform_setup\n");
> +	sead3_i2c_platform_setup(priv);
> +
> +	return 0;
> +}
> +#else
> +#define sead3_i2c_platform_suspend	NULL
> +#define sead3_i2c_platform_resume	NULL
> +#endif
> +
> +static struct platform_driver sead3_i2c_platform_driver =3D {
> +	.driver =3D {
> +		.name	=3D "sead3-i2c",
> +		.owner	=3D THIS_MODULE,

Not needed.

> +	},
> +	.probe		=3D sead3_i2c_platform_probe,
> +	.remove		=3D sead3_i2c_platform_remove,
> +	.suspend	=3D sead3_i2c_platform_suspend,
> +	.resume		=3D sead3_i2c_platform_resume,
> +};
> +
> +static int __init sead3_i2c_platform_init(void)
> +{
> +	return platform_driver_register(&sead3_i2c_platform_driver);
> +}
> +module_init(sead3_i2c_platform_init);
> +
> +static void __exit sead3_i2c_platform_exit(void)
> +{
> +	platform_driver_unregister(&sead3_i2c_platform_driver);
> +}
> +module_exit(sead3_i2c_platform_exit);

module_platform_driver()

> +
> +MODULE_AUTHOR("Chris Dearman, MIPS Technologies INC.");
> +MODULE_DESCRIPTION("SEAD3 PIC32 I2C driver");
> +MODULE_LICENSE("GPL");

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZGq2AAoJEBQN5MwUoCm2PrIQAJ4Fy3A11EMcU/G7yJRn3sAR
4f8+AIsBv7okeH3K8/ypzrbRS9V+VzU9v1izOfrdasBXTUuM6mo3otV9ZetyX8L0
xeBA+MqTjLuUIv+3qkreJ1SEjquoceuvjoOhLVX63d5FK4vNPEB22nFxttGpe5yq
ghOfWPFVi+abzcs/zbGf1vtvnGGLgw6CWzMrv4e0y8qEkXYtrvVU5tSxpGW//pDL
v6nFCfyxJBWe+zQgXAi8vtyS9q9lszfvUFj/qVwQ9rRQh1i1kj09gP6IcK08P/vw
6qjrqzvfdzKXmeUrstGvIBexE7/JXnn7yYfw+OuK5VoEbaYva+L+JI9T7qByl+H/
vjPjcjADcz2XQkXFqlxB7FFNjw6HMDRJrt3E8ZP+QRTywSLIxh7TuX/V2NiQuqxB
z3fDO9RCxkvuv9izzHmv0TLxJRXYTrpjfuZQ0U4czvLMtGj9XlrG4jdsOTaf4Ad5
29dsSasAIwG1UILdLaGlqoJD+Na2HmuudstAHqsAwceNAFJFaWJn8KV0QX/Ry+SY
E9MbblEc5B5VD/sm8FRX4Iv7qwCrh8nrMOlo5Y7LUzGGA3IBolbGT6pJzxlynMho
LWjiCgfapjbk8TvmCI4j+SI1AnyIVe+XkDfakRqAxfuh0i4SKTPiWvxW8awcFhi6
Jwj2UQ25lYnSaGPp0TST
=pULg
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
