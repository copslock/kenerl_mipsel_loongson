Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 12:47:44 +0200 (CEST)
Received: from [64.238.111.99] ([64.238.111.99]:31756 "EHLO mail.ivivity.com")
	by linux-mips.org with ESMTP id <S1123924AbSJWKro>;
	Wed, 23 Oct 2002 12:47:44 +0200
Received: by ATLOPS with Internet Mail Service (5.5.2653.19)
	id <414L5PWQ>; Wed, 23 Oct 2002 06:47:28 -0400
Message-ID: <AEC4671C8179D61194DE0002B328BDD2070C8C@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: KSeg0 coherency policy selection.
Date: Wed, 23 Oct 2002 06:47:27 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <dinesh_nagpure@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dinesh_nagpure@ivivity.com
Precedence: bulk
X-list: linux-mips

Hello,

I am almost done with my porting of kernel 2.4.16 to our platform using
RM5231A. But I had to make a couple of very basic hacks and I am trying to
understand if there is any way I can avoid them.
First the memcpy wouldn't work for me properly, both the compiler generated
and also the one under arch/mips/lib/memcpy.c, so I had to change the lib
version to do byte copy. I know this is a very crude change but things
worked.
Second, the Kseg0 coherency algorithm selection in the function
ld_mmu_r4xx0( ) seems to be improper for RM5231A, This function sets the CP0
config register K0 field to 3 which as per RM5231A user manual is Cacheable,
noncoherent, write back policy Should this not be set to 0, which is
cacheable, non-coherent, write-through, no write allocate? 
Also from the knowledge base I understand there is a cache aliasing problem
associated with RM5231A when page size is set to 4KB. The document
recommends to invalidate the cache before retiring a virtual page OR
coloring of the pages. Can someone tell me if this fix is already taken care
of? For me when I enable caching under "Kernel hacking" my kernel crashes
with page fault, when it tries to run bin/init, consistently.

Thanks
Dinesh
