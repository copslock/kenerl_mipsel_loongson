Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4O9m8710574
	for linux-mips-outgoing; Thu, 24 May 2001 02:48:08 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4O9kWF10527;
	Thu, 24 May 2001 02:47:36 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id LAA07583;
	Thu, 24 May 2001 11:32:30 +0200 (MET DST)
Date: Thu, 24 May 2001 11:32:29 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Joe deBlaquiere <jadb@redhat.com>
cc: Florian Lohoff <flo@rfc822.org>, Jun Sun <jsun@mvista.com>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com,
   "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B0C17D9.3060600@redhat.com>
Message-ID: <Pine.GSO.3.96.1010524111911.6990A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 23 May 2001, Joe deBlaquiere wrote:

> ll/sc emulation. If somebody wants to make a MIPS I optimized glibc, 
> then that's fine, but allowing the 'standard' MIPSII glibc to work on 
> all systems simplifies life ( mine at least ;) ).

 I have no objections against providing an ll/sc emulation -- I have never
had and certainly haven't expressed them.  What I insist on is to keep
ISA-I-compiled glibc not making use of ll/sc.  Anyone feel free to finish
the emulation we have.

 Anyway, an ISA-II-compiled glibc won't work on an ISA I system even if
the ll/sc emulation works.  An ISA II is more than just an addition of the
ll and sc instructions.  There were also branch likely, trap and
doubleword coprocessor load instructions added in ISA II.  Do you want to
emulate these, too? 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
