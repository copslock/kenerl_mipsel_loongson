Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA10803 for <linux-archive@neteng.engr.sgi.com>; Tue, 20 Oct 1998 18:32:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA53974
	for linux-list;
	Tue, 20 Oct 1998 18:31:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA53650
	for <linux@engr.sgi.com>;
	Tue, 20 Oct 1998 18:31:37 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA09257
	for <linux@engr.sgi.com>; Tue, 20 Oct 1998 18:31:32 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-09.uni-koblenz.de [141.26.249.9])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id DAA27303
	for <linux@engr.sgi.com>; Wed, 21 Oct 1998 03:31:29 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id BAA02181;
	Wed, 21 Oct 1998 01:50:47 +0200
Message-ID: <19981021015047.G1830@uni-koblenz.de>
Date: Wed, 21 Oct 1998 01:50:47 +0200
From: ralf@uni-koblenz.de
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Haifa scheduler bug in egcs 1.0.2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi all,

I've resolved a bug report of Ulf Carlson whose kernel compiles resulted
died with:

gcc -D__KERNEL__ -I/home/ulfc/kernels/sgi-lin/linux/include -Wall \
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic \
-mcpu=r4600 -mips2 -pipe    arch/mips/mm/r6000.c   -o arch/mips/mm/r6000

{standard input}: Assembler messages:
{standard input}:385: Warning: Unmatched %hi reloc
{standard input}:488: Internal error!
Assertion failure in tc_gen_reloc at ./config/tc-mips.c line 10203.
Please report this bug.
make: *** [arch/mips/mm/r6000] Error 1

This is caused by bad assembler code like:

[...]
        lui     $11,%hi(r6000_flush_cache_mm) # high
        lui     $12,%hi(r6000_flush_cache_range) # high
        lui     $17,%hi(r6000_flush_tlb_all) # high
        lui     $2,%hi(r6000_flush_tlb_mm) # high
        lui     $3,%hi(r6000_flush_tlb_range) # high
        lui     $4,%hi(r6000_flush_tlb_page) # high
        lui     $5,%hi(r6000_load_pgd) # high
        lui     $6,%hi(r6000_pgd_init) # high
        lui     $7,%hi(r6000_update_mmu_cache) # high
        lui     $8,%hi(r6000_show_regs) # high
        lui     $9,%hi(r6000_add_wired_entry) # high
        lui     $10,%hi(r6000_user_mode) # high
[...]

Relocating the code generated from this source later on will not be
possible for ld.  As knows this and dies ungracefully.

I was able to track this down to the Haifa scheduler which seems to be
incompatible with the -msplit-addresses used for kernel compiles.  For
now I suggest to recompile egcs without the Haifa scheduler.  Egcs by
default doesn't enable the Haifa scheduler and there is a reason why.

This egcs 1.0.2 bug is a platform independent bug.  Since currently
egcs does not support -msplit-addresses for PIC code, that is all userland
this bug will only hit some low level stuff.

Alex or somebody else, could you make an update to the egcs package
with the haifa scheduler disabled?  Thanks!

  Ralf
