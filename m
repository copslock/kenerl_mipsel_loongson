Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 21:19:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58565 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026874AbbFBTT3g-C94 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Jun 2015 21:19:29 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t52JJFWt030688;
        Tue, 2 Jun 2015 21:19:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t52JJBpc030687;
        Tue, 2 Jun 2015 21:19:11 +0200
Date:   Tue, 2 Jun 2015 21:19:11 +0200
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
Message-ID: <20150602191910.GO29986@linux-mips.org>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin>
 <556D6C31.3070500@gentoo.org>
 <20150602095920.GD29986@linux-mips.org>
 <556DFD1A.7070802@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556DFD1A.7070802@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47804
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

On Tue, Jun 02, 2015 at 02:59:38PM -0400, Joshua Kinard wrote:

> >> How useful might this be for older hardware, such as the R10k CPUs?  Just
> >> fallbacks to the old sync insn?
> > 
> > The R10000 family is strongly ordered so there is no SYNC instruction
> > required in the entire kernel even though some Origin hardware documentation
> > incorrectly claims otherwise.
> 
> So no benefits even in the speculative execution case on noncoherent hardware
> like IP28 and IP32?

That's handled entirely differently by using a CACHE BARRIER instruction,
something which is specific to the R10000-family.  It's also used
differently by putting once such instruction at the end of every basic
block that might result in speculatively dirty cache lines.

Note that these systems affected by this speculation issue are all
non-coherent uniprocessor systems while Leonid's patch matters for
SMP kernels; the primitives he's changed will not genrate any code for
a !CONFIG_SMP kernel.

  Ralf
