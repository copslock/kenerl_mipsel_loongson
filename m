Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2007 14:26:18 +0100 (BST)
Received: from nz-out-0506.google.com ([64.233.162.224]:15721 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022407AbXICNZK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Sep 2007 14:25:10 +0100
Received: by nz-out-0506.google.com with SMTP id n1so709280nzf
        for <linux-mips@linux-mips.org>; Mon, 03 Sep 2007 06:25:09 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S3CBVdxmFVhbQFP940cIAHY/KlE0jzc8nf16af+H5c1DQCNQTZVlRH7GXrzXDnhRTahxHtwIHU3mjjiN05aUdmfTEf4mBsW/lUgbCgAdZEl+S90uxZa6/et7H4bPAA3L7urEZsc1LRz0C4T2bnzz1GRSkqxGJN041UqJ0HiyI+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XA8mB3NB9Ux41Pp7kvmrN+Ft0+TA+PNt1PrehDY0bDGP7OxGJOlog9XCySxsO3mgTE1MrYNKVN8iBScPVMsN81tC8onbPUftyVcIPtB2sW05/vDMZA7zd+RnbbTOmHE13sS9AxlwGgR0KZo8C4JZJ1BSk3ODqiWYQXe2EUlHgPM=
Received: by 10.114.137.2 with SMTP id k2mr737639wad.1188825904984;
        Mon, 03 Sep 2007 06:25:04 -0700 (PDT)
Received: by 10.115.111.13 with HTTP; Mon, 3 Sep 2007 06:25:04 -0700 (PDT)
Message-ID: <40101cc30709030625p341efbcxeb2aed237123c690@mail.gmail.com>
Date:	Mon, 3 Sep 2007 15:25:04 +0200
From:	"Matteo Croce" <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 6/7] AR7: serial
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16354
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Serial support, should not broke other archs

Signed-off-by: Matteo Croce <technoboy85@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
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
@@ -2453,7 +2460,11 @@ static void serial8250_console_putchar(struct
uart_port *port, int ch)
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
index e811a61..8a86779 100644
--- a/include/linux/serialP.h
+++ b/include/linux/serialP.h
@@ -135,6 +135,9 @@ struct rs_multiport_struct {
  * the interrupt line _up_ instead of down, so if we register the IRQ
  * while the UART is in that state, we die in an IRQ storm. */
 #define ALPHA_KLUDGE_MCR (UART_MCR_OUT2)
+#elif defined(CONFIG_AR7)
+/* This is how it is set up by bootloader... */
+#define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1 |
UART_MCR_RTS | UART_MCR_DTR)
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
