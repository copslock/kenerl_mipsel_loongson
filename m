Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Feb 2003 22:01:28 +0000 (GMT)
Received: from smtp-102.nerim.net ([IPv6:::ffff:62.4.16.102]:28427 "EHLO
	kraid.nerim.net") by linux-mips.org with ESMTP id <S8225199AbTBPWB1>;
	Sun, 16 Feb 2003 22:01:27 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by kraid.nerim.net (Postfix) with ESMTP id D095140E2A
	for <linux-mips@linux-mips.org>; Sun, 16 Feb 2003 23:01:23 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18kWqi-00067b-00
	for <linux-mips@linux-mips.org>; Sun, 16 Feb 2003 23:01:24 +0100
Date: Sun, 16 Feb 2003 23:01:24 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: linux-mips@linux-mips.org
Subject: IDT RC5000 ll/lld bug on 64-bit address?
Message-ID: <Pine.LNX.4.21.0302162221580.23174-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

Hi,

	I think I'm facing an hardware bug with the IDT RV5000 CPU of the
SGI O2 (prid = 0x2321), and would like to know if someone else has faced
it or knows about it. When executing a load linked on a 64-bit address
(XKPHYS cache mode 3 in tested case), it seems the data is loaded directly
in secondary cache/system memory instead of the D-cache. Executing a
standard load operation on the same address loads the correct data, i.e.
lld %0, 0(%1) ; load the old content at address %1 in %0
ld %0, 0(%1)  ; load the correct content at address %1 in %0 
If I execute a writeback on the cache line before accessing it with the
ll/lld instruction, the data read is correct. ll/lld work correctly on
KSEG0 addresses though (in cache mode 3 too). I've also checked ll/lld
work correcly on the O2 R10000.

I'm actually hitting the bug while booting the kernel, in free_bootmem_core
(linux-2.5.47, mm/bootmem.c:125). test_and_clear_bit  
(include/asm-mips64/bitops.h:220) returns false, meaning the bit was
already cleared whereas it is not. All bdata->node_bootmem_map is
initialized to 0xff in init_bootmem_core (mm/bootmem.c:63), but the lld in
test_and_clear bit loads a 0 instead.

The processor errata (http://www.idt.com/docs/RC5000_ER_99398.pdf) only
speak of a bug with LLaddr being loaded with the virtual address instead
of the physical one, which doesn't seem related to my problem.

Sounds familiar to someone?

Vivien.
