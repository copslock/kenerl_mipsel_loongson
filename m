Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 22:38:23 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:38935 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S28578787AbYCUWiV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 22:38:21 +0000
Received: from SNaIlmail.Peter (85.233.32.210.static.cablesurf.de [85.233.32.210])
	by mail1.pearl-online.net (Postfix) with ESMTP id 34794CCE5;
	Fri, 21 Mar 2008 23:38:16 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id m2L23vfM001487;
	Fri, 21 Mar 2008 03:03:57 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id m2LMSxFS000587;
	Fri, 21 Mar 2008 23:28:59 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id m2LMSxRu000584;
	Fri, 21 Mar 2008 23:28:59 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Fri, 21 Mar 2008 23:28:59 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] WD33C93: let platform stub override no_sync/fast/dma_mode
In-Reply-To: <Pine.LNX.4.58.0803212302190.564@Indigo2.Peter>
Message-ID: <Pine.LNX.4.58.0803212327070.580@Indigo2.Peter>
References: <20080321212543.6F769C2DF8@solo.franken.de>
 <Pine.LNX.4.58.0803212302190.564@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Oops, forget it, i just missed the change in wd33c93.c, sorry.


kind regrads

peter


On Fri, 21 Mar 2008, peter fuerst wrote:

> Date: Fri, 21 Mar 2008 23:20:07 +0100 (CET)
> From: peter fuerst <post@pfrst.de>
> To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
>      ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
> Subject: Re: [PATCH] WD33C93: let platform stub override
>     no_sync/fast/dma_mode
>
>
> Hi Thomas,
>
> the code-sequence
> ...
