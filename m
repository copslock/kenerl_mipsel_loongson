Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Oct 2009 19:07:49 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:62160 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492896AbZJORHn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Oct 2009 19:07:43 +0200
Received: by ewy12 with SMTP id 12so1129218ewy.0
        for <multiple recipients>; Thu, 15 Oct 2009 10:07:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=NV60d4feHtFmjTa0KQwiH9a2NdzUycjlc+aQ0oeHAHw=;
        b=puExIgMInHi8bnoX0ncl8Orl/h2bZswAMzcIIlLED5qH9mGH/ZEP89o6TSU8XHC3CY
         5+p9KCsUz+HSWnbB6AI8Uyoki6nV73y9AQMxtMkGcEtulosplAQFGn1N2vCIdAvcZhjr
         pOMGwpO6wKarW+rONKRfTOdM3QcMXPaU1em/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bPRRFQsBBax/EOVZ50fYvquCM/ciluDliAf1LVGkag4iJ70oTaWNt5uMCmLjGm3dFg
         OEOPPUFb4BOilVIc+At3olnSfLCT+pmNWduhhVZpx/gJ0HmJFQ34ADnK7127NhrgMg4u
         gTi0O9ILufeUiegHOa/outjq5S8iojOtWJEoY=
Received: by 10.216.89.130 with SMTP id c2mr91702wef.44.1255626456689;
        Thu, 15 Oct 2009 10:07:36 -0700 (PDT)
Received: from localhost.localdomain (p5496E392.dip.t-dialin.net [84.150.227.146])
        by mx.google.com with ESMTPS id m5sm588174gve.26.2009.10.15.10.07.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 10:07:33 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: get rid of superfluous UART definitions
Date:	Thu, 15 Oct 2009 19:07:34 +0200
Message-Id: <1255626454-12715-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Remove unused uart bit definitions and base macros.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Applies on top of the previous prom_putchar patch.

No functional changes observed.  The UART0_ADDR macro is used by PM
code but I'll get rid of that too, eventually.

 arch/mips/alchemy/common/platform.c        |   44 ++++++-------
 arch/mips/include/asm/mach-au1x00/au1000.h |   95 ----------------------------
 2 files changed, 21 insertions(+), 118 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 5a9a4f9..195e5b3 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -20,38 +20,36 @@
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 
-#define PORT(_base, _irq)				\
-	{						\
-		.iobase		= _base,		\
-		.membase	= (void __iomem *)_base,\
-		.mapbase	= CPHYSADDR(_base),	\
-		.irq		= _irq,			\
-		.regshift	= 2,			\
-		.iotype		= UPIO_AU,		\
-		.flags		= UPF_SKIP_TEST 	\
+#define PORT(_base, _irq)					\
+	{							\
+		.mapbase	= _base,			\
+		.irq		= _irq,				\
+		.regshift	= 2,				\
+		.iotype		= UPIO_AU,			\
+		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
 	}
 
 static struct plat_serial8250_port au1x00_uart_data[] = {
 #if defined(CONFIG_SERIAL_8250_AU1X00)
 #if defined(CONFIG_SOC_AU1000)
-	PORT(UART0_ADDR, AU1000_UART0_INT),
-	PORT(UART1_ADDR, AU1000_UART1_INT),
-	PORT(UART2_ADDR, AU1000_UART2_INT),
-	PORT(UART3_ADDR, AU1000_UART3_INT),
+	PORT(UART0_PHYS_ADDR, AU1000_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1000_UART1_INT),
+	PORT(UART2_PHYS_ADDR, AU1000_UART2_INT),
+	PORT(UART3_PHYS_ADDR, AU1000_UART3_INT),
 #elif defined(CONFIG_SOC_AU1500)
-	PORT(UART0_ADDR, AU1500_UART0_INT),
-	PORT(UART3_ADDR, AU1500_UART3_INT),
+	PORT(UART0_PHYS_ADDR, AU1500_UART0_INT),
+	PORT(UART3_PHYS_ADDR, AU1500_UART3_INT),
 #elif defined(CONFIG_SOC_AU1100)
-	PORT(UART0_ADDR, AU1100_UART0_INT),
-	PORT(UART1_ADDR, AU1100_UART1_INT),
-	PORT(UART3_ADDR, AU1100_UART3_INT),
+	PORT(UART0_PHYS_ADDR, AU1100_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1100_UART1_INT),
+	PORT(UART3_PHYS_ADDR, AU1100_UART3_INT),
 #elif defined(CONFIG_SOC_AU1550)
-	PORT(UART0_ADDR, AU1550_UART0_INT),
-	PORT(UART1_ADDR, AU1550_UART1_INT),
-	PORT(UART3_ADDR, AU1550_UART3_INT),
+	PORT(UART0_PHYS_ADDR, AU1550_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1550_UART1_INT),
+	PORT(UART3_PHYS_ADDR, AU1550_UART3_INT),
 #elif defined(CONFIG_SOC_AU1200)
-	PORT(UART0_ADDR, AU1200_UART0_INT),
-	PORT(UART1_ADDR, AU1200_UART1_INT),
+	PORT(UART0_PHYS_ADDR, AU1200_UART0_INT),
+	PORT(UART1_PHYS_ADDR, AU1200_UART1_INT),
 #endif
 #endif	/* CONFIG_SERIAL_8250_AU1X00 */
 	{ },
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 4918e64..ee65236 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -915,9 +915,6 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1000
 
 #define UART0_ADDR		0xB1100000
-#define UART1_ADDR		0xB1200000
-#define UART2_ADDR		0xB1300000
-#define UART3_ADDR		0xB1400000
 
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
@@ -934,7 +931,6 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1500
 
 #define UART0_ADDR		0xB1100000
-#define UART3_ADDR		0xB1400000
 
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017fffc
@@ -951,8 +947,6 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1100
 
 #define UART0_ADDR		0xB1100000
-#define UART1_ADDR		0xB1200000
-#define UART3_ADDR		0xB1400000
 
 #define USB_OHCI_BASE		0x10100000	/* phys addr for ioremap */
 #define USB_HOST_CONFIG 	0xB017FFFC
@@ -965,8 +959,6 @@ enum soc_au1200_ints {
 
 #ifdef CONFIG_SOC_AU1550
 #define UART0_ADDR		0xB1100000
-#define UART1_ADDR		0xB1200000
-#define UART3_ADDR		0xB1400000
 
 #define USB_OHCI_BASE		0x14020000	/* phys addr for ioremap */
 #define USB_OHCI_LEN		0x00060000
@@ -984,7 +976,6 @@ enum soc_au1200_ints {
 #ifdef CONFIG_SOC_AU1200
 
 #define UART0_ADDR		0xB1100000
-#define UART1_ADDR		0xB1200000
 
 #define USB_UOC_BASE		0x14020020
 #define USB_UOC_LEN		0x20
@@ -1261,14 +1252,6 @@ enum soc_au1200_ints {
 #define MAC_RX_BUFF3_STATUS	0x30
 #define MAC_RX_BUFF3_ADDR	0x34
 
-/* UARTS 0-3 */
-#define UART_BASE		UART0_ADDR
-#ifdef	CONFIG_SOC_AU1200
-#define UART_DEBUG_BASE 	UART1_ADDR
-#else
-#define UART_DEBUG_BASE 	UART3_ADDR
-#endif
-
 #define UART_RX		0	/* Receive buffer */
 #define UART_TX		4	/* Transmit buffer */
 #define UART_IER	8	/* Interrupt Enable Register */
@@ -1281,84 +1264,6 @@ enum soc_au1200_ints {
 #define UART_CLK	0x28	/* Baud Rate Clock Divider */
 #define UART_MOD_CNTRL	0x100	/* Module Control */
 
-#define UART_FCR_ENABLE_FIFO	0x01 /* Enable the FIFO */
-#define UART_FCR_CLEAR_RCVR	0x02 /* Clear the RCVR FIFO */
-#define UART_FCR_CLEAR_XMIT	0x04 /* Clear the XMIT FIFO */
-#define UART_FCR_DMA_SELECT	0x08 /* For DMA applications */
-#define UART_FCR_TRIGGER_MASK	0xF0 /* Mask for the FIFO trigger range */
-#define UART_FCR_R_TRIGGER_1	0x00 /* Mask for receive trigger set at 1 */
-#define UART_FCR_R_TRIGGER_4	0x40 /* Mask for receive trigger set at 4 */
-#define UART_FCR_R_TRIGGER_8	0x80 /* Mask for receive trigger set at 8 */
-#define UART_FCR_R_TRIGGER_14   0xA0 /* Mask for receive trigger set at 14 */
-#define UART_FCR_T_TRIGGER_0	0x00 /* Mask for transmit trigger set at 0 */
-#define UART_FCR_T_TRIGGER_4	0x10 /* Mask for transmit trigger set at 4 */
-#define UART_FCR_T_TRIGGER_8    0x20 /* Mask for transmit trigger set at 8 */
-#define UART_FCR_T_TRIGGER_12	0x30 /* Mask for transmit trigger set at 12 */
-
-/*
- * These are the definitions for the Line Control Register
- */
-#define UART_LCR_SBC	0x40	/* Set break control */
-#define UART_LCR_SPAR	0x20	/* Stick parity (?) */
-#define UART_LCR_EPAR	0x10	/* Even parity select */
-#define UART_LCR_PARITY	0x08	/* Parity Enable */
-#define UART_LCR_STOP	0x04	/* Stop bits: 0=1 stop bit, 1= 2 stop bits */
-#define UART_LCR_WLEN5  0x00	/* Wordlength: 5 bits */
-#define UART_LCR_WLEN6  0x01	/* Wordlength: 6 bits */
-#define UART_LCR_WLEN7  0x02	/* Wordlength: 7 bits */
-#define UART_LCR_WLEN8  0x03	/* Wordlength: 8 bits */
-
-/*
- * These are the definitions for the Line Status Register
- */
-#define UART_LSR_TEMT	0x40	/* Transmitter empty */
-#define UART_LSR_THRE	0x20	/* Transmit-hold-register empty */
-#define UART_LSR_BI	0x10	/* Break interrupt indicator */
-#define UART_LSR_FE	0x08	/* Frame error indicator */
-#define UART_LSR_PE	0x04	/* Parity error indicator */
-#define UART_LSR_OE	0x02	/* Overrun error indicator */
-#define UART_LSR_DR	0x01	/* Receiver data ready */
-
-/*
- * These are the definitions for the Interrupt Identification Register
- */
-#define UART_IIR_NO_INT	0x01	/* No interrupts pending */
-#define UART_IIR_ID	0x06	/* Mask for the interrupt ID */
-#define UART_IIR_MSI	0x00	/* Modem status interrupt */
-#define UART_IIR_THRI	0x02	/* Transmitter holding register empty */
-#define UART_IIR_RDI	0x04	/* Receiver data interrupt */
-#define UART_IIR_RLSI	0x06	/* Receiver line status interrupt */
-
-/*
- * These are the definitions for the Interrupt Enable Register
- */
-#define UART_IER_MSI	0x08	/* Enable Modem status interrupt */
-#define UART_IER_RLSI	0x04	/* Enable receiver line status interrupt */
-#define UART_IER_THRI	0x02	/* Enable Transmitter holding register int. */
-#define UART_IER_RDI	0x01	/* Enable receiver data interrupt */
-
-/*
- * These are the definitions for the Modem Control Register
- */
-#define UART_MCR_LOOP	0x10	/* Enable loopback test mode */
-#define UART_MCR_OUT2	0x08	/* Out2 complement */
-#define UART_MCR_OUT1	0x04	/* Out1 complement */
-#define UART_MCR_RTS	0x02	/* RTS complement */
-#define UART_MCR_DTR	0x01	/* DTR complement */
-
-/*
- * These are the definitions for the Modem Status Register
- */
-#define UART_MSR_DCD	0x80	/* Data Carrier Detect */
-#define UART_MSR_RI	0x40	/* Ring Indicator */
-#define UART_MSR_DSR	0x20	/* Data Set Ready */
-#define UART_MSR_CTS	0x10	/* Clear to Send */
-#define UART_MSR_DDCD	0x08	/* Delta DCD */
-#define UART_MSR_TERI	0x04	/* Trailing edge ring indicator */
-#define UART_MSR_DDSR	0x02	/* Delta DSR */
-#define UART_MSR_DCTS	0x01	/* Delta CTS */
-#define UART_MSR_ANY_DELTA 0x0F	/* Any of the delta bits! */
-
 /* SSIO */
 #define SSI0_STATUS		0xB1600000
 #  define SSI_STATUS_BF 	(1 << 4)
-- 
1.6.5.rc2
