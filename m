Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 17:11:45 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.244]:60439 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20022307AbXITQLg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 17:11:36 +0100
Received: by an-out-0708.google.com with SMTP id d26so84958and
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2007 09:11:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=y1uIeXAls7PDzvQKacf/+0rsN9Ksy6acZsW9lzSnKS4=;
        b=LICnXcO2wPd6xoX8HdICvE2i9dmlD0e9h24Qe+9uXCRF7US/oqPK20/WM3SuBr37hiU28kZcxl+zMhXkUGqwHYSAg/y0PeNT9tyPOx0iK3ppoxSlehrkqZyu94cztAGqBPxYbFHiJWby1Z1y9fzxDhgjOqoeV/QO2iqUTH6nGkw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=NXQLWiUoFVTqtBKR5WkVqm9mzJEv2RI0+7iZaQCrtjcVHiU55rVk4E+bBRJR1Y3F1oCMHt1B8znQUWI1SsqAcl4uYyIsE9EO/lOE1uW5cGueSsKigk1Bin1toCUW54Gq1XAsbBNXqsmstQxCbRv9JbTXilhKkGMCon2CXgy1zoQ=
Received: by 10.100.167.7 with SMTP id p7mr2618230ane.1190304677765;
        Thu, 20 Sep 2007 09:11:17 -0700 (PDT)
Received: from ?192.168.0.3? ( [87.6.117.29])
        by mx.google.com with ESMTPS id y56sm1473073hsb.2007.09.20.09.11.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2007 09:11:16 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][6/7] AR7: serial hack
Date:	Thu, 20 Sep 2007 18:11:10 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
References: <200709201728.10866.technoboy85@gmail.com>
In-Reply-To: <200709201728.10866.technoboy85@gmail.com>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Nicolas Thill <nico@openwrt.org>, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200709201811.10447.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Hack to use serial in the way the bootloader wants to.

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Nicolas Thill <nico@openwrt.org>

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index f94109c..94253b7 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -267,6 +267,13 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_AR7] = {
+		.name		= "TI-AR7",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+	},
 };
 
 #if defined (CONFIG_SERIAL_8250_AU1X00)
@@ -2453,7 +2460,11 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
 {
 	struct uart_8250_port *up = (struct uart_8250_port *)port;
 
+#ifdef CONFIG_AR7
+	wait_for_xmitr(up, BOTH_EMPTY);
+#else
 	wait_for_xmitr(up, UART_LSR_THRE);
+#endif
 	serial_out(up, UART_TX, ch);
 }
 
diff --git a/include/linux/serialP.h b/include/linux/serialP.h
index e811a61..cf71de9 100644
--- a/include/linux/serialP.h
+++ b/include/linux/serialP.h
@@ -135,6 +135,10 @@ struct rs_multiport_struct {
  * the interrupt line _up_ instead of down, so if we register the IRQ
  * while the UART is in that state, we die in an IRQ storm. */
 #define ALPHA_KLUDGE_MCR (UART_MCR_OUT2)
+#elif defined(CONFIG_AR7)
+/* This is how it is set up by bootloader... */
+#define ALPHA_KLUDGE_MCR (UART_MCR_OUT2 | UART_MCR_OUT1 \
+			| UART_MCR_RTS | UART_MCR_DTR)
 #else
 #define ALPHA_KLUDGE_MCR 0
 #endif
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 09d17b0..8ad2c3b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -40,6 +40,7 @@
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
+#define PORT_AR7	16
 #define PORT_MAX_8250	16	/* max port ID */
 
 /*
