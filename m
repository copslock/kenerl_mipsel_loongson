Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 17:17:29 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:45238 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225384AbTLIRR2>; Tue, 9 Dec 2003 17:17:28 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc13) with SMTP
          id <2003120917172001500bt5tne>
          (Authid: kumba12345);
          Tue, 9 Dec 2003 17:17:21 +0000
Message-ID: <3FD603B5.9050006@gentoo.org>
Date: Tue, 09 Dec 2003 12:17:41 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
References: <3FD5FE41.8040909@bitbox.co.uk>
In-Reply-To: <3FD5FE41.8040909@bitbox.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Peter Horton wrote:

> Hi.
> 
> Has anyone got a 2.4.23 kernel running on the Cobalt Qube 2 ?
> 
> I've cross compiled the latest kernel from CVS (using the default Cobalt 
> config in the tree) on a PC using gcc 2.95.4 and binutils 2.12.90.0.1 
> (both from Debian sources).
> 
> The kernel boots okay from the HD, but I get strange segmentation faults 
> and other errors whilst running Debian's "dpkg" to install packages. If 
> I repeat the installation from scratch I get exactly the same errors in 
> exactly the same places :-(
> 
> I've changed both the memory SIMMs for new ones and the problem is still 
> the same. I've done the same Debian install on an Au1100 board with no 
> problems at all.
> 
> Neither of the on-board ethernet ports work correctly with new kernel 
> either. The primary port seems to work fine pinging single packets back 
> and forth, but seems to stall for periods of approx 20 seconds when 
> performing bulk transfers. I've been using an RTL8139 card in the PCI 
> slot for network access.
> 
> TIA,
> 
>    P.

	I've got a RaQ2 with which I tinker with every so often.  I recently 
tried one of the 2.4.23 rc* kernels, and gave up after the network 
issues stung me.  It's surprising you get ~20sec stalls with the onboard 
tulip driver.  On my RaQ2, I get a virtual freeze, with very small 
amounts of data slowly leaking in at about I dunno, 5 bits per sec. 
What triggers it, I'm not sure of.

	My current theory is the problem is either in the tulip driver, or the 
network system that only surfaces with cobalt machines.  But beyond 
that, I haven't managed to further isolate the problem.  Other than that 
annoying network issue, the kernel seems to run fine for me, aside from 
having to strip virtually everything out to make the kernel's size just 
right.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
