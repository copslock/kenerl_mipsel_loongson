Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49J1GD05399
	for linux-mips-outgoing; Wed, 9 May 2001 12:01:16 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49IxWF05355;
	Wed, 9 May 2001 11:59:33 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA23229;
	Wed, 9 May 2001 20:59:35 +0200 (MET DST)
Date: Wed, 9 May 2001 20:59:34 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Andreas Jaeger <aj@suse.de>, "Steven J. Hill" <sjhill@cotw.com>,
   Florian Lohoff <flo@rfc822.org>, Tom Appermont <tea@sonycom.com>,
   linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
In-Reply-To: <20010509150934.B2073@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010509204803.22796A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 9 May 2001, Ralf Baechle wrote:

> It's only modutils which for correct functionality depends on the trad-
> format, so I don't see any real reason for raising version requirements
> for libc.

 That would be needed if elf(32|64)-trad(little|big)mips was specified
explicitly as rtld-oformat in sysdeps/mips/mipsel/rtld-parms and
sysdeps/mips/rtld-parms.

 Note that libc doesn't require any version of binutils at all now. 
This is probably bad as using pre-2.11 versions of binutils may yield
weird results. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
