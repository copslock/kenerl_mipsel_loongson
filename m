Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0S9lsK04171
	for linux-mips-outgoing; Mon, 28 Jan 2002 01:47:54 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0S9lkP04151;
	Mon, 28 Jan 2002 01:47:46 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA26530;
	Mon, 28 Jan 2002 00:47:33 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA02439;
	Mon, 28 Jan 2002 00:47:29 -0800 (PST)
Message-ID: <002f01c1a7d8$e49bb9f0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Daniel Jacobowitz" <dan@debian.org>,
   "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Dominic Sweetman" <dom@algor.co.uk>, "Ralf Baechle" <ralf@oss.sgi.com>,
   "Ulrich Drepper" <drepper@redhat.com>, "Mike Uhler" <uhler@mips.com>,
   "\"MIPS/Linux List \(SGI\)\"" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
References: <E16Uvqu-0002X7-00@the-village.bc.nu>
Subject: Re: thread-ready ABIs
Date: Mon, 28 Jan 2002 09:50:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > Which it is.  Fork shares no memory regions; vfork/clone share all
> > memory regions.  AFAIK there is no share-heap-but-not-stack option in
> > Linux.
> 
> Thats a design decision. At the point you don't have identical mappings for
> both threads you need two sets of page tables and you take all the
> performance hits that go with changing current tables on a schedule.
> 
> Its a lot cheaper to use a different %esp for each thread

That's a point of view that reflects the PC-centric origins of
Linux.  Large-scale parallel systems, such as the current
high-end server offerings from Sun, IBM/Sequent, and SGI,
have a non-uniform memory access (NUMA) model on which
insisting on maintining identical page tables for all threads of
a parallel program can result in an intollerable level of remote
memory accesses.  The usual technique employed on such
systems is a dynamic replication of frequently accessed
pages.  This of course implies greater OS overhead for all 
operations on virtual memory maps, and additional overhead
to synchronize the copies, but that can be more than
compensated for by reducing the average memory latency
seen by the CPUs.  An even more extrememe case, though
one that is perhaps less relevant to mainstream parallel 
servers, is that of the emulation of shared memory ("virtual
shared memory" or VSM as we used to call it) on message
based highly-parallel machines, which likewise depends on
having distinctly set-up and managed page tables for different
threads/processes within a parallel program.

There's nothing wrong with having an OS design that allows
common page tables to be used across the threads of a
parallel program running on a simple, small-scale SMP
platform like a dual or quad CPU PC.  But making that
the *only* way that thread parallelism is supported
is, in my opinion, a design error that will have to be fixed
one of these days.  And the longer the existing model
is enhanced and maintained, the harder it will be to fix.

All that having been said, please note that this issue is
orthogonal to the question of whether one should have
a single "process image" across all threads of a parallel
program.

            Regards,

            Kevin K.
