Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 00:10:32 +0100 (CET)
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33437 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011623AbcBJXKaSdeNr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 00:10:30 +0100
Received: by mail-pa0-f67.google.com with SMTP id zv9so41593pab.0
        for <linux-mips@linux-mips.org>; Wed, 10 Feb 2016 15:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ogc/H6YGbTIW382AljWJcIrGqCgTXXvA83Ll644jkww=;
        b=Ki+hQDzhcsksJ6kCwDpjcQ0FAmaqfb2vgWreMKCVMvfvh0QJqG4qRART0tWVRwDSh3
         CctaTV2cmYmtNbMiUrV3GMJKYIRAtn+SbZrqRTBuq3WUMWBXdvNFJgmHkSCmrA0Y90E/
         RALlU2ZWTpHOR2MGEoNo1OXPq60jpvuBqPo6lIGR6IAfzH6bB9FK+Rvqzx06yRA2C5AC
         kngw5pgkT82xBuFAgSrGbTOc6X4q1p4fvJq6NeCusmOS6IpTHS28qsqaxugPDbfHLf/x
         OdBaBAC8puofGK34Pbw0ZZ9n13xLY+vl5is4WKIcjNEWsrBfvf2IkaGEy0DrnAxKJPrO
         VlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ogc/H6YGbTIW382AljWJcIrGqCgTXXvA83Ll644jkww=;
        b=MYI/hgosyHxyw4zuMWVyWVFAct3DYvaE/ef2hIUH0uzKCtzy+XaW1CTiDfFq8MFRcg
         h8zI9JfKD0Dos2QgmARCU0tA5nFg+CIM4YWwBdgEqrcRWwLcLogujPUAP3L6BSBBBvw7
         HaYxjIgaV6qmxCdH8olq8bFlXCuFRi2wnPD3yMzzd7gEy82qihJwPkr0Ace/hKBQLWRp
         57Yd3IhSlcnX3rKKyw+i0yDM3eI+5cQbNHEhYbycfilbwB3lJARj4qQjNHF7YP2JwId6
         GBMLXXMhYSaA60G46F0O/I81arT5wUYi0K8bJex5993IYKPc5R+mM7pcHjzM/KSlMy7e
         0M6A==
X-Gm-Message-State: AG10YOT/KFxM0v6YB+DDxpwwWn4ql/Qj2rh2kEmkSDS4JBAuhARZmAXFplq2J1dJYBMEkQ==
X-Received: by 10.66.55.106 with SMTP id r10mr47832747pap.133.1455145824210;
        Wed, 10 Feb 2016 15:10:24 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id 1sm7554679pfm.10.2016.02.10.15.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2016 15:10:23 -0800 (PST)
Subject: Re: [PATCH 1/3] MIPS: add hook for platforms to register CMA memory
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
References: <1444148603-45454-1-git-send-email-manuel.lauss@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56BBC31F.10301@gmail.com>
Date:   Wed, 10 Feb 2016 15:09:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <1444148603-45454-1-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 06/10/15 09:23, Manuel Lauss wrote:
> Add a hook which is called after MIPS CMA memory reservation
> to allow platforms to register device-specific CMA areas.
> I'm going to use this for the Au1200/Au1300 framebuffer initially.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

This is also useful for BMIPS_GENERIC platforms where we may need to do
custom memory reservations.

Thanks!

> ---
> Tested on Db1200/Db1300 and Db1500.  I found that this is the only
> place in the initcall-chain where allocating CMA memory for devices
> is actually possible on MIPS/Alchemy.
> 
>  arch/mips/include/asm/bootinfo.h | 5 +++++
>  arch/mips/kernel/setup.c         | 7 +++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/mips/include/asm/bootinfo.h b/arch/mips/include/asm/bootinfo.h
> index b603804..1fc1f67 100644
> --- a/arch/mips/include/asm/bootinfo.h
> +++ b/arch/mips/include/asm/bootinfo.h
> @@ -132,6 +132,11 @@ extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
>   */
>  extern void plat_mem_setup(void);
>  
> +/*
> + * optional hook to reserve CMA memory for devices
> + */
> +extern void (*plat_reserve_mem)(void);
> +
>  #ifdef CONFIG_SWIOTLB
>  /*
>   * Optional platform hook to call swiotlb_setup().
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 35b8316..2b56885 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -71,6 +71,8 @@ char __initdata arcs_cmdline[COMMAND_LINE_SIZE];
>  static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
>  #endif
>  
> +void (*plat_reserve_mem)(void) __initdata = NULL;
> +
>  /*
>   * mips_io_port_base is the begin of the address space to which x86 style
>   * I/O ports are mapped.
> @@ -678,7 +680,12 @@ static void __init arch_mem_init(char **cmdline_p)
>  	plat_swiotlb_setup();
>  	paging_init();
>  
> +	/* allocate default CMA area */
>  	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
> +	/* allow platforms to reserve CMA memory for devices */
> +	if (plat_reserve_mem)
> +		plat_reserve_mem();
> +
>  	/* Tell bootmem about cma reserved memblock section */
>  	for_each_memblock(reserved, reg)
>  		if (reg->size != 0)
> 


-- 
Florian
