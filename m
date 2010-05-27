Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 01:10:50 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:43253 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492425Ab0E0XKr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 01:10:47 +0200
Received: by pwi2 with SMTP id 2so312990pwi.36
        for <multiple recipients>; Thu, 27 May 2010 16:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ZwMJwPkJ7eI/4NYC/MyEIh9FdwPKkPwCqbNqF4b82V0=;
        b=ibmzIP96kn0RnSXKlBoHebBYQL9kMOm8g5coMTVdyWXEgW7jB8TGQOsBzm+v23N1cU
         JPvjXAA5EnGYxPijJ+GGcRRXROgzVJOewLQYd0l3qesMrC27J1zlvZAzS3E0mTHwDTip
         kJCuYPmLP/J2q96cX9dy9QUib3j3vK/oCxtdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=BT8Tx/Tqdj5uSFEuTY6Mms/Sz0AROkpdkTCrX80A1MGPTWU36HX/FuCNYwXOP2WU+5
         D/8/8jK5U/Y9m+bw9fpDY8GwvCp/CV54rgOV9ae3oPiT+HxHOTDPZbw1fzm8x1/Zig4X
         0b+pUUFyiLaaO2DngTZ3oMtMJB7DH9YfGaw0U=
Received: by 10.140.57.15 with SMTP id f15mr8578743rva.56.1275001840256;
        Thu, 27 May 2010 16:10:40 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id b1sm1498967rvn.2.2010.05.27.16.10.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 16:10:39 -0700 (PDT)
Message-ID: <4BFEFBEE.7050108@gmail.com>
Date:   Thu, 27 May 2010 16:10:38 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 09/12] MIPS/Perf-events: replace pmu names with numeric
 IDs
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-10-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-10-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> Using Perf-events as the backend, clients such as Oprofile will need to
> enquire the pmu names. A convenient way to do this is to use pmu id to
> index the exported name array. And this is what we are doing here.
>
> NOTE: While using scripts/checkpatch.pl to check this patch, a style
> warning is reported. I suppose it is a false positive, and will report to
> the maintainer. The message is:
> =======================================
> WARNING:
> EXPORT_SYMBOL(foo); should immediately follow its function/variable
> #81: FILE: arch/mips/kernel/perf_event.c:112:
> +EXPORT_SYMBOL_GPL(mips_pmu_names);
> =======================================

I don't like this one.

In cpu-probe.c we used to have this same type of parallel name array, 
and it was messy.

You know what type of cpu you are running on, so I don't understand the 
advantage of querying by name.  What possible use could there be to 
knowing the names of processors that are not applicable to the current 
runtime?

David Daney



>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>   arch/mips/include/asm/pmu.h          |   26 ++++++++++++++++++++++++++
>   arch/mips/kernel/perf_event.c        |   31 ++++++++++++++++++++++++++++++-
>   arch/mips/kernel/perf_event_mipsxx.c |   12 +++++++-----
>   3 files changed, 63 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
> index 2822810..16d4fcd 100644
> --- a/arch/mips/include/asm/pmu.h
> +++ b/arch/mips/include/asm/pmu.h
> @@ -89,4 +89,30 @@ extern unsigned int rm9000_perfcount_irq;
>
>   #endif /* CONFIG_CPU_* */
>
> +/* MIPS PMU IDs for use by internal perf clients. */
> +enum mips_pmu_id {
> +	/* mipsxx */
> +	MIPS_PMU_ID_20K = 0,
> +	MIPS_PMU_ID_24K,
> +	MIPS_PMU_ID_25K,
> +	MIPS_PMU_ID_1004K,
> +	MIPS_PMU_ID_34K,
> +	MIPS_PMU_ID_74K,
> +	MIPS_PMU_ID_5K,
> +	MIPS_PMU_ID_R10000V2,
> +	MIPS_PMU_ID_R10000,
> +	MIPS_PMU_ID_R12000,
> +	MIPS_PMU_ID_SB1,
> +	/* rm9000 */
> +	MIPS_PMU_ID_RM9000,
> +	/* loongson2 */
> +	MIPS_PMU_ID_LOONGSON2,
> +	/* unsupported */
> +	MIPS_PMU_ID_UNSUPPORTED,
> +};
> +
> +extern const char *mips_pmu_names[];
> +
> +extern enum mips_pmu_id mipspmu_get_pmu_id(void);
> +
>   #endif /* __MIPS_PMU_H__ */
> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
> index 0ef54e6..f05e2b1 100644
> --- a/arch/mips/kernel/perf_event.c
> +++ b/arch/mips/kernel/perf_event.c
> @@ -88,8 +88,31 @@ static DEFINE_MUTEX(raw_event_mutex);
>   #define UNSUPPORTED_PERF_EVENT_ID 0xffffffff
>   #define C(x) PERF_COUNT_HW_CACHE_##x
>
> +/* MIPS PMU names */
> +const char *mips_pmu_names[] = {
> +	/* mipsxx */
> +	[MIPS_PMU_ID_20K]		= "mips/20K",
> +	[MIPS_PMU_ID_24K]		= "mips/24K",
> +	[MIPS_PMU_ID_25K]		= "mips/25K",
> +	[MIPS_PMU_ID_1004K]		= "mips/1004K",
> +	[MIPS_PMU_ID_34K]		= "mips/34K",
> +	[MIPS_PMU_ID_74K]		= "mips/74K",
> +	[MIPS_PMU_ID_5K]		= "mips/5K",
> +	[MIPS_PMU_ID_R10000V2]		= "mips/r10000-v2.x",
> +	[MIPS_PMU_ID_R10000]		= "mips/r10000",
> +	[MIPS_PMU_ID_R12000]		= "mips/r12000",
> +	[MIPS_PMU_ID_SB1]		= "mips/sb1",
> +	/* rm9000 */
> +	[MIPS_PMU_ID_RM9000]		= "mips/rm9000",
> +	/* loongson2 */
> +	[MIPS_PMU_ID_LOONGSON2]		= "mips/loongson2",
> +	/* unsupported */
> +	[MIPS_PMU_ID_UNSUPPORTED]	= NULL,
> +};
> +EXPORT_SYMBOL_GPL(mips_pmu_names);
> +
>   struct mips_pmu {
> -	const char	*name;
> +	enum mips_pmu_id id;
>   	irqreturn_t	(*handle_irq)(int irq, void *dev);
>   	int		(*handle_shared_irq)(void);
>   	void		(*start)(void);
> @@ -111,6 +134,12 @@ struct mips_pmu {
>
>   static const struct mips_pmu *mipspmu;
>
> +enum mips_pmu_id mipspmu_get_pmu_id(void)
> +{
> +	return mipspmu ? mipspmu->id : MIPS_PMU_ID_UNSUPPORTED;
> +}
> +EXPORT_SYMBOL_GPL(mipspmu_get_pmu_id);
> +
>   static int
>   mipspmu_event_set_period(struct perf_event *event,
>   			struct hw_perf_event *hwc,
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
> index 1c92917..4e37a3a 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -962,22 +962,22 @@ init_hw_perf_events(void)
>
>   	switch (current_cpu_type()) {
>   	case CPU_24K:
> -		mipsxxcore_pmu.name = "mips/24K";
> +		mipsxxcore_pmu.id = MIPS_PMU_ID_24K;
>   		mipsxxcore_pmu.num_counters = counters;
>   		mipspmu =&mipsxxcore_pmu;
>   		break;
>   	case CPU_34K:
> -		mipsxxcore_pmu.name = "mips/34K";
> +		mipsxxcore_pmu.id = MIPS_PMU_ID_34K;
>   		mipsxxcore_pmu.num_counters = counters;
>   		mipspmu =&mipsxxcore_pmu;
>   		break;
>   	case CPU_74K:
> -		mipsxx74Kcore_pmu.name = "mips/74K";
> +		mipsxx74Kcore_pmu.id = MIPS_PMU_ID_74K;
>   		mipsxx74Kcore_pmu.num_counters = counters;
>   		mipspmu =&mipsxx74Kcore_pmu;
>   		break;
>   	case CPU_1004K:
> -		mipsxxcore_pmu.name = "mips/1004K";
> +		mipsxxcore_pmu.id = MIPS_PMU_ID_1004K;
>   		mipsxxcore_pmu.num_counters = counters;
>   		mipspmu =&mipsxxcore_pmu;
>   		break;
> @@ -989,7 +989,9 @@ init_hw_perf_events(void)
>
>   	if (mipspmu)
>   		pr_cont("%s PMU enabled, %d counters available to each "
> -			"CPU\n", mipspmu->name, mipspmu->num_counters);
> +			"CPU\n",
> +			mips_pmu_names[mipspmu->id],
> +			mipspmu->num_counters);
>
>   	return 0;
>   }
