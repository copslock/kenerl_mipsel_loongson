Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6V7QsRw013154
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 31 Jul 2002 00:26:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6V7Qsuh013153
	for linux-mips-outgoing; Wed, 31 Jul 2002 00:26:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6V7QjRw013140;
	Wed, 31 Jul 2002 00:26:45 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6V7RPXb020859;
	Wed, 31 Jul 2002 00:27:25 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA10962;
	Wed, 31 Jul 2002 00:27:16 -0700 (PDT)
Message-ID: <005001c23863$e077caa0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "Carsten Langgaard" <carstenl@mips.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, <linux-mips@fnet.fr>,
   <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020729163359.22288I-100000@delta.ds2.pg.gda.pl> <3D45A13E.79C882B5@mips.com> <3D46393D.37D36612@mips.com> <20020730132955.A28302@dea.linux-mips.net> <00f801c237c6$29cabd00$10eca8c0@grendel> <20020731040529.A5451@dea.linux-mips.net>
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
Date: Wed, 31 Jul 2002 09:28:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

From: "Ralf Baechle" <ralf@oss.sgi.com>:
> Basically we have two groups of interrupt handlers.  Some contain
> workarounds for hardware bugs; the rest are very similar except having
> to handle different hazards.  I was already thinking about building the
> actuall exception handlers from a piece of code that inserts the right
> number of (ss)nops etc. as required into the right place, thereby
> producing an optimal handler for every CPU.

I really don't think that's a good idea.  That implies that we
could no longer simply inspect the exception handlers in
the source code or disassembled kernel binary file to 
analyse them for correctness, and I think it would lead
to unnecessary and hard-to-find bugs.  My personal
recommendation would be to keep the model we have
today, wherein handlers are selected at boot time from
some set of candidates built into the kernel binary, with
the slight modification that the templates be loaded into 
the init segment, so that the memory consumed can be
reclaimed at run time.  That would eliminate the only
argument I can see against having a larger set of 
statically-built optimized handlers.  The current
selection process is ad-hoc based on CPU ID.
We could easily formalize that a bit, and even
provide a boot command line option to override
the automatic selection with something "safer".

            Regards,

            Kevin K.
