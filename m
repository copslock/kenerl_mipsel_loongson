Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 18:16:35 +0000 (GMT)
Received: from atlrel7.hp.com ([156.153.255.213]:48590 "EHLO atlrel7.hp.com")
	by ftp.linux-mips.org with ESMTP id S3468173AbWASSQO (ORCPT
	<rfc822;Linux-mips@linux-mips.org>); Thu, 19 Jan 2006 18:16:14 +0000
Received: from atarelint01.atl.hp.com (atarelint01.atl.hp.com [15.45.89.136])
	by atlrel7.hp.com (Postfix) with ESMTP id 2E3FF358EC;
	Thu, 19 Jan 2006 13:19:56 -0500 (EST)
Received: from hplms2.hpl.hp.com (hplms2.hpl.hp.com [15.0.152.33])
	by atarelint01.atl.hp.com (Postfix) with ESMTP id DE69E34055;
	Thu, 19 Jan 2006 13:19:55 -0500 (EST)
Received: from frankl.hpl.hp.com (frankl.hpl.hp.com [15.4.89.73])
	by hplms2.hpl.hp.com (8.13.1/8.13.1/HPL-PA Hub) with ESMTP id k0JIITk1023737;
	Thu, 19 Jan 2006 10:18:29 -0800 (PST)
Received: from frankl.hpl.hp.com (localhost [127.0.0.1])
	by frankl.hpl.hp.com (8.12.8/8.12.8) with ESMTP id k0JIG9vH021006;
	Thu, 19 Jan 2006 10:16:09 -0800
Received: (from eranian@localhost)
	by frankl.hpl.hp.com (8.12.8/8.12.8/Submit) id k0JIG8R6021004;
	Thu, 19 Jan 2006 10:16:08 -0800
Date:	Thu, 19 Jan 2006 10:16:08 -0800
From:	Stephane Eranian <eranian@hpl.hp.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Philip Mucci <mucci@cs.utk.edu>, Linux-mips@linux-mips.org,
	perfmon@napali.hpl.hp.com
Subject: Re: 2.6.13-rc2 perfmon2 new code base with MIPS5K/20K support + libpfm available
Message-ID: <20060119181608.GP19622@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <1137666602.6648.80.camel@localhost.localdomain> <20060119133609.GA3398@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119133609.GA3398@linux-mips.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail:	eranian@hpl.hp.com
Return-Path: <eranian@frankl.hpl.hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 9999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eranian@hpl.hp.com
Precedence: bulk
X-list: linux-mips

Ralf,

On Thu, Jan 19, 2006 at 01:36:09PM +0000, Ralf Baechle wrote:
> > PAPI is also in the works for these systems. Feel free to give it a spin
> > and tell us where it breaks or otherwise offends you. 
> > 
> > P.S. The code should be relatively easy to extend to other members of
> > the product line...currently I've only got kernel code in for
> > 5K/20K/25K, which are nearly identical as far as the PMC goes. 
> 
> More recently myself and others have verified that Oprofile is working
> on the 5K, 20K, 24K, 25K cores and the SB1 and SB1A cores in the Sibyte
> SOCs - and a few more in the queue.  So now I wonder how perfmon2 is
> going to interfear with oprofile which already is in the kernel?
> 
On Itaniun, where perfmon was orginally designed, we have Oprofile and
perfmon2 working together. You can use Oprofile or perfmon2 native tools.

Oprofile user level tools are using the perfmon2 interface to program the
counters. But the sampling buffer format and buffer export interface remain
the same as with "native" Oprofile. As Phil mentioned, perfmon2 implements
a kernel evel sampling buffer. But the format of the buffer, i.e., what gets
recorded, how it is recorded in the buffer and how the buffer gets exported
to user is implemented by a simple kernel module called a "custom sampling
format". The core of each format is a handler function called on counter
overflow. We use this mechanism to connect the Oprofile PMU interrupt handler
to perfmon, it is just 100 lines of C and we reuse the full Oprofile sample
recording infrastructure.

There is nothing specific to Itanium is thr way Oprofile is connecte to perfmon2.
As such, I believe that we could implement the same trick on all the other
architectures supported by perfmon2. I think some people would like to try this
on i386 first. But you are certainly welcome to try this on MIPS. The Oprofile
tools are already aware of perfmon on Itanium. It may be that they need to be
made ware when compiling for i386 or MIPS.

The goal of perfmon2 is not to get rid of OProfile but to allow the two
to work side by side but avoid duplication of kernel code as much as possible.
Some people are satisfied with the functionalities of Oprofile others are not,
especially because Oprofile does not provide per-thread monitoring. The perfmon2
interface is designed to be generic and flexible, it was designed with a particular
tool or measurement in mind.

> I've put a quick page into the wiki at http://www.linux-mips.org/wiki/Perfmon2
> It's really just a starting point but people should know what's there.
> 

-- 

-Stephane
