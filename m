Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2002 13:57:31 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:395 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1124014AbSJQL5a>; Thu, 17 Oct 2002 13:57:30 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA24886;
	Thu, 17 Oct 2002 13:57:30 +0200 (MET DST)
Date: Thu, 17 Oct 2002 13:57:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Johannes Stezenbach <js@convergence.de>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
In-Reply-To: <20021016181135.GA26994@convergence.de>
Message-ID: <Pine.GSO.3.96.1021017134232.24495A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 16 Oct 2002, Johannes Stezenbach wrote:

> The patch is only for the VR41XX. I'm not shure what other CPUs
> fall into the same category. If I read binutils/opcodes/mips-opc.c
> correctly, then the TX39XX, while not being ISA2, has beql.

 I think I have TX39XX docs somewhere -- I may check if that's true.

> Please tell me if the patch is acceptable.
> 
> Possible options:
> - don't mess with tlbex-r4k.S
> - or unconditonally replace the 'nop's before 'eret's in tlbex-r4k.S with
>   'move k1,zero' plus a comment

 I'd go for that, so that VR41XX user binaries work fine on real MIPS II+
processors as well.  There is no performance nor space impact for
tlbex-r4k.S and for stackframe.h the single-instruction impact is not
critical, or I believe there is a single free slot in RESTORE_SOME that
may be reused (after a bit of restructuring to make sure
RESTORE_SP_AND_RET isn't used alone). 

> - drop the CONFIG_CPU_USERSPACE_LLSC_EMUL configuration option and
>   always clear k1 in RESTORE_SP_AND_RET for the VR41XX

 And this one as well.  There is no need for a separate config option --
lone comments in place should suffice.

 But you may ask Ralf before making further changes as he is the one to
decide if the patch goes in. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
