Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2003 04:15:52 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:65010 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8226259AbTAMEN5>;
	Mon, 13 Jan 2003 04:13:57 +0000
Received: from localhost (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id UAA17795;
	Sun, 12 Jan 2003 20:13:47 -0800
Subject: Re: Cpu frequency scaling
From: Pete Popov <ppopov@mvista.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	"Krishnakumar. R" <krishnakumar@naturesoft.net>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <003b01c2ba6c$f64ef840$10eca8c0@grendel>
References: <200301101600.26246.krishnakumar@naturesoft.net>
	 <20030112180917.A18654@linux-mips.org>
	 <003b01c2ba6c$f64ef840$10eca8c0@grendel>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1042431334.29107.9.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Jan 2003 20:15:34 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1138
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Sun, 2003-01-12 at 11:01, Kevin D. Kissell wrote:
> > > Can frequency scaling (through software) 
> > > be done on mips using linux ?
> > > 
> > > Is  such a feature feasible in mips ??
> > > 
> > > I could not find any documentation nor patches 
> > > for  frequency
> > > scaling on mips at 
> > > http://www.brodo.de/cpufreq/
> > > :-(
> > 
> > None of the currently supported MIPS CPUs support such a feature in
> > hardware as such our support is already complete and by definition
> > bug free ;-)
> 
> Actually, that's not *quite* true.  A number of MIPS CPUs and
> cores that are otherwise supported by Linux (e.g. 4K, 5K) have
> a "reduced power" mode which is modulated by the CP0 "RP"
> bit. In general, this bit does nothing in the CPU itself, however.
> It was intended that it be connected to system-level logic for
> frequency scaling (1/n normal clock, or CPU=Bus).  So on
> most systems it does nothing, and on the ones where it does
> do something, it's entirely system dependent.  I don't have an
> Alchemy AU1000 spec handy, but since they've integrated
> a lot of other logic with their CPU, and since they designed
> their component to go into low-power devices, it wouldn't
> surprise me in the least if they do something well-defined
> with the RP bit.

Actually the Au1x CPUs support both, frequency and voltage scaling.

> So, to get back to the original question, something highly
> platform dependent *could* be done using MIPS/Linux, 
> via /proc/cpu or some kind of system call, but I don't believe 
> anyone has made such a hook generally available as yet.

For the Au1x CPUs, I had added a /proc interface that allows you to do something
like "echo 192 > /proc/cpufreq" to reduce the frequency from 396 MHz to 192,
or whatever number you chose, but the implementation was very adhoc and
probably not generally useful for other CPUs.  IBM and MontaVista recently 
published a whitepaper on power management that's designed to be arch 
independent. The design considers not only CPU scaling but scaling of all the 
buses as well, which I don't think the cpufreq project takes into account.

Pete
