Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1CCo3630240
	for linux-mips-outgoing; Tue, 12 Feb 2002 04:50:03 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1CCnk930234;
	Tue, 12 Feb 2002 04:49:47 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA18197;
	Tue, 12 Feb 2002 12:49:30 +0100 (MET)
Date: Tue, 12 Feb 2002 12:49:29 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
In-Reply-To: <20020210121134.B2018@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020212124236.17858C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, 10 Feb 2002, Ralf Baechle wrote:

> > Shouldnt sgidefs.h or its content be included in the gcc ?
> 
> There should be a copy of sgidefs.h in /usr/include rsp. for crosscompilers
> in <prefix>/<target>/include/sgidefs.h.  However the gcc varargs stuff

 That file is part of libc, not gcc.  OTOH, gcc when configured for
"mipsel-linux" is allowed to assume glibc is available.  So there is no
need to migrate the file after all.

> has been rewritten completely; the new implementation does no longer try
> to include sgidefs.h.

 That's fine but for 2.95.x the issue exists.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
