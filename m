Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 15:25:52 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:10500 "EHLO
	hell") by linux-mips.org with ESMTP id <S1123891AbSJQNZv>;
	Thu, 17 Oct 2002 15:25:51 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 182Aen-0000Tc-00; Thu, 17 Oct 2002 15:25:45 +0200
Date: Thu, 17 Oct 2002 15:25:45 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021017132545.GA1813@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <20021016181135.GA26994@convergence.de> <Pine.GSO.3.96.1021017134232.24495A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021017134232.24495A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Hello Ralf,

On Thu, Oct 17, 2002 at 01:57:29PM +0200, Maciej W. Rozycki wrote:
> On Wed, 16 Oct 2002, Johannes Stezenbach wrote:
> 
> > The patch is only for the VR41XX. I'm not shure what other CPUs
> > fall into the same category. If I read binutils/opcodes/mips-opc.c
> > correctly, then the TX39XX, while not being ISA2, has beql.
> 
>  I think I have TX39XX docs somewhere -- I may check if that's true.
> 
> > Please tell me if the patch is acceptable.
> > 
> > Possible options:
> > - don't mess with tlbex-r4k.S
> > - or unconditonally replace the 'nop's before 'eret's in tlbex-r4k.S with
> >   'move k1,zero' plus a comment
> 
>  I'd go for that, so that VR41XX user binaries work fine on real MIPS II+
> processors as well.  There is no performance nor space impact for
> tlbex-r4k.S and for stackframe.h the single-instruction impact is not
> critical, or I believe there is a single free slot in RESTORE_SOME that
> may be reused (after a bit of restructuring to make sure
> RESTORE_SP_AND_RET isn't used alone). 

This also would prevent me from shooting myself in the foot by accidentally
running a VR41XX user binaries on a kernel with "clear k1" support disabled ;-)

> > - drop the CONFIG_CPU_USERSPACE_LLSC_EMUL configuration option and
> >   always clear k1 in RESTORE_SP_AND_RET for the VR41XX
> 
>  And this one as well.  There is no need for a separate config option --
> lone comments in place should suffice.
> 
>  But you may ask Ralf before making further changes as he is the one to
> decide if the patch goes in. 

If this is OK with you, I would prepare a patch that just
unconditionally clears k1 before every eret in tlbex-r4k.S
and stackframe.h according to Maciej's suggestions, and adds
a comment explaining its purpose.


Regards,
Johannes
