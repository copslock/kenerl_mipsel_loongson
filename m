Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2008 14:07:35 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53739 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S29049567AbYI3NH2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2008 14:07:28 +0100
Received: from localhost (p6058-ipad310funabasi.chiba.ocn.ne.jp [123.217.208.58])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 088D3AF60; Tue, 30 Sep 2008 22:07:21 +0900 (JST)
Date:	Tue, 30 Sep 2008 22:07:22 +0900 (JST)
Message-Id: <20080930.220722.72708027.anemo@mba.ocn.ne.jp>
To:	htejun@gmail.com
Cc:	bzolnier@gmail.com, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org, jens.axboe@oracle.com,
	James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48DEAF1F.8040200@gmail.com>
References: <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
	<200809271819.19510.bzolnier@gmail.com>
	<48DEAF1F.8040200@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 28 Sep 2008 07:09:35 +0900, Tejun Heo <htejun@gmail.com> wrote:
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

I suppose you mean thread http://lkml.org/lkml/2006/1/13/156.

IIUC flushing in ide string ops is still needed for MIPS.

---
Atsushi Nemoto
