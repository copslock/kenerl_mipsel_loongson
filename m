Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 15:39:30 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:53396 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006155AbcEMNj2NUVBz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 15:39:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=u6v1WiSBCiwbjexSRzkC20cBSLChg0809IKLrQ44uvo=; b=QuDcdzPfO7Z+Wan5YEcGV6UP8R
        r8Il2JHRGYkKKEIO/5x9BkHXehInLk0OS+ukG4ve0gF/GmpWuOLfN4YvCJL55dRt07jMO6EwIlYZY
        EMJkloLrfNYKGaz6DAGHQk6OopMFb7m8ctjY/rhSYrXhDMRyVQsEBOJdwlikXr4HSIuujqXHL4wQr
        +sLSFEMIN2Tn/bTP16r4DYrTBdd15qQYAn3nEQO8ehhalQ1RdQmQgKtWIY10KBKrMDkpJjn38Szl/
        hQhJLvkO9wIOkxDBq90XbCDFm74o5aji2pVKYXqixs7KzrmEk5WivcGAAbN8DX3RQE/uLETydCB7m
        Nws6/UUQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47730 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1b1DJ3-001hpr-B4; Fri, 13 May 2016 13:39:09 +0000
Date:   Fri, 13 May 2016 06:39:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: MIPS: Loongson: Adjust cpu features for Loongson-3
Message-ID: <20160513133908.GA3969@roeck-us.net>
References: <1461132882-23933-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461132882-23933-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Wed, Apr 20, 2016 at 02:14:42PM +0800, Huacai Chen wrote:
> Some Loongson-3 features (i.e., cpu_has_wsbh, cpu_has_ic_fills_f_dc and
> cpu_hwrena_impl_bits) are different from Loongson-2, so we define them
> in a single group. This also fixes 04a35922c1dac ("MIPS: Loongson: Add
> Loongson-3A R2 basic support") which breaks Loongson-2E/2F's booting.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> index c3406db..89328a3d 100644
> --- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
> @@ -27,7 +27,6 @@
>  #define cpu_has_dc_aliases	(PAGE_SIZE < 0x4000)
>  #define cpu_has_divec		0
>  #define cpu_has_ejtag		0
> -#define cpu_has_ic_fills_f_dc	0
>  #define cpu_has_inclusive_pcaches	1
>  #define cpu_has_llsc		1
>  #define cpu_has_mcheck		0
> @@ -45,7 +44,10 @@
>  #define cpu_has_watch		1
>  #define cpu_has_local_ebase	0
>  
> -#define cpu_has_wsbh		IS_ENABLED(CONFIG_CPU_LOONGSON3)
> +#ifdef CONFIG_CPU_LOONGSON3
> +#define cpu_has_wsbh		1
> +#define cpu_has_ic_fills_f_dc	1
>  #define cpu_hwrena_impl_bits	0xc0000000
> +#endif
>  
>  #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
