Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2017 10:59:08 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:59354 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992336AbdLLJ6rLyw9C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2017 10:58:47 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 12 Dec 2017 09:58:40 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 12 Dec 2017 01:58:40 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [RFC PATCH 01/16] MIPS: VDSO: Prevent use of smp_processor_id()
Date:   Tue, 12 Dec 2017 09:57:47 +0000
Message-ID: <1513072682-1371-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
References: <1513072682-1371-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1513072719-298555-4532-274402-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187894
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

From: Paul Burton <paul.burton@imgtec.com>

VDSO code should not be using smp_processor_id(), since it is executed
in user mode.
Introduce a VDSO-specific path which will cause a compile-time
or link-time error (depending upon support for __compiletime_error) if
the VDSO ever incorrectly attempts to use smp_processor_id().

[Matt Redfearn <matt.redfearn@imgtec.com>: Move before change to
smp_processor_id in series]
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

 arch/mips/include/asm/smp.h | 12 +++++++++++-
 arch/mips/vdso/Makefile     |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 88ebd83b3bf9..056a6bf13491 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -25,7 +25,17 @@ extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
 extern cpumask_t cpu_foreign_map[];
 
-#define raw_smp_processor_id() (current_thread_info()->cpu)
+static inline int raw_smp_processor_id(void)
+{
+#if defined(__VDSO__)
+	extern int vdso_smp_processor_id(void)
+		__compiletime_error("VDSO should not call smp_processor_id()");
+	return vdso_smp_processor_id();
+#else
+	return current_thread_info()->cpu;
+#endif
+}
+#define raw_smp_processor_id raw_smp_processor_id
 
 /* Map from cpu id to sequential logical cpu number.  This will only
    not be idempotent when cpus failed to come on-line.	*/
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index ce196046ac3e..477c463c89ec 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -7,7 +7,8 @@ ccflags-vdso := \
 	$(filter -I%,$(KBUILD_CFLAGS)) \
 	$(filter -E%,$(KBUILD_CFLAGS)) \
 	$(filter -mmicromips,$(KBUILD_CFLAGS)) \
-	$(filter -march=%,$(KBUILD_CFLAGS))
+	$(filter -march=%,$(KBUILD_CFLAGS)) \
+	-D__VDSO__
 cflags-vdso := $(ccflags-vdso) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
-- 
2.7.4
