Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0P8MbH26489
	for linux-mips-outgoing; Fri, 25 Jan 2002 00:22:37 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0P8MUP26438;
	Fri, 25 Jan 2002 00:22:30 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA19242;
	Thu, 24 Jan 2002 23:22:19 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id XAA05143;
	Thu, 24 Jan 2002 23:22:16 -0800 (PST)
Message-ID: <001001c1a571$7a7a08b0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>,
   "Machida Hiroyuki" <machida@sm.sony.co.jp>
Cc: <aj@suse.de>, <hjl@lucon.org>, <linux-mips@oss.sgi.com>
References: <20020122232529V.machida@sm.sony.co.jp> <005301c1a368$87d27ed0$10eca8c0@grendel> <20020123145634M.machida@sm.sony.co.jp> <20020124105915.A838@dea.linux-mips.net>
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
Date: Fri, 25 Jan 2002 08:25:10 +0100
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

> > > It should in principle be SMP safe.
> > 
> > I don't think so.
> > 
> > Suppose that 
> > THREAD A is bound to CPU A and THREAD B is bound to CPU B.
> > THREAD A and THREAD B are running on_atomic_inc_nollsc(). 
> > Two threads are really running at the same time, without
> > context-switch. In this case nobody clear k1.
> 
> There is a method for mutual exclusion called Dekker's Algorithem (sp?)
> which only requires just atomic stores and can be implemented in plain
> C.  Downside is it's weak performance that renders it pretty much a CS
> only thing.

Having actually ised Dekker's algorithm once in an industrial
application (2 Z80's with a shared buffer) some 20-odd years ago, 
I can say that it does work, but caution that, while in theory one can 
scale it to arbitrary number of CPUs, the time of the operation expands
by something like the square of the number of CPUs involved.
It's minimally acceptable for 2 CPUs.  More than that...

            Kevin K.
