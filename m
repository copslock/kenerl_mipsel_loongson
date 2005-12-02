Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2005 18:51:34 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:54182 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133864AbVLBSvL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2005 18:51:11 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jB2Ishmh031036;
	Fri, 2 Dec 2005 12:54:43 -0600
Received: from 163.181.250.1 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 02 Dec 2005 12:54:37 -0600
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jB2IsaTw004122; Fri,
 2 Dec 2005 12:54:36 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 75138202D; Fri, 2 Dec 2005
 11:54:36 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jB2J2NDU031398; Fri, 2 Dec 2005 12:02:23
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jB2J2NEF031397; Fri, 2 Dec 2005 12:02:23 -0700
Date:	Fri, 2 Dec 2005 12:02:23 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Subject: [PATCH] ALCHEMY: SPI driver for Au1200
Message-ID: <20051202190223.GG28227@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F8E47E740G500239-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

A SPI driver for the Au1200 processor.  Sending now so it 
can be queued for the post 2.6.15 rush.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/mips/au1000/common/clocks.c          |    2 
 drivers/char/Kconfig                      |    4 
 drivers/char/Makefile                     |    1 
 drivers/char/au1xxx_psc_spi.c             |  492 +++++++++++++++++++++++++++++
 include/asm-mips/mach-au1x00/au1550_spi.h |   38 ++
 5 files changed, 536 insertions(+), 1 deletions(-)

diff --git a/arch/mips/au1000/common/clocks.c b/arch/mips/au1000/common/clocks.c
index 3ce6cac..6dbc87a 100644
--- a/arch/mips/au1000/common/clocks.c
+++ b/arch/mips/au1000/common/clocks.c
@@ -46,7 +46,7 @@ unsigned int get_au1x00_speed(void)
 {
 	return au1x00_clock;
 }
-
+EXPORT_SYMBOL(get_au1x00_speed);
 
 
 /*
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 2b0cf62..5501b12 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -351,6 +351,10 @@ config AU1XXX_CIM
        tristate "Au1200 Camera Interface Module (CIM)"
        depends on MIPS && SOC_AU1X00 && I2C_AU1550
 
+config AU1XXX_PSC_SPI
+       tristate ' Alchemy Au1550/Au1200 PSC SPI support'
+       depends on MIPS && SOC_AU1X00 && !I2C_AU1550
+
 config SIBYTE_SB1250_DUART
 	bool "Support for BCM1xxx onchip DUART"
 	depends on MIPS && SIBYTE_SB1xxx_SOC=y
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 6629394..b8bcfeb 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_AU1000_GPIO) += au1000_gpio
 obj-$(CONFIG_AU1000_USB_TTY) += au1000_usbtty.o
 obj-$(CONFIG_AU1000_USB_RAW) += au1000_usbraw.o
 obj-$(CONFIG_AU1XXX_CIM) += au1xxx_cim.o
+obj-$(CONFIG_AU1XXX_PSC_SPI) += au1xxx_psc_spi.o
 obj-$(CONFIG_PPDEV) += ppdev.o
 obj-$(CONFIG_NWBUTTON) += nwbutton.o
 obj-$(CONFIG_NWFLASH) += nwflash.o
diff --git a/drivers/char/au1xxx_psc_spi.c b/drivers/char/au1xxx_psc_spi.c
new file mode 100644
index 0000000..66d99e0
--- /dev/null
+++ b/drivers/char/au1xxx_psc_spi.c
@@ -0,0 +1,492 @@
+/*
+ *  Driver for Alchemy Au1550 SPI on the PSC.
+ *
+ * Copyright 2004 Embedded Edge, LLC.
+ *	dan@embeddededge.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE	LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1550_spi.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+
+#ifdef CONFIG_MIPS_PB1550
+#include <asm/mach-pb1x00/pb1550.h>
+#endif
+
+#ifdef CONFIG_MIPS_DB1550
+#include <asm/mach-db1x00/db1x00.h>
+#endif
+
+#ifdef CONFIG_MIPS_PB1200
+#include <asm/mach-pb1x00/pb1200.h>
+#endif
+
+#ifdef CONFIG_MIPS_DB1200
+#include <asm/mach-db1x00/db1200.h>
+#endif
+
+/* This is just a simple programmed I/O SPI interface on the PSC of the 1550.
+ * We support open, close, write, and ioctl.  The SPI is a full duplex
+ * interface, you can't read without writing.  So, the write system call
+ * copies the bytes out to the SPI, and whatever is returned is placed
+ * in the same buffer.  Kinda weird, maybe we'll change it, but for now
+ * it works OK.
+ * I didn't implement any DMA yet, and it's a debate about the necessity.
+ * The SPI clocks are usually quite fast, so data is sent/received as
+ * quickly as you can stuff the FIFO.  The overhead of DMA and interrupts
+ * are usually far greater than the data transfer itself.  If, however,
+ * we find applications that move large amounts of data, we may choose
+ * use the overhead of buffering and DMA to do the work.
+ */
+
+/* The maximum clock rate specified in the manual is 2mHz.
+*/
+#define MAX_BAUD_RATE	(2 * 1000000)
+#define PSC_INTCLK_RATE (32 * 1000000)
+
+static	int	inuse;
+
+/* We have to know what the user requested for the data length
+ * so we know how to stuff the fifo.  The FIFO is 32 bits wide,
+ * and we have to load it with the bits to go in a single transfer.
+ */
+static	uint	spi_datalen;
+ 
+static int
+au1550spi_master_done( int ms )
+{
+	int timeout=ms;
+	volatile psc_spi_t *sp;
+
+	sp = (volatile psc_spi_t *)SPI_PSC_BASE;
+
+	/* Loop until MD is set or timeout has expired */
+	while(!(sp->psc_spievent & PSC_SPIEVNT_MD) &&  timeout--) udelay(1000);
+
+	if ( !timeout )
+		return 0;
+	else
+		sp->psc_spievent |= PSC_SPIEVNT_MD;
+
+	return 1;
+}
+
+static int
+au1550spi_open(struct inode *inode, struct file *file)
+{
+	if (inuse)
+		return -EBUSY;
+
+	inuse = 1;
+
+	
+	return 0;
+}
+
+static ssize_t
+au1550spi_write(struct file *fp, const char *bp, size_t count, loff_t *ppos)
+{
+	int	bytelen, i;
+	size_t	rcount, retval;
+	unsigned char	sb, *rp, *wp;
+	uint	fifoword, pcr, stat;
+	volatile psc_spi_t *sp;
+
+	/* Get the number of bytes per transfer.
+	*/
+	bytelen = ((spi_datalen - 1) / 8) + 1;
+
+	/* User needs to send us multiple of this count.
+	*/
+	if ((count % bytelen) != 0)
+		return -EINVAL;
+
+	rp = wp = (unsigned char *)bp;
+	retval = rcount = count;
+
+	/* Reset the FIFO.
+	*/
+	sp = (volatile psc_spi_t *)SPI_PSC_BASE;
+	sp->psc_spipcr = (PSC_SPIPCR_RC | PSC_SPIPCR_TC);
+	au_sync();
+	do {
+		pcr = sp->psc_spipcr;
+		au_sync();
+	} while (pcr != 0);
+
+	/* Prime the transmit FIFO.
+	*/
+	while (count > 0) {
+		fifoword = 0;
+		for (i=0; i<bytelen; i++) {
+			fifoword <<= 8;
+			if (get_user(sb, wp) < 0)
+				return -EFAULT;
+			fifoword |= sb;
+			wp++;
+		}
+		count -= bytelen;
+		if (count <= 0)
+			fifoword |= PSC_SPITXRX_LC;
+		sp->psc_spitxrx = fifoword;
+		au_sync();
+		stat = sp->psc_spistat;
+		au_sync();
+		if (stat & PSC_SPISTAT_TF)
+			break;
+	}
+
+	/* Start the transfer.
+	*/
+	sp->psc_spipcr = PSC_SPIPCR_MS;
+	au_sync();
+
+	/* Now, just keep the transmit fifo full and empty the receive.
+	*/
+	while (count > 0) {
+		stat = sp->psc_spistat;
+		au_sync();
+		while ((stat & PSC_SPISTAT_RE) == 0) {
+			fifoword = sp->psc_spitxrx;
+			au_sync();
+			for (i=0; i<bytelen; i++) {
+				sb = fifoword & 0xff;
+				if (put_user(sb, rp) < 0)
+					return -EFAULT;
+				fifoword >>= 8;
+				rp++;
+			}
+			rcount -= bytelen;
+			stat = sp->psc_spistat;
+			au_sync();
+		}
+		if ((stat & PSC_SPISTAT_TF) == 0) {
+			fifoword = 0;
+			for (i=0; i<bytelen; i++) {
+				fifoword <<= 8;
+				if (get_user(sb, wp) < 0)
+					return -EFAULT;
+				fifoword |= sb;
+				wp++;
+			}
+			count -= bytelen;
+			if (count <= 0)
+				fifoword |= PSC_SPITXRX_LC;
+			sp->psc_spitxrx = fifoword;
+			au_sync();
+		}
+	}
+
+	/* All of the bytes for transmit have been written.  Hang
+	 * out waiting for any residual bytes that are yet to be
+	 * read from the fifo.
+	 */
+	while (rcount > 0) {
+		stat = sp->psc_spistat;
+		au_sync();
+		if ((stat & PSC_SPISTAT_RE) == 0) {
+			fifoword = sp->psc_spitxrx;
+			au_sync();
+			for (i=0; i<bytelen; i++) {
+				sb = fifoword & 0xff;
+				if (put_user(sb, rp) < 0)
+					return -EFAULT;
+				fifoword >>= 8;
+				rp++;
+			}
+			rcount -= bytelen;
+		}
+	}
+
+	/* Wait for MasterDone event. 30ms timeout */
+	if (!au1550spi_master_done(30) ) retval = -EFAULT;
+	return retval;
+}
+
+static int
+au1550spi_release(struct inode *inode, struct file *file)
+{
+	
+	inuse = 0;
+
+	return 0;
+}
+
+/* Set the baud rate closest to the request, then return the actual
+ * value we are using.
+ */
+static uint
+set_baud_rate(uint baud)
+{
+	uint	rate, tmpclk, brg, ctl, stat;
+	volatile psc_spi_t *sp;
+
+	/* For starters, the input clock is divided by two.
+	*/
+	tmpclk = PSC_INTCLK_RATE/2;
+
+	rate = tmpclk / baud;
+
+	/* The dividers work as follows:
+	 *	baud = tmpclk / (2 * (brg + 1))
+	 */
+	 brg = (rate/2) - 1;
+
+	 /* Test BRG to ensure it will fit into the 6 bits allocated.
+	 */
+
+	 /* Make sure the device is disabled while we make the change.
+	 */
+	sp = (volatile psc_spi_t *)SPI_PSC_BASE;
+	ctl = sp->psc_spicfg;
+	au_sync();
+	sp->psc_spicfg = ctl & ~PSC_SPICFG_DE_ENABLE;
+	au_sync();
+	ctl = PSC_SPICFG_CLR_BAUD(ctl);
+	ctl |= PSC_SPICFG_SET_BAUD(brg);
+	sp->psc_spicfg = ctl;
+	au_sync();
+
+	/* If the device was running prior to getting here, wait for
+	 * it to restart.
+	 */
+	if (ctl & PSC_SPICFG_DE_ENABLE) {
+		do {
+			stat = sp->psc_spistat;
+			au_sync();
+		} while ((stat & PSC_SPISTAT_DR) == 0);
+	}
+
+	/* Return the actual value.
+	*/
+	rate = tmpclk / (2 * (brg + 1));
+
+	return(rate);
+}
+
+static uint
+set_word_len(uint len)
+{
+	uint	ctl, stat;
+	volatile psc_spi_t *sp;
+
+	if ((len < 4) || (len > 24))
+		return -EINVAL;
+
+	 /* Make sure the device is disabled while we make the change.
+	 */
+	sp = (volatile psc_spi_t *)SPI_PSC_BASE;
+	ctl = sp->psc_spicfg;
+	au_sync();
+	sp->psc_spicfg = ctl & ~PSC_SPICFG_DE_ENABLE;
+	au_sync();
+	ctl = PSC_SPICFG_CLR_LEN(ctl);
+	ctl |= PSC_SPICFG_SET_LEN(len);
+	sp->psc_spicfg = ctl;
+	au_sync();
+
+	/* If the device was running prior to getting here, wait for
+	 * it to restart.
+	 */
+	if (ctl & PSC_SPICFG_DE_ENABLE) {
+		do {
+			stat = sp->psc_spistat;
+			au_sync();
+		} while ((stat & PSC_SPISTAT_DR) == 0);
+	}
+
+	return 0;
+}
+
+static uint
+set_clk_src(void)
+{
+	uint	clk, rate;
+
+/* Wire up Freq3 as a clock for the SPI.  The PSC does
+	 * factor of 2 divisor, so run a higher rate so we can
+	 * get some granularity to the clock speeds.
+	 * We can't do this in board set up because the frequency
+	 * is computed too late.
+	 */
+	rate = get_au1x00_speed();
+	rate /= PSC_INTCLK_RATE;
+	  
+
+    
+	/* The FRDIV in the frequency control is (FRDIV + 1) * 2
+	*/
+	rate /=2;
+	rate--;
+	clk = au_readl(SYS_FREQCTRL1);
+	
+	au_sync();
+	clk &= ~SYS_FC_FRDIV3_MASK;
+	clk |= (rate << SYS_FC_FRDIV3_BIT);
+	clk |= SYS_FC_FE3;
+	au_writel(clk, SYS_FREQCTRL1);
+	au_sync();
+
+	/* Set up the clock source routing to get Freq3 to PSC0_intclk.
+	*/
+	clk = au_readl(SYS_CLKSRC);
+   	au_sync();
+#if defined(CONFIG_SOC_AU1200)
+	clk &= ~SYS_CS_ME0_MASK;
+	clk |= (5 << 22);
+#elif defined (CONFIG_SOC_AU1550)
+    clk &= ~0x03e0;
+	clk |= (5 << 7);
+#endif
+  	au_writel(clk, SYS_CLKSRC);
+	au_sync();
+
+	/* Set up GPIO pin function to drive PSC0_SYNC1, which is
+	 * the SPI Select.
+	 */
+	clk = au_readl(SYS_PINFUNC);
+	au_sync();
+#if defined(CONFIG_SOC_AU1200)
+	clk |= (0x1 <<17);
+	clk &= ~SYS_PINFUNC_P0B;
+#elif defined (CONFIG_SOC_AU1550)
+     clk |= 1;
+#endif
+   	au_writel(clk, SYS_PINFUNC);
+	au_sync();
+
+  return 0;
+} 
+
+static int
+au1550spi_ioctl(struct inode *inode, struct file *file,
+			    unsigned int cmd, unsigned long arg)
+{
+	int status;
+	u32 val;
+
+	status = 0;
+
+	switch(cmd) {
+	case AU1550SPI_WORD_LEN:
+		status = set_word_len(arg);
+		break;
+
+	case AU1550SPI_SET_BAUD:
+		if (get_user(val, (u32 *)arg)) 
+			return -EFAULT;
+
+		val = set_baud_rate(val);
+		if (put_user(val, (u32 *)arg)) 
+			return -EFAULT;
+		break;
+
+	default:
+		status = -ENOIOCTLCMD;
+
+	}
+
+	return status;
+}
+
+static struct file_operations au1550spi_fops =
+{	 .owner    = 	THIS_MODULE,
+	.write    =		au1550spi_write,
+	.ioctl    =	    au1550spi_ioctl,
+	.open     =		au1550spi_open,
+	.release  =	    au1550spi_release,
+};
+
+
+static struct miscdevice au1550spi_miscdev =
+{
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "au1550_spi",
+	.fops = &au1550spi_fops,
+};
+
+
+int __init
+au1550spi_init(void)
+{
+	uint  stat;
+	volatile psc_spi_t *sp;
+	  
+	 /* Set clock Source*/
+	 set_clk_src();
+
+	/* Now, set up the PSC for SPI PIO mode.
+	*/
+	sp = (volatile psc_spi_t *)SPI_PSC_BASE;
+	sp->psc_ctrl = PSC_CTRL_DISABLE;
+	au_sync();
+	sp->psc_sel = PSC_SEL_PS_SPIMODE;
+   	sp->psc_spicfg = 0;
+	au_sync();
+	sp->psc_ctrl = PSC_CTRL_ENABLE;
+	au_sync();
+	
+	do {
+		stat = sp->psc_spistat;
+		au_sync();
+	} while ((stat & PSC_SPISTAT_SR) == 0);
+	  
+   
+	sp->psc_spicfg = (PSC_SPICFG_RT_FIFO8 | PSC_SPICFG_TT_FIFO8 |
+				PSC_SPICFG_DD_DISABLE | PSC_SPICFG_MO);
+	sp->psc_spicfg |= PSC_SPICFG_SET_LEN(8); 
+	spi_datalen = 8;
+	sp->psc_spimsk = PSC_SPIMSK_ALLMASK;
+	au_sync();
+
+	set_baud_rate(1000000);
+
+	sp->psc_spicfg |= PSC_SPICFG_DE_ENABLE;
+	 
+	 do {
+		stat = sp->psc_spistat;
+		au_sync();
+	} while ((stat & PSC_SPISTAT_DR) == 0);
+
+
+	misc_register(&au1550spi_miscdev);
+	return 0;
+}	
+
+void __exit
+au1550spi_exit(void)
+{
+	misc_deregister(&au1550spi_miscdev);
+}
+
+module_init(au1550spi_init);
+module_exit(au1550spi_exit);
diff --git a/include/asm-mips/mach-au1x00/au1550_spi.h b/include/asm-mips/mach-au1x00/au1550_spi.h
new file mode 100644
index 0000000..d956145
--- /dev/null
+++ b/include/asm-mips/mach-au1x00/au1550_spi.h
@@ -0,0 +1,38 @@
+/*
+ *	API to Alchemy Au1550 SPI device.
+ *
+ * Copyright 2004 Embedded Edge, LLC.
+ *	dan@embeddededge.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __AU1550_SPI_H
+#define __AU1550_SPI_H
+
+#include <linux/ioctl.h>
+
+#define AU1550SPI_IOC_MAGIC 'S'
+
+#define AU1550SPI_SET_BAUD	_IOW(AU1550SPI_IOC_MAGIC, 0, int *)
+#define AU1550SPI_WORD_LEN	_IOW(AU1550SPI_IOC_MAGIC, 1, int)
+
+#endif /* __AU1000_SPI_H */
