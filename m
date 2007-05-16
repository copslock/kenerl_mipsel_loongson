Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2007 06:34:43 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:13328 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022108AbXEPFel (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 May 2007 06:34:41 +0100
Received: (qmail 13053 invoked by uid 1000); 16 May 2007 07:34:40 +0200
Date:	Wed, 16 May 2007 07:34:40 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	i2c@lm-sensors.org
Cc:	linux-mips@linux-mips.org, khali@linux-fr.org
Subject: [PATCH 2/2] i2c-au1550: convert to platform driver
Message-ID: <20070516053439.GB12986@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Convert the i2c-au1550 driver to platform_driver.

* Convert the core i2c-au1550 driver to platform_driver, get rid of
  the i2c-au1550.h file, and remove the unused pb1550_wm_codec_write().
* register the platform device for Alchemy boards which previously
  defined the i2c psc base address in their headers.
* update au1x psc header for the new driver style.

 arch/mips/au1000/common/platform.c        |   22 ++
 drivers/i2c/busses/i2c-au1550.c           |  311 ++++++++++++++----------------
 drivers/i2c/busses/i2c-au1550.h           |   32 ---
 include/asm-mips/mach-au1x00/au1xxx_psc.h |   18 -
 4 files changed, 177 insertions(+), 206 deletions(-)

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

diff -Naurp linux-2.6.21-a/arch/mips/au1000/common/platform.c linux-2.6.21-au/arch/mips/au1000/common/platform.c
--- linux-2.6.21-a/arch/mips/au1000/common/platform.c	2007-05-15 20:31:58.000000000 +0200
+++ linux-2.6.21-au/arch/mips/au1000/common/platform.c	2007-05-15 20:21:15.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/resource.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
 
 /* OHCI (USB full speed host controller) */
 static struct resource au1xxx_usb_ohci_resources[] = {
@@ -270,6 +271,24 @@ static struct platform_device smc91x_dev
 
 #endif
 
+/* All Alchemy demoboards with I2C have this #define in their headers */
+#ifdef SMBUS_PSC_BASE
+static struct resource pbdb_smbus_resources[] = {
+	{
+		.start	= SMBUS_PSC_BASE,
+		.end	= SMBUS_PSC_BASE + 0x24 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device pbdb_smbus_device = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(pbdb_smbus_resources),
+	.resource	= pbdb_smbus_resources,
+};
+#endif
+
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xxx_usb_ohci_device,
 	&au1x00_pcmcia_device,
@@ -287,6 +306,9 @@ static struct platform_device *au1xxx_pl
 #ifdef CONFIG_MIPS_DB1200
 	&smc91x_device,
 #endif
+#ifdef SMBUS_PSC_BASE
+	&pbdb_smbus_device,
+#endif
 };
 
 int au1xxx_platform_init(void)
diff -Naurp linux-2.6.21-a/drivers/i2c/busses/i2c-au1550.c linux-2.6.21-au/drivers/i2c/busses/i2c-au1550.c
--- linux-2.6.21-a/drivers/i2c/busses/i2c-au1550.c	2007-05-15 20:32:44.000000000 +0200
+++ linux-2.6.21-au/drivers/i2c/busses/i2c-au1550.c	2007-05-15 21:39:34.000000000 +0200
@@ -33,29 +33,31 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-au1x00/au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
-#include "i2c-au1550.h"
+struct i2c_au1550_data {
+	u32 psc_base;
+	int xfer_timeout;
+	int ack_timeout;
+	struct i2c_adapter adap;
+};
 
 static int
 wait_xfer_done(struct i2c_au1550_data *adap)
 {
-	u32	stat;
+	u32	stat, base = adap->psc_base;
 	int	i;
-	volatile psc_smb_t	*sp;
-
-	sp = (volatile psc_smb_t *)(adap->psc_base);
 
 	/* Wait for Tx FIFO Underflow.
 	*/
 	for (i = 0; i < adap->xfer_timeout; i++) {
-		stat = sp->psc_smbevnt;
-		au_sync();
+		stat = au_readl(base + PSC_SMBEVNT);
 		if ((stat & PSC_SMBEVNT_TU) != 0) {
 			/* Clear it.  */
-			sp->psc_smbevnt = PSC_SMBEVNT_TU;
+			au_writel(PSC_SMBEVNT_TU, base + PSC_SMBEVNT);
 			au_sync();
 			return 0;
 		}
@@ -68,18 +70,13 @@ wait_xfer_done(struct i2c_au1550_data *a
 static int
 wait_ack(struct i2c_au1550_data *adap)
 {
-	u32	stat;
-	volatile psc_smb_t	*sp;
+	u32 stat, base = adap->psc_base;
 
 	if (wait_xfer_done(adap))
 		return -ETIMEDOUT;
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
-	stat = sp->psc_smbevnt;
-	au_sync();
-
-	if ((stat & (PSC_SMBEVNT_DN | PSC_SMBEVNT_AN | PSC_SMBEVNT_AL)) != 0)
+	stat = au_readl(base + PSC_SMBEVNT);
+	if (stat & (PSC_SMBEVNT_DN | PSC_SMBEVNT_AN | PSC_SMBEVNT_AL))
 		return -ETIMEDOUT;
 
 	return 0;
@@ -88,17 +85,13 @@ wait_ack(struct i2c_au1550_data *adap)
 static int
 wait_master_done(struct i2c_au1550_data *adap)
 {
-	u32	stat;
-	int	i;
-	volatile psc_smb_t	*sp;
-
-	sp = (volatile psc_smb_t *)(adap->psc_base);
+	u32 stat, base = adap->psc_base;
+	int i;
 
 	/* Wait for Master Done.
 	*/
 	for (i = 0; i < adap->xfer_timeout; i++) {
-		stat = sp->psc_smbevnt;
-		au_sync();
+		stat = au_readl(base + PSC_SMBEVNT);
 		if ((stat & PSC_SMBEVNT_MD) != 0)
 			return 0;
 		udelay(1);
@@ -110,24 +103,18 @@ wait_master_done(struct i2c_au1550_data 
 static int
 do_address(struct i2c_au1550_data *adap, unsigned int addr, int rd)
 {
-	volatile psc_smb_t	*sp;
-	u32			stat;
-
-	sp = (volatile psc_smb_t *)(adap->psc_base);
+	u32 stat, base = adap->psc_base;
 
 	/* Reset the FIFOs, clear events.
 	*/
-	stat = sp->psc_smbstat;
-	sp->psc_smbevnt = PSC_SMBEVNT_ALLCLR;
+	stat = au_readl(base + PSC_SMBSTAT);
+	au_writel(PSC_SMBEVNT_ALLCLR, base + PSC_SMBEVNT);
 	au_sync();
-
 	if (!(stat & PSC_SMBSTAT_TE) || !(stat & PSC_SMBSTAT_RE)) {
-		sp->psc_smbpcr = PSC_SMBPCR_DC;
+		au_writel(PSC_SMBPCR_DC, base + PSC_SMBPCR);
 		au_sync();
-		do {
-			stat = sp->psc_smbpcr;
-			au_sync();
-		} while ((stat & PSC_SMBPCR_DC) != 0);
+		while (au_readl(base + PSC_SMBPCR) & PSC_SMBPCR_DC)
+			msleep(0);
 		udelay(50);
 	}
 
@@ -139,44 +126,37 @@ do_address(struct i2c_au1550_data *adap,
 
 	/* Put byte into fifo, start up master.
 	*/
-	sp->psc_smbtxrx = addr;
+	au_writel(addr, base + PSC_SMBTXRX);
 	au_sync();
-	sp->psc_smbpcr = PSC_SMBPCR_MS;
+	au_writel(PSC_SMBPCR_MS, base + PSC_SMBPCR);
 	au_sync();
-	if (wait_ack(adap))
-		return -EIO;
-	return 0;
+
+	return wait_ack(adap) ? -EIO : 0;
 }
 
 static u32
 wait_for_rx_byte(struct i2c_au1550_data *adap, u32 *ret_data)
 {
-	int	j;
-	u32	data, stat;
-	volatile psc_smb_t	*sp;
+	u32 stat, base = adap->psc_base;
+	int j;
 
 	if (wait_xfer_done(adap))
 		return -EIO;
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
 	j =  adap->xfer_timeout * 100;
 	do {
 		j--;
 		if (j <= 0)
 			return -EIO;
 
-		stat = sp->psc_smbstat;
-		au_sync();
+		stat = au_readl(base + PSC_SMBSTAT);
 		if ((stat & PSC_SMBSTAT_RE) == 0)
 			j = 0;
 		else
 			udelay(1);
 	} while (j > 0);
-	data = sp->psc_smbtxrx;
-	au_sync();
-	*ret_data = data;
 
+	*ret_data = au_readl(base + PSC_SMBTXRX);
 	return 0;
 }
 
@@ -184,9 +164,8 @@ static int
 i2c_read(struct i2c_au1550_data *adap, unsigned char *buf,
 		    unsigned int len)
 {
-	int	i;
-	u32	data;
-	volatile psc_smb_t	*sp;
+	u32 data, base = adap->psc_base;
+	int i;
 
 	if (len == 0)
 		return 0;
@@ -196,11 +175,9 @@ i2c_read(struct i2c_au1550_data *adap, u
 	 * receive fifo, then reading the bytes.
 	 */
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
 	i = 0;
 	while (i < (len-1)) {
-		sp->psc_smbtxrx = 0;
+		au_writel(0, base + PSC_SMBTXRX);
 		au_sync();
 		if (wait_for_rx_byte(adap, &data))
 			return -EIO;
@@ -211,14 +188,12 @@ i2c_read(struct i2c_au1550_data *adap, u
 
 	/* The last byte has to indicate transfer done.
 	*/
-	sp->psc_smbtxrx = PSC_SMBTXRX_STP;
+	au_writel(PSC_SMBTXRX_STP, base + PSC_SMBTXRX);
 	au_sync();
 	if (wait_master_done(adap))
 		return -EIO;
 
-	data = sp->psc_smbtxrx;
-	au_sync();
-	buf[i] = data;
+	buf[i] = au_readl(base + PSC_SMBTXRX);
 	return 0;
 }
 
@@ -226,19 +201,15 @@ static int
 i2c_write(struct i2c_au1550_data *adap, unsigned char *buf,
 		     unsigned int len)
 {
-	int	i;
-	u32	data;
-	volatile psc_smb_t	*sp;
+	u32 base = adap->psc_base;
+	int i;
 
 	if (len == 0)
 		return 0;
 
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-
 	i = 0;
 	while (i < (len-1)) {
-		data = buf[i];
-		sp->psc_smbtxrx = data;
+		au_writel(buf[i], base + PSC_SMBTXRX);
 		au_sync();
 		if (wait_ack(adap))
 			return -EIO;
@@ -247,9 +218,7 @@ i2c_write(struct i2c_au1550_data *adap, 
 
 	/* The last byte has to indicate transfer done.
 	*/
-	data = buf[i];
-	data |= PSC_SMBTXRX_STP;
-	sp->psc_smbtxrx = data;
+	au_writel(buf[i] | PSC_SMBTXRX_STP, base + PSC_SMBTXRX);
 	au_sync();
 	if (wait_master_done(adap))
 		return -EIO;
@@ -259,26 +228,27 @@ i2c_write(struct i2c_au1550_data *adap, 
 static int
 au1550_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs, int num)
 {
-	struct i2c_au1550_data *adap = i2c_adap->algo_data;
-	volatile psc_smb_t *sp = (volatile psc_smb_t *)(adap->psc_base);
+	struct i2c_au1550_data *priv = i2c_adap->algo_data;
 	struct i2c_msg *p;
-	int i, err = 0;
+	int i, err;
 
+	err = 0;
 	for (i = 0; !err && i < num; i++) {
 		p = &msgs[i];
-		err = do_address(adap, p->addr, p->flags & I2C_M_RD);
+		err = do_address(priv, p->addr, p->flags & I2C_M_RD);
 		if (err || ((!p->len) && (i == (num - 1)))) {
-			sp->psc_smbtxrx = PSC_SMBTXRX_STP;
+			au_writel(PSC_SMBTXRX_STP,
+				   priv->psc_base + PSC_SMBTXRX);
 			au_sync();
-			wait_master_done(adap);
+			wait_master_done(priv);
 			continue;
 		}
 		if (!p->len)
 			continue;
 		if (p->flags & I2C_M_RD)
-			err = i2c_read(adap, p->buf, p->len);
+			err = i2c_read(priv, p->buf, p->len);
 		else
-			err = i2c_write(adap, p->buf, p->len);
+			err = i2c_write(priv, p->buf, p->len);
 	}
 
 	/* Return the number of messages processed, or the error code.
@@ -304,136 +274,151 @@ static const struct i2c_algorithm au1550
  * Prior to calling us, the 50MHz clock frequency and routing
  * must have been set up for the PSC indicated by the adapter.
  */
-int
-i2c_au1550_add_bus(struct i2c_adapter *i2c_adap)
+static int
+i2c_au1550_probe(struct platform_device *pdev)
 {
-	struct i2c_au1550_data *adap = i2c_adap->algo_data;
-	volatile psc_smb_t	*sp;
-	u32	stat;
-
-	i2c_adap->algo = &au1550_algo;
+	struct i2c_au1550_data *priv;
+	struct resource *r;
+	u32 base, cfg;
+	int ret;
+
+	ret = -ENODEV;
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		goto out;
+	base = r->start;
+
+	priv = kzalloc(sizeof(struct i2c_au1550_data), GFP_KERNEL);
+	if (!priv)
+		goto out;
+
+	priv->psc_base = base;
+	priv->xfer_timeout = 200;
+	priv->ack_timeout = 200;
+
+	priv->adap.id		= I2C_HW_AU1550_PSC,
+	priv->adap.algo		= &au1550_algo;
+	priv->adap.algo_data	= priv;
+	priv->adap.dev.parent	= &pdev->dev;
+	strcpy(priv->adap.name, "Au1550 PSC I2C");
 
 	/* Now, set up the PSC for SMBus PIO mode.
 	*/
-	sp = (volatile psc_smb_t *)(adap->psc_base);
-	sp->psc_ctrl = PSC_CTRL_DISABLE;
+	au_writel(PSC_CTRL_DISABLE, base + PSC_CTRL_OFFSET);
 	au_sync();
-	sp->psc_sel = PSC_SEL_PS_SMBUSMODE;
-	sp->psc_smbcfg = 0;
+	au_writel(PSC_SEL_PS_SMBUSMODE, base + PSC_SEL_OFFSET);
+	au_writel(0, base + PSC_SMBCFG);
 	au_sync();
-	sp->psc_ctrl = PSC_CTRL_ENABLE;
+	au_writel(PSC_CTRL_ENABLE, base + PSC_CTRL_OFFSET);
 	au_sync();
-	do {
-		stat = sp->psc_smbstat;
+	while (!(au_readl(base + PSC_SMBSTAT) & PSC_SMBSTAT_SR))
 		au_sync();
-	} while ((stat & PSC_SMBSTAT_SR) == 0);
 
-	sp->psc_smbcfg = (PSC_SMBCFG_RT_FIFO8 | PSC_SMBCFG_TT_FIFO8 |
-				PSC_SMBCFG_DD_DISABLE);
+	cfg =	PSC_SMBCFG_RT_FIFO8 | PSC_SMBCFG_TT_FIFO8 |
+		PSC_SMBCFG_DD_DISABLE;
 
-	/* Divide by 8 to get a 6.25 MHz clock.  The later protocol
-	 * timings are based on this clock.
+	au_writel(PSC_SMBMSK_ALLMASK, base + PSC_SMBMSK);
+
+	/* Divide by 8 to get a 6.25 MHz clock.  The protocol timings
+	 * below are based on this clock. (96MHz AUXPLL assumed!)
 	 */
-	sp->psc_smbcfg |= PSC_SMBCFG_SET_DIV(PSC_SMBCFG_DIV8);
-	sp->psc_smbmsk = PSC_SMBMSK_ALLMASK;
+	cfg |= PSC_SMBCFG_SET_DIV(PSC_SMBCFG_DIV8);
+	au_writel(cfg, base + PSC_SMBCFG);
 	au_sync();
 
 	/* Set the protocol timer values.  See Table 71 in the
 	 * Au1550 Data Book for standard timing values.
 	 */
-	sp->psc_smbtmr = PSC_SMBTMR_SET_TH(0) | PSC_SMBTMR_SET_PS(15) | \
-		PSC_SMBTMR_SET_PU(15) | PSC_SMBTMR_SET_SH(15) | \
-		PSC_SMBTMR_SET_SU(15) | PSC_SMBTMR_SET_CL(15) | \
-		PSC_SMBTMR_SET_CH(15);
+	au_writel(PSC_SMBTMR_SET_TH(0)  | PSC_SMBTMR_SET_PS(15) | \
+		  PSC_SMBTMR_SET_PU(15) | PSC_SMBTMR_SET_SH(15) | \
+		  PSC_SMBTMR_SET_SU(15) | PSC_SMBTMR_SET_CL(15) | \
+		  PSC_SMBTMR_SET_CH(15), base + PSC_SMBTMR);
 	au_sync();
 
-	sp->psc_smbcfg |= PSC_SMBCFG_DE_ENABLE;
-	do {
-		stat = sp->psc_smbstat;
+	cfg |= PSC_SMBCFG_DE_ENABLE;
+	au_writel(cfg, base + PSC_SMBCFG);
+	au_sync();
+
+	while (!(au_readl(base + PSC_SMBSTAT) & PSC_SMBSTAT_DR))
 		au_sync();
-	} while ((stat & PSC_SMBSTAT_DR) == 0);
 
-	return i2c_add_adapter(i2c_adap);
-}
+	ret = i2c_add_adapter(&priv->adap);
+	if (ret == 0) {
+		platform_set_drvdata(pdev, priv);
+		return 0;
+	}
 
+	au_writel(0, base + PSC_SMBCFG);
+	au_writel(PSC_CTRL_DISABLE, base + PSC_CTRL_OFFSET);
+	au_sync();
 
-int
-i2c_au1550_del_bus(struct i2c_adapter *adap)
-{
-	return i2c_del_adapter(adap);
+	kfree(priv);
+out:	return ret;
 }
 
 static int
-pb1550_reg(struct i2c_client *client)
+i2c_au1550_remove(struct platform_device *pdev)
 {
-	return 0;
+	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
+	u32 base;
+
+	if (priv) {
+		platform_set_drvdata(pdev, NULL);
+		base = priv->psc_base;
+		i2c_del_adapter(&priv->adap);
+		au_writel(0, base + PSC_SMBCFG);
+		au_writel(PSC_CTRL_DISABLE, base + PSC_CTRL_OFFSET);
+		au_sync();
+		kfree(priv);
+	}
+	return 0;	
 }
 
 static int
-pb1550_unreg(struct i2c_client *client)
+i2c_au1550_suspend(struct platform_device *pdev, pm_message_t state)
 {
+	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
+	u32 base = priv->psc_base;
+
+	au_writel(PSC_CTRL_SUSPEND, base + PSC_CTRL_OFFSET);
+	au_sync();
 	return 0;
 }
 
-static struct i2c_au1550_data pb1550_i2c_info = {
-	SMBUS_PSC_BASE, 200, 200
-};
-
-static struct i2c_adapter pb1550_board_adapter = {
-	name:              "pb1550 adapter",
-	id:                I2C_HW_AU1550_PSC,
-	algo:              NULL,
-	algo_data:         &pb1550_i2c_info,
-	client_register:   pb1550_reg,
-	client_unregister: pb1550_unreg,
-};
-
-/* BIG hack to support the control interface on the Wolfson WM8731
- * audio codec on the Pb1550 board.  We get an address and two data
- * bytes to write, create an i2c message, and send it across the
- * i2c transfer function.  We do this here because we have access to
- * the i2c adapter structure.
- */
-static struct i2c_msg wm_i2c_msg;  /* We don't want this stuff on the stack */
-static	u8 i2cbuf[2];
-
-int
-pb1550_wm_codec_write(u8 addr, u8 reg, u8 val)
+static int
+i2c_au1550_resume(struct platform_device *pdev)
 {
-	wm_i2c_msg.addr = addr;
-	wm_i2c_msg.flags = 0;
-	wm_i2c_msg.buf = i2cbuf;
-	wm_i2c_msg.len = 2;
-	i2cbuf[0] = reg;
-	i2cbuf[1] = val;
+	struct i2c_au1550_data *priv = platform_get_drvdata(pdev);
+	u32 base = priv->psc_base;
 
-	return pb1550_board_adapter.algo->master_xfer(&pb1550_board_adapter, &wm_i2c_msg, 1);
+	au_writel(PSC_CTRL_ENABLE, base + PSC_CTRL_OFFSET);
+	au_sync();
+	while (!(au_readl(base + PSC_SMBSTAT) & PSC_SMBSTAT_SR))
+		au_sync();
+	return 0;
 }
 
+static struct platform_driver au1xpsc_smbus_driver = {
+	.driver = {
+		.name	= "au1xpsc_smbus",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= i2c_au1550_probe,
+	.remove		= __devexit_p(i2c_au1550_remove),
+	.suspend	= i2c_au1550_suspend,
+	.resume		= i2c_au1550_resume,
+};
+
 static int __init
 i2c_au1550_init(void)
 {
-	printk(KERN_INFO "Au1550 I2C: ");
-
-	/* This is where we would set up a 50MHz clock source
-	 * and routing.  On the Pb1550, the SMBus is PSC2, which
-	 * uses a shared clock with USB.  This has been already
-	 * configured by Yamon as a 48MHz clock, close enough
-	 * for our work.
-	 */
-        if (i2c_au1550_add_bus(&pb1550_board_adapter) < 0) {
-		printk("failed to initialize.\n");
-                return -ENODEV;
-	}
-
-	printk("initialized.\n");
-	return 0;
+	return  platform_driver_register(&au1xpsc_smbus_driver);
 }
 
 static void __exit
 i2c_au1550_exit(void)
 {
-	i2c_au1550_del_bus(&pb1550_board_adapter);
+	platform_driver_unregister(&au1xpsc_smbus_driver);
 }
 
 MODULE_AUTHOR("Dan Malek, Embedded Edge, LLC.");
diff -Naurp linux-2.6.21-a/drivers/i2c/busses/i2c-au1550.h linux-2.6.21-au/drivers/i2c/busses/i2c-au1550.h
--- linux-2.6.21-a/drivers/i2c/busses/i2c-au1550.h	2007-05-15 20:32:02.000000000 +0200
+++ linux-2.6.21-au/drivers/i2c/busses/i2c-au1550.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,32 +0,0 @@
-/*
- * Copyright (C) 2004 Embedded Edge, LLC <dan@embeddededge.com>
- * 2.6 port by Matt Porter <mporter@kernel.crashing.org>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef I2C_AU1550_H
-#define I2C_AU1550_H
-
-struct i2c_au1550_data {
-	u32	psc_base;
-	int	xfer_timeout;
-	int	ack_timeout;
-};
-
-int i2c_au1550_add_bus(struct i2c_adapter *);
-int i2c_au1550_del_bus(struct i2c_adapter *);
-
-#endif /* I2C_AU1550_H */
diff -Naurp linux-2.6.21-a/include/asm-mips/mach-au1x00/au1xxx_psc.h linux-2.6.21-au/include/asm-mips/mach-au1x00/au1xxx_psc.h
--- linux-2.6.21-a/include/asm-mips/mach-au1x00/au1xxx_psc.h	2007-05-15 20:32:16.000000000 +0200
+++ linux-2.6.21-au/include/asm-mips/mach-au1x00/au1xxx_psc.h	2007-05-15 20:21:15.000000000 +0200
@@ -412,17 +412,13 @@ typedef struct	psc_spi {
 
 /* PSC in SMBus (I2C) Mode.
 */
-typedef struct	psc_smb {
-	u32	psc_sel;
-	u32	psc_ctrl;
-	u32	psc_smbcfg;
-	u32	psc_smbmsk;
-	u32	psc_smbpcr;
-	u32	psc_smbstat;
-	u32	psc_smbevnt;
-	u32	psc_smbtxrx;
-	u32	psc_smbtmr;
-} psc_smb_t;
+#define PSC_SMBCFG	0x08
+#define PSC_SMBMSK	0x0C
+#define PSC_SMBPCR	0x10
+#define PSC_SMBSTAT	0x14
+#define PSC_SMBEVNT	0x18
+#define PSC_SMBTXRX	0x1C
+#define PSC_SMBTMR	0x20
 
 /* SMBus Config Register.
 */
