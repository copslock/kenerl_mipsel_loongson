Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7E8Bhg02100
	for linux-mips-outgoing; Tue, 14 Aug 2001 01:11:43 -0700
Received: from firewall.i-data.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7E8Bej02078
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 01:11:41 -0700
Received: (qmail 13342 invoked from network); 14 Aug 2001 08:11:39 -0000
Received: from idahub2000.i-data.com (HELO idanshub) (172.16.1.8)
  by firewall.i-data.com with SMTP; 14 Aug 2001 08:11:39 -0000
Received: from eicon.com ([172.17.159.1])
          by idanshub (Lotus Domino Release 5.0.8)
          with ESMTP id 2001081410140571:4761 ;
          Tue, 14 Aug 2001 10:14:05 +0200 
Message-ID: <3B78DD81.39D4A69B@eicon.com>
Date: Tue, 14 Aug 2001 10:12:49 +0200
From: "Tommy S. Christensen" <tommy.christensen@eicon.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Barry Wu <wqb123@yahoo.com>, linux-mips@oss.sgi.com
Subject: Re: mips ide disk dma problem
References: <20010813130729.37581.qmail@web13908.mail.yahoo.com> <3B782CB0.AA24C7C8@eicon.com> <20010814071718.A5552@bacchus.dhis.org>
X-MIMETrack: Itemize by SMTP Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 14-08-2001 10:14:05,
	Serialize by Router on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at 14-08-2001
 10:14:06,
	Serialize complete at 14-08-2001 10:14:06
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Mon, Aug 13, 2001 at 09:38:24PM +0200, Tommy S. Christensen wrote:
> 
> > Barry Wu wrote:
> > > I meet problems about mips ide disk. I find dma mode
> > > is different from other platform. We have to use
> > > dma_cache_wback_inv and vtonocache functions to work
> > > under DMA mode, I read pcnet32 ethernet driver,
> > > it works like that. I do not know if I have to support
> > > ide disk dma, what I have to do?
> >
> > Some MIPS'ification is needed to handle the caches.
> > You can try the patch below to drivers/block/ide-dma.c.
> >
> > I don't know about your IDE controller (our board have
> > a CMD PCI-648), but it may need some special handling also.
> 
> You're referencing a function that doesn't exist in the whole kernel.

vtonocache(p) is defined as KSEG1ADDR(virt_to_phys(p)).
This is for linux-2.2.12 from MIPS, remember.

> Aside it's a crude hack anyway.  If you have problems with caches use
> the API defined in Documentation/DMA-mapping.txt.

I don't see why this is a hack. Sure, the Dynamic DMA
interface is a lot cleaner, but it ends up with more or
less the same.

-Tommy
