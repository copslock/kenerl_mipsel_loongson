Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 00:39:23 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:39663 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225255AbUAOAjW>;
	Thu, 15 Jan 2004 00:39:22 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0F0dKa16163;
	Wed, 14 Jan 2004 16:39:20 -0800
Date: Wed, 14 Jan 2004 16:39:20 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc: jsun@mvista.com
Subject: [BUG] 2.6.1/MIPS - missing cache flushing when user program returns pages to kernel
Message-ID: <20040114163920.E13471@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I have been chasing a nasty memory corruption bug on my MIPS box with
2.6.1 kernel.  In the end it appears the following sequence has
happened:

1. userland gets a page and writes some stuff to it, which dirties
   data cache.  In my case, it is actually doing a sys_read() into
   that page.  See my kgdb trace attached in the end.

2. userland returns this page to kernel *without* any cache flushing,
   i.e., the dcache is still dirty.

3. kernel calls kmalloc() to get a block from this page.

4. the dirty dcache is written back to physical memory some time later,
   corrupting the kernel data.

It seems to me the problem is that we should do a cache flush 
for all the pages returned to kernel during step 2.

I attached a hack which solves my problem but I am not sure if it is
most appropriate.  It looks like the affected user region (start, end)
can span over multiple vma areas.  If so, the fix will only flush the first
area.

Also, it is hard to find an appropriate place to do the flushing
The new 2.6 mm is a confusing maze to me.  I hope someone more
knowledgable can come up with a more decent fix for this problem.

BTW, it appears in 2.4 we are doing this flushing in do_zap_page_range()
where we call a flush_cache_range(mm, start, end).

Jun

P.S., Here is the stack trace when dirty data is written to user page:

$8 = 0x2aac3000
(gdb) p/x kaddr 
$9 = 0x811a3880 
(gdb) bt
#0  both_aligned () at arch/mips/lib/memcpy.S:222
#1  0xffffffff8014351c in file_read_actor (desc=0x87fd1dd0, page=0x8102c178,
    offset=0, size=2717) at mm/filemap.c:754
#2  0xffffffff80143088 in do_generic_mapping_read (mapping=0x803e3168,
    ra=0x87fe8868, filp=0x87fe8820, ppos=0x87fe8840, desc=0x87fd1dd0, 
    actor=0x80143480 <file_read_actor>) at mm/filemap.c:658
#3  0xffffffff801437a0 in __generic_file_aio_read (iocb=0x80143480,
    iov=0x811a3880, nr_segs=1, ppos=0x87fe8840) at fs.h:1334
#4  0xffffffff80143884 in generic_file_read (filp=0x61697265,
    buf=0xcccccccd <Address 0xcccccccd out of bounds>, count=715927552,
    ppos=0xa9d) at mm/filemap.c:877
#5  0xffffffff80162688 in vfs_read (file=0x87fe8820,
    buf=0x2aac3000 "# /etc/inittab: init(8) configuration.\n# $Id: inittab,v 1.8 1998/05/10 10:37:50 miquels Exp $\n\n# The default runlevel.\nid:3:initdefault:\n\n# Boot-time system configuration/initialization script.\n# This"..., 
    count=4096, pos=0x87fe8840) at fs/read_write.c:213
#6  0xffffffff80162918 in sys_read (fd=715929728, 
    buf=0x2aac3000 "# /etc/inittab: init(8) configuration.\n# $Id: inittab,v 1.8 1998/05/10 10:37:50 miquels Exp $\n\n# The default runlevel.\nid:3:initdefault:\n\n# Boot-time system configuration/initialization script.\n# This"..., 
    count=4096) at fs/read_write.c:278

It appears I lost the stack trace when kernel finds data corruption.  It is somewhere
inside d_splice_alias() where inode->i_dentry, happens to be at 0x811a3880, has
a wrong value instead of the expected 0.


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="missing-cache-flush-on-return-user-page.patch"

diff -Nru linux/mm/mmap.c.orig linux/mm/mmap.c
--- linux/mm/mmap.c.orig	Mon Jan 12 16:31:22 2004
+++ linux/mm/mmap.c	Wed Jan 14 14:22:20 2004
@@ -1134,6 +1134,8 @@
 	struct mmu_gather *tlb;
 	unsigned long nr_accounted = 0;
 
+	flush_cache_range(vma, start, end);
+
 	lru_add_drain();
 	tlb = tlb_gather_mmu(mm, 0);
 	unmap_vmas(&tlb, mm, vma, start, end, &nr_accounted);

--IJpNTDwzlM2Ie8A6--
