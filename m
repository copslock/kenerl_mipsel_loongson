Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBJ3apK29042
	for linux-mips-outgoing; Tue, 18 Dec 2001 19:36:51 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBJ3amo29039
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 19:36:48 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA08591
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 18:36:26 -0800 (PST)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id DAA18021;
	Wed, 19 Dec 2001 03:30:47 +0100 (MET)
Date: Wed, 19 Dec 2001 03:30:46 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: jim@jtan.com, linux-mips@oss.sgi.com
Subject: Re: ISA
In-Reply-To: <3C1FF6F0.B8834B75@mvista.com>
Message-ID: <Pine.GSO.3.96.1011219031430.16267D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 18 Dec 2001, Jun Sun wrote:

> Overall, I still feel using isa_xxx() macros in the driver seems like a
> cleaner solution.  That essentially treats ISA memory space as a separate

 It depends on what you want to do.  For one isa_xxx() functions/macros
do not permit to control caching.

> space.  The ioremap/readb/writeb approach tries to lump ISA memory and PCI
> memory space together but in fact we still have treat them differently (based
> on whether the address is greater than 16MB, which is a little hackish.)

 The problem is a lone address doesn't really tell us what bus is it
expected to come from.  And practically there are few systems having
unrelated I/O buses implemented.  I don't know if any of them is supported
by Linux.  PCI and ISA are historically related, i.e. ISA is usually
accessed via a PCI-ISA bridge with a hardwired address mapping.  I don't
know any system doing it differently -- even Alphas do it this way.

 The *_resource() functions might help as you may refer to particular
resources with them, but I don't think a generic way for a multi-bus
system was defined.  Maybe the problem needs to be discussed at
linux-kernel.  It's generic after all. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
