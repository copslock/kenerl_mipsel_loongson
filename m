Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2003 10:55:58 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:48017 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225201AbTEUJzz>; Wed, 21 May 2003 10:55:55 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA02293;
	Wed, 21 May 2003 11:56:45 +0200 (MET DST)
Date: Wed, 21 May 2003 11:56:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Kevin D. Kissell" <kevink@mips.com>,
	Gilad Benjamini <yaelgilad@myrealbox.com>,
	linux-mips@linux-mips.org
Subject: Re: lwl-lwr
In-Reply-To: <20030521013449.A16378@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030521115345.2088D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 21 May 2003, Ralf Baechle wrote:

> > There's really no such thing as "disabling" lwl/lwr.  They are part 
> > of the base MIPS instruction set.  If one wants to live without them, 
> > one can either rig a compiler to emit multi-instruction sequences instead 
> > of lwr/lwl to do the appropriate shifts and masks (which is slower on all 
> > targets), or you can rig the OS to emulate them, and hope that the processors 
> > lacking support will take clean reserved instruction traps, where the function 
> > can be emulated (which is "free" for code running  on CPUs with lwl/lwr, 
> > but *really* slow for the guys doing emulation).
> 
> Technically you're right ...  In reality lwl/lwr are covered by US patent
> 4,814,976 which would also cover a software implementation.  So unless MIPS
> grants a license for the purpose of emulation in the Linux kernel ...

 For practical reasons I believe it can be dealt with without patent
infringing, but I am not that excited with doing anything at all about it. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
