Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4SKJ7Z02557
	for linux-mips-outgoing; Mon, 28 May 2001 13:19:07 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4SK1nd02341;
	Mon, 28 May 2001 13:05:50 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA26818;
	Mon, 28 May 2001 17:43:19 +0200 (MET DST)
Date: Mon, 28 May 2001 17:43:19 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: Joe deBlaquiere <jadb@redhat.com>, Jun Sun <jsun@mvista.com>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com,
   "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <20010526151550.B611@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010528173758.15200K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 26 May 2001, Florian Lohoff wrote:

> Export the existance of ll/sc via /proc/cpuinfo or whatever.

 That's a valid approach and also nothing new to glibc -- see Alpha and
in()/out() support.  But do we want an extra overhead due to an indirect
call?  Especially as _test_and_set() gets usually inlined?

> I dont think this is true necessarly - There are still people building
> embedded x86 systems based on 386 cores. Look at the vr41xx systems - They
> do also lack the ll/sc afaik. This is nowadays the most commonly
> used embedded/pda cpu.

 Are vr41xx plain ISA I or crippled ISA II+ CPUs? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
