Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f85I4Ja28132
	for linux-mips-outgoing; Wed, 5 Sep 2001 11:04:19 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f85I4Bd28121
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 11:04:11 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA13985;
	Wed, 5 Sep 2001 20:05:46 +0200 (MET DST)
Date: Wed, 5 Sep 2001 20:05:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: Jim Paris <jim@jtan.com>, linux-mips@oss.sgi.com
Subject: Re: segfault
In-Reply-To: <20010905191550.B1054@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010905195417.7702G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 5 Sep 2001, Florian Lohoff wrote:

> Do you have a fix for the sysmips(MIPS_ATOMIC_SET) in there ? Or do
> you have the glibc compiled as -mips2 for usage of ll/sc ?
> 
> This bug might be a register corruption due to wrong return path
> in the sysmips case.

 Since there appears to be no conclusion of the sysmips-on-MIPS-I problem
in sight, I've just put all the related patches I use in a single place
for easy retrieval.  All of them were sent to this mailing list once but
digging through archives is tiresome.  Get them from
'ftp://ftp.ds2.pg.gda.pl/pub/macro/sysmips/'. 

 There is a sys_sysmips() fix in the "sysmips-1" patch and two additional
patches implementing a sys__test_and_set() syscall and its usage in glibc. 
Feel free to use them until an official solution is available. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
