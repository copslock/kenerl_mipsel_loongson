Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 17:57:37 +0200 (CEST)
Received: from relay3.sgi.com ([192.48.152.1]:55876 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491921Ab1F0P5a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jun 2011 17:57:30 +0200
Received: from pkunk.americas.sgi.com (pkunk.americas.sgi.com [128.162.232.31])
        by relay3.corp.sgi.com (Postfix) with ESMTP id 55C0AAC006;
        Mon, 27 Jun 2011 08:57:22 -0700 (PDT)
Date:   Mon, 27 Jun 2011 10:57:21 -0500 (CDT)
From:   Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 11/12] MISC: IOC4: Fix section mismatch / race
 condition.
In-Reply-To: <2ecba7369d1ac0d7b1ab08ccce65f240719f99c8.1309182743.git.ralf@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1106271056200.28116@pkunk.americas.sgi.com>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org> <2ecba7369d1ac0d7b1ab08ccce65f240719f99c8.1309182743.git.ralf@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Organization: "Silicon Graphics, Inc."
Importance: normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 30533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bcasavan@sgi.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22008

On Mon, 27 Jun 2011, Ralf Baechle wrote:

> WARNING: drivers/misc/ioc4.o(.data+0x144): Section mismatch in reference from the variable ioc4_load_modules_work to the function .devinit.text:ioc4_load_modules()
> The variable ioc4_load_modules_work references
> the function __devinit ioc4_load_modules()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *driver, *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> This one is potencially fatal; by the time ioc4_load_modules is invoked
> it may already have been freed.  For that reason ioc4_load_modules_work
> can't be turned to __devinitdata but also because it's referenced in
> ioc4_exit.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> To: Brent Casavant <bcasavan@sgi.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>  drivers/misc/ioc4.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/misc/ioc4.c b/drivers/misc/ioc4.c
> index 668d41e..df03dd3 100644
> --- a/drivers/misc/ioc4.c
> +++ b/drivers/misc/ioc4.c
> @@ -270,7 +270,7 @@ ioc4_variant(struct ioc4_driver_data *idd)
>  	return IOC4_VARIANT_PCI_RT;
>  }
>  
> -static void __devinit
> +static void
>  ioc4_load_modules(struct work_struct *work)
>  {
>  	request_module("sgiioc4");
> -- 
> 1.7.4.4
> 

Acked-by: Brent Casavant <bcasavan@sgi.com>

-- 
Brent Casavant
Silicon Graphics International
