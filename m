Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4SJsOd02046
	for linux-mips-outgoing; Mon, 28 May 2001 12:54:24 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4SJr7d02022;
	Mon, 28 May 2001 12:53:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA26579;
	Mon, 28 May 2001 17:37:00 +0200 (MET DST)
Date: Mon, 28 May 2001 17:37:00 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: Joe deBlaquiere <jadb@redhat.com>, Jun Sun <jsun@mvista.com>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com,
   "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <20010526151427.A611@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010528173546.15200J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 26 May 2001, Florian Lohoff wrote:

> >  Anyway, an ISA-II-compiled glibc won't work on an ISA I system even if
> > the ll/sc emulation works.  An ISA II is more than just an addition of the
> > ll and sc instructions.  There were also branch likely, trap and
> > doubleword coprocessor load instructions added in ISA II.  Do you want to
> > emulate these, too? 
> 
> Isnt this the reason why Linux/Mips userspace is compiles with ISA I + ll/sc ?

 Is it?  Mine certainly is not. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
