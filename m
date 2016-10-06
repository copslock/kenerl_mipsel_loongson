Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2016 21:56:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33504 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992181AbcJFT4uqRe01 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Oct 2016 21:56:50 +0200
Date:   Thu, 6 Oct 2016 20:56:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/9] MIPS: traps: 64bit kernels should read CP0_EBase
 64bit
In-Reply-To: <20161006180525.GG19354@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.LFD.2.20.1610062054500.1794@eddie.linux-mips.org>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com> <e826225b15736539cd96a1b6b2a99e2bb2b4eb87.1472747205.git-series.james.hogan@imgtec.com> <20160921130852.GA10899@linux-mips.org>
 <73eede89-af68-eb17-b0b3-2537084da819@imgtec.com> <alpine.LFD.2.20.1610021038190.25303@eddie.linux-mips.org> <20161005155653.GG15578@jhogan-linux.le.imgtec.org> <alpine.LFD.2.20.1610061709400.1794@eddie.linux-mips.org>
 <20161006180525.GG19354@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55358
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

> >  ISTR a while ago we had a rather lengthy discussion as to how to detect 
> > the presence of the upper 32 bits without triggering undefined behaviour 
> > implied by 64-bit CP0 accesses to 32-bit CP0 registers.  As I believe we 
> > set EBase ourselves I think we are able to make the necessary checks and 
> > have an accurate condition here, still remembering however that it may go 
> > back as far as MIPSr3.
> 
> We only set ebase under certain circumstances, otherwise leaving it as
> already set.

 How can we install a handler then when we don't know what the upper 32 
bits of EBase are?

  Maciej
