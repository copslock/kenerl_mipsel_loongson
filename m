Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 17:12:23 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:15599 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021852AbXC0QMV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2007 17:12:21 +0100
Received: from localhost (p3060-ipad207funabasi.chiba.ocn.ne.jp [222.145.85.60])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 2B290BA9B
	for <linux-mips@linux-mips.org>; Wed, 28 Mar 2007 01:11:00 +0900 (JST)
Date:	Wed, 28 Mar 2007 01:11:00 +0900 (JST)
Message-Id: <20070328.011100.07456480.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: missimg system calls
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Nice patches to check unwired system calls are available recently:

http://lkml.org/lkml/2007/3/21/358
http://lkml.org/lkml/2007/3/21/360
http://lkml.org/lkml/2007/3/21/361

These patches are already in -mm tree.

I tried it with quick and dirty hack for N32/O32 on 64-bit kernel.
Many of these warnings seem false positive but it might be worth to
look at.

On 32-bit kernel:
  CC      init/missing_syscalls.o
In file included from /work/linux-mips/init/missing_syscalls.c:97:
init/missing_syscalls.h:331:2: warning: #warning syscall select not implemented
init/missing_syscalls.h:763:2: warning: #warning syscall vfork not implemented
init/missing_syscalls.h:1083:2: warning: #warning syscall fadvise64_64 not implemented

On 64-bit kernel:
  CC      init/missing_syscalls.o
In file included from /work/linux-mips/init/missing_syscalls.c:97:
init/missing_syscalls.h:55:2: warning: #warning syscall time not implemented
init/missing_syscalls.h:279:2: warning: #warning syscall ssetmask not implemented
init/missing_syscalls.h:331:2: warning: #warning syscall select not implemented
init/missing_syscalls.h:347:2: warning: #warning syscall uselib not implemented
init/missing_syscalls.h:763:2: warning: #warning syscall vfork not implemented
init/missing_syscalls.h:887:2: warning: #warning syscall getdents64 not implemented
  CC      arch/mips/kernel/missing_syscalls_n32.o
In file included from /work/linux-mips/arch/mips/kernel/missing_syscalls.h:1,
                 from /work/linux-mips/arch/mips/kernel/../../../init/missing_syscalls.c:97,
                 from /work/linux-mips/arch/mips/kernel/missing_syscalls_n32.c:1:
arch/mips/kernel/../../../init/missing_syscalls.h:55:2: warning: #warning syscall time not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:279:2: warning: #warning syscall ssetmask not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:331:2: warning: #warning syscall select not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:347:2: warning: #warning syscall uselib not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:763:2: warning: #warning syscall vfork not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:775:2: warning: #warning syscall truncate64 not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:779:2: warning: #warning syscall ftruncate64 not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:783:2: warning: #warning syscall stat64 not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:787:2: warning: #warning syscall lstat64 not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:791:2: warning: #warning syscall fstat64 not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:887:2: warning: #warning syscall getdents64 not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:1083:2: warning: #warning syscall fadvise64_64 not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:1191:2: warning: #warning syscall fstatat64 not implemented
  CC      arch/mips/kernel/missing_syscalls_o32.o
In file included from /work/linux-mips/arch/mips/kernel/missing_syscalls.h:1,
                 from /work/linux-mips/arch/mips/kernel/../../../init/missing_syscalls.c:97,
                 from /work/linux-mips/arch/mips/kernel/missing_syscalls_o32.c:1:
arch/mips/kernel/../../../init/missing_syscalls.h:331:2: warning: #warning syscall select not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:763:2: warning: #warning syscall vfork not implemented
arch/mips/kernel/../../../init/missing_syscalls.h:1083:2: warning: #warning syscall fadvise64_64 not implemented


And here's my hack.  Advices from kbuild gurus are highly appreciated.

 arch/mips/kernel/Makefile               |   11 +++++++++++
 arch/mips/kernel/missing_syscalls.h     |    1 +
 arch/mips/kernel/missing_syscalls_n32.c |    1 +
 arch/mips/kernel/missing_syscalls_o32.c |    1 +
 4 files changed, 14 insertions(+)

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 4924626..d6abdc5 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -4,6 +4,17 @@
 
 extra-y		:= head.o init_task.o vmlinux.lds
 
+ifdef CONFIG_MIPS32_N32
+missing_syscalls_n32.o: missing_syscalls_n32.c
+CFLAGS_missing_syscalls_n32.o = -mabi=n32
+always += missing_syscalls_n32.o
+endif
+ifdef CONFIG_MIPS32_O32
+missing_syscalls_o32.o: missing_syscalls_o32.c
+CFLAGS_missing_syscalls_o32.o = -mabi=32
+always += missing_syscalls_o32.o
+endif
+
 obj-y		+= cpu-probe.o branch.o entry.o genex.o irq.o process.o \
 		   ptrace.o reset.o semaphore.o setup.o signal.o syscall.o \
 		   time.o topology.o traps.o unaligned.o
diff --git a/arch/mips/kernel/missing_syscalls.h b/arch/mips/kernel/missing_syscalls.h
new file mode 100644
index 0000000..9c4f2e9
--- /dev/null
+++ b/arch/mips/kernel/missing_syscalls.h
@@ -0,0 +1 @@
+#include "../../../init/missing_syscalls.h"
diff --git a/arch/mips/kernel/missing_syscalls_n32.c b/arch/mips/kernel/missing_syscalls_n32.c
new file mode 100644
index 0000000..ce527c6
--- /dev/null
+++ b/arch/mips/kernel/missing_syscalls_n32.c
@@ -0,0 +1 @@
+#include "../../../init/missing_syscalls.c"
diff --git a/arch/mips/kernel/missing_syscalls_o32.c b/arch/mips/kernel/missing_syscalls_o32.c
new file mode 100644
index 0000000..ce527c6
--- /dev/null
+++ b/arch/mips/kernel/missing_syscalls_o32.c
@@ -0,0 +1 @@
+#include "../../../init/missing_syscalls.c"

---
Atsushi Nemoto
