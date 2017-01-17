Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:20:45 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.134]:65305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992227AbdAQPUcGONAd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:20:32 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LmT7D-1d2ZJC2P91-00aGVS; Tue, 17 Jan 2017 16:19:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] MIPS: fix modversions
Date:   Tue, 17 Jan 2017 16:18:35 +0100
Message-Id: <20170117151911.4109452-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:+jYMRGu76kg18nG66AdfIp4B5NFOX48eVcEPTspO80kkUKJCyTg
 lsOSOhLacL8ISlN1b5bp1/JTMt05dtK9VkWc7qe0SzeV/avNIX0XzUY7tsHkkbfF6bQjVno
 eh4fuEFhodFvsMEiDPjSxeICGgwrMjjJGy2qxRHRNVy20Dko5siKFETOjGpoAzLc4ClEypb
 gpZB4H+VK3OyI+fkCA5jw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mNRjf7xVJqA=:R3XUZylvfZ881Dvql1QNpD
 p3ibPXJ0hjV/6zuNEv63YVchwbe7t7+X4T01VZR7pn5jtlrv57TYZME8fgJXorNLQBz1qrcyq
 e+Kac3Lza9CejGg3lwSRasMLbMGxHNEsFLYxMf680Er6hqifpbdi+JxGVIqin0pZsZMn/YYHt
 pINjNvKndOrryDGAKEQHOKEe6ikw0VBHCSzJspiwd5xPSjSzBSIuwG5PibhFHEH5lNrHYQX9e
 Wf1gwUJy9UXPBvG6f+X0aIFLvTlCEhkr2coKZjhyRlieTY7X2fiGq7M8gHUqtli/r90hMIRwg
 BBhE2VXw3Y/iH3j+RIWpLQ57IHb9TFPbTn7fq4DS7gx8bJhGiNg3LsuMNUqoeZVnSDys1eIZ3
 dpihukTYI1WquqesamtGzNbmIFC9y5AZ5+ToBGr1Wt12SI13MC7ujZQZUv73KSA/tvzxeTTW/
 gCtNuG5PzutWAi29eqx7Fap/bWgatf4vEx3nPlhpusnI/C1JTL00rCdplZmREV7bYaA/bli2X
 unUA8GWnBLo1Te1kR1sxvHep67gT5qy4j8Aj78DMzlJvB0u1JXXIYvhA5sg5F81robqtUQHxJ
 ZbcUE9V1kgybY/bve8F+QQS7F7Mz1xdpzK75HJtW7otM5sPRXMmtquK1Yi8IDI5Eq21gd4NZg
 V8VNMwj62KGz8anuxti+GyLZDvvlCb985/UyH9b431carmNtx7D1C3P7mozUAHx6ljzE=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

kernelci.org reports tons of build warnings for linux-next:

35	WARNING: "memcpy" [fs/fat/msdos.ko] has no CRC!
35	WARNING: "__copy_user" [fs/fat/fat.ko] has no CRC!
32	WARNING: EXPORT symbol "memset" [vmlinux] version generation failed, symbol will not be versioned.
32	WARNING: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.
32	WARNING: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.
32	WARNING: EXPORT symbol "__strncpy_from_user_nocheck_asm" [vmlinux] version generation failed, symbol will not be versioned.

The problem here is mainly the missing asm/asm-prototypes.h header file
that is supposed to include the prototypes for each symbol that is exported
from an assembler file.

A second problem is that the asm/uaccess.h header contains some but not
all the necessary declarations for the user access helpers.

Finally, the vdso build is broken once we add asm/asm-prototypes.h, so
we have to fix this at the same time by changing the vdso header. My
approach here is to just not look for exported symbols in the VDSO
assembler files, as the symbols cannot be exported anyway.

Fixes: 576a2f0c5c6d ("MIPS: Export memcpy & memset functions alongside their definitions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/uaccess.h | 18 ++++++++++++++++++
 arch/mips/lib/strlen_user.S     |  4 +++-
 arch/mips/lib/strncpy_user.S    | 10 ++++++----
 arch/mips/lib/strnlen_user.S    |  8 ++++++--
 arch/mips/vdso/Makefile         |  7 +++++--
 5 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 89fa5c0b1579..5347cfe15af2 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -1241,6 +1241,9 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__cu_len;							\
 })
 
+extern __kernel_size_t __bzero_kernel(void __user *addr, __kernel_size_t size);
+extern __kernel_size_t __bzero(void __user *addr, __kernel_size_t size);
+
 /*
  * __clear_user: - Zero a block of memory in user space, with less checking.
  * @to:	  Destination address, in user space.
@@ -1293,6 +1296,9 @@ __clear_user(void __user *addr, __kernel_size_t size)
 	__cl_size;							\
 })
 
+extern long __strncpy_from_kernel_nocheck_asm(char *__to, const char __user *__from, long __len);
+extern long __strncpy_from_user_nocheck_asm(char *__to, const char __user *__from, long __len);
+
 /*
  * __strncpy_from_user: - Copy a NUL terminated string from userspace, with less checking.
  * @dst:   Destination address, in kernel space.  This buffer must be at
@@ -1344,6 +1350,9 @@ __strncpy_from_user(char *__to, const char __user *__from, long __len)
 	return res;
 }
 
+extern long __strncpy_from_kernel_asm(char *__to, const char __user *__from, long __len);
+extern long __strncpy_from_user_asm(char *__to, const char __user *__from, long __len);
+
 /*
  * strncpy_from_user: - Copy a NUL terminated string from userspace.
  * @dst:   Destination address, in kernel space.  This buffer must be at
@@ -1393,6 +1402,9 @@ strncpy_from_user(char *__to, const char __user *__from, long __len)
 	return res;
 }
 
+extern long __strlen_kernel_asm(const char __user *s);
+extern long __strlen_user_asm(const char __user *s);
+
 /*
  * strlen_user: - Get the size of a string in user space.
  * @str: The string to measure.
@@ -1434,6 +1446,9 @@ static inline long strlen_user(const char __user *s)
 	return res;
 }
 
+extern long __strnlen_kernel_nocheck_asm(const char __user *s, long n);
+extern long __strnlen_user_nocheck_asm(const char __user *s, long n);
+
 /* Returns: 0 if bad, string length+1 (memory size) of string if ok */
 static inline long __strnlen_user(const char __user *s, long n)
 {
@@ -1463,6 +1478,9 @@ static inline long __strnlen_user(const char __user *s, long n)
 	return res;
 }
 
+extern long __strnlen_kernel_asm(const char __user *s, long n);
+extern long __strnlen_user_asm(const char __user *s, long n);
+
 /*
  * strnlen_user: - Get the size of a string in user space.
  * @str: The string to measure.
diff --git a/arch/mips/lib/strlen_user.S b/arch/mips/lib/strlen_user.S
index c9cb7e6c59a6..40be22625bc5 100644
--- a/arch/mips/lib/strlen_user.S
+++ b/arch/mips/lib/strlen_user.S
@@ -25,7 +25,6 @@
  */
 	.macro __BUILD_STRLEN_ASM func
 LEAF(__strlen_\func\()_asm)
-EXPORT_SYMBOL(__strlen_\func\()_asm)
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a0
 	bnez		v0, .Lfault\@
@@ -50,9 +49,11 @@ EXPORT_SYMBOL(__strlen_\func\()_asm)
 	/* Set aliases */
 	.global __strlen_user_asm
 	.set __strlen_user_asm, __strlen_kernel_asm
+EXPORT_SYMBOL(__strlen_user_asm)
 #endif
 
 __BUILD_STRLEN_ASM kernel
+EXPORT_SYMBOL(__strlen_kernel_asm)
 
 #ifdef CONFIG_EVA
 
@@ -60,4 +61,5 @@ __BUILD_STRLEN_ASM kernel
 	.set eva
 __BUILD_STRLEN_ASM user
 	.set pop
+EXPORT_SYMBOL(__strlen_user_asm)
 #endif
diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index af745b1d04e3..5267ca800b84 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -31,13 +31,11 @@
 
 	.macro __BUILD_STRNCPY_ASM func
 LEAF(__strncpy_from_\func\()_asm)
-EXPORT_SYMBOL(__strncpy_from_\func\()_asm)
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a1
 	bnez		v0, .Lfault\@
 
 FEXPORT(__strncpy_from_\func\()_nocheck_asm)
-EXPORT_SYMBOL(__strncpy_from_\func\()_nocheck_asm)
 	move		t0, zero
 	move		v1, a1
 .ifeqs "\func","kernel"
@@ -75,15 +73,19 @@ EXPORT_SYMBOL(__strncpy_from_\func\()_nocheck_asm)
 	.global __strncpy_from_user_nocheck_asm
 	.set __strncpy_from_user_asm, __strncpy_from_kernel_asm
 	.set __strncpy_from_user_nocheck_asm, __strncpy_from_kernel_nocheck_asm
-	EXPORT_SYMBOL(__strncpy_from_user_asm)
-	EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm)
+EXPORT_SYMBOL(__strncpy_from_user_asm)
+EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm)
 #endif
 
 __BUILD_STRNCPY_ASM kernel
+EXPORT_SYMBOL(__strncpy_from_kernel_asm)
+EXPORT_SYMBOL(__strncpy_from_kernel_nocheck_asm)
 
 #ifdef CONFIG_EVA
 	.set push
 	.set eva
 __BUILD_STRNCPY_ASM user
 	.set pop
+EXPORT_SYMBOL(__strncpy_from_user_asm)
+EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm)
 #endif
diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
index 3ac38162d7f0..860ea99fd70c 100644
--- a/arch/mips/lib/strnlen_user.S
+++ b/arch/mips/lib/strnlen_user.S
@@ -28,13 +28,11 @@
  */
 	.macro __BUILD_STRNLEN_ASM func
 LEAF(__strnlen_\func\()_asm)
-EXPORT_SYMBOL(__strnlen_\func\()_asm)
 	LONG_L		v0, TI_ADDR_LIMIT($28)	# pointer ok?
 	and		v0, a0
 	bnez		v0, .Lfault\@
 
 FEXPORT(__strnlen_\func\()_nocheck_asm)
-EXPORT_SYMBOL(__strnlen_\func\()_nocheck_asm)
 	move		v0, a0
 	PTR_ADDU	a1, a0			# stop pointer
 1:
@@ -73,9 +71,13 @@ EXPORT_SYMBOL(__strnlen_\func\()_nocheck_asm)
 	.global __strnlen_user_nocheck_asm
 	.set __strnlen_user_asm, __strnlen_kernel_asm
 	.set __strnlen_user_nocheck_asm, __strnlen_kernel_nocheck_asm
+EXPORT_SYMBOL(__strnlen_user_asm)
+EXPORT_SYMBOL(__strnlen_user_nocheck_asm)
 #endif
 
 __BUILD_STRNLEN_ASM kernel
+EXPORT_SYMBOL(__strnlen_kernel_asm)
+EXPORT_SYMBOL(__strnlen_kernel_nocheck_asm)
 
 #ifdef CONFIG_EVA
 
@@ -83,4 +85,6 @@ __BUILD_STRNLEN_ASM kernel
 	.set eva
 __BUILD_STRNLEN_ASM user
 	.set pop
+EXPORT_SYMBOL(__strnlen_user_asm)
+EXPORT_SYMBOL(__strnlen_user_nocheck_asm)
 #endif
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index c3dc12a8b7d9..4f42bd213538 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -50,6 +50,9 @@ quiet_cmd_vdsold = VDSO    $@
       cmd_vdsold = $(CC) $(c_flags) $(VDSO_LDFLAGS) \
                    -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
 
+quiet_cmd_vdsoas_o_S = AS       $@
+      cmd_vdsoas_o_S = $(CC) $(a_flags) -c -o $@ $<
+
 # Strip rule for the raw .so files
 $(obj)/%.so.raw: OBJCOPYFLAGS := -S
 $(obj)/%.so.raw: $(obj)/%.so.dbg.raw FORCE
@@ -110,7 +113,7 @@ $(obj-vdso-o32): KBUILD_CFLAGS := $(cflags-vdso) -mabi=32
 $(obj-vdso-o32): KBUILD_AFLAGS := $(aflags-vdso) -mabi=32
 
 $(obj)/%-o32.o: $(src)/%.S FORCE
-	$(call if_changed_dep,as_o_S)
+	$(call if_changed_dep,vdsoas_o_S)
 
 $(obj)/%-o32.o: $(src)/%.c FORCE
 	$(call cmd,force_checksrc)
@@ -150,7 +153,7 @@ $(obj-vdso-n32): KBUILD_CFLAGS := $(cflags-vdso) -mabi=n32
 $(obj-vdso-n32): KBUILD_AFLAGS := $(aflags-vdso) -mabi=n32
 
 $(obj)/%-n32.o: $(src)/%.S FORCE
-	$(call if_changed_dep,as_o_S)
+	$(call if_changed_dep,vdsoas_o_S)
 
 $(obj)/%-n32.o: $(src)/%.c FORCE
 	$(call cmd,force_checksrc)
-- 
2.9.0
