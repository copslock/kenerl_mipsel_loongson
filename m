Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 20:11:54 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:47110 "EHLO
	hell") by linux-mips.org with ESMTP id <S1123253AbSJPSLx>;
	Wed, 16 Oct 2002 20:11:53 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 181sdr-00072G-00; Wed, 16 Oct 2002 20:11:35 +0200
Date: Wed, 16 Oct 2002 20:11:35 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021016181135.GA26994@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <20021007184344.GA17548@convergence.de> <Pine.GSO.3.96.1021015171817.16503B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021015171817.16503B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Tue, Oct 15, 2002 at 05:36:29PM +0200, Maciej W. Rozycki wrote:
>  Well, the kernel changes should be trivial, with no performance impact if
> written carefully, so they might get included even if only a few people
> are interested.  Send a proposal.

Here's patch for the kernel. Tested on a VR41XX, but my glibc
patch needs some cleanup and so will be posted seperately.

I thought "explicit is better than implicit" and thus added
many small changes depending on CONFIG_CPU_USERSPACE_LLSC_EMUL
before every eret.

The changes in tlbex-r4k.S are not stricly necessary, since
in current code k1 always ends up with a CP0_ENTRYLO value
with has bit31 == 0, which is sufficient for the glibc-patch.
Also, the 'move k1,zero' does not add any overhead and thus
could be done unconditionally.
But i thought that adding the #ifdef CONFIG_CPU_USERSPACE_LLSC_EMUL
prevents possible future changes from accidentally breaking this.

The patch is only for the VR41XX. I'm not shure what other CPUs
fall into the same category. If I read binutils/opcodes/mips-opc.c
correctly, then the TX39XX, while not being ISA2, has beql.

Please tell me if the patch is acceptable.

Possible options:
- don't mess with tlbex-r4k.S
- or unconditonally replace the 'nop's before 'eret's in tlbex-r4k.S with
  'move k1,zero' plus a comment
- drop the CONFIG_CPU_USERSPACE_LLSC_EMUL configuration option and
  always clear k1 in RESTORE_SP_AND_RET for the VR41XX


Regards,
Johannes
