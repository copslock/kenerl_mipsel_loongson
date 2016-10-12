Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Oct 2016 18:30:19 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:52210 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992571AbcJLQaKI2EEZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Oct 2016 18:30:10 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id C1319F0B7205D;
        Wed, 12 Oct 2016 17:29:59 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 12 Oct 2016
 17:30:03 +0100
Received: from [10.20.78.104] (10.20.78.104) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 12 Oct 2016
 17:30:02 +0100
Date:   Wed, 12 Oct 2016 17:29:53 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Bhushan Attarde <bhushan.attarde@imgtec.com>,
        <gdb-patches@sourceware.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Andrew Bennett <Andrew.Bennett@imgtec.com>,
        Jaydeep Patil <Jaydeep.Patil@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 02/24]     Add MIPS32 FPU64 GDB target descriptions
In-Reply-To: <20161012135803.GT19354@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1610121701180.31859@tp.orcam.me.uk>
References: <1467038991-6600-1-git-send-email-bhushan.attarde@imgtec.com> <1467038991-6600-2-git-send-email-bhushan.attarde@imgtec.com> <alpine.DEB.2.00.1607221827040.4076@tp.orcam.me.uk> <20161012135803.GT19354@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.104]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Hi James,

 Thanks for your input!

 Cc-ing linux-mips for the discussion about a ptrace(2) kernel API update; 
anyone interested in previous talk about this change please have a look 
at: <https://sourceware.org/ml/gdb-patches/2016-06/msg00441.html> and 
<https://sourceware.org/ml/gdb-patches/2016-10/msg00311.html> for the 
earlier messages.

> >  Hmm, has Linux kernel support for CP0.Config5 accesses gone upstream 
> > already?  Can you give me an upstream commit ID and/or reference to the 
> > discussion where it has been approved if so?
> 
> I don't think it did go upstream yet.

 Good!

> >  More importantly, what do we need CP0.Config5 access for in the first 
> > place?  It looks to me like this bit is irrelevant to GDB as it does not 
> > affect the native (raw) register format.  So the only use would be to let 
> > the user running a debugging session switch between the FRE and NFRE modes 
> > without the need to poke at CP1C.FRE or CP1C.NFRE registers with a CTC1 
> > instruction, which by itself makes sense to me, but needs a further 
> > consideration.
> 
> It allows the FRE bit to be read (I seem to remember this was the only
> bit actually exposed through ptrace by the patch).

 Then I think it makes sense even more not to create this artificial API 
and use the CP1C.FRE/CP1C.NFRE registers instead which do correspond to 
what hardware presents to user software.  Also with CP1C.UFR/CP1C.UNFR vs 
CP0.Status; while we want to retain the latter register in the view for 
historical reasons, it has always been read-only and I think it ought to 
remain such, with any writes to CP0.Status.FR executed via the former CP1C 
registers only.

> FRE simply causes certain instructions (all single precision FP
> arithmetic instructions and FP word loads/stores) to trap to the kernel
> so that it can emulate a variation/subset of FR=0, so the debugger would
> use it to decide how to decode the single precision FP registers based
> on the double precision FP registers (iirc).

 I don't think there is any value in it for GDB, I think all 64-bit FP 
registers ought to remain being presented as doubles and pairs of singles 
regardless of the mode selected (and also possibly fixed-point longs and 
pairs of fixed-point words).  We don't know what's emulated and what's not 
after all, and then the contents of FPRs are not interpreted by GDB itself 
anyhow except in user-supplied expressions or assignment requests, which 
for users' convenience I think should retain the maximum flexibility 
possible.

 So as I say it looks to me like the only, though obviously valid and 
wholeheartedly supported, use for CP1C.FRE/CP1C.NFRE would be for user's 
control of the execution environment.

> >  Additionally exposing CP0.Config5 may have security implications, 
> > especially as parts of the register have not been defined yet in the 
> > architectures and we'd have to force architecture maintainers somehow to 
> > ask us every time they intend to add a bit to this register to check if 
> > this has security implications and has to be avoided and/or explicitly 
> > handled in software.
> 
> yes, as above it explicity only shows certain bits. I'm fine with the
> api changing if necessary though since it isn't upstream.

 It sounds like a plan to me then -- any further questions or comments 
about the kernel API part, anyone?

  Maciej
