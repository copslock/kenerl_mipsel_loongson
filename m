Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 16:46:53 +0100 (CET)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:40050 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011685AbcBIPqrY7EVQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 16:46:47 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.15.2/8.15.2) with ESMTPS id u19FkUL2021200
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 9 Feb 2016 15:46:30 GMT
Received: from [10.151.38.189] ([10.151.38.189])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id u19FkSCv017463;
        Tue, 9 Feb 2016 16:46:28 +0100
Subject: Re: [PATCH] MIPS: Fix early CM probing
To:     EXT Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
References: <1454953591-19491-1-git-send-email-paul.burton@imgtec.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-kernel@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <56BA09D6.1080002@nokia.com>
Date:   Tue, 9 Feb 2016 16:46:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1454953591-19491-1-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 3155
X-purgate-ID: 151667::1455032792-000006B0-EEF31170/0/0
Return-Path: <alexander.sverdlin@nokia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@nokia.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi!

On 08.02.2016 18:46, EXT Paul Burton wrote:
> Commit c014d164f21d ("MIPS: Add platform callback before initializing
> the L2 cache") added a platform_early_l2_init function in order to allow
> platforms to probe for the CM before L2 initialisation is performed, so
> that CM GCRs are available to mips_sc_probe.
> 
> That commit actually fails to do anything useful, since it checks
> mips_cm_revision to determine whether it should call mips_cm_probe but
> the result of mips_cm_revision will always be 0 until mips_cm_probe has
> been called. Thus the "early" mips_cm_probe call never occurs.
> 
> Fix this & drop the useless weak platform_early_l2_init function by
> simply calling mips_cm_probe from setup_arch. For platforms that don't
> select CONFIG_MIPS_CM this will be a no-op, and for those that do it
> removes the requirement for them to call mips_cm_probe manually
> (although doing so isn't harmful for now).
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
> 
>  arch/mips/kernel/setup.c         |  1 +
>  arch/mips/mm/sc-mips.c           | 10 ----------
>  arch/mips/mti-malta/malta-init.c |  8 --------
>  3 files changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 569a7d5..5fdaf8b 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -782,6 +782,7 @@ static inline void prefill_possible_map(void) {}
>  void __init setup_arch(char **cmdline_p)
>  {
>  	cpu_probe();
> +	mips_cm_probe();
>  	prom_init();
>  
>  	setup_early_fdc_console();
> diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
> index 3bd0597..2496475 100644
> --- a/arch/mips/mm/sc-mips.c
> +++ b/arch/mips/mm/sc-mips.c
> @@ -181,10 +181,6 @@ static int __init mips_sc_probe_cm3(void)
>  	return 1;
>  }
>  
> -void __weak platform_early_l2_init(void)
> -{
> -}
> -
>  static inline int __init mips_sc_probe(void)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
> @@ -194,12 +190,6 @@ static inline int __init mips_sc_probe(void)
>  	/* Mark as not present until probe completed */
>  	c->scache.flags |= MIPS_CACHE_NOT_PRESENT;
>  
> -	/*
> -	 * Do we need some platform specific probing before
> -	 * we configure L2?
> -	 */
> -	platform_early_l2_init();
> -
>  	if (mips_cm_revision() >= CM_REV_CM3)
>  		return mips_sc_probe_cm3();
>  
> diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
> index 571148c..dc2c521 100644
> --- a/arch/mips/mti-malta/malta-init.c
> +++ b/arch/mips/mti-malta/malta-init.c
> @@ -293,7 +293,6 @@ mips_pci_controller:
>  	console_config();
>  #endif
>  	/* Early detection of CMP support */
> -	mips_cm_probe();
>  	mips_cpc_probe();
>  
>  	if (!register_cps_smp_ops())
> @@ -304,10 +303,3 @@ mips_pci_controller:
>  		return;
>  	register_up_smp_ops();
>  }
> -
> -void platform_early_l2_init(void)
> -{
> -	/* L2 configuration lives in the CM3 */
> -	if (mips_cm_revision() >= CM_REV_CM3)
> -		mips_cm_probe();
> -}
> 
