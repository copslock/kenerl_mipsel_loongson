Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7ECgiE08025
	for linux-mips-outgoing; Tue, 14 Aug 2001 05:42:44 -0700
Received: from dea.waldorf-gmbh.de (u-244-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.244])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7ECgfj08022
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 05:42:42 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7E93oK06622;
	Tue, 14 Aug 2001 11:03:50 +0200
Date: Tue, 14 Aug 2001 11:03:50 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Tommy S. Christensen" <tommy.christensen@eicon.com>
Cc: Barry Wu <wqb123@yahoo.com>, linux-mips@oss.sgi.com
Subject: Re: mips ide disk dma problem
Message-ID: <20010814110350.A6592@bacchus.dhis.org>
References: <20010813130729.37581.qmail@web13908.mail.yahoo.com> <3B782CB0.AA24C7C8@eicon.com> <20010814071718.A5552@bacchus.dhis.org> <3B78DD81.39D4A69B@eicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B78DD81.39D4A69B@eicon.com>; from tommy.christensen@eicon.com on Tue, Aug 14, 2001 at 10:12:49AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 14, 2001 at 10:12:49AM +0200, Tommy S. Christensen wrote:

> vtonocache(p) is defined as KSEG1ADDR(virt_to_phys(p)).
> This is for linux-2.2.12 from MIPS, remember.
> 
> > Aside it's a crude hack anyway.  If you have problems with caches use
> > the API defined in Documentation/DMA-mapping.txt.
> 
> I don't see why this is a hack. Sure, the Dynamic DMA
> interface is a lot cleaner, but it ends up with more or
> less the same.

Less.  It's a non-portable construct which for example will fail on any
machine that uses some sort of DMA address translation.  And would you
expect the maintainers to accept such a bunch of #ifdefs?

  Ralf
