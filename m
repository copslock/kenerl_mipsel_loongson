Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5RIPGnC019943
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 27 Jun 2002 11:25:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5RIPGRM019942
	for linux-mips-outgoing; Thu, 27 Jun 2002 11:25:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5RIP5nC019931;
	Thu, 27 Jun 2002 11:25:06 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA28154;
	Thu, 27 Jun 2002 20:29:06 +0200 (MET DST)
Date: Thu, 27 Jun 2002 20:29:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Ladislav Michl <ladis@psi.cz>,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: DBE/IBE handling rewrite
In-Reply-To: <3D1B4787.5030709@mvista.com>
Message-ID: <Pine.GSO.3.96.1020627193348.21496G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 27 Jun 2002, Jun Sun wrote:

> You missed the point - I like to see some open discussions before any big 
> changes to MIPS.  If you look back of all the significant changes made to the 

 Agreed.

> MIPS tree, you will see a high percentage of them went in without any open 

 I can't actually recall any significant changes recently (barring
platform additions I don't really track), certainly not since 2.4.  All I
observe are bug fixes, clean-ups and similar stuff.

> discussion or pre-warning.  It is this context that brought out :-(.  Not your 
> patch per se.

 If you suggest that this change qualifies as big, then I'd write you
exaggerate.  Anyway, I've sent a proposed function and then a real
implementation of bits that were broken "since forever".  Even the
previous clean-up, for 32-bit MIPS solely, was written by me -- apparently
nobody else was interested in the subsystem.

 Then you are aware of the changes.  You may look at the original and the
new code.  You may suggest improvements, fixes, etc.  The source tree is
not cast in stone -- any changes may get reverted, fixed, rewritten, etc. 

 Thus I think the context is clean. 

> Once in while I hop into other communities.  I get a feeling they appear to be 
> doing better than us in this regard.  And I like that feeling.

 Well, as you might have noticed I send unobvious patches here, asking for
comments (usually getting no response, unforunately).  I comment on
others' changes if I feel I have thoughts to express.  I don't sent
patches I consider obvious here -- if you worry of bad changes, then just
follow the CVS list.  I reply to commits I consider problematic when I
spot one, others do as well.

 I believe the arrangement here is as good as it can be.  Certainly it's
not worse than that of the linux-kernel list (with the official kernel you
usually know something got changed in the i386 or generic bits only after
your favourite non-i386 code doesn't work or even compile anymore).  The
volume is low, easy to follow.  I sometimes even worry it's too low -- as
if hardly anyone was interested.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
