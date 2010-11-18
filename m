Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2010 10:28:15 +0100 (CET)
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:47512 "EHLO
        cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492402Ab0KRJ2G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Nov 2010 10:28:06 +0100
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
        by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id oAI9LwF9018119;
        Thu, 18 Nov 2010 09:21:58 GMT
Received: from [10.1.68.185] ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
         Thu, 18 Nov 2010 09:27:42 +0000
Subject: Re: [PATCH 5/5] MIPS/Perf-events: Use unsigned delta for right
 shift in event update
From:   Will Deacon <will.deacon@arm.com>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, fweisbec@gmail.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
In-Reply-To: <1290063401-25440-6-git-send-email-dengcheng.zhu@gmail.com>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
         <1290063401-25440-6-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 18 Nov 2010 09:27:38 +0000
Message-ID: <1290072458.18450.1.camel@e102144-lin.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2010 09:27:42.0299 (UTC) FILETIME=[D9BE1AB0:01CB8702]
Return-Path: <Will.Deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-11-18 at 06:56 +0000, Deng-Cheng Zhu wrote:
> Leverage the commit for ARM by Will Deacon:
> 
> 446a5a8b1eb91a6990e5c8fe29f14e7a95b69132
>         ARM: 6205/1: perf: ensure counter delta is treated as unsigned
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> ---
>  arch/mips/kernel/perf_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/kernel/perf_event.c b/arch/mips/kernel/perf_event.c
> index 345232a..0f1cdf5 100644
> --- a/arch/mips/kernel/perf_event.c
> +++ b/arch/mips/kernel/perf_event.c
> @@ -169,7 +169,7 @@ static void mipspmu_event_update(struct perf_event *event,
>         unsigned long flags;
>         int shift = 64 - TOTAL_BITS;
>         s64 prev_raw_count, new_raw_count;
> -       s64 delta;
> +       u64 delta;
> 
>  again:
>         prev_raw_count = local64_read(&hwc->prev_count);
> --
> 1.7.1

Acked-by: Will Deacon <will.deacon@arm.com>

You might also want to look at commit 65b4711f if you based
the MIPS port on the old ARM code.

Thanks,

Will
