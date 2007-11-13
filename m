Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 21:29:22 +0000 (GMT)
Received: from fk-out-0910.google.com ([209.85.128.185]:5415 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027420AbXKMV3N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 21:29:13 +0000
Received: by fk-out-0910.google.com with SMTP id f40so1882956fka
        for <linux-mips@linux-mips.org>; Tue, 13 Nov 2007 13:29:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=VdfsikXDURqE+3XnCbSX0kv36hT6tShkRfyW6Lide0A=;
        b=afk5RPuAMgBdlRUfVyg8dirKf/VQhbUizEhSKSaaJeygsvsbtPSszs6m4MphfwfnHd706BX0zANb3KkRIyv/N1ksvMLB/hoBPpPwhzQOCPaTCCZvrEKeCiYEaHiQAtGRZhXJCSN/LTLpkSlzcLUi5qoruaw92SWRhfutWjqmLTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sRXJ7DlQ6fPL7W63dqLr+HBq73roYuIgFn8+5Ym9Om590hkrfVtZVszo0iAvm13yb8GnYsm4NBDFD5MNzZq69YrdJk0Ps1FS+jbqDf+OeEZYB54/qJMMXW8uU932llxtIYOHKgdzrgJwGMd0+jb5fE0iaqW14r/fgzXaoPxRxdk=
Received: by 10.86.49.13 with SMTP id w13mr6159264fgw.1194989342702;
        Tue, 13 Nov 2007 13:29:02 -0800 (PST)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j9sm13880896mue.2007.11.13.13.29.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Nov 2007 13:29:02 -0800 (PST)
Message-ID: <473A169B.1040501@gmail.com>
Date:	Tue, 13 Nov 2007 22:26:51 +0100
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: VDSO on mips (was Re: Cannot unwind through MIPS signal frames with
 ICACHE_REFILLS_WORKAROUND_WAR)
References: <473957B6.3030202@avtrex.com>	 <18233.36645.232058.964652@zebedee.pink>	 <20071113121036.GA6582@linux-mips.org> <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com>
In-Reply-To: <cda58cb80711130514x16356ea3x4069616c9ee3caac@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> 
> I started to add vdso support for MIPS a couple months ago, but
> it's in a very early stage and I unfortunately haven't time to finish
> it. I can send it to you if you want.
> 

Here it is. As I said it far from complete but it might help.

		Franck

--- 8< ---

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 2fd96d9..01d700c 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -6,11 +6,13 @@ extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
-		   time.o topology.o traps.o unaligned.o
+		   time.o topology.o traps.o unaligned.o vdso.o
 
 binfmt_irix-objs	:= irixelf.o irixinv.o irixioctl.o irixsig.o	\
 			   irix5sys.o sysirix.o
 
+obj-$(CONFIG_32BIT)		+= vdso32/
+
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
 
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
new file mode 100644
index 0000000..281b7ce
--- /dev/null
+++ b/arch/mips/kernel/vdso.c
@@ -0,0 +1,52 @@
+#include <linux/init.h>
+
+typedef struct {
+        unsigned long id;
+        unsigned long vdso_base;
+} mm_context_t;
+
+
+static int vdso_enabled __read_mostly = 1;
+
+static int __init vdso_setup(char *s)
+{
+	vdso_enabled = simple_strtol(s, NULL, 0);
+	return 1;
+}
+__setup("vdso=", vdso_setup);
+
+
+int arch_setup_additional_pages(struct linux_binprm *bprm, int exec_stack)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long vdso_pages;
+	unsigned long vdso_base;
+	int rv;
+
+	if (!vdso_enabled)
+		return 0;
+
+	down_write(&mm->mmap_sem);
+
+	rv = get_unmapped_area(NULL, vdso_base, vdso_pages << PAGE_SHIFT, 0, 0);
+	if (IS_ERR_VALUE(rv))
+		goto out;
+	vdso_base = rv;
+
+	rv = install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
+				     VM_READ|VM_EXEC|
+				     VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				     VM_ALWAYSDUMP,
+				     vdso_pagelist);
+	if (rv)
+		goto out;
+out:
+	up_write(&mm->mmap_sem);
+	return rv;
+}
+
+static int __init vdso_init(void)
+{
+        return 0;
+}
+arch_initcall(vdso_init);
diff --git a/arch/mips/kernel/vdso32/.gitignore b/arch/mips/kernel/vdso32/.gitignore
new file mode 100644
index 0000000..e45fba9
--- /dev/null
+++ b/arch/mips/kernel/vdso32/.gitignore
@@ -0,0 +1 @@
+vdso32.lds
diff --git a/arch/mips/kernel/vdso32/Makefile b/arch/mips/kernel/vdso32/Makefile
new file mode 100644
index 0000000..b1ea645
--- /dev/null
+++ b/arch/mips/kernel/vdso32/Makefile
@@ -0,0 +1,35 @@
+# List of files in the vdso
+obj-vdso32 = sigtramp.o
+
+# Build rules
+targets := $(obj-vdso32) vdso32.so
+obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
+
+
+EXTRA_CFLAGS := -shared -s -fno-common -fno-builtin
+EXTRA_CFLAGS += -nostdlib -Wl,-soname=linux-vdso32.so.1
+EXTRA_CFLAGS +=	$(call ld-option, -Wl$(comma)--hash-style=sysv)
+
+EXTRA_AFLAGS := -D__VDSO32__ -s
+
+obj-y += vdso32.o
+extra-y += vdso32.lds
+CPPFLAGS_vdso32.lds += -P -C -U$(ARCH)
+
+# kbuild does not track this dependency due to usage of .incbin
+$(obj)/vdso32.o : $(obj)/vdso32.so
+
+# link rule for the .so file, .lds has to be first
+$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32)
+	$(call if_changed,vdso32ld)
+
+# assembly rules for the .S files
+$(obj-vdso32): %.o: %.S
+	$(call if_changed_dep,vdso32as)
+
+# actual build commands
+quiet_cmd_vdso32ld = VDSO32_LD $@
+      cmd_vdso32ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+quiet_cmd_vdso32as = VDSO32_AS $@
+      cmd_vdso32as = $(CC) $(a_flags) -c -o $@ $<
+
diff --git a/arch/mips/kernel/vdso32/sigtramp.S b/arch/mips/kernel/vdso32/sigtramp.S
new file mode 100644
index 0000000..4f83203
--- /dev/null
+++ b/arch/mips/kernel/vdso32/sigtramp.S
@@ -0,0 +1,13 @@
+#include <asm/asm.h>
+#include <asm/regdef.h>
+#include <asm/unistd.h>
+
+LEAF(__kernel_sigtramp_32)
+	li	v0, __NR_sigreturn
+	syscall
+END(__kernel_sigtramp_32)
+
+LEAF(__kernel_sigtramp_rt32)
+	li	v0, __NR_rt_sigreturn
+	syscall
+END(__kernel_sigtramp_rt32)
diff --git a/arch/mips/kernel/vdso32/vdso32.S b/arch/mips/kernel/vdso32/vdso32.S
new file mode 100644
index 0000000..9548930
--- /dev/null
+++ b/arch/mips/kernel/vdso32/vdso32.S
@@ -0,0 +1,11 @@
+#include <linux/init.h>
+
+__INITDATA
+
+	.globl vdso32_start
+	.globl vdso32_end
+vdso32_start:
+	.incbin "arch/mips/kernel/vdso32/vdso32.so"
+vdso32_end:
+
+__FINIT
diff --git a/arch/mips/kernel/vdso32/vdso32.lds.S b/arch/mips/kernel/vdso32/vdso32.lds.S
new file mode 100644
index 0000000..250a03d
--- /dev/null
+++ b/arch/mips/kernel/vdso32/vdso32.lds.S
@@ -0,0 +1,73 @@
+/*
+ * Linker script for vsyscall DSO.  The vsyscall page is an ELF shared
+ * object prelinked to its virtual address, and with only one read-only
+ * segment (that fits in one page).  This script controls its layout.
+ */
+#include <asm/asm-offsets.h>
+
+/* Default link addresses for the vDSOs */
+#define VDSO32_LBASE	0x100000
+#define VDSO64_LBASE	0x100000
+
+/* Default map addresses */
+#define VDSO32_MBASE	VDSO32_LBASE
+#define VDSO64_MBASE	VDSO64_LBASE
+
+OUTPUT_ARCH(mips)
+ENTRY(__kernel_sigtramp_32);
+
+SECTIONS
+{
+  . = VDSO32_LBASE + SIZEOF_HEADERS;
+
+  .hash           : { *(.hash) }		:text
+  .gnu.hash       : { *(.gnu.hash) }
+  .dynsym         : { *(.dynsym) }
+  .dynstr         : { *(.dynstr) }
+  .gnu.version    : { *(.gnu.version) }
+  .gnu.version_d  : { *(.gnu.version_d) }
+  .gnu.version_r  : { *(.gnu.version_r) }
+
+  . = ALIGN(16);
+
+  .text           : { *(.text) }		:text
+  .note           : { *(.note.*) }		:text :note
+  .eh_frame_hdr   : { *(.eh_frame_hdr) }	:text :eh_frame_hdr
+  .eh_frame       : { KEEP (*(.eh_frame)) }	:text
+
+  .dynamic        : { *(.dynamic) }		:text :dynamic
+  .got            : { *(.got) }
+  .plt            : { *(.plt) }
+
+  /DISCARD/       : {
+	*(.got.plt) *(.got)
+	*(.data .data.* .gnu.linkonce.d.*)
+	*(.dynbss)
+	*(.bss .bss.* .gnu.linkonce.b.*)
+  }						:text
+}
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+  text PT_LOAD FILEHDR PHDRS FLAGS(5);	/* PF_R|PF_X */
+  dynamic PT_DYNAMIC FLAGS(4);		/* PF_R */
+  note PT_NOTE FLAGS(4);		/* PF_R */
+  eh_frame_hdr 0x6474e550; /* PT_GNU_EH_FRAME, but ld doesn't match the name */
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+  LINUX_2.6.24 {
+    global:
+	__kernel_sigtramp_32;
+	__kernel_sigtramp_rt32;
+    local: *;
+  };
+}
