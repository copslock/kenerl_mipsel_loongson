Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 00:48:58 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:45340 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491864Ab0E0Wsz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 00:48:55 +0200
Received: by pxi1 with SMTP id 1so273883pxi.36
        for <multiple recipients>; Thu, 27 May 2010 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Yjjw14SqQEQ718/RaSBpmqSVV3PH1fbnvEETkMt14jQ=;
        b=QVagKXG+SqO/4iAMspDGTkSl1c7FzLzdGMng1kk7jnM4XN0KyzzJqUQQdL5BFiXlcx
         jE2ZARShwCXieoJtUjClkNoOaFVNcJCFdnXOg8yoi5U7P/2OJvGiJyUC71qOvpmAiZB5
         TrYEr2mnFGtZ7lb25gn0BhkNtxkWS4svx03s0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=MxRuFHwdwgirQORY/OwnNAar60NwCzoB/u4P9KPyGNaraur9XNkPCPsAXO90RBe222
         p8ovHwzAApEY8DTT8Zw38SryRtChIYZHE++WRds73jez298iRSSAF3wEiELT462tH/p+
         uBhfvlHajZPZdcWKPjdyolLcMo65jXjP+AiVs=
Received: by 10.142.6.33 with SMTP id 33mr7706699wff.135.1275000528616;
        Thu, 27 May 2010 15:48:48 -0700 (PDT)
Received: from dd1.caveonetworks.com ([12.108.191.226])
        by mx.google.com with ESMTPS id u18sm956315wfh.19.2010.05.27.15.48.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 15:48:48 -0700 (PDT)
Message-ID: <4BFEF6CE.3040002@gmail.com>
Date:   Thu, 27 May 2010 15:48:46 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 07/12] MIPS/Perf-events: add raw event support for
 mipsxx 24K/34K/74K/1004K
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com> <1274965420-5091-8-git-send-email-dengcheng.zhu@gmail.com>
In-Reply-To: <1274965420-5091-8-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/27/2010 06:03 AM, Deng-Cheng Zhu wrote:
> Raw event is an important part of Perf-events. It helps the user collect
> performance data for events that are not listed as the generic hardware
> events and cache events but ARE supported by the CPU's PMU.
>
> This patch adds this feature for mipsxx 24K/34K/74K/1004K. For how to use
> it, please refer to processor core software user's manual and the
> comments for mipsxx_pmu_map_raw_event() for more details.
>
> Please note that this is a "precise" implementation, which means the
> kernel will check whether the requested raw events are supported by this
> CPU and which hardware counters can be assigned for them.
>
> Signed-off-by: Deng-Cheng Zhu<dengcheng.zhu@gmail.com>
> ---
>   arch/mips/kernel/perf_event.c        |    4 +
>   arch/mips/kernel/perf_event_mipsxx.c |  152 +++++++++++++++++++++++++++++++++-
>   2 files changed, 155 insertions(+), 1 deletions(-)
>

Should this just be folded into the other patches?

I would also reiterate that perhaps the generic support functions be 
separated from the processor specific event definitions.

David Daney
