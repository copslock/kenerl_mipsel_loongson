Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2003 13:09:06 +0000 (GMT)
Received: from p508B625A.dip.t-dialin.net ([IPv6:::ffff:80.139.98.90]:45256
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225248AbTAQNJG>; Fri, 17 Jan 2003 13:09:06 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0HD92L08800;
	Fri, 17 Jan 2003 14:09:02 +0100
Date: Fri, 17 Jan 2003 14:09:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Chetan B L <chetanb@ishoni.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Performance measuring in MIPS R3000
Message-ID: <20030117140902.B8301@linux-mips.org>
References: <7CFD7CA8510CD6118F950002A519EA3003FB04E6@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3003FB04E6@leonoid.in.ishoni.com>; from chetanb@ishoni.com on Thu, Jan 16, 2003 at 12:01:52PM +0530
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1178
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 16, 2003 at 12:01:52PM +0530, Chetan B L wrote:

>       I want to measure the time taken by any kernel function. 
> Is  there anything like rdtsc indtruction in MIPS ?
> I saw timepeg patch for measuring the same for Pentium , is there anything
> similar to it for MIPS ?

The subject of your mail is mentioning the R3000 which doesn't have any
kind of timer in the processor.  As already mentioned in my other posting
do_gettimeofday() is the portable timer interface providing the highest
accuracy.  But the R3000 processor itself doesn't provide any timers so
the precission of the clock will actually depend of the whatever timers
are provided by the rest of the system.  Hoever I doubt you're actually
using a true R3000 - the R3000 is an ~ 1988 vintage processor.  Later
R3000 processors frequently contain a suitable timer.

  Ralf
