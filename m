Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 18:35:35 +0000 (GMT)
Received: from bes.cs.utk.edu ([160.36.56.220]:56028 "EHLO bes.cs.utk.edu")
	by ftp.linux-mips.org with ESMTP id S3468175AbWASSfQ (ORCPT
	<rfc822;Linux-mips@linux-mips.org>); Thu, 19 Jan 2006 18:35:16 +0000
Received: from localhost (bes [127.0.0.1])
	by bes.cs.utk.edu (Postfix) with ESMTP id EDCDD273D9;
	Thu, 19 Jan 2006 13:38:59 -0500 (EST)
Received: from bes.cs.utk.edu ([127.0.0.1])
 by localhost (bes [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24651-04; Thu, 19 Jan 2006 13:38:59 -0500 (EST)
Received: from dhcp-221-85.pdc.kth.se (dhcp-221-85.pdc.kth.se [130.237.221.85])
	by bes.cs.utk.edu (Postfix) with ESMTP id 141BE273C3;
	Thu, 19 Jan 2006 13:38:57 -0500 (EST)
Subject: Re: [perfmon] Re: 2.6.13-rc2 perfmon2 new code base with
	MIPS5K/20K support + libpfm available
From:	Philip Mucci <mucci@cs.utk.edu>
To:	eranian@hpl.hp.com
Cc:	Ralf Baechle <ralf@linux-mips.org>, perfmon@napali.hpl.hp.com,
	Linux-mips@linux-mips.org
In-Reply-To: <20060119181608.GP19622@frankl.hpl.hp.com>
References: <1137666602.6648.80.camel@localhost.localdomain>
	 <20060119133609.GA3398@linux-mips.org>
	 <20060119181608.GP19622@frankl.hpl.hp.com>
Content-Type: text/plain
Organization: Innovative Computing Laboratory
Date:	Thu, 19 Jan 2006 19:38:56 +0100
Message-Id: <1137695936.6648.268.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new with ClamAV and SpamAssasin at cs.utk.edu
Return-Path: <mucci@cs.utk.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 10000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mucci@cs.utk.edu
Precedence: bulk
X-list: linux-mips

Stefane,

Are you saying that oprofile user level tools don't even use the
oprofile driver but rather just set up a system-wide IP-sampling context
for perfmon2?

Think of all the work that Ralf just did. ;-)

Phil

On Thu, 2006-01-19 at 10:16 -0800, Stephane Eranian wrote:
> Ralf,
> 
> On Thu, Jan 19, 2006 at 01:36:09PM +0000, Ralf Baechle wrote:
> > > PAPI is also in the works for these systems. Feel free to give it a spin
> > > and tell us where it breaks or otherwise offends you. 
> > > 
> > > P.S. The code should be relatively easy to extend to other members of
> > > the product line...currently I've only got kernel code in for
> > > 5K/20K/25K, which are nearly identical as far as the PMC goes. 
> > 
> > More recently myself and others have verified that Oprofile is working
> > on the 5K, 20K, 24K, 25K cores and the SB1 and SB1A cores in the Sibyte
> > SOCs - and a few more in the queue.  So now I wonder how perfmon2 is
> > going to interfear with oprofile which already is in the kernel?
> > 
> On Itaniun, where perfmon was orginally designed, we have Oprofile and
> perfmon2 working together. You can use Oprofile or perfmon2 native tools.
> 
> Oprofile user level tools are using the perfmon2 interface to program the
> counters. But the sampling buffer format and buffer export interface remain
> the same as with "native" Oprofile. As Phil mentioned, perfmon2 implements
> a kernel evel sampling buffer. But the format of the buffer, i.e., what gets
> recorded, how it is recorded in the buffer and how the buffer gets exported
> to user is implemented by a simple kernel module called a "custom sampling
> format". The core of each format is a handler function called on counter
> overflow. We use this mechanism to connect the Oprofile PMU interrupt handler
> to perfmon, it is just 100 lines of C and we reuse the full Oprofile sample
> recording infrastructure.
> 
> There is nothing specific to Itanium is thr way Oprofile is connecte to perfmon2.
> As such, I believe that we could implement the same trick on all the other
> architectures supported by perfmon2. I think some people would like to try this
> on i386 first. But you are certainly welcome to try this on MIPS. The Oprofile
> tools are already aware of perfmon on Itanium. It may be that they need to be
> made ware when compiling for i386 or MIPS.
> 
> The goal of perfmon2 is not to get rid of OProfile but to allow the two
> to work side by side but avoid duplication of kernel code as much as possible.
> Some people are satisfied with the functionalities of Oprofile others are not,
> especially because Oprofile does not provide per-thread monitoring. The perfmon2
> interface is designed to be generic and flexible, it was designed with a particular
> tool or measurement in mind.
> 
> > I've put a quick page into the wiki at http://www.linux-mips.org/wiki/Perfmon2
> > It's really just a starting point but people should know what's there.
> > 
> 
