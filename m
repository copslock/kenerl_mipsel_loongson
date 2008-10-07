Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2008 13:10:14 +0100 (BST)
Received: from pasmtpa.tele.dk ([80.160.77.114]:3797 "EHLO pasmtpA.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20821136AbYJGMKG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2008 13:10:06 +0100
Received: from kernel.dk (brick.kernel.dk [93.163.65.50])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 43B188006EA;
	Tue,  7 Oct 2008 14:10:03 +0200 (CEST)
Received: by kernel.dk (Postfix, from userid 500)
	id B705C257BC0; Tue,  7 Oct 2008 14:09:35 +0200 (CEST)
Date:	Tue, 7 Oct 2008 14:09:35 +0200
From:	Jens Axboe <jens.axboe@oracle.com>
To:	Tejun Heo <htejun@gmail.com>
Cc:	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Message-ID: <20081007120935.GX19428@kernel.dk>
References: <48C851ED.4090607@ru.mvista.com> <48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp> <200809271819.19510.bzolnier@gmail.com> <48DEAF1F.8040200@gmail.com> <1222787387.3232.26.camel@localhost.localdomain> <48E6DB55.2050800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48E6DB55.2050800@gmail.com>
Return-Path: <axboe@kernel.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jens.axboe@oracle.com
Precedence: bulk
X-list: linux-mips

On Sat, Oct 04 2008, Tejun Heo wrote:
> James Bottomley wrote:
> > On Sun, 2008-09-28 at 07:09 +0900, Tejun Heo wrote:
> >> Bartlomiej Zolnierkiewicz wrote:
> >>> On Friday 12 September 2008, Atsushi Nemoto wrote:
> >>>> On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> >>> [...]
> >>>
> >>>>>>>> +	__ide_flush_dcache_range((unsigned long)addr, size);
> >>>>>>>   Why is this needed BTW?
> >>>>>> Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> >>>>>> inconsistency on PIO drive.  PIO transfer only writes to cache but
> >>>>>> upper layers expects the data is in main memory.
> >>>>>     Hum, then I wonder why it's MIPS specific...
> >>>> SPARC also have it.  And there were some discussions for ARM IIRC.
> >>> I was under the impression that it has been addressed by Tejun at
> >>> the higher-layer level (for both ide/libata) long time ago and that
> >>> MIPS/SPARC code are just a left-overs which could be removed now?
> >> cc'ing Jens and James.  IIRC, I posted several patches but they never
> >> went in.  I don't remember what the objections were or whether any
> >> alternative fix went in.
> > 
> > Which patches were these?  We have several methods of doing PIO
> > fallback, the most common one being
> > scatterlist.c:sg_copy_from/to_buffer() which does the cache coherency.
> 
> The thread Atsushi found seems to be the correct one.
> 
>   http://lkml.org/lkml/2006/1/13/156
> 
> Thanks.

I agreed to them last time... Shall we get this merged up?

-- 
Jens Axboe
