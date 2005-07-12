Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 23:04:29 +0100 (BST)
Received: from pasta.sw.starentnetworks.com ([IPv6:::ffff:12.33.234.10]:54411
	"EHLO pasta.sw.starentnetworks.com") by linux-mips.org with ESMTP
	id <S8226651AbVGLWEN>; Tue, 12 Jul 2005 23:04:13 +0100
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP id 8462F14B6C0
	for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 18:05:09 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17108.16021.215526.97259@cortez.sw.starentnetworks.com>
Date:	Tue, 12 Jul 2005 18:05:09 -0400
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	linux-mips@linux-mips.org
Subject: elf_core_dump() from binfmt_elfo32.c trashes heap
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips


64bit kernel, o32 userspace.

The call to elf_core_copy_regs() from elf_core_dump() is writing
beyond the end of prstatus because the wrong copy function is being
called:

slab error in cache_free_debugcheck(): cache `size-256': double free, or memory outside object was overwritten
Call Trace:
 [<ffffffff8016f77c>] __slab_error+0x2c/0x38
 [<ffffffff80171c50>] cache_free_debugcheck+0x290/0x318
 [<ffffffff80171c1c>] cache_free_debugcheck+0x25c/0x318
 [<ffffffff80172d80>] kfree+0x98/0x168
 [<ffffffff80172ce8>] kfree+0x0/0x168
 [<ffffffff8011a250>] elf_core_dump+0x508/0xb58
 [<ffffffff8019b394>] do_coredump+0x234/0x260
 [<ffffffff80144a28>] __dequeue_signal+0x0/0x2c0
 [<ffffffff80147118>] get_signal_to_deliver+0x210/0x390
 [<ffffffff80116d10>] do_signal32+0x80/0x288
 [<ffffffff80145f80>] kill_something_info+0x48/0x128
 [<ffffffff8011727c>] sys32_rt_sigprocmask+0xfc/0x1c0
 [<ffffffff80106ed4>] do_notify_resume+0x3c/0x48
 [<ffffffff801039cc>] work_notifysig+0xc/0x14
 [<ffffffff8011a9c0>] handle_sys+0x120/0x13c

a80000013ff0b2b8: redzone 1: 0x170fc2a5, redzone 2: 0x7a120.

redzone 2 has been overwritten.

--

Running binfmt_elfo32.c through the pre-processor reveals that
elf_core_copy_regs() is calling dump_regs() instead of
elf32_core_copy_regs().


In arch/mips/kernel/binfmt_elfo32.c:

#undef ELF_CORE_COPY_REGS
#define ELF_CORE_COPY_REGS(_dest,_regs) elf32_core_copy_regs(_dest,_regs);

Those 2 have no effect because elf_core_copy_regs() has already been
defined inline by including 'linux/elfcore.h' at the top of
binfmt_elfo32.c.

Changing elf32_core_copy_regs to a static also reveals the problem:

  CC      arch/mips/kernel/binfmt_elfo32.o
arch/mips/kernel/binfmt_elfo32.c:116: warning: `elf32_core_copy_regs' defined but not used


--

There's probably 10 different ways to fix this by re-ordering
#includes/#defines in arch/mips/kernel/binfmt_elfo32.c.

--

I found a reference to this in the mailing list from Jan/Feb 2005, but
the proposed patch didn't seem to get applied.

Suggestions on the best way to fix this?  Was that patch no good?


-- 
Dave Johnson
Starent Networks
