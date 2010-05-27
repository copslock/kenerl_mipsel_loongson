Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 01:16:43 +0200 (CEST)
Received: from mail-pz0-f173.google.com ([209.85.222.173]:43280 "EHLO
        mail-pz0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492403Ab0E0XQk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 01:16:40 +0200
Received: by pzk3 with SMTP id 3so217754pzk.24
        for <multiple recipients>; Thu, 27 May 2010 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nYzHgLRqbSIO8lO5ShFSh9/5mUg1/i3K2H9LSdyLbb0=;
        b=vswm3lN3pg+KneysR7CeIykwW2e5i8vuMrOLFBP/61FxOPCinJf1Bi+S3jbXUnXKw9
         rH07vlP7y/348RWNPVGAC7CTYTx6xaWrQwM1JXZ9SfRajrU5Mh4nWMafljtOUYxTmm07
         RTj8vwueChJysLUCaXIPAgUSnAiIVWXvoxcmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=h9wWkXU0Z80cgC+q3E4RI5KhK1RPqGSI68Id22DBFjx6WoCA6cxKwONtkp7d+TWfu5
         Sk8g6BsgH8jqGyfVHFTu93owEIVvzsHfxfMZn80TLAvBz+/mt57IDvbFiq46ECsuuOww
         60kpBeJygM4TdXTrYh7XibEePxa9Ziq065L/Q=
Received: by 10.140.57.13 with SMTP id f13mr8565642rva.70.1275002192011;
        Thu, 27 May 2010 16:16:32 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id i19sm1499312rvn.23.2010.05.27.16.16.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 16:16:31 -0700 (PDT)
Message-ID: <4BFEFD4D.4010801@gmail.com>
Date:   Thu, 27 May 2010 16:16:29 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 10/12] MIPS/Perf-events: allow modules to get pmu number
 of counters
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-11-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-11-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> Oprofile module needs a function to get the number of pmu counters in its
> high level interfaces.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>   arch/mips/include/asm/pmu.h   |    1 +
>   arch/mips/kernel/perf_event.c |    6 ++++++
>   2 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
> index 16d4fcd..023a915 100644
> --- a/arch/mips/include/asm/pmu.h
> +++ b/arch/mips/include/asm/pmu.h
> @@ -114,5 +114,6 @@ enum mips_pmu_id {
>   extern const char *mips_pmu_names[];
>
>   extern enum mips_pmu_id mipspmu_get_pmu_id(void);
> +extern int mipspmu_get_max_events(void);
>
>   #endif /* __MIPS_PMU_H__ */
> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
> index f05e2b1..dc3a553 100644
> --- a/arch/mips/kernel/perf_event.c
> +++ b/arch/mips/kernel/perf_event.c
> @@ -140,6 +140,12 @@ enum mips_pmu_id mipspmu_get_pmu_id(void)
>   }
>   EXPORT_SYMBOL_GPL(mipspmu_get_pmu_id);
>
> +int mipspmu_get_max_events(void)
> +{
> +	return mipspmu ? mipspmu->num_counters : 0;
> +}
> +EXPORT_SYMBOL_GPL(mipspmu_get_max_events);
> +

Why is it called 'max_events' when it is returning the number of 
counters?  How about mipspmu_get_max_counters?

Do we even need this accessor?

Why not just query it from the struct mips_pmu?  Don't you need the 
mipspmu structure anyhow to be able to use the counters?

David Daney
