Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 09:57:25 +0100 (BST)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:35083 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8226032AbVF1I5D>; Tue, 28 Jun 2005 09:57:03 +0100
Received: by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==) for <linux-mips@linux-mips.org>; Tue, 28 Jun 2005 10:54:05 +0200
Received: from Opal.Peter (root@Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id j5S7ZTIH000553;
	Tue, 28 Jun 2005 09:35:30 +0200
Received: from localhost (pf@localhost)
	by Opal.Peter (8.9.3/8.9.3/Sendmail/Linux 2.2.5-15) with ESMTP id JAA00870;
	Tue, 28 Jun 2005 09:20:43 +0200
Date:	Tue, 28 Jun 2005 09:20:43 +0200 (CEST)
From:	peter fuerst <pf@net.alphadv.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: [patch] blast_scache nop for sc cpus without scache
In-Reply-To: <Pine.LNX.4.61L.0506272035290.23903@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.21.0506280900370.858-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips


Hi !


On Mon, 27 Jun 2005, Maciej W. Rozycki wrote:
>  How about using these prom_printf()s to implement a real early printk()?  
> You'd save yourself and perhaps others a lot of hassle.

Here's what helped me *a lot* when debugging. It's rather ugly, polluting
printk.c with platform/driver-(cross-)dependent hacks, but output is available
immediately on kernel startup, and on some machines you just can't do without
that ;)
(perhaps someone sometimes will create a clean implementation...)

--- kernel/printk.c	Tue Apr 19 21:43:47 2005
+++ kernel/printk.c	Mon Jun 13 22:13:09 2005
@@ -33,6 +33,7 @@
 #include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
+#define early_log_by_prom_write 1
 
 #define __LOG_BUF_LEN	(1 << CONFIG_LOG_BUF_SHIFT)
 
@@ -403,12 +403,27 @@
 	}
 }
 
+static void inline __call_prom_write(unsigned long start, unsigned long end)
+{
+	static int prom_write(const char *s, int n);
+	prom_write(&LOG_BUF(start), end - start);
+}
+
 /*
  * Write out chars from start to end - 1 inclusive
  */
 static void _call_console_drivers(unsigned long start,
 				unsigned long end, int msg_log_level)
 {
+	if (/*msg_log_level < console_loglevel &&*/ start != end) {
+		if ((start & LOG_BUF_MASK) > (end & LOG_BUF_MASK)) {
+			/* wrapped write */
+			__call_prom_write(start & LOG_BUF_MASK, log_buf_len);
+			__call_prom_write(0, end & LOG_BUF_MASK);
+		} else {
+			__call_prom_write(start, end);
+		}
+	}
 	if (msg_log_level < console_loglevel &&
 			console_drivers && start != end) {
 		if ((start & LOG_BUF_MASK) > (end & LOG_BUF_MASK)) {
@@ -892,6 +907,7 @@
 		 * for us.
 		 */
 		spin_lock_irqsave(&logbuf_lock, flags);
+/*if(!early_log_by_prom_write)*/
 		con_start = log_start;
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
@@ -994,3 +1010,27 @@
 				printk_ratelimit_burst);
 }
 EXPORT_SYMBOL(printk_ratelimit);
+
+#include <asm/sgialib.h>
+static int prom_write(const char *s, int n)
+{
+#ifdef CONFIG_SGI_IP28
+	extern int ip22zilog_is_active(void);
+	extern int impactgfx_is_active(void);
+	if (n > 0 && early_log_by_prom_write)
+		if(!ip22zilog_is_active() && !impactgfx_is_active())
+		{	unsigned long oldstate;
+			int i;
+			romvec = ROMVECTOR;
+			oldstate = ip2628_enable_ucmem();
+			for (i = 0; i < n; ++i, ++s)
+			{	if ('\n' == *s)
+					prom_putchar('\r');
+				prom_putchar(*s);
+			}
+			ip2628_return_ucmem(oldstate);
+			return 1;
+		}
+#endif
+	return 0;
+}

kind regards

pf
