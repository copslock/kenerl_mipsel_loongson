Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 00:39:03 +0200 (CEST)
Received: from p508B5F13.dip.t-dialin.net ([80.139.95.19]:40330 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122978AbSIBWjC>; Tue, 3 Sep 2002 00:39:02 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g82Mcvv26766
	for linux-mips@linux-mips.org; Tue, 3 Sep 2002 00:38:57 +0200
Resent-Message-Id: <200209022238.g82Mcvv26766@dea.linux-mips.net>
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g82MZqV26722;
	Tue, 3 Sep 2002 00:35:52 +0200
Date: Tue, 3 Sep 2002 00:35:52 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
Cc: Brian Murphy <brm@murphy.dk>, linux-mips@oss.sgi.com
Subject: Re: [PATCH 2.5] R5000 secondary cache support
Message-ID: <20020903003552.L15618@linux-mips.org>
References: <3D5964EF.7040503@murphy.dk> <Pine.LNX.4.21.0208262136090.485-100000@melkor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0208262136090.485-100000@melkor>; from vivien.chappelier@enst-bretagne.fr on Mon, Aug 26, 2002 at 09:49:37PM +0200
Resent-From: ralf@linux-mips.org
Resent-Date: Tue, 3 Sep 2002 00:38:57 +0200
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 26, 2002 at 09:49:37PM +0200, Vivien Chappelier wrote:

> 	I've tested and updated Brian Murphy's R5K SC patch to the 2.5
> kernel. I've also changed a few comments, changed Page_Invalidate
> operation to R5K_Page_Invalidate_S to be consistent with the naming of R4K
> cache ops, and simplified the r5k_dma_cache_inv_sc routine (no need for
> two 'while'). And I've also removed the extra crap for in config-shared.in
> in Brian's latest diff (removing spaces/formating) :)
> 
> 	I've also tested this patch at runtime, it runs fine (as far as
> a 2.5.8 can run fine :)). This patch is for both 2.5.8/mips64 and
> 2.5.8/mips.
> 
> Please comment and/or apply,

Mostly ok.  I just don't like that you force CONFIG_BOARD_SCACHE on
everybody with a R5000 or Nevada.  Cobalt Qube 1 for example has a Nevada
which never has a second level cache, whatever type.   So if you could
fix that eventually :-)

  Ralf
