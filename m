Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2017 19:49:20 +0200 (CEST)
Received: from mail-wr0-x231.google.com ([IPv6:2a00:1450:400c:c0c::231]:33520
        "EHLO mail-wr0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994624AbdFMRtNf5odN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jun 2017 19:49:13 +0200
Received: by mail-wr0-x231.google.com with SMTP id v104so145211068wrb.0
        for <linux-mips@linux-mips.org>; Tue, 13 Jun 2017 10:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GeMzQPE3Wuw56tTtDU1EQqURmCZmc2kQMRBsplZve3I=;
        b=SutwhMsM/GKgyn/izMRikv3Fma723GJ4pQPCegTSROxVm7kW2NQ0cpaKM+9OsO80HB
         hRPm0DLhcTV8IU7ObCqBgE2J/Ug2+E2jS+OWJnQSy0VhnJFR8N3V+289XZZPsUuuvpWJ
         B128Os6PImmOg6G/59lApp8YjyannDkGQNnjb+eFGI90XwCngpy7+GOREc5Uv+7dZFVq
         XZlSzMMnyyZTG5XahwvJDmLtov9Ms2ErfH6UoPQArVZeyZND34WQ4S7gMBhUPeQdBrJ9
         ASyizluG6Tceco1Yk2zmWKNxlhOus8a4XO0PPfaNsGTrpf3btWry1h+gAEhMeiYTYT3V
         Dtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GeMzQPE3Wuw56tTtDU1EQqURmCZmc2kQMRBsplZve3I=;
        b=a9q25pBPS66DqULQ0aEUPuqrAjI5vfcndviq0KBM/bDx7IkeHhpYZoi+4CwaYTWDc+
         hoQ6tc058m7Cu12REGuYrRvIXYSK/8tHqcDCnzYDgmTb89+e1n0PM0vo92tkpdR6YQyR
         2raOUgZMlfWeASSA9P9Aeao4lym7HOFQ5hR4UBQbmT/Y9P36yEooh8MT6GZEWy3eAeiJ
         ogrMwcNH+kkDSwbhMUalauYIGNZnkg3uESODB7CeOzVkf7kYuW8bfe/+aGIuPKamREF4
         iPUcRLk8BgAqD4mf+ItWjiEIYFOoQ8SHdNJrkCdNGtVoV3amH9itt94VbYonLV8amywJ
         wq5g==
X-Gm-Message-State: AKS2vOzxaWrydnY71FzNqpF59PPaNcKpbTZbG6nWPseQ5nhzySckC3yl
        uk/zxCMZ+fAxYgsD
X-Received: by 10.80.182.71 with SMTP id c7mr824424ede.55.1497376147277;
        Tue, 13 Jun 2017 10:49:07 -0700 (PDT)
Received: from [10.40.8.34] ([217.156.156.69])
        by smtp.gmail.com with ESMTPSA id m53sm6564633edc.29.2017.06.13.10.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 10:49:06 -0700 (PDT)
Subject: Re: [PATCH v2] MIPS: Perform post-DMA cache flushes on systems with
 MAARs
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Cc:     Ed Blake <ed.blake@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>
References: <20170612214218.25370-1-paul.burton@imgtec.com>
 <20170613170108.15875-1-paul.burton@imgtec.com>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <20fe5a35-8bf4-fbe9-d1f9-1688911af8ca@nexus-software.ie>
Date:   Tue, 13 Jun 2017 18:52:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170613170108.15875-1-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <pure.logic@nexus-software.ie>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pure.logic@nexus-software.ie
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

On 13/06/17 18:01, Paul Burton wrote:
> Recent CPUs from Imagination Technologies such as the I6400 or P6600 are
> able to speculatively fetch data from memory into caches. This means
> that if used in a system with non-coherent DMA they require that caches
> be invalidated after a device performs DMA, and before the CPU reads the
> DMA'd data, in order to ensure that stale values weren't speculatively
> prefetched.
> 
> Such CPUs also introduced Memory Accessibility Attribute Registers
> (MAARs) in order to control the regions in which they are allowed to
> speculate. Thus we can use the presence of MAARs as a good indication
> that the CPU requires the above cache maintenance. Use the presence of
> MAARs to determine the result of cpu_needs_post_dma_flush() in the
> default case, in order to handle these recent CPUs correctly.
> 
> Note that the return type of cpu_needs_post_dma_flush() is changed to
> bool, such that it's clearer what's happening when cpu_has_maar is cast
> to bool for the return value. If this patch were backported to a
> pre-v4.7 kernel then MIPS_CPU_MAAR was 1ull<<34, so when cast to an int
> we would incorrectly return 0. It so happens that MIPS_CPU_MAAR is
> currently 1ull<<30, so when truncated to an int gives a non-zero value
> anyway, but even so the implicit conversion from long long int to bool
> makes it clearer to understand what will happen than the implicit
> conversion from long long int to int would. The bool return type also
> fits this usage better semantically, so seems like an all-round win.
> 
> Thanks to Ed for spotting the issue for pre-v4.7 kernels & suggesting
> the return type change.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Bryan O'Donoghue <Bryan.ODonoghue@imgtec.com>
> Cc: Ed Blake <ed.blake@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> 
> ---
> 
> Changes in v2:
> - Change cpu_needs_post_dma_flush() return type to bool.
> - Comment explaining the default cpu_has_maar case.
> 
>   arch/mips/mm/dma-default.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index fe8df14b6169..e08598c70b3e 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -68,12 +68,25 @@ static inline struct page *dma_addr_to_page(struct device *dev,
>    * systems and only the R10000 and R12000 are used in such systems, the
>    * SGI IP28 Indigo² rsp. SGI IP32 aka O2.
>    */
> -static inline int cpu_needs_post_dma_flush(struct device *dev)
> +static inline bool cpu_needs_post_dma_flush(struct device *dev)
>   {
> -	return !plat_device_is_coherent(dev) &&
> -	       (boot_cpu_type() == CPU_R10000 ||
> -		boot_cpu_type() == CPU_R12000 ||
> -		boot_cpu_type() == CPU_BMIPS5000);
> +	if (plat_device_is_coherent(dev))
> +		return false;
> +
> +	switch (boot_cpu_type()) {
> +	case CPU_R10000:
> +	case CPU_R12000:
> +	case CPU_BMIPS5000:
> +		return true;
> +
> +	default:
> +		/*
> +		 * Presence of MAARs suggests that the CPU supports
> +		 * speculatively prefetching data, and therefore requires
> +		 * the post-DMA flush/invalidate.
> +		 */
> +		return cpu_has_maar;
> +	}
>   }
>   
>   static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
> 

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
