Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:26:48 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1465 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834945Ab3CWS02zpAz9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:28 +0100
Received: from [10.9.208.53] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:21:54 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:14 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:14 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 74C103928A; Sat, 23
 Mar 2013 11:26:12 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 2/9] MIPS: Netlogic: Remove unused EIMR/EIRR functions
Date:   Sat, 23 Mar 2013 23:57:54 +0530
Message-ID: <9e189bdc53ac2650d22d18f037df89dd2e412be9.1364062916.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1364062916.git.jchandra@broadcom.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D532D483A01621402-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35952
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove the definitions of {read,write}_c0_{eirr,eimr}. These functions
are now unused after the PIC and IRQ code has been updated to use
optimized EIMR/EIRR functions which work on both 32-bit and 64-bit.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/mips-extns.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
index 69d18a0..f299d31 100644
--- a/arch/mips/include/asm/netlogic/mips-extns.h
+++ b/arch/mips/include/asm/netlogic/mips-extns.h
@@ -38,10 +38,6 @@
 /*
  * XLR and XLP interrupt request and interrupt mask registers
  */
-#define read_c0_eirr()		__read_64bit_c0_register($9, 6)
-#define read_c0_eimr()		__read_64bit_c0_register($9, 7)
-#define write_c0_eirr(val)	__write_64bit_c0_register($9, 6, val)
-
 /*
  * NOTE: Do not save/restore flags around write_c0_eimr().
  * On non-R2 platforms the flags has part of EIMR that is shadowed in STATUS
@@ -125,7 +121,7 @@ static inline uint64_t read_c0_eirr_and_eimr(void)
 	uint64_t val;
 
 #ifdef CONFIG_64BIT
-	val = read_c0_eimr() & read_c0_eirr();
+	val = __read_64bit_c0_register($9, 6) & __read_64bit_c0_register($9, 7);
 #else
 	__asm__ __volatile__(
 		".set	push\n\t"
@@ -140,7 +136,6 @@ static inline uint64_t read_c0_eirr_and_eimr(void)
 		".set	pop"
 		: "=r" (val));
 #endif
-
 	return val;
 }
 
-- 
1.7.9.5
