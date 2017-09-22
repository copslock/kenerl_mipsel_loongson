Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Sep 2017 18:38:17 +0200 (CEST)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:57892 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbdIVQiJx80n7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Sep 2017 18:38:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id DAE413F4EB;
        Fri, 22 Sep 2017 18:38:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id on2IdTuc2yKE; Fri, 22 Sep 2017 18:38:01 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 6607B3F2FD;
        Fri, 22 Sep 2017 18:37:55 +0200 (CEST)
Date:   Fri, 22 Sep 2017 18:37:54 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20170922163753.GA2415@localhost.localdomain>
References: <20170911151737.GA2265@localhost.localdomain>
 <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170920140715.GA9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60114
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

>  The operation is only defined for bits 63:0 AFAICS.  IIUC bits 127:64 
> remain unchanged (which is why I think that at the initial stage of R5900 
> support they have to be explicitly set to a fixed value on a context 
> switch, to prevent leaking information), but I have no means to verify it.
> 
>  In the interim to fix the value of bits 127:64 while keeping disruption 
> to existing code at the minimum you could AFAICT use a sequence like:
> 
> 	pcpyld	$1, $0, $1
> 	pcpyld	$2, $0, $2
> #	...
> 	pcpyld	$31, $0, $31
> 
> in RESTORE_SOME, preferably via an auxiliary macro.  Once we have switched 
> to saving/restoring full 128-bit registers, possibly with SQ/LQ, we can 
> remove this temporary measure.

Sounds reasonable!

>  This would verify whether the original contents of $17 were a properly 
> sign-extended 32-bit value.  Although for predictable operation I would 
> advise to use:
> 
> 	sll	k1, $17, 0
> 	sw	k1, PT_R17(sp)
> 	lw	k1, PT_R17(sp)
> 	tne	k1, $17, 12
> 
> or simply:
> 
> 	sll	k1, $17, 0
> 	tne	k1, $17, 12
> 	sw	$17, PT_R17(sp)

There is a slight complication: the trap appears to be taken before the
console is ready, hence nothing is displayed. Is there a practical way
to postpone or recover from a trap? The issue becomes somewhat involved
since the trap needs to save/restore registers for itself to recover,
and so might evoke boundless recursion.

From a practical point of view it would be great if backtraces could be
rate limited, recoverable and possible to copy over network (I don't have
e.g. a serial port soldered). I will look into other alternatives to try
to capture this.

> Previously you wrote that the problem is with resetting the upper 96 bits 
> (how did you notice that BTW?) rather than bits 63:32 only, so you need a 
> different check.

I suspect 63:32 are the critical bits of the upper 96 bits since SD/LD
is sufficient. Summery of observations thus far: save/restore works with
SQ/LQ and SD/LD, but not SW/LW, in a 32-bit kernel ceteris paribus.

> Also I see no reason why LW would set bits 63:32 to anything different
> from what was there before SW as long as the original value was 32-bit
> (hence the second check sequence proposed).

Yes, SLL seems sufficient for testing this.

> > A question is whether registers are clobbered within the kernel itself
> > (via interrupts or some such) or for user programs.
> 
>  Well, you do need to verify your patches for such a possibility, right.  
> I would advise double-checking exception handling indeed, including 
> run-time generated exception handler code in particular.

The extremely early trap indicates a kernel issue, or perhaps register
garbage during kernel initialisation, that wouldn't be an error? Is the
run-time code related to genex.S? The R5900 patch sprinkles NOP and
SYNC.P instructions on it, for various workarounds, but not much else
apart from reverting db8466c581c "MIPS: IRQ Stack: Unwind IRQ stack onto
task stack" that otherwise crashes for an unknown reason.

Fredrik
