Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2003 15:59:03 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:64153 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTEWO7A>; Fri, 23 May 2003 15:59:00 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA17834;
	Fri, 23 May 2003 16:59:43 +0200 (MET DST)
Date: Fri, 23 May 2003 16:59:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Vr41xx unaligned access update
In-Reply-To: <Pine.GSO.4.21.0305231618590.26586-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1030523165223.14542I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 23 May 2003, Geert Uytterhoeven wrote:

> >  Hmm, what tree is it against?  I can't see code matching these hunks in
> > our tree at linux-mips.org.
> 
> Check out the 2.4.x branch. I did verify that all patches apply.

 Being much surprised I've double checked this before replying, both a
nightly snapshot at my local system here and directly at
ftp.linux-mips.org.  I'm using a branch tagged as "linux_2_4".  AFAIK, it
is *the* 2.4 branch.  And AFAIK, it is the only branch that is actively
maintained these days.

 Also I recall the discussion on the BD issue on these chips once, but I
can't recall any results of it going into the CVS. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
