Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5KCQ6nC010964
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 20 Jun 2002 05:26:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5KCQ6LJ010963
	for linux-mips-outgoing; Thu, 20 Jun 2002 05:26:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5KCQ1nC010960
	for <linux-mips@oss.sgi.com>; Thu, 20 Jun 2002 05:26:02 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA20187;
	Thu, 20 Jun 2002 14:29:27 +0200 (MET DST)
Date: Thu, 20 Jun 2002 14:29:26 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Smith, Todd" <Todd.Smith@camc.org>
cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: RE: Linux and the Sony Playstation 2
In-Reply-To: <490E0430C3C72046ACF7F18B7CD76A2A568B84@KES.camcare.com>
Message-ID: <Pine.GSO.3.96.1020620141032.18164A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 19 Jun 2002, Smith, Todd wrote:

> This list is been pretty quiet lately so I don't really know what is
> happening on the Linux/MIPS front.  I am hoping that work is still slowly
> proceeding on the DECstation that I have, but I don't really know.  I agree
> with you that PS2 offer enormous power to the developer and as a cheap
> source of computing power to other countries.

 I'm doing some development on the DECstation -- changes get applied to
the CVS as they are ready (e.g. I fixed a few bugs in declance yesterday). 
The last large change was the IRQ handling rewrite (small parts of which
are still pending awaiting approval of generic bits they depend on).  I'm
planning another big change soon.

 If you have any problems, just report them here. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
