Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 May 2004 14:54:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:31451 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225777AbUEINyc>; Sun, 9 May 2004 14:54:32 +0100
Received: from localhost (p7141-ipad202funabasi.chiba.ocn.ne.jp [222.146.78.141])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3F7606165; Sun,  9 May 2004 22:54:29 +0900 (JST)
Date: Sun, 09 May 2004 22:56:37 +0900 (JST)
Message-Id: <20040509.225637.92590265.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: geert@linux-m68k.org, jsun@mvista.com, linux-mips@linux-mips.org
Subject: Re: semaphore woes in 2.6, 32bit
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040509125750.GA19225@linux-mips.org>
References: <20040508224806.A24682@mvista.com>
	<Pine.GSO.4.58.0405091108150.26985@waterleaf.sonytel.be>
	<20040509125750.GA19225@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 9 May 2004 14:57:50 +0200, Ralf Baechle <ralf@linux-mips.org> said:

ralf> We got tripped by a change in 2.6.6-rc2.  Before that change the
ralf> kmalloc slab caches were being created with SLAB_HWCACHE_ALIGN
ralf> which results in L1_CACHE_SHIFT alignment for allocations of
ralf> L1_CACHE_SHIFT for slab caches that are at least that size.  For
ralf> the sake of S390 this behaviour was changed; new it defaults to
ralf> BYTES_PER_WORD alignment which is four bytes.

ralf> Fixed by defining ARCH_KMALLOC_MINALIGN as 8.

Hmm, many drivers use kmalloc and pci_map_single for DMA buffer.  So
ARCH_KMALLOC_MINALIGN should be L1_CACHE_BYTES for non-coherent
system?

---
Atsushi Nemoto
