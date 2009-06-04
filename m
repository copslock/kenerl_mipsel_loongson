Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 15:23:03 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:33447 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022294AbZFDOW5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 15:22:57 +0100
Received: by fxm23 with SMTP id 23so821613fxm.0
        for <multiple recipients>; Thu, 04 Jun 2009 07:22:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XfqWeE+3z+P3ZxRjqykV8MEbMBD2dZ5U2AH83hfUcN4=;
        b=iTzLthrC7wJQcUZ8YY3SHLha28wj3oyr3kxoNWsv14VA/OJS6msv6y96kvjKMH8/8g
         45JmbAGX1xNPOoxi1t+eWD49MX6v+ebtrBHL7lFOZHsVU2EK5fXCY/D6f0QsYTqzeytR
         TkKpcJiuY3hTQpFpIs0+jOyiZzYctq5m7KT2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Ky/4OFA264c1bnvi3rRbcRWutEWGWaGBLXRK7R+TNpCxtrwiJV83Jn5+ecMc2+0wqY
         fTjzQ/q1pmKJafX1kGB8yJCAgQbk3fcxd2lV4hwLfVGqu1bDgqKpv2EqSL+snIZH6LiJ
         ZapCIHRkSqTpip+AfqValaARXCM9f8j5HioPw=
Received: by 10.86.59.18 with SMTP id h18mr2608879fga.44.1244125371206;
        Thu, 04 Jun 2009 07:22:51 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id e20sm1967829fga.15.2009.06.04.07.22.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 07:22:50 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Thu, 4 Jun 2009 16:22:46 +0200
Subject: [PATCH 8/8] 8250: add Texas Instruments AR7 internal UART
MIME-Version: 1.0
X-UID:	239
X-Length: 2074
To:	"Linux-MIPS" <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-serial@vger.kernel.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906041622.47591.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Alan,

We discussed that in private, there are a couple of things
to fix in order to get 8250 working properly with TI AR7 HW.
If you can still merge that bit, this would ease future work, thanks !
--
From: Florian Fainelli <florian@openwrt.org>

This patch adds support for Texas Instruments AR7 internal
UART.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index a0127e9..fb867a9 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -287,6 +287,13 @@ static const struct serial8250_config uart_config[] = {
 		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
 		.flags		= UART_CAP_FIFO,
 	},
+	[PORT_AR7] = {
+		.name		= "AR7",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
+		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
+	},
 };
 
 #if defined (CONFIG_SERIAL_8250_AU1X00)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 57a97e5..48766ea 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -41,7 +41,8 @@
 #define PORT_XSCALE	15
 #define PORT_RM9000	16	/* PMC-Sierra RM9xxx internal UART */
 #define PORT_OCTEON	17	/* Cavium OCTEON internal UART */
-#define PORT_MAX_8250	17	/* max port ID */
+#define PORT_AR7	18	/* Texas Instruments AR7 internal UART */
+#define PORT_MAX_8250	18	/* max port ID */
 
 /*
  * ARM specific type numbers.  These are not currently guaranteed
