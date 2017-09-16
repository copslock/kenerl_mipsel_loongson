Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Sep 2017 19:38:41 +0200 (CEST)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:34799
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992533AbdIPRiduZMGi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Sep 2017 19:38:33 +0200
Received: by mail-oi0-x242.google.com with SMTP id v66so1223822oig.1;
        Sat, 16 Sep 2017 10:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A2FsbOEEkrMdVsMuzVsZGPCtA7yROMLAz659WXkvtEE=;
        b=p7mWLjnEoJojLn3LA4feQl9duSJnZbCZ8lcy0dH4d5x+RZw1DWbkpQzuYbS7lr4Tjt
         2miJ2q5XneTmvP82gNJxjYKuZXNxcJIuz59B+qB1KptJsDTMgNBZgSwUddxfAxD+EEJA
         lJv6V7yntVm17EXayHVrZl92GmjYpvUfIuuLJ5h1dfBRL8xjsIO1/HU6cY3BA+GpMP9Y
         39kYu9sbPe627Af647wIOyWJD9Gk2p+X9jAWl05vtDHanUj3kg/VP2gB477O8TfNkHDY
         zTXvk1OQOJMna2qKQQGbmPvOZx+yqO5YhK7db9/T9vEDQcDDFWcdu8Qzf0zfOlCocJkK
         UpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A2FsbOEEkrMdVsMuzVsZGPCtA7yROMLAz659WXkvtEE=;
        b=iYB9XrLF3wh/jTRSjR/O0xoHEzaDof5kkidOzQIT9pKVBhiNWfgHXi3w86jYinwIp0
         +JZZtgNhORNoO4O4KWK+embPeZQFbGjKTqdNG7WPhNX+qOhSigrblzBFRSccNVwhO/md
         rK9Q2KOgupFU239M7uOnGqXSzHs6Y5ew9IiX9Qm84zMU4JDzqaDOOd+jmxnksa7hZLKM
         rEZEhfInL1GCjfKbCGeBP2EpfT8OCxtc8PZKwDPswOLTKSWfomSrHdFzCKWrKO94UqML
         6jK9nzwcmZIzV6EBjLyuXBuEr7jXind8s71V9LkFYg7IP5dXRQdeUXX3ScVnDA8U0tnJ
         mSTQ==
X-Gm-Message-State: AHPjjUgGx2IIGM3ACjEDyte0dJ8ZRgYsHUaeCkxyBRU1mJa/dTaDElx/
        nXCaSzrHaS3Xjw==
X-Google-Smtp-Source: AOwi7QBNkHpeqUaSmOFOngSeJJeiSLXiNXfVQY9vXhROlAJJ2x86h0cNgtByEAr4ob0OYivevN7oUA==
X-Received: by 10.202.80.145 with SMTP id e139mr13957428oib.80.1505583507383;
        Sat, 16 Sep 2017 10:38:27 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:a44d:fd1e:981d:f058? ([2001:470:d:73f:a44d:fd1e:981d:f058])
        by smtp.gmail.com with ESMTPSA id s133sm4451508oih.25.2017.09.16.10.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Sep 2017 10:38:26 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Allow __cpu_number_map to be larger than NR_CPUS
To:     "Steven J. Hill" <steven.hill@cavium.com>,
        linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, david.daney@cavium.com
References: <1505494693-22732-1-git-send-email-steven.hill@cavium.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <203e4433-39cc-140b-59a0-e140343f0cde@gmail.com>
Date:   Sat, 16 Sep 2017 10:38:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1505494693-22732-1-git-send-email-steven.hill@cavium.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60033
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

On 09/15/2017 09:58 AM, Steven J. Hill wrote:
> From: David Daney <david.daney@cavium.com>
> 
> In systems where the CPU id space is sparse, this allows a smaller
> NR_CPUS to be chosen, thus keeping internal data structures smaller.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Carlos Munoz <cmunoz@caviumnetworks.com>
> ---
>  arch/mips/Kconfig           | 3 ++-
>  arch/mips/include/asm/smp.h | 2 +-
>  arch/mips/kernel/smp.c      | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 48d91d5..ed35fd1 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -915,7 +915,8 @@ config CAVIUM_OCTEON_SOC
>  	select USE_OF
>  	select ARCH_SPARSEMEM_ENABLE
>  	select SYS_SUPPORTS_SMP
> -	select NR_CPUS_DEFAULT_16
> +	select NR_CPUS_DEFAULT_64
> +	select MIPS_NR_CPU_NR_MAP_1024

Are you possibly missing a hunk in this patch series that does something
like the following:

config MIPS_NR_CPU_NR_MAP
	int
	default "1024" if MIPS_NR_CPU_NR_MAP_1024
	default NR_CPUS

config MIPS_NR_CPU_NR_MAP_1024
	bool

otherwise...

>  	select BUILTIN_DTB
>  	select MTD_COMPLEX_MAPPINGS
>  	select SYS_SUPPORTS_RELOCATABLE
> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
> index bab3d41..5fa6c85 100644
> --- a/arch/mips/include/asm/smp.h
> +++ b/arch/mips/include/asm/smp.h
> @@ -29,7 +29,7 @@ extern cpumask_t cpu_foreign_map[];
>  
>  /* Map from cpu id to sequential logical cpu number.  This will only
>     not be idempotent when cpus failed to come on-line.	*/
> -extern int __cpu_number_map[NR_CPUS];
> +extern int __cpu_number_map[CONFIG_MIPS_NR_CPU_NR_MAP];

I don't think this is defined and would build?

Should you also have a BUILD_BUG_ON() statement that ensures that the
sparse map is bigger than or equal to NR_CPUS?

>  #define cpu_number_map(cpu)  __cpu_number_map[cpu]
>  
>  /* The reverse map from sequential logical cpu number to cpu id.  */
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 6bace76..aea84b9 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -48,10 +48,10 @@
>  #include <asm/setup.h>
>  #include <asm/maar.h>
>  
> -int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
> +int __cpu_number_map[CONFIG_MIPS_NR_CPU_NR_MAP];   /* Map physical to logical */
>  EXPORT_SYMBOL(__cpu_number_map);
>  
> -int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
> +int __cpu_logical_map[NR_CPUS];			   /* Map logical to physical */

Unrelated clean up.

>  EXPORT_SYMBOL(__cpu_logical_map);
>  
>  /* Number of TCs (or siblings in Intel speak) per CPU core */
> 

-- 
Florian
