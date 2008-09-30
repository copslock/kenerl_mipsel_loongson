Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2008 16:10:27 +0100 (BST)
Received: from accolon.hansenpartnership.com ([76.243.235.52]:32954 "EHLO
	accolon.hansenpartnership.com") by ftp.linux-mips.org with ESMTP
	id S29565680AbYI3PKZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Sep 2008 16:10:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 459C2856E;
	Tue, 30 Sep 2008 10:10:16 -0500 (CDT)
Received: from accolon.hansenpartnership.com ([127.0.0.1])
	by localhost (redscar.int.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qye3tjrpgSBZ; Tue, 30 Sep 2008 10:10:14 -0500 (CDT)
Received: from [153.66.150.222] (mulgrave-w.int.hansenpartnership.com [153.66.150.222])
	by accolon.hansenpartnership.com (Postfix) with ESMTP id 1217F8048;
	Tue, 30 Sep 2008 10:10:14 -0500 (CDT)
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	James Bottomley <James.Bottomley@HansenPartnership.com>
To:	Tejun Heo <htejun@gmail.com>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org, Jens Axboe <jens.axboe@oracle.com>
In-Reply-To: <48DEAF1F.8040200@gmail.com>
References: <48C851ED.4090607@ru.mvista.com>
	 <48CA8BEE.1090305@ru.mvista.com>
	 <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
	 <200809271819.19510.bzolnier@gmail.com>  <48DEAF1F.8040200@gmail.com>
Content-Type: text/plain
Date:	Tue, 30 Sep 2008 10:09:47 -0500
Message-Id: <1222787387.3232.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Sun, 2008-09-28 at 07:09 +0900, Tejun Heo wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Friday 12 September 2008, Atsushi Nemoto wrote:
> >> On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > 
> > [...]
> > 
> >>>>>> +	__ide_flush_dcache_range((unsigned long)addr, size);
> >>>>>   Why is this needed BTW?
> >>>> Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> >>>> inconsistency on PIO drive.  PIO transfer only writes to cache but
> >>>> upper layers expects the data is in main memory.
> >>>     Hum, then I wonder why it's MIPS specific...
> >> SPARC also have it.  And there were some discussions for ARM IIRC.
> > 
> > I was under the impression that it has been addressed by Tejun at
> > the higher-layer level (for both ide/libata) long time ago and that
> > MIPS/SPARC code are just a left-overs which could be removed now?
> 
> cc'ing Jens and James.  IIRC, I posted several patches but they never
> went in.  I don't remember what the objections were or whether any
> alternative fix went in.

Which patches were these?  We have several methods of doing PIO
fallback, the most common one being
scatterlist.c:sg_copy_from/to_buffer() which does the cache coherency.

James


> Thanks.
> 
