Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 08:26:27 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:34282 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28577823AbYFLH0Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 08:26:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5C7Q5Da012575;
	Thu, 12 Jun 2008 08:26:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5C7Q551012569;
	Thu, 12 Jun 2008 08:26:05 +0100
Date:	Thu, 12 Jun 2008 08:26:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] [MIPS] fix sparse warning about
	setup_early_printk()
Message-ID: <20080612072604.GF30400@linux-mips.org>
References: <12124843631664-git-send-email-dmitri.vorobiev@movial.fi> <12124843631742-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12124843631742-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 03, 2008 at 12:12:40PM +0300, Dmitri Vorobiev wrote:
> From: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
> Date: Tue,  3 Jun 2008 12:12:40 +0300
> To: linux-mips@linux-mips.org, ralf@linux-mips.org
> Subject: [PATCH 1/5] [MIPS] fix sparse warning about setup_early_printk()
> 
> This patch fixes the following sparse warning:
> 
> <<<<<<<<
> 
> arch/mips/kernel/early_printk.c:35:13: warning: symbol 'setup_early_printk'
> was not declared. Should it be static?
> 
> <<<<<<<<
> 
> The fix is to define a prototype of the setup_early_printk() function and
> to include the appropriate header into arch/mips/kernel/early_printk.c.
> 
> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
> ---
>  arch/mips/kernel/early_printk.c |    1 +
>  arch/mips/kernel/setup.c        |    6 +-----
>  include/asm-mips/setup.h        |    2 ++
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kernel/early_printk.c b/arch/mips/kernel/early_printk.c
> index 9dccfa4..cb602c1 100644
> --- a/arch/mips/kernel/early_printk.c
> +++ b/arch/mips/kernel/early_printk.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) 2007 MIPS Technologies, Inc.
>   *   written by Ralf Baechle (ralf@linux-mips.org)
>   */
> +#include <asm/setup.h>
>  #include <linux/console.h>
>  #include <linux/init.h>

Queued for 2.6.27 with includes sorted <linux/...> first followed by
<asm/...>.

  Ralf
