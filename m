Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2004 14:19:52 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:18075 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225803AbUDUNTv>; Wed, 21 Apr 2004 14:19:51 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id AF2AB47A40; Wed, 21 Apr 2004 15:19:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 9BA2F475C5; Wed, 21 Apr 2004 15:19:45 +0200 (CEST)
Date: Wed, 21 Apr 2004 15:19:45 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [RFC] Separate time support for using cpu timer
In-Reply-To: <20040420162500.H22846@mvista.com>
Message-ID: <Pine.LNX.4.55.0404211445470.28167@jurand.ds.pg.gda.pl>
References: <20040419180720.H14976@mvista.com> <Pine.LNX.4.55.0404201522220.28193@jurand.ds.pg.gda.pl>
 <20040420162500.H22846@mvista.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 20 Apr 2004, Jun Sun wrote:

> >  It makes it separate again -- more maintenance burden and a bigger
> > opportunity to have functional divergence, sigh...
> 
> Pretty much true for lots of improvement we made in the past a couple of
> years .... :)

 Hmm, s/improvement/hacks/, perhaps?

> >  Additionally I don't think using the CP0 Count & Compare registers for
> > the system timer is the way to go.  It's rather a way to escape when
> > there's no other possibility.  A lot of systems have a reliable external
> > timer interrupt source and using it actually would free the CP0 registers
> > for other uses, like profiling or a programmable interval timer.
> 
> I was rather neutral on this point until I started to add HRT/VST support to 
> MIPS.  When adding such features you really just want one common timer code.
> And the best choice for MIPS is cpu timer.

 Well, with the _hpt_ abstraction layer you have one common timer code,
regardless of the actual timer hardware used.  If there's some
functionality you miss there, we may discuss about possible solutions.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
