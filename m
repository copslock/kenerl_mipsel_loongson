Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2017 01:20:37 +0100 (CET)
Received: from vmicros1.altlinux.org ([194.107.17.57]:50028 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbdCBAU2dhjz3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Mar 2017 01:20:28 +0100
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E95BA72EF79;
        Thu,  2 Mar 2017 03:20:22 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D82B27CCE22; Thu,  2 Mar 2017 03:20:22 +0300 (MSK)
Date:   Thu, 2 Mar 2017 03:20:22 +0300
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
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-cris-kernel@axis.com, uclinux-h8-devel@lists.sourceforge.jp,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] uapi: fix asm/signal.h userspace compilation errors
Message-ID: <20170302002022.GB27097@altlinux.org>
References: <20170226010156.GA28831@altlinux.org> <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0YX3RGAqWN0mwUJtBsqUX0C+QRtJLrT_UA=wX6Z+q0DA@mail.gmail.com>
Return-Path: <ldv@altlinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56954
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

Replace size_t with __kernel_size_t to fix asm/signal.h userspace
compilation errors like this:

/usr/include/asm-generic/signal.h:116:2: error: unknown type name 'size_t'
  size_t ss_size;

This change is not applicable to x86 port because x32 is the only
architecture where sizeof(size_t) < sizeof(__kernel_size_t).

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
v2: create a separate patch for x86,
    replace size_t with __kernel_size_t instead of including <stddef.h>.

 include/uapi/asm-generic/signal.h      | 2 +-
 arch/alpha/include/uapi/asm/signal.h   | 2 +-
 arch/arm/include/uapi/asm/signal.h     | 2 +-
 arch/avr32/include/uapi/asm/signal.h   | 2 +-
 arch/cris/include/uapi/asm/signal.h    | 2 +-
 arch/h8300/include/uapi/asm/signal.h   | 2 +-
 arch/ia64/include/uapi/asm/signal.h    | 2 +-
 arch/m32r/include/uapi/asm/signal.h    | 2 +-
 arch/m68k/include/uapi/asm/signal.h    | 2 +-
 arch/mips/include/uapi/asm/signal.h    | 2 +-
 arch/mn10300/include/uapi/asm/signal.h | 2 +-
 arch/parisc/include/uapi/asm/signal.h  | 2 +-
 arch/powerpc/include/uapi/asm/signal.h | 2 +-
 arch/s390/include/uapi/asm/signal.h    | 2 +-
 arch/sparc/include/uapi/asm/signal.h   | 2 +-
 arch/xtensa/include/uapi/asm/signal.h  | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 3094618..6bbcdfa 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -113,7 +113,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/alpha/include/uapi/asm/signal.h b/arch/alpha/include/uapi/asm/signal.h
index dd4ca4bc..16a2217 100644
--- a/arch/alpha/include/uapi/asm/signal.h
+++ b/arch/alpha/include/uapi/asm/signal.h
@@ -113,7 +113,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 /* sigstack(2) is deprecated, and will be withdrawn in a future version
diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
index 33073bd..859f2de 100644
--- a/arch/arm/include/uapi/asm/signal.h
+++ b/arch/arm/include/uapi/asm/signal.h
@@ -113,7 +113,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/avr32/include/uapi/asm/signal.h b/arch/avr32/include/uapi/asm/signal.h
index ffe8c77..46af348 100644
--- a/arch/avr32/include/uapi/asm/signal.h
+++ b/arch/avr32/include/uapi/asm/signal.h
@@ -115,7 +115,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* _UAPI__ASM_AVR32_SIGNAL_H */
diff --git a/arch/cris/include/uapi/asm/signal.h b/arch/cris/include/uapi/asm/signal.h
index ce42fa7..02149d2 100644
--- a/arch/cris/include/uapi/asm/signal.h
+++ b/arch/cris/include/uapi/asm/signal.h
@@ -109,7 +109,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
index af3a6c3..0b1825d 100644
--- a/arch/h8300/include/uapi/asm/signal.h
+++ b/arch/h8300/include/uapi/asm/signal.h
@@ -108,7 +108,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
index c0ea285..04604da 100644
--- a/arch/ia64/include/uapi/asm/signal.h
+++ b/arch/ia64/include/uapi/asm/signal.h
@@ -113,7 +113,7 @@ struct siginfo;
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/m32r/include/uapi/asm/signal.h b/arch/m32r/include/uapi/asm/signal.h
index 54acacb..a7f5c0b 100644
--- a/arch/m32r/include/uapi/asm/signal.h
+++ b/arch/m32r/include/uapi/asm/signal.h
@@ -110,7 +110,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/m68k/include/uapi/asm/signal.h b/arch/m68k/include/uapi/asm/signal.h
index cba6f85..387fddc 100644
--- a/arch/m68k/include/uapi/asm/signal.h
+++ b/arch/m68k/include/uapi/asm/signal.h
@@ -106,7 +106,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* _UAPI_M68K_SIGNAL_H */
diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
index addb9f5..6ec6885 100644
--- a/arch/mips/include/uapi/asm/signal.h
+++ b/arch/mips/include/uapi/asm/signal.h
@@ -111,7 +111,7 @@ struct sigaction {
 /* IRIX compatible stack_t  */
 typedef struct sigaltstack {
 	void __user *ss_sp;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 	int ss_flags;
 } stack_t;
 
diff --git a/arch/mn10300/include/uapi/asm/signal.h b/arch/mn10300/include/uapi/asm/signal.h
index f423a08..c17d363 100644
--- a/arch/mn10300/include/uapi/asm/signal.h
+++ b/arch/mn10300/include/uapi/asm/signal.h
@@ -118,7 +118,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user	*ss_sp;
 	int		ss_flags;
-	size_t		ss_size;
+	__kernel_size_t		ss_size;
 } stack_t;
 
 
diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index e26043b..403e2d8 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -99,7 +99,7 @@ typedef __signalfn_t __user *__sighandler_t;
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* !__ASSEMBLY */
diff --git a/arch/powerpc/include/uapi/asm/signal.h b/arch/powerpc/include/uapi/asm/signal.h
index 6c69ee9..c1c2a0b 100644
--- a/arch/powerpc/include/uapi/asm/signal.h
+++ b/arch/powerpc/include/uapi/asm/signal.h
@@ -109,7 +109,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/s390/include/uapi/asm/signal.h b/arch/s390/include/uapi/asm/signal.h
index 2f43cfb..b8c2db6 100644
--- a/arch/s390/include/uapi/asm/signal.h
+++ b/arch/s390/include/uapi/asm/signal.h
@@ -122,7 +122,7 @@ struct sigaction {
 typedef struct sigaltstack {
         void __user *ss_sp;
         int ss_flags;
-        size_t ss_size;
+        __kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
index f387400..cd6c036 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -172,7 +172,7 @@ struct __old_sigaction {
 typedef struct sigaltstack {
 	void			__user *ss_sp;
 	int			ss_flags;
-	size_t			ss_size;
+	__kernel_size_t			ss_size;
 } stack_t;
 
 
diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
index 586756e..d835627 100644
--- a/arch/xtensa/include/uapi/asm/signal.h
+++ b/arch/xtensa/include/uapi/asm/signal.h
@@ -126,7 +126,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif	/* __ASSEMBLY__ */
-- 
ldv
