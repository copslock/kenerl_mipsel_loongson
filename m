Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 16:53:55 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45781 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026918AbXLFQxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Dec 2007 16:53:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB6GrKCn021697;
	Thu, 6 Dec 2007 16:53:21 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB6GrJP3021696;
	Thu, 6 Dec 2007 16:53:19 GMT
Date:	Thu, 6 Dec 2007 16:53:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH] Fix oprofile configuration breakage
Message-ID: <20071206165319.GA21553@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

The cleanup 09cadedbdc01f1a4bea1f427d4fb4642eaa19da9 broke the oprofile
configuration for MIPS by allowing oprofile support to be built for
kernel models where oprofile doesn't have a chance in hell to work.

Just a dependecy list on a number of architectures is - surprise - broken
and should as per past discussions probably in most considered to be
broken in most cases.  So I introduce a dependency for the oprofile
configuration on ARCH_SUPPORTS_OPROFILE.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---

Since we're already in -rc4 I try to keep things minimally intrusive and
use ARCH_SUPPORTS_OPROFILE only for MIPS for now instead of touching a
dozen architectures.

 arch/mips/Kconfig              |    4 ++++
 kernel/Kconfig.instrumentation |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 455bd1f..c6fc405 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -714,6 +714,10 @@ config ARCH_HAS_ILOG2_U64
 	bool
 	default n
 
+config ARCH_SUPPORTS_OPROFILE
+	bool
+	default y if !MIPS_MT_SMTC
+
 config GENERIC_FIND_NEXT_BIT
 	bool
 	default y
diff --git a/kernel/Kconfig.instrumentation b/kernel/Kconfig.instrumentation
index 2ea1e34..12a9f74 100644
--- a/kernel/Kconfig.instrumentation
+++ b/kernel/Kconfig.instrumentation
@@ -21,7 +21,7 @@ config PROFILING
 config OPROFILE
 	tristate "OProfile system profiling (EXPERIMENTAL)"
 	depends on PROFILING
-	depends on (ALPHA || ARM || BLACKFIN || X86_32 || IA64 || M32R || MIPS || PARISC || PPC || S390 || SUPERH || SPARC || X86_64) && !UML
+	depends on (ARCH_SUPPORTS_OPROFILE || ALPHA || ARM || BLACKFIN || X86_32 || IA64 || M32R || PARISC || PPC || S390 || SUPERH || SPARC || X86_64) && !UML
 	help
 	  OProfile is a profiling system capable of profiling the
 	  whole system, include the kernel, kernel modules, libraries,
