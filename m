Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2003 21:47:15 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:5602 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225215AbTF0UrN>; Fri, 27 Jun 2003 21:47:13 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA02723;
	Fri, 27 Jun 2003 22:48:12 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Fri, 27 Jun 2003 22:48:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kip Walker <kwalker@broadcom.com>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
In-Reply-To: <3EFCA9E8.D08AAA3A@broadcom.com>
Message-ID: <Pine.GSO.3.96.1030627223600.27044Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 27 Jun 2003, Kip Walker wrote:

> >  There's still missing a load delay slot filler there.  I'm checking in an
> > obvious fix immediately.
> 
> What about the other back-to-back loads in that file (9 lines above)? 

 Oops -- I've missed that one even though I've browsed through the file. 
Thanks for pointing it out. 

> My CPU doesn't care about the load delay slot, so I didn't think to add

 I hope you haven't realized of the problem rather than ignored it.  I
think the nops should eventually be replaced with macros that would
conditionally expand to nothing.  But correctness first and performance
later. 

> the nop.  At least my patch didn't introduce the problem ;-)

 But it let me notice it.  Better late than never. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
