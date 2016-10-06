Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 00:41:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39586 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992227AbcJFWlk5uATm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 00:41:40 +0200
Date:   Thu, 6 Oct 2016 23:41:40 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
In-Reply-To: <20161006201943.GI19354@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.LFD.2.20.1610062335410.1794@eddie.linux-mips.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com> <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com> <20160921130852.GA10899@linux-mips.org>
 <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com> <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org> <20161005155653.GG15578@jhogan-linux.le.imgtec.org> <alpine.LFD.2.20.1610061709400.1794@eddie.linux-mips.org> <20161006180525.GG19354@jhogan-linux.le.imgtec.org>
 <alpine.LFD.2.20.1610062054500.1794@eddie.linux-mips.org> <20161006201943.GI19354@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Thu, 6 Oct 2016, James Hogan wrote:

> >  How can we install a handler then when we don't know what the upper 32 
> > bits of EBase are?
> 
> Right now its assumed the default upper 32 bits are sign extension of
> bit 31 in that case (i.e. thats what upper 32bits are clobbered to). I
> think the only case where that might not be true would be where WG is
> implemented and the bootloader has changed them to e.g. somewhere in
> XKPhys, and then cleared WG. We could catch that most of the time by
> detecting changed bits 31:30 (as I think you suggested before), but it
> still isn't watertight (e.g. xkphys+0x80000000), so if in doubt we
> should probably be sure to allocate our own exception vector instead of
> guessing at the boot one. What a mess :-(.

 Does it really matter in reality though?

 By keeping EBase unchanged we try to install exception handlers in memory 
assigned by the firmware.  This may not necessarily be safe.  I think we 
actually ought to set EBase ourselves, perhaps on a CPU by CPU basis in an 
MP system, pointing to memory we know we can use at will.  If this is 
going to consume say a page of memory per CPU, then still I don't think 
it's a huge waste, and any firmware memory safe to reclaim after boostrap 
we can use for other purposes.

 Have I missed anything?

  Maciej
