Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 01:24:59 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:44532 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491861Ab0E0XYy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 01:24:54 +0200
Received: by pxi1 with SMTP id 1so285935pxi.36
        for <multiple recipients>; Thu, 27 May 2010 16:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=JxuOKacIe1wTZYaURPDoeu6TKDiwtBkdiROKt9D5wjM=;
        b=m1orhGH/sWR7EuPss1xJZihTpAmiQn6aSo5SmAcLacw6AOvzpBmSNLzO3uBkYdXlxl
         uAjcCo5toLIXQKdrfJZx20woddwOGVFQdId14wO2moQhxKOaS2CryjwHaZgAolB1vzsu
         3IihZ3SSvSrwAJwcTj7TeiR5YjzRqcSqX5Y7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=XRdXt6OfpEWidYjjm+v5PAUCYfh4F/2LhuN+BaFV8gZHOGSjhBuw9/6Ot1jLDxQe0I
         Rue3L1Z6X92frvdNdv1XFSkEYmpvN24ZFBZqK7HQkdsHfOpjsu6HF6JW4sGod9XNqqN3
         diVsN52tIAvsnXQJ3mkiVMUo8ll9k+ROgcd1s=
Received: by 10.142.55.18 with SMTP id d18mr7687169wfa.170.1275002685659;
        Thu, 27 May 2010 16:24:45 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id x35sm972421wfh.18.2010.05.27.16.24.44
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 16:24:45 -0700 (PDT)
Message-ID: <4BFEFF3B.3080009@gmail.com>
Date:   Thu, 27 May 2010 16:24:43 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 11/12] MIPS/Oprofile: use Perf-events framework as
 backend
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-12-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-12-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> This patch is based on Will Deacon's work for ARM. The well-written
> reasons and ideas can be found here:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/013210.html
>
> This effort makes the bug-fixes shared by different pmu users/clients
> (for now, Oprofile&  Perf-events), and make them coexist in the system
> without lock issues, and make their results comparable.
>
> So this patch moves Oprofile on top of Perf-events by replacing its
> original interfaces with new ones calling Perf-events.
>
> Oprofile uses raw events, so Perf-events (mipsxx in this patch) is
> modified to support more mipsxx CPUs.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>   arch/mips/kernel/perf_event.c        |    7 +-
>   arch/mips/kernel/perf_event_mipsxx.c |  125 ++++++++++++------
>   arch/mips/oprofile/common.c          |  237 +++++++++++++++++++++++++---------
>   3 files changed, 266 insertions(+), 103 deletions(-)
>
[...]
>
>   static int __init
> @@ -963,35 +960,77 @@ init_hw_perf_events(void)
>   	switch (current_cpu_type()) {
>   	case CPU_24K:
>   		mipsxxcore_pmu.id = MIPS_PMU_ID_24K;
> -		mipsxxcore_pmu.num_counters = counters;
> -		mipspmu =&mipsxxcore_pmu;
> +		mipsxxcore_pmu.general_event_map =&mipsxxcore_event_map;
> +		mipsxxcore_pmu.cache_event_map =&mipsxxcore_cache_map;
>   		break;
>   	case CPU_34K:
>   		mipsxxcore_pmu.id = MIPS_PMU_ID_34K;
> -		mipsxxcore_pmu.num_counters = counters;
> -		mipspmu =&mipsxxcore_pmu;
> +		mipsxxcore_pmu.general_event_map =&mipsxxcore_event_map;
> +		mipsxxcore_pmu.cache_event_map =&mipsxxcore_cache_map;
>   		break;

The mips perf events system should already know what type of cpu it is 
running on.

Can we have all this processor specific perf/counter stuff live in one 
place and simplify all of this?


[...]

> +/*
> + * Attributes are created as "pinned" events and so are permanently
> + * scheduled on the PMU.
> + */
> +static void op_perf_setup(void)
> +{
> +	int i;
> +	u32 size = sizeof(struct perf_event_attr);
> +	struct perf_event_attr *attr;
> +
> +	for (i = 0; i<  perf_num_counters; ++i) {
> +		attr =&ctr[i].attr;
> +		memset(attr, 0, size);
> +		attr->type		= PERF_TYPE_RAW;
> +		attr->size		= size;
> +		attr->config		= ctr[i].event + (i&  0x1 ? 128 : 0);

Too many magic numbers.  Lets have symbolic names.

[...]

Thanks,
David Daney
