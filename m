Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 12:17:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43115 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012191AbbA2LOnG054C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 12:14:43 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BC1E083EF9F29;
        Thu, 29 Jan 2015 11:14:34 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 29 Jan 2015 11:14:36 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 29 Jan 2015 11:14:35 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Jason Wessel <jason.wessel@windriver.com>,
        <kgdb-bugreport@lists.sourceforge.net>
Subject: [PATCH 9/9] ttyFDC: Implement KGDB IO operations.
Date:   Thu, 29 Jan 2015 11:14:14 +0000
Message-ID: <1422530054-7976-10-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
References: <1422530054-7976-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Implement KGDB IO operations for MIPS Fast Debug Channel (FDC). This can
be enabled via Kconfig, which also allows the channel number to be
chosen.

The magic sysrq hack is implemented in the TTY driver, detecting just ^C
for the KGDB channel, and ^O followed by a letter for the FDC console
channel.

The KGDB operations are reasonably efficient thanks to the flush
callback, with a 4 byte buffer being used in both directions to allow up
to 4 bytes to be encoded per FDC word. Reading of data for KGDB will
discard any data received on other channels, which clearly isn't ideal,
but given that there is a single FIFO shared between channels we can't
do much better.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: linux-mips@linux-mips.org
Cc: kgdb-bugreport@lists.sourceforge.net
---
 drivers/tty/Kconfig          |  16 ++++
 drivers/tty/mips_ejtag_fdc.c | 169 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 179 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index e0c18e5b7057..c01f45095877 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -450,4 +450,20 @@ config MIPS_EJTAG_FDC_EARLYCON
 
 	  If unsure, say N.
 
+config MIPS_EJTAG_FDC_KGDB
+	bool "Use KGDB over an FDC channel"
+	depends on MIPS_EJTAG_FDC_TTY && KGDB
+	default y
+	help
+          This enables the use of KGDB over an FDC channel, allowing KGDB to be
+          used remotely or when a serial port isn't available.
+
+config MIPS_EJTAG_FDC_KGDB_CHAN
+	int "KGDB FDC channel"
+	depends on MIPS_EJTAG_FDC_KGDB
+	range 2 15
+	default 3
+	help
+	  FDC channel number to use for KGDB.
+
 endif # TTY
diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 8d9bf6f90110..04d9e23d1ee1 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -17,9 +17,11 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/kgdb.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
 #include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -136,6 +138,8 @@ struct mips_ejtag_fdc_tty_port {
  * @removing:		Indicates the device is being removed and @poll_timer
  *			should not be restarted.
  * @poll_timer:		Timer for polling for interrupt events when @irq < 0.
+ * @sysrq_pressed:	Whether the magic sysrq key combination has been
+ *			detected. See mips_ejtag_fdc_handle().
  */
 struct mips_ejtag_fdc_tty {
 	struct device			*dev;
@@ -159,6 +163,10 @@ struct mips_ejtag_fdc_tty {
 	int				 irq;
 	bool				 removing;
 	struct timer_list		 poll_timer;
+
+#ifdef CONFIG_MAGIC_SYSRQ
+	bool				 sysrq_pressed;
+#endif
 };
 
 /* Hardware access */
@@ -568,21 +576,47 @@ static void mips_ejtag_fdc_handle(struct mips_ejtag_fdc_tty *priv)
 		raw_spin_lock(&dport->rx_lock);
 		data = mips_ejtag_fdc_read(priv, REG_FDRX);
 
-		/* Check the port isn't being shut down */
-		if (!dport->rx_buf)
-			goto unlock;
-
 		len = mips_ejtag_fdc_decode(data, buf);
 		dev_dbg(priv->dev, "%s%u: in  %08x: \"%*pE\"\n",
 			priv->driver_name, channel, data, len, buf);
 
 		flipped = 0;
-		for (i = 0; i < len; ++i)
+		for (i = 0; i < len; ++i) {
+#ifdef CONFIG_MAGIC_SYSRQ
+#ifdef CONFIG_MIPS_EJTAG_FDC_KGDB
+			/* Support just Ctrl+C with KGDB channel */
+			if (channel == CONFIG_MIPS_EJTAG_FDC_KGDB_CHAN) {
+				if (buf[i] == '\x03') { /* ^C */
+					handle_sysrq('g');
+					continue;
+				}
+			}
+#endif
+			/* Support Ctrl+O for console channel */
+			if (channel == mips_ejtag_fdc_con.cons.index) {
+				if (buf[i] == '\x0f') {	/* ^O */
+					priv->sysrq_pressed =
+						!priv->sysrq_pressed;
+					if (priv->sysrq_pressed)
+						continue;
+				} else if (priv->sysrq_pressed) {
+					handle_sysrq(buf[i]);
+					priv->sysrq_pressed = false;
+					continue;
+				}
+			}
+#endif /* CONFIG_MAGIC_SYSRQ */
+
+			/* Check the port isn't being shut down */
+			if (!dport->rx_buf)
+				continue;
+
 			flipped += tty_insert_flip_char(&dport->port, buf[i],
 							TTY_NORMAL);
+		}
 		if (flipped)
 			tty_flip_buffer_push(&dport->port);
-unlock:
+
 		raw_spin_unlock(&dport->rx_lock);
 	}
 
@@ -1144,3 +1178,126 @@ int __init setup_early_fdc_console(void)
 	return mips_ejtag_fdc_console_init(&mips_ejtag_fdc_earlycon);
 }
 #endif
+
+#ifdef CONFIG_MIPS_EJTAG_FDC_KGDB
+
+/* read buffer to allow decompaction */
+static unsigned int kgdbfdc_rbuflen;
+static unsigned int kgdbfdc_rpos;
+static char kgdbfdc_rbuf[4];
+
+/* write buffer to allow compaction */
+static unsigned int kgdbfdc_wbuflen;
+static char kgdbfdc_wbuf[4];
+
+static void __iomem *kgdbfdc_setup(void)
+{
+	void __iomem *regs;
+	unsigned int cpu;
+
+	/* Find address, piggy backing off console percpu regs */
+	cpu = smp_processor_id();
+	regs = mips_ejtag_fdc_con.regs[cpu];
+	/* First console output on this CPU? */
+	if (!regs) {
+		regs = mips_cdmm_early_probe(0xfd);
+		mips_ejtag_fdc_con.regs[cpu] = regs;
+	}
+	/* Already tried and failed to find FDC on this CPU? */
+	if (IS_ERR(regs))
+		return regs;
+
+	return regs;
+}
+
+/* read a character from the read buffer, filling from FDC RX FIFO */
+static int kgdbfdc_read_char(void)
+{
+	unsigned int stat, channel, data;
+	void __iomem *regs;
+
+	/* No more data, try and read another FDC word from RX FIFO */
+	if (kgdbfdc_rpos >= kgdbfdc_rbuflen) {
+		kgdbfdc_rpos = 0;
+		kgdbfdc_rbuflen = 0;
+
+		regs = kgdbfdc_setup();
+		if (IS_ERR(regs))
+			return NO_POLL_CHAR;
+
+		/* Read next word from KGDB channel */
+		do {
+			stat = ioread32(regs + REG_FDSTAT);
+
+			/* No data waiting? */
+			if (stat & REG_FDSTAT_RXE)
+				return NO_POLL_CHAR;
+
+			/* Read next word */
+			channel = (stat & REG_FDSTAT_RXCHAN) >>
+					REG_FDSTAT_RXCHAN_SHIFT;
+			data = ioread32(regs + REG_FDRX);
+		} while (channel != CONFIG_MIPS_EJTAG_FDC_KGDB_CHAN);
+
+		/* Decode into rbuf */
+		kgdbfdc_rbuflen = mips_ejtag_fdc_decode(data, kgdbfdc_rbuf);
+	}
+	pr_devel("kgdbfdc r %c\n", kgdbfdc_rbuf[kgdbfdc_rpos]);
+	return kgdbfdc_rbuf[kgdbfdc_rpos++];
+}
+
+/* push an FDC word from write buffer to TX FIFO */
+static void kgdbfdc_push_one(void)
+{
+	const char *bufs[1] = { kgdbfdc_wbuf };
+	struct fdc_word word;
+	void __iomem *regs;
+	unsigned int i;
+
+	/* Construct a word from any data in buffer */
+	word = mips_ejtag_fdc_encode(bufs, &kgdbfdc_wbuflen, 1);
+	/* Relocate any remaining data to beginnning of buffer */
+	kgdbfdc_wbuflen -= word.bytes;
+	for (i = 0; i < kgdbfdc_wbuflen; ++i)
+		kgdbfdc_wbuf[i] = kgdbfdc_wbuf[i + word.bytes];
+
+	regs = kgdbfdc_setup();
+	if (IS_ERR(regs))
+		return;
+
+	/* Busy wait until there's space in fifo */
+	while (ioread32(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
+		;
+	iowrite32(word.word, regs + REG_FDTX(CONFIG_MIPS_EJTAG_FDC_KGDB_CHAN));
+}
+
+/* flush the whole write buffer to the TX FIFO */
+static void kgdbfdc_flush(void)
+{
+	while (kgdbfdc_wbuflen)
+		kgdbfdc_push_one();
+}
+
+/* write a character into the write buffer, writing out if full */
+static void kgdbfdc_write_char(u8 chr)
+{
+	pr_devel("kgdbfdc w %c\n", chr);
+	kgdbfdc_wbuf[kgdbfdc_wbuflen++] = chr;
+	if (kgdbfdc_wbuflen >= sizeof(kgdbfdc_wbuf))
+		kgdbfdc_push_one();
+}
+
+static struct kgdb_io kgdbfdc_io_ops = {
+	.name		= "kgdbfdc",
+	.read_char	= kgdbfdc_read_char,
+	.write_char	= kgdbfdc_write_char,
+	.flush		= kgdbfdc_flush,
+};
+
+static int __init kgdbfdc_init(void)
+{
+	kgdb_register_io_module(&kgdbfdc_io_ops);
+	return 0;
+}
+early_initcall(kgdbfdc_init);
+#endif
-- 
2.0.5
