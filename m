Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BDqo006291
	for linux-mips-outgoing; Mon, 11 Feb 2002 05:52:50 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BDqg906287
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 05:52:42 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA19824;
	Mon, 11 Feb 2002 13:51:47 +0100 (MET)
Date: Mon, 11 Feb 2002 13:51:47 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
In-Reply-To: <20020209150155.GA853@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1020211134516.18917A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 9 Feb 2002, Florian Lohoff wrote:

> i just stumbled when i tried to compile a program (bootloader) with
> gcc which uses varargs. I got the error that "sgidefs.h" was missing.
> sgidefs.h is contained in the glibc which gets included by va-mips.h
> from stdarg.h - I dont think this is correct as i should be able
> to compile programs without glibc.

 Hmm, in 2.95.3 in va-mips.h I see: 

/* Get definitions for _MIPS_SIM_ABI64 etc.  */
#ifdef _MIPS_SIM
#include <sgidefs.h>
#endif

so you shouldn't need sgidefs.h normally.  Or did something get broken for
3.x?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
