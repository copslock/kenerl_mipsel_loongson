Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2003 13:22:43 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:42638 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225309AbTHSMWl>; Tue, 19 Aug 2003 13:22:41 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA29602;
	Tue, 19 Aug 2003 14:22:38 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Tue, 19 Aug 2003 14:22:37 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
In-Reply-To: <20030819033843.GA6223@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030819140527.29184B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 19 Aug 2003, Ralf Baechle wrote:

> > > > #ifdef __mips64
> > > > # define MFC0		dmfc0
> > > > # define MTC0		dmtc0
> > > > #else
> > > > # define MFC0		mfc0
> > > > # define MTC0		mtc0
> > > > #endif
> > > 
> > >  I'd go for CONFIG_MIPS64 here.
> > 
> > This would work as well, but I prefer compiler intrinsic defines
> > over custom configury.
> 
> I agree for this particular header file because it's been copied into
> user applications.  So ideally it should be able to live entirely without
> CONFIG_* symbols rsp. <linux/config.h>.

 OK, I now recall <asm/asm.h> and <asm/regdef.h> as traditionally being
often included in user assembly.  But then we should get rid of
configuration dependency entirely, i.e. remove "#include <linux/config.h>" 
and a CONFIG_CPU_HAS_PREFETCH dependency.  Perhaps <asm/pref.h> would be
desireable if we don't want wasting cycles.

 It's a pity a more reasonable choice wasn't made for the location of
these headers -- the asm and linux trees shouldn't really be used for
userland.  For example Alpha has <alpha/regdef.h> that comes from glibc. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
