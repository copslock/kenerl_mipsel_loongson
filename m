Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2011 22:57:53 +0200 (CEST)
Received: from mail-pz0-f45.google.com ([209.85.210.45]:55647 "EHLO
        mail-pz0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491829Ab1IXU5t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Sep 2011 22:57:49 +0200
Received: by pzk2 with SMTP id 2so11911554pzk.4
        for <multiple recipients>; Sat, 24 Sep 2011 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WIaFU+GWilnbnELPjcxJzJ9YF3C3uDZjzUK7gRzUowI=;
        b=QPUJScfSmLpQEwVqkxsJtJikhqwaTqKcsdkPsnFb9tDIvvxeYwnXjHv/Shp+X+XeRW
         uJYL+hQrqlZCHmHDtlImQjKZFFCenBRyx66IdpeQpD/nxLNQbj8xy6biL0iTuopaqRK6
         Hf+oweeTLQDtjk9HQrXrbYIrkHNXhYrz8YK1g=
Received: by 10.68.19.196 with SMTP id h4mr18667390pbe.39.1316897863014;
        Sat, 24 Sep 2011 13:57:43 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-68-122-40-123.dsl.pltn13.pacbell.net. [68.122.40.123])
        by mx.google.com with ESMTPS id ji3sm53716950pbc.2.2011.09.24.13.57.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 13:57:42 -0700 (PDT)
Message-ID: <4E7E4444.4010706@gmail.com>
Date:   Sat, 24 Sep 2011 13:57:40 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc13 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, ralf@linux-mips.org
CC:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 4/5] MIPS: perf: Add support for 64-bit perf counters.
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>        <1316712378-7282-5-git-send-email-david.daney@cavium.com> <CAOfQC98YwVoFWz+ZYv5JYCPG=NhzoeMKy70oE7aJbwAB+yZ6gA@mail.gmail.com>
In-Reply-To: <CAOfQC98YwVoFWz+ZYv5JYCPG=NhzoeMKy70oE7aJbwAB+yZ6gA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13925

On 09/23/2011 07:54 PM, Deng-Cheng Zhu wrote:
> 2011/9/23 David Daney<david.daney@cavium.com>:
>> The hard coded constants are moved to struct mips_pmu.  All counter
>> register access move to the read_counter and write_counter function
>> pointers, which are set to either 32-bit or 64-bit access methods at
>> initialization time.
>>
>> Many of the function pointers in struct mips_pmu were not needed as
>> there was only a single implementation, these were removed.
>>
>> I couldn't figure out what made struct cpu_hw_events.msbs[] at all
>> useful, so I removed it too.
> The idea behind msbs is to simulate 32-bit counters based on the fact
> of MIPS using the MSB to trigger the overflow interrupt. By doing this, the
> average length of the overflow ISR can be shorter in the case of event
> period is bigger than 0x80000000.
It doesn't make the maximum overflow period any shorter.  It just hides 
it from the perf core, which is perfectly capable of handling the 
shorter maximum overflow period.

>   Also, it simplifies counter value related
> algorithms in the code

Have you looked at the code?  It in no way simplifies things.  The patch 
removes 80 lines of code while maintaining 32-bit counter support *and* 
adding 64-bit support.


>   - most of other architectures have 32-bit counters
> instead of 31-bit. In addition, taking over those bugfixes can be easier as
> a concequence.

Not the Linux way.  If there are bugs in the perf core we fix them, we 
don't work around them in archecture specific code.

David Daney
