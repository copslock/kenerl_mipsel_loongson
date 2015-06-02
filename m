Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 11:59:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52766 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006954AbbFBJ7h4Wwm4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jun 2015 11:59:37 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t529xOga018575;
        Tue, 2 Jun 2015 11:59:24 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t529xKoM018567;
        Tue, 2 Jun 2015 11:59:20 +0200
Date:   Tue, 2 Jun 2015 11:59:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        markos.chandras@imgtec.com, macro@linux-mips.org,
        Steven.Hill@imgtec.com, alexander.h.duyck@redhat.com,
        davem@davemloft.net
Subject: Re: [PATCH 0/3] MIPS: SMP memory barriers: lightweight sync,
 acquire-release
Message-ID: <20150602095920.GD29986@linux-mips.org>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
 <556D6C31.3070500@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556D6C31.3070500@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Jun 02, 2015 at 04:41:21AM -0400, Joshua Kinard wrote:

> On 06/01/2015 20:09, Leonid Yegoshin wrote:
> > The following series implements lightweight SYNC memory barriers for SMP Linux
> > and a correct use of SYNCs around atomics, futexes, spinlocks etc LL-SC loops -
> > the basic building blocks of any atomics in MIPS.
> > 
> > Historically, a generic MIPS doesn't use memory barriers around LL-SC loops in
> > atomics, spinlocks etc. However, Architecture documents never specify that LL-SC
> > loop creates a memory barrier. Some non-generic MIPS vendors already feel
> > the pain and enforces it. With introduction in a recent out-of-order superscalar
> > MIPS processors an aggressive speculative memory read it is a problem now.
> > 
> > The generic MIPS memory barrier instruction SYNC (aka SYNC 0) is something
> > very heavvy because it was designed for propogating barrier down to memory.
> > MIPS R2 introduced lightweight SYNC instructions which correspond to smp_*()
> > set of SMP barriers. The description was very HW-specific and it was never
> > used, however, it is much less trouble for processor pipelines and can be used
> > in smp_mb()/smp_rmb()/smp_wmb() as is as in acquire/release barrier semantics.
> > After prolonged discussions with HW team it became clear that lightweight SYNCs
> > were designed specifically with smp_*() in mind but description is in timeline
> > ordering space.
> > 
> > So, the problem was spotted recently in engineering tests and it was confirmed
> > with tests that without memory barrier load and store may pass LL/SC
> > instructions in both directions, even in old MIPS R2 processors.
> > Aggressive speculation in MIPS R6 and MIPS I5600 processors adds more fire to
> > this issue.
> > 
> > 3 patches introduces a configurable control for lightweight SYNCs around LL/SC
> > loops and for MIPS32 R2 it was allowed to choose an enforcing SYNCs or not
> > (keep as is) because some old MIPS32 R2 may be happy without that SYNCs.
> > In MIPS R6 I chose to have SYNC around LL/SC mandatory because all of that
> > processors have an agressive speculation and delayed write buffers. In that
> > processors series it is still possible the use of SYNC 0 instead of
> > lightweight SYNCs in configuration - just in case of some trouble in
> > implementation in specific CPU. However, it is considered safe do not implement
> > some or any lightweight SYNC in specific core because Architecture requires
> > HW map of unimplemented SYNCs to SYNC 0.
> 
> How useful might this be for older hardware, such as the R10k CPUs?  Just
> fallbacks to the old sync insn?

The R10000 family is strongly ordered so there is no SYNC instruction
required in the entire kernel even though some Origin hardware documentation
incorrectly claims otherwise.

  Ralf
