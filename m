Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 19:04:39 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:34968 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038469AbXBFTEc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 19:04:32 +0000
Received: (qmail 16181 invoked by uid 101); 6 Feb 2007 19:03:15 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 6 Feb 2007 19:03:15 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l16J3Eu9004447;
	Tue, 6 Feb 2007 11:03:14 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <1CC7QRAW>; Tue, 6 Feb 2007 11:03:14 -0800
Message-ID: <45C8D0EC.2060007@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	linux-mips@linux-mips.org
Subject: Re: Embedding rootfs with kernel
Date:	Tue, 6 Feb 2007 11:03:08 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 06 Feb 2007 19:03:09.0088 (UTC) FILETIME=[70D74200:01C74A21]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Alexander Voropay wrote:
> 
> 
>  >I was also looking at initramfs but from documentation I found it,
>  > appears to expand the cpio.gz into a tmpfs (i.e. RAM) before using
>  > it.
> 
>  Read this nice article:
> http://www.linuxdevices.com/articles/AT4017834659.html
> 

Thanks Alexander, I'd read it many months ago, it does clarifies a few
issues. Another article on various methods of preparing the initramfs is:
"Including an initramfs Intialization Program in the Kernel"
http://lldn.timesys.com/docs/initramfs?elq=1EE1D775A62A4EF68F0A3E9AEC666D0D

Neither of these seem to help with regards to embedding a read-only
file system. It seems like there is no officially supported way of doing
this. Presumably these types of file systems are meant to only be used
separate from the kernel image, such as in a flash partition.

I guess we can continue to use our current method, but I was hoping
to eliminate any changes to non-platform code such as vmlinux.lds.S.

Marc
