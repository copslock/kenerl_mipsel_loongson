Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACC2SM18110
	for linux-mips-outgoing; Mon, 12 Nov 2001 04:02:28 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACC2C018105
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 04:02:13 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA27640;
	Mon, 12 Nov 2001 13:00:02 +0100 (MET)
Date: Mon, 12 Nov 2001 13:00:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: Steven Liu <stevenliu@psdc.com>, linux-mips@oss.sgi.com
Subject: Re: Which usrland packages should be built for swapon, hostname,and grep?
In-Reply-To: <20011109131334.E8243@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1011112125901.24771H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 9 Nov 2001, Florian Lohoff wrote:

> One problem though might be that you need to fix "sysmips(MIPS_ATOMIC_SET)"
> in the kernel to actually run the binarys (glibc 2.2).

 It seems to be fixed to the point of working.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
