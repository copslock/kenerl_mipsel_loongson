Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14G0Ej28110
	for linux-mips-outgoing; Mon, 4 Feb 2002 08:00:14 -0800
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14FxvA27903;
	Mon, 4 Feb 2002 07:59:58 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA09246; Mon, 4 Feb 2002 06:58:37 -0800 (PST)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA16007;
	Mon, 4 Feb 2002 15:54:11 +0100 (MET)
Date: Mon, 4 Feb 2002 15:54:11 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "H . J . Lu" <hjl@lucon.org>, Hiroyuki Machida <machida@sm.sony.co.jp>,
   libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix ll/sc for mips
In-Reply-To: <20020204080145.C13799@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020204154108.5750F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 4 Feb 2002, Ralf Baechle wrote:

> > It will make the code more readable. We don't have to guess what
> > the assembler will do. 
> 
> Generally speaking a MIPS assembler is free to do arbitrary reordering.
> In the past there have been non-GNU assembler that were doing more massive
> reordering than gcc does ...  Using .set noreorder means you dump the
> assembler's intelligence and take full responsibility for dealing with
> all interlocks (or the lack thereof) and other performance issues
> yourself.

 That's why I'm still uneasy about the patch or, specifically, its
_test_and_set hunk.  It's best to avoid pretending we have the knowledge
beyond what an assembler has, as it's often not the case -- consider all
the options an assembler can accept for code variations.

 Using "noreorder" is really justified if you need to generate an exact
opcode stream for some reason (perhaps for a trampoline with a fixed
format) or you know you have the knowledege beyond what an assembler has,
e.g. you know an instruction can (or must) really be placed in a delay
slot even though a dependency analysis performed by an assembler shows
otherwise. 

 Also beware of implicit macros which may expand into multiple
instructions -- their semantics when placed in a delay slot may differ
from what one may expect! 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
