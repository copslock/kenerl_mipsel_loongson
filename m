Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 16:03:24 +0100 (BST)
Received: from mra05.ex.eclipse.net.uk ([IPv6:::ffff:212.104.129.155]:40893
	"EHLO mra05.ex.eclipse.net.uk") by linux-mips.org with ESMTP
	id <S8226358AbVGHPDE>; Fri, 8 Jul 2005 16:03:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by mra05.ex.eclipse.net.uk (Postfix) with ESMTP id A8F6BD4C4E;
	Fri,  8 Jul 2005 15:58:44 +0100 (BST)
Received: from mra05.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra05.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 28617-01-56; Fri,  8 Jul 2005 15:58:41 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra05.ex.eclipse.net.uk (Postfix) with ESMTP id 2202BD4ACB;
	Fri,  8 Jul 2005 15:35:45 +0100 (BST)
Subject: Re: Benchmarking RM9000
From:	Alex Gonzalez <linux-mips@packetvision.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050708130131.GC2816@linux-mips.org>
References: <20050708091711Z8226352-3678+1954@linux-mips.org>
	 <20050708120238.GA2816@linux-mips.org>
	 <1120825549.28569.949.camel@euskadi.packetvision>
	 <20050708130131.GC2816@linux-mips.org>
Content-Type: text/plain
Message-Id: <1120833749.28569.965.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Fri, 08 Jul 2005 15:42:29 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

The performance of our video application is well below our expectations.
We are still doing some profiling work on it, but we are also looking at
other possibilities.

What other benchmarking tool would you recommend?

Currently it's a NFS mounted system, but even if we could use a block
device the access speed wouldn't be more than 1.5 Mbps, so that is a
limitation for the benchmark.

Alex

On Fri, 2005-07-08 at 14:01, Ralf Baechle wrote:
> On Fri, Jul 08, 2005 at 01:25:49PM +0100, Alex Gonzalez wrote:
> 
> > I am doing some basic benchmarking tests on our RM9000 based platform,
> > running on just one of the two cores (non-smp kernel).
> > 
> > I would be very interesting in seeing some comparative data as we seem
> > to experience some performance problems.
> 
> What exactly are those performance issues?
> 
> If I recall right how to read bytebench numbers, your Bytebench numbers
> are look roughly ok, at least in first approximation.  That benchmark
> has become uncommon so I don't have any numbers at hand to compare with.
> 
>   Ralf
