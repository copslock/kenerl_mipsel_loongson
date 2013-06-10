Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:33:21 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1876 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819540Ab3FJHc0tC6DA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:32:26 +0200
Received: from [10.9.208.55] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:28:27 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:32:06 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:32:06 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 67CAAF2D75; Mon, 10
 Jun 2013 00:32:03 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 2/2] MIPS: Netlogic: Support compressed kernel
Date:   Mon, 10 Jun 2013 13:03:26 +0530
Message-ID: <1370849606-5025-3-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370849606-5025-1-git-send-email-jchandra@broadcom.com>
References: <1370849606-5025-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5F9131W33900590-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Add SYS_SUPPORTS_ZBOOT and SYS_SUPPORTS_ZBOOT_UART16550 config options
for XLR and XLP.

Update boot/compressed/uart-16550.c to add UART port for XLR and XLP.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/Kconfig                      |    4 ++++
 arch/mips/boot/compressed/uart-16550.c |   12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f9e278b..2c28631 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -806,6 +806,8 @@ config NLM_XLR_BOARD
 	select SYS_HAS_EARLY_PRINTK
 	select USB_ARCH_HAS_OHCI if USB_SUPPORT
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
+	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_ZBOOT_UART16550
 	help
 	  Support for systems based on Netlogic XLR and XLS processors.
 	  Say Y here if you have a XLR or XLS based board.
@@ -832,6 +834,8 @@ config NLM_XLP_BOARD
 	select SYNC_R4K
 	select SYS_HAS_EARLY_PRINTK
 	select USE_OF
+	select SYS_SUPPORTS_ZBOOT
+	select SYS_SUPPORTS_ZBOOT_UART16550
 	help
 	  This board is based on Netlogic XLP Processor.
 	  Say Y here if you have a XLP based board.
diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index 90ae440..c01d343 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -23,6 +23,18 @@
 #define PORT(offset) (UART0_BASE + (4 * offset))
 #endif
 
+#ifdef CONFIG_CPU_XLR
+#define UART0_BASE  0x1EF14000
+#define PORT(offset) (CKSEG1ADDR(UART0_BASE) + (4 * offset))
+#define IOTYPE unsigned int
+#endif
+
+#ifdef CONFIG_CPU_XLP
+#define UART0_BASE  0x18030100
+#define PORT(offset) (CKSEG1ADDR(UART0_BASE) + (4 * offset))
+#define IOTYPE unsigned int
+#endif
+
 #ifndef IOTYPE
 #define IOTYPE char
 #endif
-- 
1.7.9.5
