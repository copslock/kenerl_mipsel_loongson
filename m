Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 14:26:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:13545 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225562AbUEJN0l>; Mon, 10 May 2004 14:26:41 +0100
Received: from localhost (p4173-ipad29funabasi.chiba.ocn.ne.jp [221.184.71.173])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BAFA266D6; Mon, 10 May 2004 22:26:34 +0900 (JST)
Date: Mon, 10 May 2004 22:28:45 +0900 (JST)
Message-Id: <20040510.222845.78701815.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org
Cc: geert@linux-m68k.org, jsun@mvista.com, linux-mips@linux-mips.org
Subject: Re: semaphore woes in 2.6, 32bit
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20040509164835.GA28011@linux-mips.org>
References: <20040509125750.GA19225@linux-mips.org>
	<20040509.225637.92590265.anemo@mba.ocn.ne.jp>
	<20040509164835.GA28011@linux-mips.org>
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
X-archive-position: 4957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 9 May 2004 18:48:35 +0200, Ralf Baechle <ralf@linux-mips.org> said:
>> Hmm, many drivers use kmalloc and pci_map_single for DMA buffer.
>> So ARCH_KMALLOC_MINALIGN should be L1_CACHE_BYTES for non-coherent
>> system?

ralf> No, those drivers are simply broken.  dma_get_cache_alignment()
ralf> gives the mimimum alignment and width for DMA mappings and that
ralf> value is larger than kmalloc alignment in almost all cases.

I see.  Thank you for pointing out it.  I must learn 2.6 DMA API
quickly ...

---
Atsushi Nemoto
