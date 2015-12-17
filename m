Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 01:41:45 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:35896 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014078AbbLQAlDYyFPE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 01:41:03 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1a9McS-0006mb-HT; Thu, 17 Dec 2015 00:40:32 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1a9McQ-0001Jz-9K; Wed, 16 Dec 2015 16:40:30 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Kees Cook <keescook@chromium.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michal Marek <mmarek@suse.cz>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        James Hogan <james.hogan@imgtec.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Shawn Guo <shawn.guo@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 03/78] stackprotector: Introduce CONFIG_CC_STACKPROTECTOR_STRONG
Date:   Wed, 16 Dec 2015 16:38:47 -0800
Message-Id: <1450312802-4938-4-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1450312802-4938-1-git-send-email-kamal@canonical.com>
References: <1450312802-4938-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.13.11-ckt32 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 8779657d29c0ebcc0c94ede4df2f497baf1b563f upstream.

This changes the stack protector config option into a choice of
"None", "Regular", and "Strong":

   CONFIG_CC_STACKPROTECTOR_NONE
   CONFIG_CC_STACKPROTECTOR_REGULAR
   CONFIG_CC_STACKPROTECTOR_STRONG

"Regular" means the old CONFIG_CC_STACKPROTECTOR=y option.

"Strong" is a new mode introduced by this patch. With "Strong" the
kernel is built with -fstack-protector-strong (available in
gcc 4.9 and later). This option increases the coverage of the stack
protector without the heavy performance hit of -fstack-protector-all.

For reference, the stack protector options available in gcc are:

-fstack-protector-all:
  Adds the stack-canary saving prefix and stack-canary checking
  suffix to _all_ function entry and exit. Results in substantial
  use of stack space for saving the canary for deep stack users
  (e.g. historically xfs), and measurable (though shockingly still
  low) performance hit due to all the saving/checking. Really not
  suitable for sane systems, and was entirely removed as an option
  from the kernel many years ago.

-fstack-protector:
  Adds the canary save/check to functions that define an 8
  (--param=ssp-buffer-size=N, N=8 by default) or more byte local
  char array. Traditionally, stack overflows happened with
  string-based manipulations, so this was a way to find those
  functions. Very few total functions actually get the canary; no
  measurable performance or size overhead.

-fstack-protector-strong
  Adds the canary for a wider set of functions, since it's not
  just those with strings that have ultimately been vulnerable to
  stack-busting. With this superset, more functions end up with a
  canary, but it still remains small compared to all functions
  with only a small change in performance. Based on the original
  design document, a function gets the canary when it contains any
  of:

    - local variable's address used as part of the right hand side
      of an assignment or function argument
    - local variable is an array (or union containing an array),
      regardless of array type or length
    - uses register local variables

  https://docs.google.com/a/google.com/document/d/1xXBH6rRZue4f296vGt9YQcuLVQHeE516stHwt8M9xyU

Find below a comparison of "size" and "objdump" output when built with
gcc-4.9 in three configurations:

  - defconfig
	11430641 kernel text size
	36110 function bodies

  - defconfig + CONFIG_CC_STACKPROTECTOR_REGULAR
	11468490 kernel text size (+0.33%)
	1015 of 36110 functions are stack-protected (2.81%)

  - defconfig + CONFIG_CC_STACKPROTECTOR_STRONG via this patch
	11692790 kernel text size (+2.24%)
	7401 of 36110 functions are stack-protected (20.5%)

With -strong, ARM's compressed boot code now triggers stack
protection, so a static guard was added. Since this is only used
during decompression and was never used before, the exposure
here is very small. Once it switches to the full kernel, the
stack guard is back to normal.

Chrome OS has been using -fstack-protector-strong for its kernel
builds for the last 8 months with no problems.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/1387481759-14535-3-git-send-email-keescook@chromium.org
[ Improved the changelog and descriptions some more. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[ kamal: 3.13-stable: need these arch/arm/boot/compressed/misc.c __stack_chk
  canary functions, even for just the old CONFIG_CC_STACKPROTECTOR ]
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 Makefile                        |  8 ++++++-
 arch/Kconfig                    | 51 ++++++++++++++++++++++++++++++++++++++---
 arch/arm/boot/compressed/misc.c | 14 +++++++++++
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 58a799e..b43786f 100644
--- a/Makefile
+++ b/Makefile
@@ -598,12 +598,18 @@ KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
 endif
 
 # Handle stack protector mode.
-ifdef CONFIG_CC_STACKPROTECTOR
+ifdef CONFIG_CC_STACKPROTECTOR_REGULAR
   stackp-flag := -fstack-protector
   ifeq ($(call cc-option, $(stackp-flag)),)
     $(warning Cannot use CONFIG_CC_STACKPROTECTOR: \
 	      -fstack-protector not supported by compiler))
   endif
+else ifdef CONFIG_CC_STACKPROTECTOR_STRONG
+  stackp-flag := -fstack-protector-strong
+  ifeq ($(call cc-option, $(stackp-flag)),)
+    $(warning Cannot use CONFIG_CC_STACKPROTECTOR_STRONG: \
+	      -fstack-protector-strong not supported by compiler)
+  endif
 else
   # Force off for distro compilers that enable stack protector by default.
   stackp-flag := $(call cc-option, -fno-stack-protector)
diff --git a/arch/Kconfig b/arch/Kconfig
index 24e026d..80bbb8c 100644
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
@@ -355,8 +362,46 @@ config CC_STACKPROTECTOR
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
-	  gcc with the feature backported.
+	  gcc with the feature backported ("-fstack-protector").
+
+	  On an x86 "defconfig" build, this feature adds canary checks to
+	  about 3% of all kernel functions, which increases kernel code size
+	  by about 0.3%.
+
+config CC_STACKPROTECTOR_STRONG
+	bool "Strong"
+	select CC_STACKPROTECTOR
+	help
+	  Functions will have the stack-protector canary logic added in any
+	  of the following conditions:
+
+	  - local variable's address used as part of the right hand side of an
+	    assignment or function argument
+	  - local variable is an array (or union containing an array),
+	    regardless of array type or length
+	  - uses register local variables
+
+	  This feature requires gcc version 4.9 or above, or a distribution
+	  gcc with the feature backported ("-fstack-protector-strong").
+
+	  On an x86 "defconfig" build, this feature adds canary checks to
+	  about 20% of all kernel functions, which increases the kernel code
+	  size by about 2%.
+
+endchoice
 
 config HAVE_CONTEXT_TRACKING
 	bool
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 31bd43b..d4f891f 100644
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
1.9.1
