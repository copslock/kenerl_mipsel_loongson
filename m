Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6VBmARw018428
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 31 Jul 2002 04:48:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6VBmAqx018427
	for linux-mips-outgoing; Wed, 31 Jul 2002 04:48:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6VBlvRw018417;
	Wed, 31 Jul 2002 04:47:58 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA10995;
	Wed, 31 Jul 2002 13:49:57 +0200 (MET DST)
Date: Wed, 31 Jul 2002 13:49:57 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Ralf Baechle <ralf@oss.sgi.com>, Carsten Langgaard <carstenl@mips.com>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
In-Reply-To: <005001c23863$e077caa0$10eca8c0@grendel>
Message-ID: <Pine.GSO.3.96.1020731133556.10088B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 31 Jul 2002, Kevin D. Kissell wrote:

> I really don't think that's a good idea.  That implies that we
> could no longer simply inspect the exception handlers in
> the source code or disassembled kernel binary file to 
> analyse them for correctness, and I think it would lead
> to unnecessary and hard-to-find bugs.  My personal
> recommendation would be to keep the model we have
> today, wherein handlers are selected at boot time from
> some set of candidates built into the kernel binary, with

 Well, as long as we don't have an insane number of variations (say 32+),
I tend to agree.  Thanks to macros, maintaining source code is not that
hard.  If we ever reach the sanity limit, we may rearrange the source
again.

> the slight modification that the templates be loaded into 
> the init segment, so that the memory consumed can be
> reclaimed at run time.  That would eliminate the only

 That already happens now.  Except from the vmalloc path, which could
likely be handled this way as well, by copying the appropriate handler
to KSEG0 somewhere above standard exception vectors.  That would have the
micro-optimization advantage, we could use the "b" instruction, instead of
the much longer "dla/jr" pair.  Still possibly we can have a single
vmalloc handler only as the epilogue should be the same as for the user
path -- we need have to find a way to hook a jump back somehow in this
case.

> argument I can see against having a larger set of 
> statically-built optimized handlers.  The current
> selection process is ad-hoc based on CPU ID.
> We could easily formalize that a bit, and even

 Well, the current approach seems appropriate.  Only a comment here and
there might be useful, to explain why a particular handler is used (with
an erratum text included if applicable).

> provide a boot command line option to override
> the automatic selection with something "safer".

 Hmm, I think that's an overkill, although for debugging purposes, a
single extremely conservative handler (possibly with some status output to
the log) might be selectable as an alternative.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
