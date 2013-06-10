Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:32:27 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:1843 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818476Ab3FJHcQPAZ0F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:32:16 +0200
Received: from [10.9.208.57] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:28:24 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:32:03 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:32:03 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 8CD58F2D88; Mon, 10
 Jun 2013 00:32:02 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 1/2] MIPS: boot: Fixes for compressed/uart-16550.c
Date:   Mon, 10 Jun 2013 13:03:25 +0530
Message-ID: <1370849606-5025-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370849606-5025-1-git-send-email-jchandra@broadcom.com>
References: <1370849606-5025-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DAB5F9231W33900575-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36773
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

Fix uart-16550.c for adding XLR/XLP support, changes are:
* Make register read/write use volatile pointers
* Support 32 bit IO read/write
* Increase timeout in waiting for UART LSR

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/boot/compressed/uart-16550.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index 1c7b739..90ae440 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -23,23 +23,27 @@
 #define PORT(offset) (UART0_BASE + (4 * offset))
 #endif
 
+#ifndef IOTYPE
+#define IOTYPE char
+#endif
+
 #ifndef PORT
 #error please define the serial port address for your own machine
 #endif
 
 static inline unsigned int serial_in(int offset)
 {
-	return *((char *)PORT(offset));
+	return *((volatile IOTYPE *)PORT(offset)) & 0xFF;
 }
 
 static inline void serial_out(int offset, int value)
 {
-	*((char *)PORT(offset)) = value;
+	*((volatile IOTYPE *)PORT(offset)) = value & 0xFF;
 }
 
 void putc(char c)
 {
-	int timeout = 1024;
+	int timeout = 1000000;
 
 	while (((serial_in(UART_LSR) & UART_LSR_THRE) == 0) && (timeout-- > 0))
 		;
-- 
1.7.9.5
