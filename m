Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PLmtRw032470
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 14:48:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PLmtPq032469
	for linux-mips-outgoing; Thu, 25 Jul 2002 14:48:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PLmhRw032457
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 14:48:43 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6PLn6Xb004409;
	Thu, 25 Jul 2002 14:49:07 -0700 (PDT)
Received: from menelaus.mips.com (menelaus [192.168.65.223])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id OAA14542;
	Thu, 25 Jul 2002 14:49:08 -0700 (PDT)
Received: from mips.com (localhost [127.0.0.1])
	by menelaus.mips.com (8.9.3/8.9.0) with ESMTP id OAA04811;
	Thu, 25 Jul 2002 14:49:08 -0700 (PDT)
Message-ID: <3D407254.233BE0DB@mips.com>
Date: Thu, 25 Jul 2002 14:49:08 -0700
From: "Kevin D. Kissell" <kevink@mips.com>
Organization: MIPS Technologies Inc.
X-Mailer: Mozilla 4.61 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Johannes Stezenbach <js@convergence.de>
CC: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: LL/SC benchmarking [was: Mipsel libc with LL/SC online anywhere?]
References: <00ce01c229a4$a7d4ed40$10eca8c0@grendel> <20020719123828.GA5521@convergence.de> <20020725162539.GA8804@convergence.de> <3D40302F.40806@mvista.com> <20020725184519.GB9302@convergence.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Johannes Stezenbach wrote:
> 
> On Thu, Jul 25, 2002 at 10:06:55AM -0700, Jun Sun wrote:
> > Johannes Stezenbach wrote:
> > >sysmips:
> > >        real    1m19.358s
> > >        user    0m28.150s
> > >        sys     0m47.250s
> > >
> > >LL/SC emulation:
> > >        real    0m41.246s
> > >        user    0m25.390s
> > >        sys     0m12.240s
> > >
> > >branch-likely hack (hm, still without kernel patch...):
> > >        real    0m25.126s
> > >        user    0m17.240s
> > >        sys     0m2.310s
> >
> > Johannes,
> >
> > This is great stuff!  Can you explain what are "real", "user", and "sys"?
> > Also, what is your initial conclusion?
> 
> This are results from simple 'time ./testapp' testing, so its real time
> and user/system time reported by wait(4).
> 
> Also, I have an interactive gtk+directfb applicaton running. The
> difference in response time is quite noticable.
> 
> On reason for the big differences is that the Glib-2.0/GObject library
> does a lot of locking in its internal type system for every object
> created. Other software might not suffer as badly from a slow mutex
> implementation.
> 
> My conclusion is that it is good for glibc to always use ll/sc,
> emulated or not, and for my specific needs I will use the branch-likely
> hack. So next I will study kernel source to decide what MAGIC_COOKIE
> is best for the branch-likely hack, and where to add 'move k1,$0'
> before eret.

I am convinced that there is a value, quite possibly 0xffdadaff,
which can provably never be in k1 at the return from an exception
in a sane system - but it would be tedious to prove, and the
assumption could very easily be perturbed. I think
that adding overhead to the TLB refill handler would be
highly undesirable, but fortunately the TLB refill handler
is one of those cases where we can be sure that members
of a set of values (including 0xffdadaff) could not be
in k1 unless the system was about to crash in any case.
The prudent thing to do would be to load the MAGIC_COOKIE
value explicitly into k1 on the way out of general exception
service.  Fortunately, it looks to me as if at least half
of the overhead of this operation (LUI/ORI) can be concealed
in branch/jump delay slots that are currently going unfilled.

> OTOH I doubt it's worth it to add the branch-likely hack to
> stock glibc. How many people are using Linux/MIPS on embedded
> CPU's without LL/SC?

MIPSII-but-no-LL/SC CPUs are certainly the minority as far
as distinct designs and part numbers are concerned, but
I suspect they provide the overwhelming majority of actual
MIPS/Linux platforms in use, since both NEC Vr41xx-based 
handhelds and Sony PlayStation 2's fall into that category.  
Someone else may have better statistics than I do, though.

		Regards,

		Kevin K.
