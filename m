Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 12:47:34 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39000 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992221AbcHaKpFVmfCD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 12:45:05 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id D0823C8C5AED3;
        Wed, 31 Aug 2016 11:44:46 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 31 Aug 2016 11:44:48 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 06/10] MIPS: pm-cps: Use MIPS standard lightweight ordering barrier
Date:   Wed, 31 Aug 2016 11:44:35 +0100
Message-ID: <1472640279-26593-7-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
References: <1472640279-26593-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Since R2 of the MIPS architecture, SYNC(0x10) has been an optional but
architecturally defined ordering barrier. If a CPU does not implement it,
the arch specifies that it must fall back to SYNC(0).

Define the barrier type and always use it in the pm-cps code rather than
falling back to the heavyweight sync(0) such that we can benefit from
the lighter weight sync.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/include/asm/barrier.h | 10 ++++++++++
 arch/mips/kernel/pm-cps.c       |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index d296633d890e..90c7a97db7e1 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -10,6 +10,16 @@
 
 #include <asm/addrspace.h>
 
+/*
+ * Lightweight sync types defined by the MIPS architecture
+ * These values are used with the sync instruction to perform memory barriers
+ * other than the standard heavyweight sync(0) completion barrier.
+ */
+
+/* Lightweight ordering barrier */
+#define STYPE_SYNC_MB 0x10
+
+
 #ifdef CONFIG_CPU_HAS_SYNC
 #define __sync()				\
 	__asm__ __volatile__(			\
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index f8c8edd0a451..572dc1d016a0 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -76,7 +76,7 @@ static struct uasm_reloc relocs[32] __initdata;
 /* CPU dependant sync types */
 static unsigned stype_intervention;
 static unsigned stype_memory;
-static unsigned stype_ordering;
+static unsigned stype_ordering = STYPE_SYNC_MB;
 
 enum mips_reg {
 	zero, at, v0, v1, a0, a1, a2, a3,
@@ -677,7 +677,6 @@ static int __init cps_pm_init(void)
 	case CPU_P6600:
 		stype_intervention = 0x2;
 		stype_memory = 0x3;
-		stype_ordering = 0x10;
 		break;
 
 	default:
-- 
2.7.4
