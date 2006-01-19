Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 13:38:57 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:49179 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134388AbWASNij (ORCPT <rfc822;Linux-mips@linux-mips.org>);
	Thu, 19 Jan 2006 13:38:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0JDaAtt005399;
	Thu, 19 Jan 2006 13:36:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0JDa9jl005398;
	Thu, 19 Jan 2006 13:36:09 GMT
Date:	Thu, 19 Jan 2006 13:36:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Philip Mucci <mucci@cs.utk.edu>
Cc:	Linux-mips@linux-mips.org, perfmon@napali.hpl.hp.com,
	Stephane Eranian <eranian@hpl.hp.com>
Subject: Re: 2.6.13-rc2 perfmon2 new code base with MIPS5K/20K support + libpfm available
Message-ID: <20060119133609.GA3398@linux-mips.org>
References: <1137666602.6648.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137666602.6648.80.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;Linux-mips@linux-mips.org
Original-Recipient: rfc822;Linux-mips@linux-mips.org
X-archive-position: 9983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 19, 2006 at 11:30:02AM +0100, Philip Mucci wrote:

> Below is an announcement of the kernel perfmon/libpfm support and user
> library for hardware performance monitoring on MIPS (and other
> platforms). This support mirrors that which has been available on IA64
> for quite some time and is an effort by Stefane Eranian, David Gibson
> myself and others to establish a fully functional kernel substrate for
> hardware performance analysis. This is based on a large body of
> work/experience with PM kernel support both on Linux and many other
> systems.
> 
> Note that the MIPS support is based on a 2.6.13-rc2 snapshot of the LM
> code base, soon to be updated to 2.6.15. If you want to patch against
> the head, you'll probably have to fix up the syscall numbers.
> 
> I have tested the code on a 20K system + 64bit kernel (that has 1 entire
> PMC register) and soon will be testing on a 5K system when it comes back
> from being serviced. n32/n64 ABI's have not yet been tested but support
> is there.
> 
> PAPI is also in the works for these systems. Feel free to give it a spin
> and tell us where it breaks or otherwise offends you. 
> 
> Regards,
> 
> Philip
> 
> P.S. The code should be relatively easy to extend to other members of
> the product line...currently I've only got kernel code in for
> 5K/20K/25K, which are nearly identical as far as the PMC goes. 

More recently myself and others have verified that Oprofile is working
on the 5K, 20K, 24K, 25K cores and the SB1 and SB1A cores in the Sibyte
SOCs - and a few more in the queue.  So now I wonder how perfmon2 is
going to interfear with oprofile which already is in the kernel?

I've put a quick page into the wiki at http://www.linux-mips.org/wiki/Perfmon2
It's really just a starting point but people should know what's there.

  Ralf
