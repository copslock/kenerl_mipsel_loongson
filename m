Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 19:39:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54560 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992232AbcJGRjmGIyXb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 19:39:42 +0200
Date:   Fri, 7 Oct 2016 18:39:42 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     James Hogan <james.hogan@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
In-Reply-To: <57F7C229.9040608@gmail.com>
Message-ID: <alpine.LFD.2.20.1610071830080.1794@eddie.linux-mips.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com> <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com> <20160921130852.GA10899@linux-mips.org>
 <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com> <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org> <20161005155653.GG15578@jhogan-linux.le.imgtec.org> <alpine.LFD.2.20.1610061709400.1794@eddie.linux-mips.org> <57F7C0D5.6000007@gmail.com>
 <57F7C229.9040608@gmail.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55372
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

On Fri, 7 Oct 2016, David Daney wrote:

> > >   Indeed, but we need to be prepared to handle the width of 64 bits and
> > > `cpu_has_mips64r6' does not seem to me to be the right condition.
> >
> > It is not the proper condition.
> >
> > The presence of a 64-bit EBase should be probed for.
> >
> > The proper check is to test of the EBase[WG] (bit 11) can be set to 1.
> > It it can, this indicates that EBase supports 64-bit accesses.

 Indeed; the problem however is it is destructive, because:

1. Until you have probed for it you cannot use 64-bit DMFC0 to record the 
   old value of EBase.

2. By using 32-bit MFC0 to record it you miss the upper 32 bits of EBase.

3. And you do need to use 32-bit MTC0 to set WG with this probing, which 
   clobbers the upper 32 bits of EBase.

So from MIPSr3 through to MIPSr5 you cannot really use the setting left 
there in EBase by the firmware unless it has also left the WG bit set.

> In r5 systems, the only time 64-bit Ebase is really interesting is for
> virtualization.
> 
> You could also gate probing WG on the presence of the VZ capability.

 Still this is an approximation only, the architecture permits 64-bit 
EBase without VZ.

  Maciej
