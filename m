Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 00:10:16 +0200 (CEST)
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:18711
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854789AbaE1WJhlWNa8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 00:09:37 +0200
Received: from alberich.caveonetworks.com (31.213.222.82) by
 BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22) with Microsoft SMTP
 Server (TLS) id 15.0.949.11; Wed, 28 May 2014 21:54:18 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        James Hogan <james.hogan@imgtec.com>, <kvm@vger.kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 09/13] MIPS: Add functions for hypervisor call
Date:   Wed, 28 May 2014 23:52:12 +0200
Message-ID: <1401313936-11867-10-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1401313936-11867-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [31.213.222.82]
X-ClientProxiedBy: AMSPR01CA013.eurprd01.prod.exchangelabs.com
 (10.255.167.158) To BLUPR07MB386.namprd07.prod.outlook.com (10.141.27.22)
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(69596002)(99396002)(76482001)(46102001)(77156001)(50466002)(85852003)(50226001)(89996001)(83072002)(53416003)(102836001)(104166001)(101416001)(80022001)(92566001)(64706001)(92726001)(79102001)(19580395003)(83322001)(19580405001)(31966008)(74502001)(74662001)(36756003)(33646001)(86362001)(66066001)(21056001)(81342001)(87286001)(93916002)(62966002)(4396001)(77982001)(48376002)(50986999)(76176999)(87976001)(20776003)(81542001)(42186004)(81156002)(88136002)(47776003);DIR:OUT;SFP:;SCL:1;SRVR:BLUPR07MB386;H:alberich.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

From: David Daney <david.daney@cavium.com>

Introduce kvm_hypercall[0-3].
Define three new hypercalls for MIPS: GET_CLOCK_FREQ, EXIT_VM, and
CONSOLE_OUTPUT.

[andreas.herrmann:
  * Properly define hypercalls and HC numbers for MIPS
    in kvm_para.h header files]

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 arch/mips/include/asm/kvm_para.h      |   91 +++++++++++++++++++++++++++++++++
 arch/mips/include/uapi/asm/kvm_para.h |    6 ++-
 include/uapi/linux/kvm_para.h         |    3 ++
 3 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/asm/kvm_para.h

diff --git a/arch/mips/include/asm/kvm_para.h b/arch/mips/include/asm/kvm_para.h
new file mode 100644
index 0000000..e559812
--- /dev/null
+++ b/arch/mips/include/asm/kvm_para.h
@@ -0,0 +1,91 @@
+#ifndef _ASM_MIPS_KVM_PARA_H
+#define _ASM_MIPS_KVM_PARA_H
+
+#include <uapi/asm/kvm_para.h>
+
+#define KVM_HYPERCALL ".word 0x42000028"
+
+/*
+ * Hypercalls for KVM.
+ *
+ * Hypercall number is passed in v0.
+ * Return value will be placed in v0.
+ * Up to 3 arguments are passed in a0, a1, and a2.
+ */
+static inline unsigned long kvm_hypercall0(unsigned long num)
+{
+	register unsigned long n asm("v0");
+	register unsigned long r asm("v0");
+
+	n = num;
+	__asm__ __volatile__(
+		KVM_HYPERCALL
+		: "=r" (r) : "r" (n) : "memory"
+		);
+
+	return r;
+}
+
+static inline unsigned long kvm_hypercall1(unsigned long num,
+					unsigned long arg0)
+{
+	register unsigned long n asm("v0");
+	register unsigned long r asm("v0");
+	register unsigned long a0 asm("a0");
+
+	n = num;
+	a0 = arg0;
+	__asm__ __volatile__(
+		KVM_HYPERCALL
+		: "=r" (r) : "r" (n), "r" (a0) : "memory"
+		);
+
+	return r;
+}
+
+static inline unsigned long kvm_hypercall2(unsigned long num,
+					unsigned long arg0, unsigned long arg1)
+{
+	register unsigned long n asm("v0");
+	register unsigned long r asm("v0");
+	register unsigned long a0 asm("a0");
+	register unsigned long a1 asm("a1");
+
+	n = num;
+	a0 = arg0;
+	a1 = arg1;
+	__asm__ __volatile__(
+		KVM_HYPERCALL
+		: "=r" (r) : "r" (n), "r" (a0), "r" (a1) : "memory"
+		);
+
+	return r;
+}
+
+static inline unsigned long kvm_hypercall3(unsigned long num,
+	unsigned long arg0, unsigned long arg1, unsigned long arg2)
+{
+	register unsigned long n asm("v0");
+	register unsigned long r asm("v0");
+	register unsigned long a0 asm("a0");
+	register unsigned long a1 asm("a1");
+	register unsigned long a2 asm("a2");
+
+	n = num;
+	a0 = arg0;
+	a1 = arg1;
+	a2 = arg2;
+	__asm__ __volatile__(
+		KVM_HYPERCALL
+		: "=r" (r) : "r" (n), "r" (a0), "r" (a1), "r" (a2) : "memory"
+		);
+
+	return r;
+}
+
+static inline unsigned int kvm_arch_para_features(void)
+{
+	return 0;
+}
+
+#endif /* _ASM_MIPS_KVM_PARA_H */
diff --git a/arch/mips/include/uapi/asm/kvm_para.h b/arch/mips/include/uapi/asm/kvm_para.h
index 14fab8f..7e16d7c 100644
--- a/arch/mips/include/uapi/asm/kvm_para.h
+++ b/arch/mips/include/uapi/asm/kvm_para.h
@@ -1 +1,5 @@
-#include <asm-generic/kvm_para.h>
+#ifndef _UAPI_ASM_MIPS_KVM_PARA_H
+#define _UAPI_ASM_MIPS_KVM_PARA_H
+
+
+#endif /* _UAPI_ASM_MIPS_KVM_PARA_H */
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index 2841f86..bf6cd7d 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -20,6 +20,9 @@
 #define KVM_HC_FEATURES			3
 #define KVM_HC_PPC_MAP_MAGIC_PAGE	4
 #define KVM_HC_KICK_CPU			5
+#define KVM_HC_MIPS_GET_CLOCK_FREQ	6
+#define KVM_HC_MIPS_EXIT_VM		7
+#define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 
 /*
  * hypercalls use architecture specific
-- 
1.7.9.5
