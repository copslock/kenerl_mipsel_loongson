Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 10:39:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25507 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008713AbaIKIhiCa5Ln (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 10:37:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 130465126B736;
        Thu, 11 Sep 2014 09:37:29 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 09:37:30 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 11 Sep 2014 08:31:39 +0100
Received: from pburton-laptop.home (192.168.159.78) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 08:31:39 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 03/10] binfmt_elf: allow arch code to examine PT_LOPROC ... PT_HIPROC headers
Date:   Thu, 11 Sep 2014 08:30:16 +0100
Message-ID: <1410420623-11691-4-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.78]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42509
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

MIPS is introducing new variants of its O32 ABI which differ in their
handling of floating point, in order to enable a gradual transition
towards a world where mips32 binaries can take advantage of new hardware
features only available when configured for certain FP modes. In order
to do this ELF binaries are being augmented with a new section that
indicates, amongst other things, the FP mode requirements of the binary.
The presence & location of such a section is indicated by a program
header in the PT_LOPROC ... PT_HIPROC range.

In order to allow the MIPS architecture code to examine the program
header & section in question, pass all program headers in this range
to an architecture-specific arch_elf_pt_proc function. This function
may return an error if the header is deemed invalid or unsuitable for
the system, in which case that error will be returned from
load_elf_binary and upwards through the execve syscall.

A means is required for the architecture code to make a decision once
it is known that all such headers have been seen, but before it is too
late to return from an execve syscall. For this purpose the
arch_check_elf function is added, and called once, after all PT_LOPROC
to PT_HIPROC headers have been passed to arch_elf_pt_proc but before
the code which invoked execve has been lost. This enables the
architecture code to make a decision based upon all the headers present
in an ELF binary and its interpreter, as is required to forbid
conflicting FP ABI requirements between an ELF & its interpreter.

In order to allow data to be stored throughout the calls to the above
functions, struct arch_elf_state is introduced.

Finally a variant of the SET_PERSONALITY macro is introduced which
accepts a pointer to the struct arch_elf_state, allowing it to act
based upon state observed from the architecture specific program
headers.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 fs/Kconfig.binfmt   |  3 +++
 fs/binfmt_elf.c     | 36 ++++++++++++++++++++++++--
 include/linux/elf.h | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 370b24c..c055d56 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -30,6 +30,9 @@ config COMPAT_BINFMT_ELF
 config ARCH_BINFMT_ELF_RANDOMIZE_PIE
 	bool
 
+config ARCH_BINFMT_ELF_STATE
+	bool
+
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 61dabe0..ceabb0d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -611,6 +611,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		struct elfhdr elf_ex;
 		struct elfhdr interp_elf_ex;
 	} *loc;
+	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
 
 	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
 	if (!loc) {
@@ -705,12 +706,21 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	elf_ppnt = elf_phdata;
 	for (i = 0; i < loc->elf_ex.e_phnum; i++, elf_ppnt++)
-		if (elf_ppnt->p_type == PT_GNU_STACK) {
+		switch (elf_ppnt->p_type) {
+		case PT_GNU_STACK:
 			if (elf_ppnt->p_flags & PF_X)
 				executable_stack = EXSTACK_ENABLE_X;
 			else
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
+
+		case PT_LOPROC ... PT_HIPROC:
+			retval = arch_elf_pt_proc(&loc->elf_ex, elf_ppnt,
+						  bprm->file, false,
+						  &arch_state);
+			if (retval)
+				goto out_free_dentry;
+			break;
 		}
 
 	/* Some simple consistency checks for the interpreter */
@@ -728,8 +738,30 @@ static int load_elf_binary(struct linux_binprm *bprm)
 						   interpreter);
 		if (!interp_elf_phdata)
 			goto out_free_dentry;
+
+		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
+		elf_ppnt = interp_elf_phdata;
+		for (i = 0; i < loc->interp_elf_ex.e_phnum; i++, elf_ppnt++)
+			switch (elf_ppnt->p_type) {
+			case PT_LOPROC ... PT_HIPROC:
+				retval = arch_elf_pt_proc(&loc->interp_elf_ex,
+							  elf_ppnt, interpreter,
+							  true, &arch_state);
+				if (retval)
+					goto out_free_dentry;
+				break;
+			}
 	}
 
+	/*
+	 * Allow arch code to reject the ELF at this point, whilst it's
+	 * still possible to return an error to the code that invoked
+	 * the exec syscall.
+	 */
+	retval = arch_check_elf(&loc->elf_ex, !!interpreter, &arch_state);
+	if (retval)
+		goto out_free_dentry;
+
 	/* Flush all traces of the currently running executable */
 	retval = flush_old_exec(bprm);
 	if (retval)
@@ -737,7 +769,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
 	   may depend on the personality.  */
-	SET_PERSONALITY(loc->elf_ex);
+	SET_PERSONALITY2(loc->elf_ex, &arch_state);
 	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 67a5fa7..6bd1504 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -15,6 +15,11 @@
 	set_personality(PER_LINUX | (current->personality & (~PER_MASK)))
 #endif
 
+#ifndef SET_PERSONALITY2
+#define SET_PERSONALITY2(ex, state) \
+	SET_PERSONALITY(ex)
+#endif
+
 #if ELF_CLASS == ELFCLASS32
 
 extern Elf32_Dyn _DYNAMIC [];
@@ -37,6 +42,74 @@ extern Elf64_Dyn _DYNAMIC [];
 
 #endif
 
+#ifndef CONFIG_ARCH_BINFMT_ELF_STATE
+
+/**
+ * struct arch_elf_state - arch-specific ELF loading state
+ *
+ * This structure is used to preserve architecture specific data during
+ * the loading of an ELF file, throughout the checking of architecture
+ * specific ELF headers & through to the point where the ELF load is
+ * known to be proceeding (ie. SET_PERSONALITY).
+ *
+ * This implementation is a dummy for architectures which require no
+ * specific state.
+ */
+struct arch_elf_state {
+};
+
+#define INIT_ARCH_ELF_STATE {}
+
+/**
+ * arch_elf_pt_proc() - check a PT_LOPROC..PT_HIPROC ELF program header
+ * @ehdr:	The main ELF header
+ * @phdr:	The program header to check
+ * @elf:	The open ELF file
+ * @is_interp:	True if the phdr is from the interpreter of the ELF being
+ *		loaded, else false.
+ * @state:	Architecture-specific state preserved throughout the process
+ *		of loading the ELF.
+ *
+ * Inspects the program header phdr to validate its correctness and/or
+ * suitability for the system. Called once per ELF program header in the
+ * range PT_LOPROC to PT_HIPROC, for both the ELF being loaded and its
+ * interpreter.
+ *
+ * Return: Zero to proceed with the ELF load, non-zero to fail the ELF load
+ *         with that return code.
+ */
+static inline int arch_elf_pt_proc(struct elfhdr *ehdr,
+				   struct elf_phdr *phdr,
+				   struct file *elf, bool is_interp,
+				   struct arch_elf_state *state)
+{
+	/* Dummy implementation, always proceed */
+	return 0;
+}
+
+/**
+ * arch_elf_pt_proc() - check a PT_LOPROC..PT_HIPROC ELF program header
+ * @ehdr:	The main ELF header
+ * @has_interp:	True if the ELF has an interpreter, else false.
+ * @state:	Architecture-specific state preserved throughout the process
+ *		of loading the ELF.
+ *
+ * Provides a final opportunity for architecture code to reject the loading
+ * of the ELF & cause an exec syscall to return an error. This is called after
+ * all program headers to be checked by arch_elf_pt_proc have been.
+ *
+ * Return: Zero to proceed with the ELF load, non-zero to fail the ELF load
+ *         with that return code.
+ */
+static inline int arch_check_elf(struct elfhdr *ehdr, bool has_interp,
+				 struct arch_elf_state *state)
+{
+	/* Dummy implementation, always proceed */
+	return 0;
+}
+
+#endif /* !CONFIG_ARCH_BINFMT_ELF_STATE */
+
 /* Optional callbacks to write extra ELF notes. */
 struct file;
 struct coredump_params;
-- 
2.0.4
