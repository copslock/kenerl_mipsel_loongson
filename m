Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NDphB07592
	for linux-mips-outgoing; Wed, 23 May 2001 06:51:43 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NDmwF07408;
	Wed, 23 May 2001 06:49:00 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA05551;
	Wed, 23 May 2001 15:34:14 +0200 (MET DST)
Date: Wed, 23 May 2001 15:34:13 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Joe deBlaquiere <jadb@redhat.com>
cc: Jun Sun <jsun@mvista.com>, Florian Lohoff <flo@rfc822.org>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B0B5AC6.6060208@redhat.com>
Message-ID: <Pine.GSO.3.96.1010523152429.5196A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 23 May 2001, Joe deBlaquiere wrote:

> I would vote for option #4 - make sure the ll/sc emulation stuff works 
> and use ll/sc in glibc instead of sysmips. Beyond the pthreads mutex 

 Please don't.  The emulation is an overkill here and the overhead is
painful for ISA I systems, which are usually not the fastest ones.  This
has already been discussed here.

 If you want to go for speed and use ll/sc on an ISA II+ system, then
compile glibc for ISA II or better.  It will never call sysmips() then. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
