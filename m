Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 11:48:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62925 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992198AbcIGJpstDTYS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 11:45:48 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5AC6426DD402;
        Wed,  7 Sep 2016 10:45:26 +0100 (IST)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 7 Sep 2016 10:45:29 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 05/12] MIPS: Barrier: Add definitions of SYNC stype values
Date:   Wed, 7 Sep 2016 10:45:13 +0100
Message-ID: <1473241520-14917-6-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
References: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55051
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

Add the definitions of sync stype 0 (global completion barrier) and sync
stype 0x10 (local ordering barrier) to barrier.h for use with the sync
instruction.

These types are defined by the MIPS Instruction Set since R2 of the
architecture and are documented in document MD00087 table 6.5.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2:
Add new patch to define standard MIPS barrier types

 arch/mips/include/asm/barrier.h | 96 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index d296633d890e..a5eb1bb199a7 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -10,6 +10,102 @@
 
 #include <asm/addrspace.h>
 
+/*
+ * Sync types defined by the MIPS architecture (document MD00087 table 6.5)
+ * These values are used with the sync instruction to perform memory barriers.
+ * Types of ordering guarantees available through the SYNC instruction:
+ * - Completion Barriers
+ * - Ordering Barriers
+ * As compared to the completion barrier, the ordering barrier is a
+ * lighter-weight operation as it does not require the specified instructions
+ * before the SYNC to be already completed. Instead it only requires that those
+ * specified instructions which are subsequent to the SYNC in the instruction
+ * stream are never re-ordered for processing ahead of the specified
+ * instructions which are before the SYNC in the instruction stream.
+ * This potentially reduces how many cycles the barrier instruction must stall
+ * before it completes.
+ * Implementations that do not use any of the non-zero values of stype to define
+ * different barriers, such as ordering barriers, must make those stype values
+ * act the same as stype zero.
+ */
+
+/*
+ * Completion barriers:
+ * - Every synchronizable specified memory instruction (loads or stores or both)
+ *   that occurs in the instruction stream before the SYNC instruction must be
+ *   already globally performed before any synchronizable specified memory
+ *   instructions that occur after the SYNC are allowed to be performed, with
+ *   respect to any other processor or coherent I/O module.
+ *
+ * - The barrier does not guarantee the order in which instruction fetches are
+ *   performed.
+ *
+ * - A stype value of zero will always be defined such that it performs the most
+ *   complete set of synchronization operations that are defined.This means
+ *   stype zero always does a completion barrier that affects both loads and
+ *   stores preceding the SYNC instruction and both loads and stores that are
+ *   subsequent to the SYNC instruction. Non-zero values of stype may be defined
+ *   by the architecture or specific implementations to perform synchronization
+ *   behaviors that are less complete than that of stype zero. If an
+ *   implementation does not use one of these non-zero values to define a
+ *   different synchronization behavior, then that non-zero value of stype must
+ *   act the same as stype zero completion barrier. This allows software written
+ *   for an implementation with a lighter-weight barrier to work on another
+ *   implementation which only implements the stype zero completion barrier.
+ *
+ * - A completion barrier is required, potentially in conjunction with SSNOP (in
+ *   Release 1 of the Architecture) or EHB (in Release 2 of the Architecture),
+ *   to guarantee that memory reference results are visible across operating
+ *   mode changes. For example, a completion barrier is required on some
+ *   implementations on entry to and exit from Debug Mode to guarantee that
+ *   memory effects are handled correctly.
+ */
+
+/*
+ * stype 0 - A completion barrier that affects preceding loads and stores and
+ * subsequent loads and stores.
+ * Older instructions which must reach the load/store ordering point before the
+ * SYNC instruction completes: Loads, Stores
+ * Younger instructions which must reach the load/store ordering point only
+ * after the SYNC instruction completes: Loads, Stores
+ * Older instructions which must be globally performed when the SYNC instruction
+ * completes: Loads, Stores
+ */
+#define STYPE_SYNC 0x0
+
+/*
+ * Ordering barriers:
+ * - Every synchronizable specified memory instruction (loads or stores or both)
+ *   that occurs in the instruction stream before the SYNC instruction must
+ *   reach a stage in the load/store datapath after which no instruction
+ *   re-ordering is possible before any synchronizable specified memory
+ *   instruction which occurs after the SYNC instruction in the instruction
+ *   stream reaches the same stage in the load/store datapath.
+ *
+ * - If any memory instruction before the SYNC instruction in program order,
+ *   generates a memory request to the external memory and any memory
+ *   instruction after the SYNC instruction in program order also generates a
+ *   memory request to external memory, the memory request belonging to the
+ *   older instruction must be globally performed before the time the memory
+ *   request belonging to the younger instruction is globally performed.
+ *
+ * - The barrier does not guarantee the order in which instruction fetches are
+ *   performed.
+ */
+
+/*
+ * stype 0x10 - An ordering barrier that affects preceding loads and stores and
+ * subsequent loads and stores.
+ * Older instructions which must reach the load/store ordering point before the
+ * SYNC instruction completes: Loads, Stores
+ * Younger instructions which must reach the load/store ordering point only
+ * after the SYNC instruction completes: Loads, Stores
+ * Older instructions which must be globally performed when the SYNC instruction
+ * completes: N/A
+ */
+#define STYPE_SYNC_MB 0x10
+
+
 #ifdef CONFIG_CPU_HAS_SYNC
 #define __sync()				\
 	__asm__ __volatile__(			\
-- 
2.7.4
