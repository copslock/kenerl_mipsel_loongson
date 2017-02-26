Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Feb 2017 02:02:10 +0100 (CET)
Received: from vmicros1.altlinux.org ([194.107.17.57]:37752 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993009AbdBZBCDb7bOY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 Feb 2017 02:02:03 +0100
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2D50072EF79;
        Sun, 26 Feb 2017 04:01:57 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 015847CCC18; Sun, 26 Feb 2017 04:01:56 +0300 (MSK)
Date:   Sun, 26 Feb 2017 04:01:56 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: fix asm/signal.h userspace compilation errors
Message-ID: <20170226010156.GA28831@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <ldv@altlinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ldv@altlinux.org
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

Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix asm/signal.h
userspace compilation errors like this:

/usr/include/asm/signal.h:126:2: error: unknown type name 'size_t'
  size_t ss_size;

As no uapi header provides a definition of size_t, inclusion
of <stddef.h> seems to be the most conservative fix available.

On the kernel side size_t is typedef'ed to __kernel_size_t, so
an alternative fix would be to change the type of sigaltstack.ss_size
from size_t to __kernel_size_t for all architectures except those where
sizeof(size_t) < sizeof(__kernel_size_t), namely, x32 and mips n32.

On x32 and mips n32, however, #include <stddef.h> seems to be the most
straightforward way to obtain the definition for sigaltstack.ss_size's
type.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 include/uapi/asm-generic/signal.h      | 3 +++
 arch/alpha/include/uapi/asm/signal.h   | 3 +++
 arch/arm/include/uapi/asm/signal.h     | 3 +++
 arch/avr32/include/uapi/asm/signal.h   | 3 +++
 arch/cris/include/uapi/asm/signal.h    | 3 +++
 arch/h8300/include/uapi/asm/signal.h   | 3 +++
 arch/ia64/include/uapi/asm/signal.h    | 4 ++++
 arch/m32r/include/uapi/asm/signal.h    | 3 +++
 arch/m68k/include/uapi/asm/signal.h    | 3 +++
 arch/mips/include/uapi/asm/signal.h    | 3 +++
 arch/mn10300/include/uapi/asm/signal.h | 3 +++
 arch/parisc/include/uapi/asm/signal.h  | 4 ++++
 arch/powerpc/include/uapi/asm/signal.h | 3 +++
 arch/s390/include/uapi/asm/signal.h    | 3 +++
 arch/sparc/include/uapi/asm/signal.h   | 3 +++
 arch/x86/include/uapi/asm/signal.h     | 3 +++
 arch/xtensa/include/uapi/asm/signal.h  | 2 ++
 17 files changed, 52 insertions(+)

diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 3094618..e618eab 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -100,6 +100,9 @@ typedef unsigned long old_sigset_t;
 #endif
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 struct sigaction {
 	__sighandler_t sa_handler;
 	unsigned long sa_flags;
diff --git a/arch/alpha/include/uapi/asm/signal.h b/arch/alpha/include/uapi/asm/signal.h
index dd4ca4bc..74e09f6 100644
--- a/arch/alpha/include/uapi/asm/signal.h
+++ b/arch/alpha/include/uapi/asm/signal.h
@@ -94,6 +94,9 @@ typedef unsigned long sigset_t;
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
index 33073bd..a7b0012 100644
--- a/arch/arm/include/uapi/asm/signal.h
+++ b/arch/arm/include/uapi/asm/signal.h
@@ -93,6 +93,9 @@ typedef unsigned long sigset_t;
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
diff --git a/arch/avr32/include/uapi/asm/signal.h b/arch/avr32/include/uapi/asm/signal.h
index ffe8c77..62f3b88 100644
--- a/arch/avr32/include/uapi/asm/signal.h
+++ b/arch/avr32/include/uapi/asm/signal.h
@@ -95,6 +95,9 @@ typedef unsigned long sigset_t;
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
diff --git a/arch/cris/include/uapi/asm/signal.h b/arch/cris/include/uapi/asm/signal.h
index ce42fa7..bedff78 100644
--- a/arch/cris/include/uapi/asm/signal.h
+++ b/arch/cris/include/uapi/asm/signal.h
@@ -89,6 +89,9 @@ typedef unsigned long sigset_t;
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
index af3a6c3..361e2e5 100644
--- a/arch/h8300/include/uapi/asm/signal.h
+++ b/arch/h8300/include/uapi/asm/signal.h
@@ -88,6 +88,9 @@ typedef unsigned long sigset_t;
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
index c0ea285..b089bfc 100644
--- a/arch/ia64/include/uapi/asm/signal.h
+++ b/arch/ia64/include/uapi/asm/signal.h
@@ -107,6 +107,10 @@
 
 #  include <linux/types.h>
 
+#  ifndef __KERNEL__
+#   include <stddef.h>	/* For size_t. */
+#  endif
+
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
diff --git a/arch/m32r/include/uapi/asm/signal.h b/arch/m32r/include/uapi/asm/signal.h
index 54acacb..269ec39 100644
--- a/arch/m32r/include/uapi/asm/signal.h
+++ b/arch/m32r/include/uapi/asm/signal.h
@@ -90,6 +90,9 @@ typedef unsigned long sigset_t;
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
diff --git a/arch/m68k/include/uapi/asm/signal.h b/arch/m68k/include/uapi/asm/signal.h
index cba6f85..f6a409e 100644
--- a/arch/m68k/include/uapi/asm/signal.h
+++ b/arch/m68k/include/uapi/asm/signal.h
@@ -86,6 +86,9 @@ typedef unsigned long sigset_t;
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
index addb9f5..744fd71 100644
--- a/arch/mips/include/uapi/asm/signal.h
+++ b/arch/mips/include/uapi/asm/signal.h
@@ -101,6 +101,9 @@ typedef unsigned long old_sigset_t;		/* at least 32 bits */
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 struct sigaction {
 	unsigned int	sa_flags;
 	__sighandler_t	sa_handler;
diff --git a/arch/mn10300/include/uapi/asm/signal.h b/arch/mn10300/include/uapi/asm/signal.h
index f423a08..2e79c71 100644
--- a/arch/mn10300/include/uapi/asm/signal.h
+++ b/arch/mn10300/include/uapi/asm/signal.h
@@ -98,6 +98,9 @@ typedef unsigned long sigset_t;
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index e26043b..6c6c979 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -81,6 +81,10 @@
 
 #  include <linux/types.h>
 
+#  ifndef __KERNEL__
+#   include <stddef.h>	/* For size_t. */
+#  endif
+
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
diff --git a/arch/powerpc/include/uapi/asm/signal.h b/arch/powerpc/include/uapi/asm/signal.h
index 6c69ee9..fba7738 100644
--- a/arch/powerpc/include/uapi/asm/signal.h
+++ b/arch/powerpc/include/uapi/asm/signal.h
@@ -91,6 +91,9 @@ typedef struct {
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 struct old_sigaction {
 	__sighandler_t sa_handler;
 	old_sigset_t sa_mask;
diff --git a/arch/s390/include/uapi/asm/signal.h b/arch/s390/include/uapi/asm/signal.h
index 2f43cfb..306373b6a 100644
--- a/arch/s390/include/uapi/asm/signal.h
+++ b/arch/s390/include/uapi/asm/signal.h
@@ -96,6 +96,9 @@ typedef unsigned long sigset_t;
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
index f387400..3b4664c 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -154,6 +154,9 @@ struct sigstack {
 #include <asm-generic/signal-defs.h>
 
 #ifndef __KERNEL__
+
+#include <stddef.h>	/* For size_t. */
+
 struct __new_sigaction {
 	__sighandler_t		sa_handler;
 	unsigned long		sa_flags;
diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
index 8264f47..2d6db1d 100644
--- a/arch/x86/include/uapi/asm/signal.h
+++ b/arch/x86/include/uapi/asm/signal.h
@@ -96,6 +96,9 @@ typedef unsigned long sigset_t;
 
 
 # ifndef __KERNEL__
+
+#  include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 #ifdef __i386__
 
diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
index 586756e..bbc9b14 100644
--- a/arch/xtensa/include/uapi/asm/signal.h
+++ b/arch/xtensa/include/uapi/asm/signal.h
@@ -106,6 +106,8 @@ typedef struct {
 
 #ifndef __KERNEL__
 
+#include <stddef.h>	/* For size_t. */
+
 /* Here we must cater to libcs that poke about in kernel headers.  */
 
 struct sigaction {
-- 
ldv
