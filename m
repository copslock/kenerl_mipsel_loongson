Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f35GpBH00798
	for linux-mips-outgoing; Thu, 5 Apr 2001 09:51:11 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f35GovM00773;
	Thu, 5 Apr 2001 09:51:04 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA12981;
	Thu, 5 Apr 2001 18:50:30 +0200 (MET DST)
Date: Thu, 5 Apr 2001 18:50:27 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <3ACC82C9.7612DCDE@mips.com>
Message-ID: <Pine.GSO.3.96.1010405173512.21134I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 5 Apr 2001, Carsten Langgaard wrote:

> I tried the following:
> rpm -ba --rcfile .rpmrc-mipsel SPECS/mipsel-linux-binutils-2.10.91-2.spec
> 
> but it fails with
> Architecture is excluded: mipsel

 All packages which names start with <cpu>-<os> are cross-development
packages.  Mipsel-linux-binutils is a package providing binutils targeted
to mipsel.  You cannot build the package for the mipsel-linux host (which
the .rpmrc-mipsel configuration file sets up) as this wouldn't be a
cross-development package.  For this package to build just run: 

$ rpm -ba SPECS/mipsel-linux-binutils-2.10.91-2.spec

 You can only change the host system with .rpmrc-* files.  The target
system is hardcoded in cross-development packages and the build system is
implied.

 I hope this helps.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
