Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 20:50:19 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:4281 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225248AbTBUUuS>; Fri, 21 Feb 2003 20:50:18 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA19270;
	Fri, 21 Feb 2003 21:50:36 +0100 (MET)
Date: Fri, 21 Feb 2003 21:50:35 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kip Walker <kwalker@broadcom.com>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <3E568A6A.96B422@broadcom.com>
Message-ID: <Pine.GSO.3.96.1030221213033.17698F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 21 Feb 2003, Kip Walker wrote:

> Suggestions and corrections are welcome.  I'm not an ABI/binutils
> expert.  FYI, I let Ralf eyeball this before checking it in.

 False alarm -- sorry for the confusion.  The ELF flags for MIPS are
twisted and inconsistent due to historical reasons (or ad hoc hacks) and
it seems they fooled me this time.  We could actually adjust
binfmt_elfo32.c a bit instead. 

> "Maciej W. Rozycki" wrote:
> > 
> > > Modified files:
> > >       include/asm-mips64: Tag: linux_2_4 a.out.h elf.h processor.h
> > >       arch/mips64/kernel: Tag: linux_2_4 process.c signal.c
> > >
> > > Log message:
> > >       Represent ABI (o32,n32,n64) in thread mflags using 2 bits:
> > >       MF_32BIT_REGS, MF_32BIT_ADDR.
> > 
> >  Why do you assume no ABI set for ELF32 means n32?  Historically it means
> > o32 and arch/mips64/kernel/binfmt_elfo32.c treats it as such.  Also a
> > brief study of binutils reveals the interpretation is the same for IRIX
> > which does not handle the EF_MIPS_ABI mask.

 Please try to reply below original text, BTW.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
