Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BFFtd10469
	for linux-mips-outgoing; Mon, 11 Feb 2002 07:15:55 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BFFl910463
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 07:15:48 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA22466;
	Mon, 11 Feb 2002 15:15:44 +0100 (MET)
Date: Mon, 11 Feb 2002 15:15:43 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
In-Reply-To: <20020211135302.GB30314@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1020211150912.18917C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 11 Feb 2002, Florian Lohoff wrote:

> I just saw it - I cant explain it ...

 Hmm, it's "subtarget_cpp_spec" in gcc's specs that defines _MIPS_SIM.  It
seems <sgidefs.h> should be a part of gcc indeed.  It would let avoiding
including the weird asm-mips/gcc/sgidefs.h header for the kernel as well. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
