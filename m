Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NDxdp08072
	for linux-mips-outgoing; Wed, 23 May 2001 06:59:39 -0700
Received: from delta.ds2.pg.gda.pl (root@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NDx3F08049;
	Wed, 23 May 2001 06:59:05 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA04954;
	Wed, 23 May 2001 15:18:39 +0200 (MET DST)
Date: Wed, 23 May 2001 15:18:39 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Florian Lohoff <flo@rfc822.org>, ralf@oss.sgi.com,
   Pete Popov <ppopov@mvista.com>, George Gensure <werkt@csh.rit.edu>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <3B0AEC51.B0C477E1@mvista.com>
Message-ID: <Pine.GSO.3.96.1010523145044.3890B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 22 May 2001, Jun Sun wrote:

> I took a look of MIPS ABI in system V and found that the spec only specifies
> this extended call in C prototype:
> 
> int _test_and_set(int *p, int v);
> 
> It seems perfectly legal for us to add one more argument to store the return
> value while still have the function returns error.  Of course, doing that will
> break binary compatibility.

 We have _test_and_set() in the library.  Implementing a clean underlying
_test_and_set() syscall is very high on my to-do list -- lack of time
prevents me from finishing it, unfortunately.

 There is no point to mess with sysmips() any further, I think.  The
library's _test_and_set() only calls sysmips() if the library was compiled
for ISA I systems.  As I guess from reports on the list, ISA I systems are
a minority, mostly DECstations and possibly a few embedded systems.  Most
people have ISA II+ and they do not need to call any syscall from
_test_and_set() at all.  For ISA II+ systems the library implements
_test_and_set() in the userland, using ll/sc appropriately. 

 Anyone having ISA II+ systems only, please do yourself a favour and set
"-mips2" (or maybe even "-mips3") somewhere in your CFLAGS for all
compilations -- not only you'll get better optimized binaries, but you'll
get rid of this sysmips() problem as well. 

> Otherwise, I think Flo's patch is the best fix to satisfy the spec and binary
> compatibility although it is a little clunky.

 I'll have yet to look at the patch, but what I think is, we should get
sysmips() work as defined by the original spec (or as reverse-engineered,
as the real spec seems to be out of reach).  Everything else belong to a
separate implementation. 

 Binary compatibility is not a necessity here.  The only sysmips() client
is glibc at the moment, and it can be updated to use a new syscall at any
time. 

 In short: let's leave sysmips() semantics alone.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
