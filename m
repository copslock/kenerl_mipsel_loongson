Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 18:41:45 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43777 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904133Ab1KDRll (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Nov 2011 18:41:41 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA4Hfev9019224;
        Fri, 4 Nov 2011 17:41:40 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA4Hfebk019222;
        Fri, 4 Nov 2011 17:41:40 GMT
Date:   Fri, 4 Nov 2011 17:41:40 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: AR7: constify some arrays in gpio and prom code
Message-ID: <20111104174140.GA18965@linux-mips.org>
References: <1320427535-24351-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320427535-24351-1-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3849

On Fri, Nov 04, 2011 at 06:25:35PM +0100, Florian Fainelli wrote:

> diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
> index 8088c6f..f642f64 100644
> --- a/arch/mips/ar7/prom.c
> +++ b/arch/mips/ar7/prom.c
> @@ -69,7 +69,7 @@ struct psbl_rec {
>  	u32	ffs_size;
>  };
>  
> -static __initdata char psp_env_version[] = "TIENV0.8";
> +static __initdata const char psp_env_version[] = "TIENV0.8";

Should be:

static const char psp_env_version[] __initconst = "TIENV0.8";

so psp_env_version actually ends up in a read-only section.

  Ralf
