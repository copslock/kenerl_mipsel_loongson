Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57B1At15876
	for linux-mips-outgoing; Thu, 7 Jun 2001 04:01:10 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57ArYh14688
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 03:56:14 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA05677;
	Thu, 7 Jun 2001 12:32:28 +0200 (MET DST)
Date: Thu, 7 Jun 2001 12:32:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: New toolchain for Linux/mips
In-Reply-To: <20010606131959.B25655@lucon.org>
Message-ID: <Pine.GSO.3.96.1010607122650.4624A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 6 Jun 2001, H . J . Lu wrote:

> As far as I can tell, all the currently available Linux/mips binutils
> are broken. I am working on fixing it.

 That depends on how you define "broken".  All software has bugs.  What I
currently use is sufficient to build working Linux 2.4.x, glibc 2.2.x as
well as all programs I built up to date.  I haven't tried C++, I admit. 
Libstdc++ of gcc 2.95.3 compiles fine, but I have not used it so far, so I
have no idea if the binary works. 

 If you know of particular problems, you are welcomed to fix them, of
course. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
