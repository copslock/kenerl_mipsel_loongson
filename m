Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4NKBe721571
	for linux-mips-outgoing; Wed, 23 May 2001 13:11:40 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4NKACF21532;
	Wed, 23 May 2001 13:10:13 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA17602;
	Wed, 23 May 2001 21:44:36 +0200 (MET DST)
Date: Wed, 23 May 2001 21:44:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: Jun Sun <jsun@mvista.com>, Joe deBlaquiere <jadb@redhat.com>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
In-Reply-To: <20010523205412.A10981@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1010523213934.16787C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 23 May 2001, Florian Lohoff wrote:

> My favourit would be to let the glibc on runtime decide whether
> to use sysmips or ll/sc in the atomic test_and_set stuff. This would
> lead to an common atom op in the userspace which is fast on ll/sc 
> cpus and gives much lesser performance penaltys in the sysmips case
> than emulating ll/sc.

 How would you do it for inlined code?

 Anyway, I consider run-time detection of ll/sc an overkill.  You only
solve a single inefficiency of ISA I code when run on better CPUs.  You
really want to recompile code to make use of new instructions if you care
about performance.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
