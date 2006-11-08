Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2006 19:51:32 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:50396 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039625AbWKHTv1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Nov 2006 19:51:27 +0000
Received: (qmail 27195 invoked by uid 101); 8 Nov 2006 19:51:15 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by father.pmc-sierra.com with SMTP; 8 Nov 2006 19:51:15 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id kA8JpEkZ017838;
	Wed, 8 Nov 2006 11:51:14 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <VY7R9BZT>; Wed, 8 Nov 2006 11:51:14 -0800
Message-ID: <E8C8A5231DDE104C816ADF532E0639120194F4C8@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>
Cc:	"'Atsushi Nemoto'" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: RE: Problems booting Linux 2.6.18.1 on MIPS34K core
Date:	Wed, 8 Nov 2006 11:51:08 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Trevor_Hamm@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Trevor_Hamm@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

 

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Sent: Wednesday, November 08, 2006 1:24 PM
> To: Trevor Hamm
> Cc: 'Atsushi Nemoto'; linux-mips@linux-mips.org
> Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
> 
> On Wed, Nov 08, 2006 at 11:09:37AM -0800, Trevor Hamm wrote:
> 
> > So just for fun, I built a linux image to use a 
> write-through caching policy, and it boots from power-up every time.
> > 
> > With this information, I would conclude the problem is due 
> to cache management, either in the way we're initializing the 
> cache, or something else in the squashfs code.  Or is there 
> another explanation that I'm overlooking?
> 
> Does your processor have cache aliases?
> 
>   Ralf
> 

Yes, we've got 64kB, 4-way caches using 4kB page size.

Trevor
