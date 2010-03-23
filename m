Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2010 00:31:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47931 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492276Ab0CWXbr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Mar 2010 00:31:47 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2NNVjHO008922;
        Wed, 24 Mar 2010 00:31:45 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2NNVi2r008920;
        Wed, 24 Mar 2010 00:31:44 +0100
Date:   Wed, 24 Mar 2010 00:31:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] mips/mm: fix module support on SiByte
Message-ID: <20100323233143.GU4554@linux-mips.org>
References: <20100321110241.GA25569@Chamillionaire.breakpoint.cc>
 <20100322145918.GR4554@linux-mips.org>
 <20100323010403.GT4554@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100323010403.GT4554@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 23, 2010 at 02:04:03AM +0100, Ralf Baechle wrote:

> > > Since commit 656be92f aka "Load modules to CKSEG0 if
> > > CONFIG_BUILD_ELF64=n" module support is broken on 64bit. Since then
> > > modules arr loaded into 32bit compat adresses which are sign extended
> > > 64bit addresses. The SiByte war handler was not updated and those
> > > addresses were not recognized by the TLB hadling.
> > > This patch fixes this by shifting away the upper bits including the R
> > > and Fill bits. Now we compare VPN2 of C0_ENTRYHI against the matching
> > > bits at C0_BADVADDR.
> > 
> > Good detective work but I'll check against the errata documents (which
> > are non-public, sigh ...) before applying your patch.
> > 
> > The M3 workaround in which you found this bug is currently applied to all
> > Sibyte SB1 cores while probably only a relativly small number of the cores
> > in circulation are affected so we should refine the workaround to be only
> > applied if the System Revision Register indicates a system older than
> > revision C0.  This could get rid of 6 instructions which according to the
> > usual rule of thumb would result in a speedup of ~ 3%.
> 
> I've just committed a patch on the master branch to handle this issue.
> On cores that are not affected by the M3 bug this also fixes the module
> issue.

I've committed two more patches to fix the M3 errata handler.  I don't
have hardware affected by this CPU bug so I had to test the code with
a little hack on another system.  So tests on Swarm boards, especially
with SOC versions older than C0 would be appreciated.  After I receive
positive feedback I will cherrypick the fixes into the stable branches.

  Ralf
