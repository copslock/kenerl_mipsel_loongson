Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f34Fbi821529
	for linux-mips-outgoing; Wed, 4 Apr 2001 08:37:44 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f34FbWM21522;
	Wed, 4 Apr 2001 08:37:33 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA21345;
	Wed, 4 Apr 2001 17:37:15 +0200 (MET DST)
Date: Wed, 4 Apr 2001 17:37:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Carsten Langgaard <carstenl@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
In-Reply-To: <3ACB2E5E.D8AFB3BF@mips.com>
Message-ID: <Pine.GSO.3.96.1010404171225.6521F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 4 Apr 2001, Carsten Langgaard wrote:

> Now I would like to start cross compile SRPMs (let say redhat7.0).
> What do I need to do to make the SRPMS cross compile ?

 Spec files need to be written appropriately for cross-compilation to be
supported as you need to override the compiler used (and possibly other
tools) and configure scripts need to be passed a host system name.  Also
depending on the cluefulness of a given maintainer/team, packages might be
easy or difficult to cross-compile -- heavy patching is required in some
cases. 

 For the way I am using RPM to cross-compile you might visit my FTP site
at 'ftp://ftp.ds2.pg.gda.pl/pub/macro/' (mirrored at
'ftp://ftp.rfc822.org/pub/mirror/ftp.ds2.pg.gda.pl/pub/macro' -- thanks,
Flo).  There are source and binary packages as well as configuration files
I use.  Read the READMEs and look at a few spec files and everything
should be clear.  Many of the *.mipsel.rpm packages available there were
cross-built -- you may verify it with `rpm -qip': "macro" is my i386-linux
system, while "3maxp" is my mipsel-linux one (still no i386-linux
cross-compiler on my mipsel-linux system, sigh... :-( ). 

 You need to build cross-binutils, cross-gcc and cross-glibc to start. 
I've already written and sent a detailed description on cross-gcc
bootstrapping here.  I'm not sure if the list is archived, or not.  If
not, I may dig through my mail archives and send it again. 

 If you have any specific questions, don't hesitate to ask me.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
