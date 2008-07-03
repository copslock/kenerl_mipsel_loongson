Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 16:23:52 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:1959 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20132516AbYGCPXq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Jul 2008 16:23:46 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m63FMjHR024510;
	Thu, 3 Jul 2008 17:23:10 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m63FMjG9024509;
	Thu, 3 Jul 2008 16:22:45 +0100
Date:	Thu, 3 Jul 2008 16:22:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/5] [MIPS] A few cleanups in malta_int.c
Message-ID: <20080703152245.GB11434@linux-mips.org>
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi> <1213773503-23536-4-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1213773503-23536-4-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 18, 2008 at 10:18:21AM +0300, Dmitri Vorobiev wrote:

> Both the fill_ipi_map() routine and the gic_intr_map array defined
> in arch/mips/mips-boards/malta/malta_int.c are not used outside of
> the latter file. Thus, these objects can become static. Moreover,
> these two objects are used by the MT code only, which is why this
> patch adds the appropriate ifdef.
> 
> While at it, this patch removes an unnecessary preprocessing macro
> in favor of the commonly used ARRAY_SIZE.
> 
> Successfully tested using a Qemu-emulated Malta board for both SMP
> and UP kernels.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>

Queued for 2.6.27 after fixing a reject.  Thanks,

  Ralf
