Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 20:03:17 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35009 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492538Ab0CITDN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 9 Mar 2010 20:03:13 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o29J3BBV001099;
        Tue, 9 Mar 2010 20:03:11 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o29J3942001096;
        Tue, 9 Mar 2010 20:03:09 +0100
Date:   Tue, 9 Mar 2010 20:03:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Yang Shi <yang.shi@windriver.com>
Cc:     ddaney@caviumnetworks.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Fix wrong variable type in smp.c
Message-ID: <20100309190309.GA301@linux-mips.org>
References: <1268115862-25976-1-git-send-email-yang.shi@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268115862-25976-1-git-send-email-yang.shi@windriver.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 09, 2010 at 02:24:22PM +0800, Yang Shi wrote:

> Change cvmx_ciu_wdogx_t type to "union cvmx_ciu_wdogx".
> 
> Signed-off-by: Yang Shi <yang.shi@windriver.com>
> ---
>  arch/mips/cavium-octeon/smp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 51e9802..52d61ba 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -281,7 +281,7 @@ static void octeon_cpu_die(unsigned int cpu)
>  
>  #ifdef CONFIG_CAVIUM_OCTEON_WATCHDOG
>  	/* Disable the watchdog */
> -	cvmx_ciu_wdogx_t ciu_wdog;
> +	union cvmx_ciu_wdogx ciu_wdog;
>  	ciu_wdog.u64 = cvmx_read_csr(CVMX_CIU_WDOGX(cpu));
>  	ciu_wdog.s.mode = 0;
>  	cvmx_write_csr(CVMX_CIU_WDOGX(cpu), ciu_wdog.u64);

David,

I think this ifdef should be replaced by a notifier called from
__cpu_die().

  Ralf
