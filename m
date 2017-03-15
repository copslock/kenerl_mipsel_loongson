Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 03:04:48 +0100 (CET)
Received: from mail-ot0-x243.google.com ([IPv6:2607:f8b0:4003:c0f::243]:35992
        "EHLO mail-ot0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991111AbdCOCEknRLyC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 03:04:40 +0100
Received: by mail-ot0-x243.google.com with SMTP id i1so616527ota.3;
        Tue, 14 Mar 2017 19:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=I1Ib5ffVaZ1yX64V5bB5/yu3GVkDIiMCJ8x6XxYkFlo=;
        b=DHWiJaeRHfKlHDqPsA9EWc8o01lFnhHlIyD+BBWPzPL3tQMHKSiz62RxvqpFVrlIDp
         t3455I0yPeZxJvAHzHP/By3M+Bj1LQKjfSx7QcgJ7xPtMlkLcE3nzrDss7HIRZRM2u8/
         Nv4gOnfSV/tJyZukwalLZKRdrbN0O85BIk8g1+5pTVVwZBqAN3Jky/1e/JQlO920+OsT
         ib/Rq9tyMATze6sJMDBZY+BncbFKdn34xT3Kyz8IjD/1Xa6YfQpufvqqaci3yHlh08Sh
         KVxHMATdP4aPwSAg1fwIug7Pe/0hsiaACL6a4y2hQUS0bpxH/lP8hx+JgZ06Ep7+pVG8
         0u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=I1Ib5ffVaZ1yX64V5bB5/yu3GVkDIiMCJ8x6XxYkFlo=;
        b=bYAAXiYrPtppmmhcLeXAVyhNb9IBbHoXYJxnhXHMytBhQjxxIjQ5qTclsQcIy8dgVG
         VVwnU1Q0oadf0JDCyW/1GG4PVT+Kg63AXXIKaBThs5pcEy9I2L2wHtPQrzC4915pSmJR
         jLHCvT5SP0q8xBG1kSSxt0EOH7NeOPNXRl47luqosxbYO7IV62PfevsqwBUU8m4Zvsjl
         5MYFUDhFNeGt+gReJxqkTUH6jhLtZ+VKm2tqa+yaOJqsKKf9XjfHjNmLh/lF2L/bJqIT
         ILAx+E0sSJbyxsB/swvBIkIeZpAdTIwP2vC4rV7c2h/YKRknM0eFhWFcGl0IRzVRxLz8
         ENMw==
X-Gm-Message-State: AFeK/H3gfPfvCakHYnLsj5fJHQHAPyWKITPXJPiqPeGfMjQYYJIgOvGT1E8uSIhXd2qheA==
X-Received: by 10.202.213.141 with SMTP id m135mr465922oig.29.1489543474715;
        Tue, 14 Mar 2017 19:04:34 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:4913:a97b:f30:df6a? ([2001:470:d:73f:4913:a97b:f30:df6a])
        by smtp.gmail.com with ESMTPSA id f36sm215024otb.52.2017.03.14.19.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Mar 2017 19:04:33 -0700 (PDT)
Subject: Re: [PATCH 0/2] cpu-features.h rename
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1489412018-30387-1-git-send-email-marcin.nowakowski@imgtec.com>
 <f5870aae-0974-6213-2499-bbfb365cf063@gmail.com>
 <be773311-fb5b-949e-378e-09db2baa8cd4@imgtec.com>
 <20170314082906.GG26432@linux-mips.org>
 <d1b970e6-f87e-3e35-7c74-7fc0a6a4c0f2@imgtec.com>
Cc:     linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b8fbd07f-1dea-eca7-87f1-81969b3874a2@gmail.com>
Date:   Tue, 14 Mar 2017 19:04:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <d1b970e6-f87e-3e35-7c74-7fc0a6a4c0f2@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57275
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



On 03/14/2017 01:45 AM, Marcin Nowakowski wrote:
> Hi Ralf,
> 
> On 14.03.2017 09:29, Ralf Baechle wrote:
>> On Tue, Mar 14, 2017 at 08:40:21AM +0100, Marcin Nowakowski wrote:
>>
>>> On 13.03.2017 18:08, Florian Fainelli wrote:
>>>> On 03/13/2017 06:33 AM, Marcin Nowakowski wrote:
>>>>> Since the introduction of GENERIC_CPU_AUTOPROBE
>>>>> (https://patchwork.linux-mips.org/patch/15395/) we've got 2 very
>>>>> similarily
>>>>> named headers: cpu-features.h and cpufeature.h.
>>>>> Since the latter is used by all platforms that implement
>>>>> GENERIC_CPU_AUTOPROBE functionality, it's better to rename the
>>>>> MIPS-specific
>>>>> cpu-features.h.
>>>>>
>>>>> Marcin Nowakowski (2):
>>>>>   MIPS: mach-rm: Remove recursive include of cpu-feature-overrides.h
>>>>>   MIPS: rename cpu-features.h -> cpucaps.h
>>>>
>>>> That's a lot of churn that could cause some good headaches in
>>>> backporting stable changes affecting cpu-feature-overrides.h.
>>>>
>>>> Can we just do the cpu-features.h -> cpucaps.h rename and keep
>>>> cpu-feature-overrides.h around?
>>>
>>> That's of course possible, but I think it would make the naming quite
>>> confusing as well, as it would be very unclear for any reader as to
>>> why a
>>> 'cpu-feature-overrides' overrides 'cpucaps'.
>>>
>>> I've looked at the change history of these files and most receive very
>>> little updates (which is hardly surprising given the changes are done
>>> mostly
>>> during initial integration of a new cpu or soon after), and none of the
>>> changes in those files were marked for stable. I think it's safe to
>>> assume
>>> that this pattern is not likely to change, would you agree?
>>
>> I've noticed the same pattern - and it's a little concerning.  Not adding
>> values for later features means the'll probably be runtime detected
>> resulting in a bigger, slower kernel.
> 
> But that is a type of optimisation that may (should?) be done when new
> features are added, which in most cases doesn't make it a candidate for
> backporting to stable.

You may be fixing actual bugs by patching this file, e.g: selecting the
correct value for e.g: cpu_has_dc_aliases, cpu_has_ic_fills_ic,
cpu_dcache_line_size() and so on. Ideally every feature in there has
been properly set/cleared in arch/mips/kernel/cpu-probe.c but there
could be platform relying exclusively on cpu-feature-overrides.h to
provide the correct value.

If not about the backport argument, just changing that many files at
once (have they actually been build tested at least?) just does not seem
practical nor worth it to me. Just put a big fat disclaimer: this is not
to be conflated with cpucaps.h (and vice versa).
-- 
Florian
