Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f56AnTW15978
	for linux-mips-outgoing; Wed, 6 Jun 2001 03:49:29 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f56An2h15908
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 03:49:04 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA25049;
	Wed, 6 Jun 2001 12:44:04 +0200 (MET DST)
Date: Wed, 6 Jun 2001 12:44:04 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
In-Reply-To: <20010605220605.A10997@lucon.org>
Message-ID: <Pine.GSO.3.96.1010606123704.23232B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 5 Jun 2001, H . J . Lu wrote:

> 2. gdb in RedHat 7.1 has yet to be ported to mips. Without a working
> gdb, it is very hard to fix 1.

 Gdb 5.0 works for me (and a few other people, I think).  Check
'ftp://ftp.ds2.pg.gda.pl/pub/macro/SRPMS/gdb-5.0-6.src.rpm'.  Most of the
patches have been submitted.  The only remaining one is the port of 4.17
changes from oss that needs copyright assignments from its authors.  There
might be a few insignificant issues remaining (I think "next" and "nexti"
don't work properly), but this is the version of gdb that helped me very,
very much to debug a few quirks in MIPS/Linux ld.so during glibc's 2.1.9x
development stage. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
