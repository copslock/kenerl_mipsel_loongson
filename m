Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 11:09:36 +0000 (GMT)
Received: from p549F4E16.dip.t-dialin.net ([84.159.78.22]:10332 "EHLO
	mail.linux-mips.net") by ftp.linux-mips.org with ESMTP
	id S8133612AbVLVLJJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Dec 2005 11:09:09 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.4/8.13.1) with ESMTP id jBMBANH9004290;
	Thu, 22 Dec 2005 12:10:23 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.4/8.13.4/Submit) id jBMBANWt004289;
	Thu, 22 Dec 2005 12:10:23 +0100
Date:	Thu, 22 Dec 2005 12:10:23 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: Kernel freezes in r4k_flush_icache_range() with CONFIG_CPU_MIPS32_R2
Message-ID: <20051222111023.GD1918@linux-mips.org>
References: <1135047438.9874.74.camel@sakura.staff.proxad.net> <Pine.LNX.4.64N.0512201120010.25567@blysk.ds.pg.gda.pl> <1135218691.9874.186.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135218691.9874.186.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 22, 2005 at 03:31:31AM +0100, Maxime Bizon wrote:

> >  FYI, GCC 3.4.4 produces the following code which is clearly wrong:
> 
> > Please file a bug report at: "http://gcc.gnu.org/bugzilla/".
> 
> Same with 3.3 and 3.2...
> 
> I'm really not familiar with inline assembly so I would appreciate that
> any gcc guru here confirm instruction_hazard() code is correct before I
> (or he) submit the bug report.
> 
> As the bug seems to be in all gcc versions, I guess we should find a
> workaround... I changed the code to use an asm label instead of the C
> label and the bug disappeared. But I'm not sure my changes are correct
> for any platform other than mine...

We ran into similar problems in the past.  It only seems to be a matter
of the code nearby and the exact options to trigger it.

The alternative is manually loading the address using la / dla which
defeats gcc's splitting of address loading.  And having to use different
code for 32-bit and 64-bit sucks.

> Could anyone with the right skills help me to write a valid workaround
> please ?
> 
> Here is what I have:
> 
> __asm__ __volatile__(
>         "lui $2,1f\n"
>         "addiu $2,1f\n"
>         "jr.hb $2\n1:":: );

Wrong, breaks 64-bit and uses $2 without telling gcc about it.

  Ralf
