Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UCc0Rw007280
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 05:38:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UCc0SH007279
	for linux-mips-outgoing; Tue, 30 Jul 2002 05:38:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UCbpRw007265;
	Tue, 30 Jul 2002 05:37:52 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6UCcUXb017031;
	Tue, 30 Jul 2002 05:38:30 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA04230;
	Tue, 30 Jul 2002 05:38:30 -0700 (PDT)
Message-ID: <00f801c237c6$29cabd00$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>, "Carsten Langgaard" <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, <linux-mips@fnet.fr>,
   <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020729163359.22288I-100000@delta.ds2.pg.gda.pl> <3D45A13E.79C882B5@mips.com> <3D46393D.37D36612@mips.com> <20020730132955.A28302@dea.linux-mips.net>
Subject: Re: [patch] MIPS64 R4k TLB refill CP0 hazards
Date: Tue, 30 Jul 2002 14:39:24 +0200
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

From: "Ralf Baechle" <ralf@oss.sgi.com>
> On Tue, Jul 30, 2002 at 08:59:17AM +0200, Carsten Langgaard wrote:
> 
> > We have been discussing this before, but I really don't like the idea of
> > solving the hazard problem with a branch. The branch will on some CPUs
> > (especially if they have a long pipeline) be a much bigger penalty than
> > we actually wants to solve the hazard. On other CPU (with branch
> > prediction) we may not even solve the hazard problem.
> 
> The branch - which is used by other OSes btw. - for the R4000 / R4400 where
> this kind of taken branch implies a total delay of three cycles.  One for
> the branch delay slot plus two extra cycles for the killed instructions
> following the branch delay slot.  For R4600, R4700, R5000 and a bunch of
> derivates I've verified that according to the documentation this extra
> penalty of two cycles does not exist nor we need two extra cycles to handle
> the hazard.  In other words the branch trick - which also is used by
> some other commercial OS btw. - is providing best possible performance on
> a wide range of processors.

Which would be a fairly compelling argument if (a) we were constrained
for some reason to only have one handler and (b) the majority of MIPS
Linux systems being built had R4000/4400/4600/4700/5000 CPUs in
them.  But neither of those assumptions is true.  I don't see any cases
in the kernel of assembler functions being put into the .init segment of
the kernel image, but I would think that it could be (and anyway should
be) done with the various exception vectors, and in any case they are
dynamically installed based on the detected CPU.  If people using
old workstations want to use a branch-based timing hack in their
TLB handlers, that's all well and good.  But there is no guarantee that
the trick will work on all future (or even current) MIPS CPUs, and
I agree with Carsten that it is inappropriate for the generic or default
MIPS32 handlers.  I guess we need to propose a patch to allow
the Indy/Decstation crowd to retain their branch-based scheme,
but to quarantine it from the rest of the MIPS/Linux universe.

            Regards,

            Kevin K.
