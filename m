Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OFomnC001360
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 08:50:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OFomha001359
	for linux-mips-outgoing; Mon, 24 Jun 2002 08:50:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OFodnC001355;
	Mon, 24 Jun 2002 08:50:40 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA02953;
	Mon, 24 Jun 2002 17:54:29 +0200 (MET DST)
Date: Mon, 24 Jun 2002 17:54:28 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Guido Guenther <agx@sigxcpu.org>, linux-mips@oss.sgi.com
Subject: Re: 2.4.18: pgtable.h compile fix
In-Reply-To: <20020624153330.C28145@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020624174346.22509N-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 24 Jun 2002, Ralf Baechle wrote:

> >  MIPS64 lags behind a bit due to less interest/testing.  Note that you
> > should use "__ASSEMBLY__" to guard assembly-unsafe parts of headers.
> 
> _LANGUAGE_ASSEMBLY is the traditional MIPS cpp symbol to indicate assembler
> source code.

 Well, but the rest of the kernel uses "__ASSEMBLY__", that's defined in
the top-level Makefile.  What's the point in being different? 

 Also it doesn't seem to work for me -- the rules in specs look broken:

$ mipsel-linux-gcc -E -dM -xassembler-with-cpp /dev/null | grep LANGUAGE
#define __LANGUAGE_C 1
#define _LANGUAGE_C 1
#define LANGUAGE_C 1

thus it cannot be considered reliable.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
