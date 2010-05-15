Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 May 2010 18:18:06 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:57041 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491984Ab0EOQSD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 May 2010 18:18:03 +0200
Received: by wyb29 with SMTP id 29so333960wyb.36
        for <multiple recipients>; Sat, 15 May 2010 09:17:56 -0700 (PDT)
Received: by 10.227.142.69 with SMTP id p5mr2640436wbu.2.1273940276186;
        Sat, 15 May 2010 09:17:56 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id h22sm2213068wbh.21.2010.05.15.09.17.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 09:17:55 -0700 (PDT)
Message-ID: <4BEEC902.2080006@mvista.com>
Date:   Sat, 15 May 2010 20:17:06 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v4 7/9] MIPS/perf-events: allow modules to get pmu number
 of counters
References: <1273937815-4781-1-git-send-email-dengcheng.zhu@gmail.com> <1273937815-4781-8-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1273937815-4781-8-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Deng-Cheng Zhu wrote:

> Oprofile module needs a function to get the number of pmu counters in its
> high level interfaces.
>
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> ---
>  arch/mips/include/asm/pmu.h   |    1 +
>  arch/mips/kernel/perf_event.c |   11 +++++++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
> index 16d4fcd..023a915 100644
> --- a/arch/mips/include/asm/pmu.h
> +++ b/arch/mips/include/asm/pmu.h
> @@ -114,5 +114,6 @@ enum mips_pmu_id {
>  extern const char *mips_pmu_names[];
>  
>  extern enum mips_pmu_id mipspmu_get_pmu_id(void);
> +extern int mipspmu_get_max_events(void);
>  
>  #endif /* __MIPS_PMU_H__ */
> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
> index 67d301d..6f95220 100644
> --- a/arch/mips/kernel/perf_event.c
> +++ b/arch/mips/kernel/perf_event.c
> @@ -145,6 +145,17 @@ enum mips_pmu_id mipspmu_get_pmu_id(void)
>  }
>  EXPORT_SYMBOL_GPL(mipspmu_get_pmu_id);
>  
> +int mipspmu_get_max_events(void)
> +{
> +	int max_events = 0;
> +
> +	if (mipspmu)
> +		max_events = mipspmu->num_counters;
> +
> +	return max_events;
>   

   Why not simply:

    return mispmu ? mipspmu->num_counters : 0;

WBR, Sergei
