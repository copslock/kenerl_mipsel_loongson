Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2011 16:10:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59972 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S2100780Ab1C2OKp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2011 16:10:45 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p2TEAixX019473;
        Tue, 29 Mar 2011 16:10:44 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p2TEAia5019472;
        Tue, 29 Mar 2011 16:10:44 +0200
Date:   Tue, 29 Mar 2011 16:10:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yoichi Yuasa <yuasa@linux-mips.org>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: msp71xx: fix msp_time build error
Message-ID: <20110329141044.GA13538@linux-mips.org>
References: <20110329155223.08fbef97.yuasa@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110329155223.08fbef97.yuasa@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 29, 2011 at 03:52:23PM +0900, Yoichi Yuasa wrote:

> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
> index 8b42f30..9e58c3d 100644
> --- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
> @@ -28,10 +28,11 @@
>  #include <linux/spinlock.h>
>  #include <linux/module.h>
>  #include <linux/ptrace.h>
> +#include <linux/clockchips.h>
>  
> +#include <asm/time.h>
>  #include <asm/cevt-r4k.h>
>  #include <asm/mipsregs.h>
> -#include <asm/time.h>
>  
>  #include <msp_prom.h>
>  #include <msp_int.h>

I went for a different patch.  Thanks Yoichi-San!

  Ralf
