Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Sep 2017 20:00:40 +0200 (CEST)
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:60238 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993916AbdILSAbV0y2d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Sep 2017 20:00:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 6CE6F3F482;
        Tue, 12 Sep 2017 20:00:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y9J4C0dyt7Tt; Tue, 12 Sep 2017 20:00:20 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D41B53F430;
        Tue, 12 Sep 2017 20:00:07 +0200 (CEST)
Date:   Tue, 12 Sep 2017 19:59:27 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add basic R5900 support
Message-ID: <20170912175826.GA2526@localhost.localdomain>
References: <20170827132309.GA32166@localhost.localdomain>
 <alpine.DEB.2.00.1708271511430.17596@tp.orcam.me.uk>
 <20170902102830.GA2602@localhost.localdomain>
 <alpine.DEB.2.00.1709091022180.4331@tp.orcam.me.uk>
 <alpine.DEB.2.00.1709110610290.5244@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709110610290.5244@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

> >  Can you please try flipping the bits instead then, e.g.:
> > 
> > 	uint32_t fcsr0, fcsr1;
> > 	asm volatile (" cfc1 %0,$31\n"
> > 		      " lui  %1,0xfffc\n"
> 
>  Actually can you please substitute:
> 
> 		      " li   %1,0xfffc0003\n"
> 
> here, so that we know how RM behaves?

Sure. I get "FCSR old: 01000001, new: 01800001" with the R5900.

>  Again, it is odd to see it set to 1 (towards zero) by default and if it 
> is hardwired, then `->fpu_csr31' and `->fpu_msk31' will have to be 
> updated, AT_FPUCW exported and glibc adjusted.

Right. Quite a few details to resolve for the FPU then. Here is the
disassembly to double-check the compiled code:

004001c0 <main>:
  4001c0:	3c1c0043 	lui	gp,0x43
  4001c4:	27bdffe0 	addiu	sp,sp,-32
  4001c8:	279c9470 	addiu	gp,gp,-27536
  4001cc:	afbf001c 	sw	ra,28(sp)
  4001d0:	afbc0010 	sw	gp,16(sp)
  4001d4:	4445f800 	cfc1	a1,$31
  4001d8:	3c06fffc 	lui	a2,0xfffc
  4001dc:	34c60003 	ori	a2,a2,0x3
  4001e0:	00c53026 	xor	a2,a2,a1
  4001e4:	44c6f800 	ctc1	a2,$31
  4001e8:	00000000 	nop
  4001ec:	4446f800 	cfc1	a2,$31
  4001f0:	44c5f800 	ctc1	a1,$31
  4001f4:	8f9980f4 	lw	t9,-32524(gp)
  4001f8:	3c040041 	lui	a0,0x41
  4001fc:	04110094 	bal	400450 <__GI_printf>
  400200:	2484f720 	addiu	a0,a0,-2272
  400204:	8fbf001c 	lw	ra,28(sp)
  400208:	00001021 	move	v0,zero
  40020c:	03e00008 	jr	ra
  400210:	27bd0020 	addiu	sp,sp,32

Fredrik
