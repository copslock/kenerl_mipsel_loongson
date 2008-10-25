Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2008 15:28:01 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:18312 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22362499AbYJYO1w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Oct 2008 15:27:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9PERp3w004049;
	Sat, 25 Oct 2008 15:27:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9PERiKH004047;
	Sat, 25 Oct 2008 15:27:44 +0100
Date:	Sat, 25 Oct 2008 15:27:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MIPS] IP22: Small cleanups
Message-ID: <20081025142740.GB1827@linux-mips.org>
References: <1224888417-26494-1-git-send-email-dmitri.vorobiev@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1224888417-26494-1-git-send-email-dmitri.vorobiev@movial.fi>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 25, 2008 at 01:46:56AM +0300, Dmitri Vorobiev wrote:

> diff --git a/arch/mips/sgi-ip22/ip22-int.c b/arch/mips/sgi-ip22/ip22-int.c
> index f6d9bf4..5b9b4f3 100644
> --- a/arch/mips/sgi-ip22/ip22-int.c
> +++ b/arch/mips/sgi-ip22/ip22-int.c
> @@ -16,6 +16,7 @@
>  #include <linux/sched.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/time.h>
>  
>  #include <asm/mipsregs.h>
>  #include <asm/addrspace.h>
> @@ -23,7 +24,6 @@
>  #include <asm/sgi/ioc.h>
>  #include <asm/sgi/hpc3.h>
>  #include <asm/sgi/ip22.h>
> -#include <asm/time.h>

<linux/time.h> does not include <asm/time.h>.  This sort of stuff happens
if you believe checkpatch.pl.  You only got away because the header isn't
needed anyway.  I'll apply the patch with this bit dropped.

  Ralf

PS: Suspicion breeds confidence.  At least in case of checkpatch ;-)
