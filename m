Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 19:34:30 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:58384 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLFSeWeEX5G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2017 19:34:22 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 06 Dec 2017 18:33:16 +0000
Received: from [10.20.78.27] (10.20.78.27) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Wed, 6 Dec 2017 10:33:07 -0800
Date:   Wed, 6 Dec 2017 18:32:56 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Dave Martin <Dave.Martin@arm.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4/5] MIPS: Execute any partial write of the last register
 with PTRACE_SETREGSET
In-Reply-To: <20171201123525.GS22781@e103592.cambridge.arm.com>
Message-ID: <alpine.DEB.2.00.1712011912120.31156@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1711290152040.31156@tp.orcam.me.uk> <alpine.DEB.2.00.1711291226320.31156@tp.orcam.me.uk> <20171130172839.GQ22781@e103592.cambridge.arm.com> <alpine.DEB.2.00.1711301831540.31156@tp.orcam.me.uk>
 <20171201123525.GS22781@e103592.cambridge.arm.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1512585195-298554-32343-12141-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187686
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Fri, 1 Dec 2017, Dave Martin wrote:

> >  That wasn't actually clarified in the referred commit's description, 
> > which it should in the first place, and I wasn't able to track down any 
> > review of your change as submitted, which would be the potential second 
> > source of such support information.  The description isn't even correct, 
> > as it states that if a short buffer is supplied, then the old values held 
> > in thread's registers are preserved, which clearly isn't correct as 
> > individual registers do get written from the beginning of the regset up to 
> > the point no more data is available to fill a whole register.
> 
> FYI, this this patch wasn't discussed on the public lists because of the
> security implications of kernel stack exposure.  IIRC, James and Ralf
> were Cc'd on the discussion.

 That's security by obscurity, I'm afraid.

 While I do agree publicly discussing an exploitable vulnerability while 
no remedy has been yet made is considered a bad practice, I see no point 
in keeping it hidden once a fix has been developed and published.  
Moreover actually publishing all the details of the vulnerability itself 
(rather than just the fix) is often considered a good way to urge binary 
software distributors to release patched versions.

 So I think a commit description should still be as accurate as usually.

> There's an awkward balance to be struck between giving a full
> description of the change and the motivation for it, and avoiding
> announcing publicly exactly how to exploit the bug.  Opinions differ on
> where the correct balance lies.

 Well, in this situation to exploit this bug you still have to figure out 
how you can use this potential information leak in practice, so having the 
mention of a stack variable being partially initialised in the fix's 
description is IMO hardly a recipe for the potential attacker, while it 
lets the next reader understand what is really going on there.

> So, the commit message was intentionally kept vague, but could have
> been better in this instance, since it doesn't correctly describe the
> change as committed.

 Ack.

  Maciej
