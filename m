Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 18:07:00 +0200 (CEST)
Received: from p508B4F39.dip.t-dialin.net ([80.139.79.57]:18912 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123926AbSJWQG7>; Wed, 23 Oct 2002 18:06:59 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g9NG6nK32511;
	Wed, 23 Oct 2002 18:06:49 +0200
Date: Wed, 23 Oct 2002 18:06:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: =?iso-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@stepmind.com>
Cc: linux-mips@linux-mips.org
Subject: Re: {swapper:1] illegal instruction at ...
Message-ID: <20021023180649.C27187@linux-mips.org>
References: <20021022114557.26269.qmail@webmail22.rediffmail.com> <3DB53D09.9010503@stepmind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB53D09.9010503@stepmind.com>; from vincent.stehle@stepmind.com on Tue, Oct 22, 2002 at 01:56:57PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 22, 2002 at 01:56:57PM +0200, Vincent Stehlé wrote:

> > after this when I boot i get so many repeated messages like..
> > 
> > [swapper:1] Illegal instruction d0c62bd0 at 800f7c6c ra=
> > 800f4860
> > [swapper:1] Illegal instruction 0031c78 at 800f5b5c at ra=8002d954
> [..]
> > can somebody suggest me something..

Just a few items to check:

 - memory hw problem
 - memory controller configuration
 - caches not properly flushed
 - memory corruption

> As it seems your problem has something to do with the swapper, are you 
> also trying to swap over nfs ? I think you need patches for that:
> 
>    http://www.instmath.rwth-aachen.de/~heine/nfs-swap/nfs-swap.html

Those patches are broken.  If you're using those patches, don't even
expect to dream about things working ...

  Ralf
