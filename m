Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2013 23:44:19 +0100 (CET)
Received: from smtp.outflux.net ([198.145.64.163]:43915 "EHLO smtp.outflux.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824811Ab3LQWoOVWrDK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Dec 2013 23:44:14 +0100
Received: from www.outflux.net (serenity-end.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.14.4/8.14.4/Debian-2ubuntu2.1) with ESMTP id rBHMhKEJ013689;
        Tue, 17 Dec 2013 14:43:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Michal Marek <mmarek@suse.cz>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shawn Guo <shawn.guo@linaro.org>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        keescook@chromium.org
Subject: [PATCH v3 2/2] provide -fstack-protector-strong build option
Date:   Tue, 17 Dec 2013 14:43:14 -0800
Message-Id: <1387320194-24185-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1387320194-24185-1-git-send-email-keescook@chromium.org>
References: <1387320194-24185-1-git-send-email-keescook@chromium.org>
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: www.outflux.net
X-Scanned-By: MIMEDefang 2.71 on 10.2.0.1
Return-Path: <keescook@www.outflux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

This changes the stack protector config option into a choice of "None",
"Regular", and "Strong". For "Strong", the kernel is built with
-fstack-protector-strong (gcc 4.9 and later). This options increases
the coverage of the stack protector without the heavy performance hit
of -fstack-protector-all.

For reference, the stack protector options available in gcc are:

-fstack-protector-all:
Adds the stack-canary saving prefix and stack-canary checking suffix to
_all_ function entry and exit. Results in substantial use of stack space
for saving the canary for deep stack users (e.g. historically xfs), and
measurable (though shockingly still low) performance hit due to all the
saving/checking. Really not suitable for sane systems, and was entirely
removed as an option from the kernel many years ago.

-fstack-protector:
Adds the canary save/check to functions that define an 8
(--param=ssp-buffer-size=N, N=8 by default) or more byte local char
array. Traditionally, stack overflows happened with string-based
manipulations, so this was a way to find those functions. Very few
total functions actually get the canary; no measurable performance or
size overhead.

-fstack-protector-strong
Adds the canary for a wider set of functions, since it's not just those
with strings that have ultimately been vulnerable to stack-busting. With
this superset, more functions end up with a canary, but it still
remains small compared to all functions with no measurable change in
performance. Based on the original design document, a function gets the
canary when it contains any of:
- local variable's address used as part of the RHS of an assignment or
  function argument
- local variable is an array (or union containing an array), regardless
  of array type or length
- uses register local variables
https://docs.google.com/a/google.com/document/d/1xXBH6rRZue4f296vGt9YQcuLVQHeE516stHwt8M9xyU

Comparison of "size" output when built with gcc-4.9 in three configurations:
- defconfig
- defconfig + CONFIG_CC_STACKPROTECTOR (+0.33%)
- defconfig + CONFIG_CC_STACKPROTECTOR_STRONG via this patch (+2.24%)

text      data     bss      dec       hex     filename
11430641  1457584  1191936  14080161  d6d8a1  vmlinux
11468490  1457584  1191936  14118010  d76c7a  vmlinux.stackprotector
11692790  1457584  1191936  14342310  dad8a6  vmlinux.stackprotector-strong

With -strong, ARM's compressed boot code now triggers stack protection,
so a static guard was added. Since this is only used during decompression
and was never used before, the exposure here is very small. Once it
switches to the full kernel, the stack guard is back to normal.

Chrome OS has been using -fstack-protector-strong for its kernel builds
for the last 8 months with no problems.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
 - split off type of stack protection as a distinct config
v2:
 - added description of all stack protector options
 - added size comparisons for Ubuntu and defconfig
---
 Makefile                        |    8 ++++++-
 arch/Kconfig                    |   44 +++++++++++++++++++++++++++++++++++++--
 arch/arm/boot/compressed/misc.c |   14 +++++++++++++
 3 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 27ed3ff7cf4c..9701b690e1ec 100644
--- a/Makefile
+++ b/Makefile
@@ -596,12 +596,18 @@ KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
 endif
 
 # Handle stack protector mode.
-ifdef CONFIG_CC_STACKPROTECTOR
+ifdef CONFIG_CC_STACKPROTECTOR_REGULAR
   stackp-flag := $(call cc-option, -fstack-protector)
   ifeq ($(stackp-flag),)
    $(error Cannot use CONFIG_CC_STACKPROTECTOR: \
 	   -fstack-protector not supported by compiler))
   endif
+else ifdef CONFIG_CC_STACKPROTECTOR_STRONG
+  stackp-flag := $(call cc-option, -fstack-protector-strong)
+  ifeq ($(stackp-flag),)
+   $(error Cannot use CONFIG_CC_STACKPROTECTOR_STRONG: \
+	   -fstack-protector-strong not supported by compiler)
+  endif
 else
   # Force off for distro compilers that enable stack protector by default.
   stackp-flag := $(call cc-option, -fno-stack-protector)
diff --git a/arch/Kconfig b/arch/Kconfig
index 24e026d83072..8dde0a5b76fd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -344,10 +344,17 @@ config HAVE_CC_STACKPROTECTOR
 	  - it has implemented a stack canary (e.g. __stack_chk_guard)
 
 config CC_STACKPROTECTOR
-	bool "Enable -fstack-protector buffer overflow detection"
+	def_bool n
+	help
+	  Set when a stack-protector mode is enabled, so that the build
+	  can enable kernel-side support for the GCC feature.
+
+choice
+	prompt "Stack Protector buffer overflow detection"
 	depends on HAVE_CC_STACKPROTECTOR
+	default CC_STACKPROTECTOR_NONE
 	help
-	  This option turns on the -fstack-protector GCC feature. This
+	  This option turns on the "stack-protector" GCC feature. This
 	  feature puts, at the beginning of functions, a canary value on
 	  the stack just before the return address, and validates
 	  the value just before actually returning.  Stack based buffer
@@ -355,9 +362,42 @@ config CC_STACKPROTECTOR
 	  overwrite the canary, which gets detected and the attack is then
 	  neutralized via a kernel panic.
 
+config CC_STACKPROTECTOR_NONE
+	bool "None"
+	help
+	  Disable "stack-protector" GCC feature.
+
+config CC_STACKPROTECTOR_REGULAR
+	bool "Regular"
+	select CC_STACKPROTECTOR
+	help
+	  Functions will have the stack-protector canary logic added if they
+	  have an 8-byte or larger character array on the stack.
+
 	  This feature requires gcc version 4.2 or above, or a distribution
 	  gcc with the feature backported.
 
+	  On an x86 "defconfig" build, this increases the kernel text by 0.3%.
+
+config CC_STACKPROTECTOR_STRONG
+	bool "Strong"
+	select CC_STACKPROTECTOR
+	help
+	  Functions will have the stack-protector canary logic added in any
+	  of the following conditions:
+	  - local variable's address used as part of the RHS of an
+	    assignment or function argument
+	  - local variable is an array (or union containing an array),
+	    regardless of array type or length
+	  - uses register local variables
+
+	  This feature requires gcc version 4.9 or above, or a distribution
+	  gcc with the feature backported.
+
+	  On an x86 "defconfig" build, this increases the kernel text by 2%.
+
+endchoice
+
 config HAVE_CONTEXT_TRACKING
 	bool
 	help
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 31bd43b82095..d4f891f56996 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -127,6 +127,18 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
+unsigned long __stack_chk_guard;
+
+void __stack_chk_guard_setup(void)
+{
+	__stack_chk_guard = 0x000a0dff;
+}
+
+void __stack_chk_fail(void)
+{
+	error("stack-protector: Kernel stack is corrupted\n");
+}
+
 extern int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
 
 
@@ -137,6 +149,8 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 {
 	int ret;
 
+	__stack_chk_guard_setup();
+
 	output_data		= (unsigned char *)output_start;
 	free_mem_ptr		= free_mem_ptr_p;
 	free_mem_end_ptr	= free_mem_ptr_end_p;
-- 
1.7.9.5
