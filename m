Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 17:50:01 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:44681 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225239AbVBDRtq>; Fri, 4 Feb 2005 17:49:46 +0000
Received: from gw.junsun.net (c-24-6-106-170.client.comcast.net[24.6.106.170])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20050204174937015009n299e>; Fri, 4 Feb 2005 17:49:37 +0000
Received: from gw.junsun.net (gw.junsun.net [127.0.0.1])
	by gw.junsun.net (8.13.1/8.13.1) with ESMTP id j14HnVkk000944;
	Fri, 4 Feb 2005 09:49:32 -0800
Received: (from jsun@localhost)
	by gw.junsun.net (8.13.1/8.13.1/Submit) id j14HnRYl000943;
	Fri, 4 Feb 2005 09:49:27 -0800
Date:	Fri, 4 Feb 2005 09:49:27 -0800
From:	Jun Sun <jsun@junsun.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Dominic Sweetman <dom@mips.com>, Nigel Stephens <nigel@mips.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: c-r4k.c cleanup
Message-ID: <20050204174927.GD30430@gw.junsun.net>
References: <20050204.231254.74753794.anemo@mba.ocn.ne.jp> <4203890B.5030305@mips.com> <20050204145803.GA5618@linux-mips.org> <16899.37525.412441.558873@gargle.gargle.HOWL> <20050204154532.GA22217@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204154532.GA22217@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips

On Fri, Feb 04, 2005 at 04:45:32PM +0100, Ralf Baechle wrote:
> On Fri, Feb 04, 2005 at 03:19:49PM +0000, Dominic Sweetman wrote:
> 
> > Only some CPUs suffer from aliases.  A 4Kbyte direct-mapped cache must
> > be alias free, because all the virtual index bits are the same (being
> > in-page) as the physical address bits.  That's true but irrelvant,
> > since there aren't any 4Kbyte caches: but what's slightly less obvious
> > is that a 16Kbyte 4-way set-associative cache is also alias free.
> 
> I had dark memory of some el cheapo CPU having 4k caches.
> 

IDT (rc32332) has a 2K d-cache. :)

Jun
