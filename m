Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 14:29:13 +0100 (BST)
Received: from web11301.mail.yahoo.com ([IPv6:::ffff:216.136.131.204]:1678
	"HELO web11301.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225737AbUDWN3L>; Fri, 23 Apr 2004 14:29:11 +0100
Message-ID: <20040423132901.97621.qmail@web11301.mail.yahoo.com>
Received: from [66.93.100.212] by web11301.mail.yahoo.com via HTTP; Fri, 23 Apr 2004 06:29:01 PDT
Date: Fri, 23 Apr 2004 06:29:01 -0700 (PDT)
From: Alex Deucher <agd5f@yahoo.com>
Subject: Re: few questions about linux on sgi machines
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040423131706.GA27375@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <agd5f@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agd5f@yahoo.com
Precedence: bulk
X-list: linux-mips


--- Christoph Hellwig <hch@lst.de> wrote:
> On Thu, Apr 22, 2004 at 10:49:16AM -0700, Alex Deucher wrote:
> > What about the PCI slots on o200?  Are they supported?
> 
> There's is PCI support but there's some problems, mosty because the
> Linux support code isn't as nice as it should and we support only
> glogic fibre channels and scsi cards and the SGI ioc3 currently.
> 
> Fixing that is in-progress but even then you could have problems with
> most standard linux drivers because the pci hardware on all systems
> using the bridge ASIC and it's sucessors (xbridge, pic) violate some
> ordering contraints in the PCI spec.  The SGI folks doing the SN1/SN2
> IA64 port have come up with workaround for xbride and pic but I'm not
> sure they're applicable to IP27.

I assume IP30 has the same problems since they are similarly
architected?  What about IP32?

Thanks,

Alex



	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
