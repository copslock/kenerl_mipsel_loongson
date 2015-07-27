Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 22:02:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47971 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011440AbbG0UBoo41-X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 22:01:44 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 26F758BD20177;
        Mon, 27 Jul 2015 21:01:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 27 Jul 2015 21:01:37 +0100
Received: from localhost (10.100.200.213) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 27 Jul
 2015 21:01:36 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Matthew Fortune <matthew.fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Daniel Borkmann <dborkman@redhat.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@codesourcery.com>
Subject: [PATCH v2 10/16] MIPS: add definitions for extended context
Date:   Mon, 27 Jul 2015 12:58:21 -0700
Message-ID: <1438027107-24420-11-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.6
In-Reply-To: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
References: <1438027107-24420-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.213]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The context introduced by MSA needs to be saved around signals. However,
we can't increase the size of struct sigcontext because that will change
the offset of the signal mask in struct sigframe or struct ucontext.
This patch instead places the new context immediately after the struct
sigframe for traditional signals, or similarly after struct ucontext for
RT signals. The layout of struct sigframe & struct ucontext is identical
from their sigcontext fields onwards, so the offset from the sigcontext
to the extended context will always be the same regardless of the type
of signal.

Userland will be able to search through the extended context by using
the magic values to detect which types of context are present. Any
unrecognised context can be skipped over using the size field of struct
extcontext. Once the magic value END_EXTCONTEXT_MAGIC is seen it is
known that there are no further extended context structures to examine.

This approach is somewhat similar to that taken by ARM to save VFP &
other context at the end of struct ucontext.

Userland can determine whether extended context is present by checking
for the USED_EXTCONTEXT bit in the sc_used_math field of struct
sigcontext. Whilst this could potentially change the historic semantics
of sc_used_math if further extended context which does not imply FP
context were to be introduced in the future, I have been unable to find
any userland code making use of sc_used_math at all. Using one of the
fields described as unused in struct sigcontext was considered, but the
kernel does not already write to those fields so there would be no
guarantee of the field being clear on older kernels. Other alternatives
would be to have userland check the kernel version, or to have a HWCAP
bit indicating presence of extended context. However there is a desire
to have the context & information required to decode it be self
contained such that, for example, debuggers could decode the saved
context easily.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/include/asm/Kbuild            |  1 -
 arch/mips/include/uapi/asm/sigcontext.h |  3 ++
 arch/mips/include/uapi/asm/ucontext.h   | 65 +++++++++++++++++++++++++++++++++
 arch/mips/kernel/signal.c               | 13 +++++++
 4 files changed, 81 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/include/uapi/asm/ucontext.h

diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 526539c..18e8b8d 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -16,6 +16,5 @@ generic-y += sections.h
 generic-y += segment.h
 generic-y += serial.h
 generic-y += trace_clock.h
-generic-y += ucontext.h
 generic-y += user.h
 generic-y += xor.h
diff --git a/arch/mips/include/uapi/asm/sigcontext.h b/arch/mips/include/uapi/asm/sigcontext.h
index f28facd..80db06c 100644
--- a/arch/mips/include/uapi/asm/sigcontext.h
+++ b/arch/mips/include/uapi/asm/sigcontext.h
@@ -21,6 +21,9 @@
 /* FR=1, but with odd singles in bits 63:32 of preceding even double */
 #define USED_HYBRID_FPRS	(1 << 2)
 
+/* extended context was used, see struct extcontext for details */
+#define USED_EXTCONTEXT		(1 << 3)
+
 #if _MIPS_SIM == _MIPS_SIM_ABI32
 
 struct sigcontext {
diff --git a/arch/mips/include/uapi/asm/ucontext.h b/arch/mips/include/uapi/asm/ucontext.h
new file mode 100644
index 0000000..2320144
--- /dev/null
+++ b/arch/mips/include/uapi/asm/ucontext.h
@@ -0,0 +1,65 @@
+#ifndef __MIPS_UAPI_ASM_UCONTEXT_H
+#define __MIPS_UAPI_ASM_UCONTEXT_H
+
+/**
+ * struct extcontext - extended context header structure
+ * @magic:	magic value identifying the type of extended context
+ * @size:	the size in bytes of the enclosing structure
+ *
+ * Extended context structures provide context which does not fit within struct
+ * sigcontext. They are placed sequentially in memory at the end of struct
+ * ucontext and struct sigframe, with each extended context structure beginning
+ * with a header defined by this struct. The type of context represented is
+ * indicated by the magic field. Userland may check each extended context
+ * structure against magic values that it recognises. The size field allows any
+ * unrecognised context to be skipped, allowing for future expansion. The end
+ * of the extended context data is indicated by the magic value
+ * END_EXTCONTEXT_MAGIC.
+ */
+struct extcontext {
+	unsigned int		magic;
+	unsigned int		size;
+};
+
+/**
+ * struct msa_extcontext - MSA extended context structure
+ * @ext:	the extended context header, with magic == MSA_EXTCONTEXT_MAGIC
+ * @wr:		the most significant 64 bits of each MSA vector register
+ * @csr:	the value of the MSA control & status register
+ *
+ * If MSA context is live for a task at the time a signal is delivered to it,
+ * this structure will hold the MSA context of the task as it was prior to the
+ * signal delivery.
+ */
+struct msa_extcontext {
+	struct extcontext	ext;
+#define MSA_EXTCONTEXT_MAGIC	0x784d5341	/* xMSA */
+
+	unsigned long long	wr[32];
+	unsigned int		csr;
+};
+
+#define END_EXTCONTEXT_MAGIC	0x78454e44	/* xEND */
+
+/**
+ * struct ucontext - user context structure
+ * @uc_flags:
+ * @uc_link:
+ * @uc_stack:
+ * @uc_mcontext:	holds basic processor state
+ * @uc_sigmask:
+ * @uc_extcontext:	holds extended processor state
+ */
+struct ucontext {
+	/* Historic fields matching asm-generic */
+	unsigned long		uc_flags;
+	struct ucontext		*uc_link;
+	stack_t			uc_stack;
+	struct sigcontext	uc_mcontext;
+	sigset_t		uc_sigmask;
+
+	/* Extended context structures may follow ucontext */
+	unsigned long long	uc_extcontext[0];
+};
+
+#endif /* __MIPS_UAPI_ASM_UCONTEXT_H */
diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
index 9cb75e9..3101baf 100644
--- a/arch/mips/kernel/signal.c
+++ b/arch/mips/kernel/signal.c
@@ -47,8 +47,11 @@ static int (*restore_fp_context)(void __user *sc);
 struct sigframe {
 	u32 sf_ass[4];		/* argument save space for o32 */
 	u32 sf_pad[2];		/* Was: signal trampoline */
+
+	/* Matches struct ucontext from its uc_mcontext field onwards */
 	struct sigcontext sf_sc;
 	sigset_t sf_mask;
+	unsigned long long sf_extcontext[0];
 };
 
 struct rt_sigframe {
@@ -686,6 +689,16 @@ static int smp_restore_fp_context(void __user *sc)
 
 static int signal_setup(void)
 {
+	/*
+	 * The offset from sigcontext to extended context should be the same
+	 * regardless of the type of signal, such that userland can always know
+	 * where to look if it wishes to find the extended context structures.
+	 */
+	BUILD_BUG_ON((offsetof(struct sigframe, sf_extcontext) -
+		      offsetof(struct sigframe, sf_sc)) !=
+		     (offsetof(struct rt_sigframe, rs_uc.uc_extcontext) -
+		      offsetof(struct rt_sigframe, rs_uc.uc_mcontext)));
+
 #ifdef CONFIG_SMP
 	/* For now just do the cpu_has_fpu check when the functions are invoked */
 	save_fp_context = smp_save_fp_context;
-- 
2.4.6
