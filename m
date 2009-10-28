Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 21:37:34 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.145]:50530 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493416AbZJ1Uh2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 21:37:28 +0100
Received: by ey-out-1920.google.com with SMTP id 5so254605eyb.52
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2009 13:37:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=D4DTqr+ciIP2NF7tJrtLSQH5O+vyyFUAlgF6FLj6CEg=;
        b=PybtbI94sYngi2P6WMGmVbCnfwL/CSRvoaBsEDZBk8B6jAFrP4KJDiNNBTZbIZb/H1
         iZUs7WdkcrjNpY3HxH8i+ZzejNYxScbWXXsF9aoZyWW9yiN8DeLbGxp7zzd8Xh7QmRw1
         O8GkGrop/OKI8FA36t1r92ZC0fTOIIrm74Dqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YNxb7zX0kHKFSEMEgLc5upzAiWIy89MTOGlqL52WaMf1SYSLEu3uY5dhfM8Xfc0b1e
         QvfiVZVavOPx1ZbXx5Dzz2gFxvZAyS2Pc0IHq2pAbpH/DeNVcmi88tEgUBKCImIltwJ/
         87Dlgz5k/mlun/FNT9by4AvvyA4acgVim9jt0=
Received: by 10.216.86.139 with SMTP id w11mr1939076wee.10.1256762245912;
        Wed, 28 Oct 2009 13:37:25 -0700 (PDT)
Received: from localhost.localdomain (p5496FE70.dip.t-dialin.net [84.150.254.112])
        by mx.google.com with ESMTPS id q9sm666765gve.0.2009.10.28.13.37.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 13:37:25 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] serial 8250: fixes for Alchemy uarts.
Date:	Wed, 28 Oct 2009 21:37:28 +0100
Message-Id: <1256762248-4305-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Limit the amount of address space claimed for Alchemy serial ports
to 0x1000.  On the Au1300, ports are only 0x1000 apart, and the
registers only extend to 0x110 at most on all supported alchemy models.

On the Au1300 the autodetect logic no longer works and this makes
it necessary to specify the port type through platform data.  Because
of this the MSR quirk needs to be moved outside the autoconfig()
function which will no longer be called when UPF_FIXED_TYPE is
specified.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/serial/8250.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index b1ae774..9538e5b 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1214,12 +1214,6 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	}
 #endif
 
-#ifdef CONFIG_SERIAL_8250_AU1X00
-	/* if access method is AU, it is a 16550 with a quirk */
-	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU)
-		up->bugs |= UART_BUG_NOMSR;
-#endif
-
 	serial_outp(up, UART_LCR, save_lcr);
 
 	if (up->capabilities != uart_config[up->port.type].flags) {
@@ -2429,7 +2423,7 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
 	if (pt->port.iotype == UPIO_AU)
-		return 0x100000;
+		return 0x1000;
 #ifdef CONFIG_ARCH_OMAP
 	if (is_omap_port(pt))
 		return 0x16 << pt->port.regshift;
@@ -2586,6 +2580,13 @@ static void serial8250_config_port(struct uart_port *port, int flags)
 
 	if (flags & UART_CONFIG_TYPE)
 		autoconfig(up, probeflags);
+
+#ifdef CONFIG_SERIAL_8250_AU1X00
+	/* if access method is AU, it is a 16550 with a quirk */
+	if (up->port.type == PORT_16550A && up->port.iotype == UPIO_AU)
+		up->bugs |= UART_BUG_NOMSR;
+#endif
+
 	if (up->port.type != PORT_UNKNOWN && flags & UART_CONFIG_IRQ)
 		autoconfig_irq(up);
 
-- 
1.6.5
