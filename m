Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7E5JCO30459
	for linux-mips-outgoing; Mon, 13 Aug 2001 22:19:12 -0700
Received: from dea.waldorf-gmbh.de (u-197-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.197])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7E5J9j30456
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 22:19:09 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7E5HJC05632;
	Tue, 14 Aug 2001 07:17:19 +0200
Date: Tue, 14 Aug 2001 07:17:19 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Tommy S. Christensen" <tommy.christensen@eicon.com>
Cc: Barry Wu <wqb123@yahoo.com>, linux-mips@oss.sgi.com
Subject: Re: mips ide disk dma problem
Message-ID: <20010814071718.A5552@bacchus.dhis.org>
References: <20010813130729.37581.qmail@web13908.mail.yahoo.com> <3B782CB0.AA24C7C8@eicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B782CB0.AA24C7C8@eicon.com>; from tommy.christensen@eicon.com on Mon, Aug 13, 2001 at 09:38:24PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 13, 2001 at 09:38:24PM +0200, Tommy S. Christensen wrote:

> Barry Wu wrote:
> > I meet problems about mips ide disk. I find dma mode
> > is different from other platform. We have to use
> > dma_cache_wback_inv and vtonocache functions to work
> > under DMA mode, I read pcnet32 ethernet driver,
> > it works like that. I do not know if I have to support
> > ide disk dma, what I have to do?
> 
> Some MIPS'ification is needed to handle the caches.
> You can try the patch below to drivers/block/ide-dma.c.
> 
> I don't know about your IDE controller (our board have 
> a CMD PCI-648), but it may need some special handling also.

You're referencing a function that doesn't exist in the whole kernel.
Aside it's a crude hack anyway.  If you have problems with caches use
the API defined in Documentation/DMA-mapping.txt.

  Ralf
