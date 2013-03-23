Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 19:27:07 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1452 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834928Ab3CWS03EBnNf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 19:26:29 +0100
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sat, 23 Mar 2013 11:21:51 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Sat, 23 Mar 2013 11:26:11 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Sat, 23 Mar 2013 11:26:12 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 1E0B53928C; Sat, 23
 Mar 2013 11:26:10 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 1/9] MIPS: Netlogic: Optimize and fix write_c0_eimr()
Date:   Sat, 23 Mar 2013 23:57:53 +0530
Message-ID: <b7e5500614e9ee7e890358327f73dae83776f5a8.1364062916.git.jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1364062916.git.jchandra@broadcom.com>
References: <cover.1364062916.git.jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7D532D353A01621394-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 35953
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

Remove the irq save/restore from write_c0_eimr(), as it is always called
with interrupts off.

This allows us to remove workaround in write_c0_eimr() to fix up the
flags used by local_irq_save. This fixup worked on XLR, but will break
when 32-bit support is added to r2 cpus like XLP.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/mips-extns.h |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/mips-extns.h b/arch/mips/include/asm/netlogic/mips-extns.h
index 8ad2e0f..69d18a0 100644
--- a/arch/mips/include/asm/netlogic/mips-extns.h
+++ b/arch/mips/include/asm/netlogic/mips-extns.h
@@ -43,16 +43,15 @@
 #define write_c0_eirr(val)	__write_64bit_c0_register($9, 6, val)
 
 /*
- * Writing EIMR in 32 bit is a special case, the lower 8 bit of the
- * EIMR is shadowed in the status register, so we cannot save and
- * restore status register for split read.
+ * NOTE: Do not save/restore flags around write_c0_eimr().
+ * On non-R2 platforms the flags has part of EIMR that is shadowed in STATUS
+ * register. Restoring flags will overwrite the lower 8 bits of EIMR.
+ *
+ * Call with interrupts disabled.
  */
 #define write_c0_eimr(val)						\
 do {									\
 	if (sizeof(unsigned long) == 4) {				\
-		unsigned long __flags;					\
-									\
-		local_irq_save(__flags);				\
 		__asm__ __volatile__(					\
 			".set\tmips64\n\t"				\
 			"dsll\t%L0, %L0, 32\n\t"			\
@@ -62,8 +61,6 @@ do {									\
 			"dmtc0\t%L0, $9, 7\n\t"				\
 			".set\tmips0"					\
 			: : "r" (val));					\
-		__flags = (__flags & 0xffff00ff) | (((val) & 0xff) << 8);\
-		local_irq_restore(__flags);				\
 	} else								\
 		__write_64bit_c0_register($9, 7, (val));		\
 } while (0)
-- 
1.7.9.5
