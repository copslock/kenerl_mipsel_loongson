Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 17:01:15 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:38639 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038432AbXBFRBK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 17:01:10 +0000
Received: (qmail 6768 invoked by uid 101); 6 Feb 2007 17:00:02 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by mother.pmc-sierra.com with SMTP; 6 Feb 2007 17:00:02 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l16H009Z025406;
	Tue, 6 Feb 2007 09:00:02 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <1CC7QLV8>; Tue, 6 Feb 2007 08:59:59 -0800
Message-ID: <45C8B408.4050203@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Domen Puncer <domen.puncer@telargo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Embedding rootfs with kernel
Date:	Tue, 6 Feb 2007 08:59:53 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 06 Feb 2007 16:59:53.0268 (UTC) FILETIME=[3896AF40:01C74A10]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

I was also looking at initramfs but from documentation I found it,
appears to expand the cpio.gz into a tmpfs (i.e. RAM) before using
it.

Since the cpio.gz is embedded into the kernel (i.e. RAM again),
won't this take twice the memory relative to embedding a
cramfs/squashfs directly in the kernel?

We only need read-only access and I believe these file systems
can be read in their compressed form without expanding and
consuming more RAM.

Marc


Domen Puncer wrote:
> On 05/02/07 12:41 -0800, Marc St-Jean wrote:
>  > What is the MIPS-way of embedding the rootfs with the kernel?
> 
> For 2.6.x (on all? architectures) initramfs.
> 
> 
>         Domen
> 
