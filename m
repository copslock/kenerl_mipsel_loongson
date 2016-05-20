Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 16:17:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60840 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27031701AbcETORIh0-RO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 May 2016 16:17:08 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4KEH6tj004544;
        Fri, 20 May 2016 16:17:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4KEH5Fs004543;
        Fri, 20 May 2016 16:17:05 +0200
Date:   Fri, 20 May 2016 16:17:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>, Paul.Burton@imgtec.com
Subject: [PATCH]: ELF/MIPS build fix
Message-ID: <20160520141705.GA1913@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

CONFIG_MIPS32_N32=y but CONFIG_BINFMT_ELF disabled results in the following
linker errors:

arch/mips/built-in.o: In function `elf_core_dump':
binfmt_elfn32.c:(.text+0x23dbc): undefined reference to `elf_core_extra_phdrs'
binfmt_elfn32.c:(.text+0x246e4): undefined reference to `elf_core_extra_data_size'
binfmt_elfn32.c:(.text+0x248d0): undefined reference to `elf_core_write_extra_phdrs'
binfmt_elfn32.c:(.text+0x24ac4): undefined reference to `elf_core_write_extra_data'

CONFIG_MIPS32_O32=y but CONFIG_BINFMT_ELF disabled results in the following
linker errors:

arch/mips/built-in.o: In function `elf_core_dump':
binfmt_elfo32.c:(.text+0x28a04): undefined reference to `elf_core_extra_phdrs'
binfmt_elfo32.c:(.text+0x29330): undefined reference to `elf_core_extra_data_size'
binfmt_elfo32.c:(.text+0x2951c): undefined reference to `elf_core_write_extra_phdrs'
binfmt_elfo32.c:(.text+0x29710): undefined reference to `elf_core_write_extra_data'

This is because binfmt_elfn32 and binfmt_elfo32 are using symbols
from elfcore but for these configurations elfcore will not be built.

Fixed by making elfcore selectable by a separate config symbol which
unlike the current mechanism can also be used from other directories
than kernel/, then having each flavor of ELF that relies on elfcore.o,
select it in Kconfig, including CONFIG_MIPS32_N32 and CONFIG_MIPS32_O32
which fixes this issue.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/Kconfig | 1 +
 fs/Kconfig.binfmt | 8 ++++++++
 kernel/Makefile   | 4 +---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5663f41..f19e15c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3116,6 +3116,7 @@ config MIPS32_N32
 config BINFMT_ELF32
 	bool
 	default y if MIPS32_O32 || MIPS32_N32
+	select ELFCORE
 
 endmenu
 
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 2d0cbbd..72c0335 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -1,6 +1,7 @@
 config BINFMT_ELF
 	bool "Kernel support for ELF binaries"
 	depends on MMU && (BROKEN || !FRV)
+	select ELFCORE
 	default y
 	---help---
 	  ELF (Executable and Linkable Format) is a format for libraries and
@@ -26,6 +27,7 @@ config BINFMT_ELF
 config COMPAT_BINFMT_ELF
 	bool
 	depends on COMPAT && BINFMT_ELF
+	select ELFCORE
 
 config ARCH_BINFMT_ELF_STATE
 	bool
@@ -34,6 +36,7 @@ config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y
 	depends on (FRV || BLACKFIN || (SUPERH32 && !MMU) || C6X)
+	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
 	  segments of a binary to be located in memory independently of each
@@ -43,6 +46,11 @@ config BINFMT_ELF_FDPIC
 
 	  It is also possible to run FDPIC ELF binaries on MMU linux also.
 
+config ELFCORE
+	bool
+	help
+	  This option enables kernel/elfcore.o.
+
 config CORE_DUMP_DEFAULT_ELF_HEADERS
 	bool "Write ELF core dumps with partial segments"
 	default y
diff --git a/kernel/Makefile b/kernel/Makefile
index f0c40bf..e2ec54e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -91,9 +91,7 @@ obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o tsacct.o
 obj-$(CONFIG_TRACEPOINTS) += tracepoint.o
 obj-$(CONFIG_LATENCYTOP) += latencytop.o
-obj-$(CONFIG_BINFMT_ELF) += elfcore.o
-obj-$(CONFIG_COMPAT_BINFMT_ELF) += elfcore.o
-obj-$(CONFIG_BINFMT_ELF_FDPIC) += elfcore.o
+obj-$(CONFIG_ELFCORE) += elfcore.o
 obj-$(CONFIG_FUNCTION_TRACER) += trace/
 obj-$(CONFIG_TRACING) += trace/
 obj-$(CONFIG_TRACE_CLOCK) += trace/
