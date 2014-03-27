Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2014 07:42:46 +0100 (CET)
Received: from mail-ee0-f43.google.com ([74.125.83.43]:37572 "EHLO
        mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816360AbaC0GmnUeuVO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Mar 2014 07:42:43 +0100
Received: by mail-ee0-f43.google.com with SMTP id e53so2436307eek.30
        for <linux-mips@linux-mips.org>; Wed, 26 Mar 2014 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=o5wSLMqnPrucd5b5cbyDnSPE+2gCySHOHNm4q3rBQso=;
        b=yhK5GQR/SxVPv+67OTjaFOgBwYHwjP1LBwNlwB6iozZHFuDOaxKX2xGgPwPf1ljQ4F
         fQ1tHmswaxJsOHxmWd8hs1xgyHdezJ0QiCUEGgYVusPVf2546h4uNzVqRvtJTfbUI4OO
         0+qmoPvgPIY/xA/k85X1Rr14hB9ZaRlc/aij23o6zsCe2A/uxSaqk1PmQkQ9JccPIX66
         LNrHoyhQ+zBk+ocHYecg04xHkkWfxdRtBs++Ep/gwx2RMweaT7AGWLPCrR0j/ZRVD1iV
         g1qA+ot+kC6nt2wm9h49Q22E9Z7BMtEOGSgglv9oIbXIa7ZPWqX+IYqgKXlJNGXR6/Ng
         jX9A==
X-Received: by 10.15.54.6 with SMTP id s6mr137822eew.4.1395902557633;
        Wed, 26 Mar 2014 23:42:37 -0700 (PDT)
Received: from localhost.localdomain (p4FD8D079.dip0.t-ipconnect.de. [79.216.208.121])
        by mx.google.com with ESMTPSA id w12sm2194081eez.36.2014.03.26.23.42.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Mar 2014 23:42:37 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: remove duplicate UART register offset definitions
Date:   Thu, 27 Mar 2014 07:42:29 +0100
Message-Id: <1395902549-176198-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

The UART register names are identical to the ones in uapi/linux/serial_reg.h,
which causes build failures in various drivers when they indirectly pull in
the au1000.h header, for example via gpio.h:

In file included from arch/mips/include/asm/mach-au1x00/gpio.h:13:0,
                 from arch/mips/include/asm/gpio.h:4,
                 from include/linux/gpio.h:48,
                 from include/linux/ssb/ssb.h:9,
                 from drivers/ssb/driver_mipscore.c:11:
arch/mips/include/asm/mach-au1x00/au1000.h:1171:0: note: this is the location of the previous definition
 #define UART_LSR 0x1C /* Line Status Register */

Get rid of the altogether, nothing in the core Alchemy code depends
on them any more.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/au1000.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index 54f9e84..b4c3ecb 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -1161,18 +1161,6 @@ enum soc_au1200_ints {
 #define MAC_RX_BUFF3_STATUS	0x30
 #define MAC_RX_BUFF3_ADDR	0x34
 
-#define UART_RX		0	/* Receive buffer */
-#define UART_TX		4	/* Transmit buffer */
-#define UART_IER	8	/* Interrupt Enable Register */
-#define UART_IIR	0xC	/* Interrupt ID Register */
-#define UART_FCR	0x10	/* FIFO Control Register */
-#define UART_LCR	0x14	/* Line Control Register */
-#define UART_MCR	0x18	/* Modem Control Register */
-#define UART_LSR	0x1C	/* Line Status Register */
-#define UART_MSR	0x20	/* Modem Status Register */
-#define UART_CLK	0x28	/* Baud Rate Clock Divider */
-#define UART_MOD_CNTRL	0x100	/* Module Control */
-
 /* SSIO */
 #define SSI0_STATUS		0xB1600000
 #  define SSI_STATUS_BF		(1 << 4)
-- 
1.9.1
