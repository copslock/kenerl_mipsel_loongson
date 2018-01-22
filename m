Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2018 22:54:42 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:40715
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992818AbeAVVydFmPAV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jan 2018 22:54:33 +0100
Received: by mail-lf0-x244.google.com with SMTP id h92so12478520lfi.7
        for <linux-mips@linux-mips.org>; Mon, 22 Jan 2018 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NAJKe5sfAOmfShOSjetjqtw53sfzH0QDcigoSPIukFs=;
        b=G4Wju7G74tXh61w32rWG8uXlZ080+vwYvugdt2+0daVW9qyGSLWfPxG5h2L5owS4ph
         PUC3U9mruBVx0+vZse9j9kFwfHf0Xkbh4yAgmuXy34/0rKVwNzoKJXse2Ym8YU/JLX6f
         LKoITtoSkeeCnJzYL4K6OkkQ+RByOQAR8p6cdD4aSEg0F804cRwSGr8sg3RP3mx6FI+O
         pPfs9/Fsdu1anR/KWARim6cE9wepxK5FmMjIs5YES/2LIBtre/m8Jfj5MZzuLKgWhdp1
         bdIOWDYW1iCVeT/IyR27qh7g7jQYMqd9qfVVDoQhwT2i9mSf9vBF7xbU9nPbZyMt9vx9
         9XVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAJKe5sfAOmfShOSjetjqtw53sfzH0QDcigoSPIukFs=;
        b=opQsOc9sbzr3kEFaG+/Gw/TWeHUk208uy2qLPuZFqEZBNW6aBZrQCV86721PKJukd0
         4N70bJr88MYZY4gTyqWrv4QNf3bWf9+Ix0dAxpwUe6+/Puz5M7Xu93PGwcn3OuutslB1
         HmSyQVjqnAW6TNkAGly5Y5vbLd4OsXJoz2MppyjHRo14SQujdfs1LJdxhkc2vNguiLLw
         kbChpmrHHepkhg+pXIRh/+k1Ap8HmVQvHc8wlc70QFqkYYArHnS5keor5Lg2sYKp7MZC
         1f+3h/1IQWURzpwAORgMoYTFZ7YGde0ilYqopVTDA6phulsORVAp0dcOxtagkzeLxSUK
         1SEg==
X-Gm-Message-State: AKwxytfq/4Ne3PoNZx2/jPcpHOn+nudvuWxMQegluijbYrCbd1wJd5Ha
        DZzaH5DPpzcImy32jFIhXFtFTnot
X-Google-Smtp-Source: AH8x226y3syo82yDuD7S4qIMl7a7lMMqwK4m8jvNN+EHUDvSQfSAz8cPHUksCmRqfBM8AngljuB4gQ==
X-Received: by 10.25.115.144 with SMTP id h16mr128952lfk.117.1516658067663;
        Mon, 22 Jan 2018 13:54:27 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id 81sm968646lje.38.2018.01.22.13.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 13:54:27 -0800 (PST)
Date:   Tue, 23 Jan 2018 00:54:39 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: KASLR: Drop relocatable fixup from reservation_init
Message-ID: <20180122215439.GD32024@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <1516638811-24880-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516638811-24880-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

On Mon, Jan 22, 2018 at 04:33:31PM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
> A recent change ("MIPS: memblock: Discard bootmem initialization")
> removed the reservation of all memory below the kernel's _end symbol in
> bootmem. This makes the call to free_bootmem unnecessary, since the
> memory region is no longer marked reserved.
> 
> Additionally, ("MIPS: memblock: Print out kernel virtual mem
> layout") added a display of the kernel's virtual memory layout, so
> printing the relocation information at this point is redundant.
> 
> Remove this section of code.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> 
> ---
> 
> This patch (or a derivative of it) tidies up some of the bootmem init code
> when CONFIG_RELOCATABLE is active during the switch to memblock - please
> can you include in the series?
> 

Agree. I'll merge it with the patch "[PATCH 04/14] MIPS: memblock: Discard
bootmem initialization" of the series in the next version of the patchset.

Regards,
-Sergey

> Thanks,
> Matt
> ---
>  arch/mips/kernel/setup.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 99bfaa6b9279..a0eac8160750 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -536,29 +536,6 @@ static void __init reservation_init(void)
>  		}
>  	}
>  
> -#ifdef CONFIG_RELOCATABLE
> -	/*
> -	 * The kernel reserves all memory below its _end symbol as bootmem,
> -	 * but the kernel may now be at a much higher address. The memory
> -	 * between the original and new locations may be returned to the system.
> -	 */
> -	if (__pa_symbol(_text) > __pa_symbol(VMLINUX_LOAD_ADDRESS)) {
> -		unsigned long offset;
> -		extern void show_kernel_relocation(const char *level);
> -
> -		offset = __pa_symbol(_text) - __pa_symbol(VMLINUX_LOAD_ADDRESS);
> -		free_bootmem(__pa_symbol(VMLINUX_LOAD_ADDRESS), offset);
> -
> -#if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
> -		/*
> -		 * This information is necessary when debugging the kernel
> -		 * But is a security vulnerability otherwise!
> -		 */
> -		show_kernel_relocation(KERN_INFO);
> -#endif
> -	}
> -#endif
> -
>  	/*
>  	 * Reserve initrd memory if needed.
>  	 */
> -- 
> 2.7.4
> 
