Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 15:50:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18667 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993963AbdINNuZWGk5x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Sep 2017 15:50:25 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id EB4C7B7A14D8B;
        Thu, 14 Sep 2017 14:50:14 +0100 (IST)
Received: from [10.20.78.36] (10.20.78.36) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 14 Sep 2017
 14:50:17 +0100
Date:   Thu, 14 Sep 2017 14:50:07 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20170911151737.GA2265@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
References: <20170911151737.GA2265@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.36]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59995
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

Hi Fredrik,

> This sounds like a good plan. I did have a few comments and questions on the
> rest of the code in
> 
> https://www.linux-mips.org/archives/linux-mips/2017-08/msg00570.html

 I'll go through and try to address those questions one by one separately.

> Can this be improved? CONFIG_R5900_128BIT_SUPPORT is configurable but the 32
> bit programs I've tested become unstable unless it's set, so something isn't
> quite working without it (which may or may not be related to the registers,
> since CONFIG_R5900_128BIT_SUPPORT activates some other changes as well).

 For the initial R5900 support I think there are two options here, 
depending on what hardware supports:

1. If (for binary compatibility reasons) 128-bit GPR support can somehow 
   be disabled in hardware, by flipping a CP0 register bit or suchlike, 
   then I suggest doing that in the first stage.

2. Otherwise I think that the context initialisation/switch code has to be 
   adjusted such that the upper GPR halves are set to a known state, 
   either zeroed or sign-extended from bit #63 (or #31 really, given the 
   initial 32-bit port only) according to hardware requirements, so as to
   make execution stable and prevent data from leaking between contexts.

Later on proper 128-bit support can be added, though for that to make 
sense you need to have compiler support too, which AFAICT is currently 
missing.  Myself I'd rather defer commenting on that further support until 
we get to it, although of course someone else might be willing to sketch 
an idea.

> At what stage in the patch series would it be appropriate to introduce
> support for quadword registers, and in what form?

 Well, I think we need to stabilise base 32-bit and then 64-bit support 
first.  So that'll be a separate patch or patch set to consider at that 
point.

> The rest of the notes comment on the new SYNC.P instruction, MFC0/MTC0,
> short loop crashes in the memcpy/strlen family of functions, etc. Several of
> these changes and workarounds are required for a stable system and would
> need to be introduced in some form.

 The exception handler workarounds should be easy to implement as we 
generate machine code for them at run-time, so inserting a pair of NOPs 
should be straightforward while not affecting any other target.  As a 
solution addressing a grave hardware erratum this obviously has to be 
included with your initial patch set, as a separate change because it's 
self-contained.

 Any other workarounds are handled via <asm/war.h>.  Those which are 
needed for correct initial 32-bit operation need to go with the initial 
patch set as well, one change per issue.

 If SYNC acts as a hazard barrier for MFC0/MTC0, etc., then it can be 
substituted for EHB/JR.HB where applicable.  We have infrastructure for 
that in <asm/hazards.h> already, so you just need to hook in.  You may 
have to expand that header of course if in the R5900 there are hazards not 
already covered by EHB/JR.HB for other processors.  These will need to go 
with the initial patch set too.

 And last but not least I suggest to structure your initial patch set such 
that the commit containing Kconfig changes to enable R5900/PS2 comes last, 
so that once that last patch goes in you can build a kernel that boots and 
correctly works on actual hardware.

  Maciej
