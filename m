Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 14:05:08 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44382 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835038Ab3FRMEc2eNsK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 14:04:32 +0200
Received: from mail-ve0-x22a.google.com (mail-ve0-x22a.google.com [IPv6:2607:f8b0:400c:c01::22a])
        by mail.nanl.de (Postfix) with ESMTPSA id 7D2B845FAD;
        Tue, 18 Jun 2013 12:03:34 +0000 (UTC)
Received: by mail-ve0-f170.google.com with SMTP id 14so3023445vea.15
        for <multiple recipients>; Tue, 18 Jun 2013 05:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/Y1DFgCU3yzBgBjR3X6RDHTEt616/rHMw6lkagkSbpQ=;
        b=EZ/tLuYYLfFynqsvXakW8hEsfXYbILleG7gVpLJlzp1WU92SUAm99Rp08xVJ5lLg6v
         /pdBw8i0AKTjlzOy3Rrjo0Sgnm38vWHobbpJwjW4CzkROin0BuccVlUBD8tG8hVRKLsb
         JpitFj3vLoahms7bKTMpoEU6aaqKkxulnQHqSfr9MP2vd0BVi49FCxaZqpP+AXevDE4K
         UnEFQL7dMn436xTNq5hhcPlou+t4SOx6UMxHfvdE36nl4cUlfUpskv0AJx/5eHtKuAVP
         epEWZzu8zBL5blVfTxnar5Z7kZSnyq4PXMhID+4pH/+A7DF1ll0eaISiDsFIeAGuxc74
         1yXw==
X-Received: by 10.220.89.131 with SMTP id e3mr6017862vcm.1.1371557011866; Tue,
 18 Jun 2013 05:03:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.177.193 with HTTP; Tue, 18 Jun 2013 05:03:11 -0700 (PDT)
In-Reply-To: <51C048FB.5050803@cogentembedded.com>
References: <1371548072-6247-1-git-send-email-jogo@openwrt.org>
 <1371548072-6247-2-git-send-email-jogo@openwrt.org> <51C048FB.5050803@cogentembedded.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 18 Jun 2013 14:03:11 +0200
Message-ID: <CAOiHx=nyUEZ-1=+o4=ViBBxWmMxzjfFFy2n+6kBoVvmHgqjscQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] MIPS: BCM63XX: Add SMP support to prom.c
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi Sergei,

On Tue, Jun 18, 2013 at 1:48 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 18-06-2013 13:34, Jonas Gorski wrote:
>
>> From: Kevin Cernekee <cernekee@gmail.com>
>
>
>> This involves two changes to the BSP code:
>
>
>> 1) register_smp_ops() for BMIPS SMP
>
>
>> 2) The CPU1 boot vector on some of the BCM63xx platforms conflicts with
>> the special interrupt vector (IV).  Move it to 0x8000_0380 at boot time,
>> to resolve the conflict.
>
>
>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>> [jogo@openwrt.org: moved SMP ops registration into ifdef guard,
>>   changed ifdef guards to if (IS_ENABLED())]
>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>> ---
>> V1 -> V2:
>>   * changed ifdef guards to if (IS_ENABLED())
>
>
>>   arch/mips/bcm63xx/prom.c |   41
>> +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>
>
>> diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
>> index fd69808..33ddc78 100644
>> --- a/arch/mips/bcm63xx/prom.c
>> +++ b/arch/mips/bcm63xx/prom.c
>
> [...]
>
>> @@ -52,6 +56,43 @@ void __init prom_init(void)
>>
>>         /* do low level board init */
>>         board_prom_init();
>> +
>> +       if (IS_ENABLED(CONFIG_CPU_BMIPS4350) && IS_ENABLED(CONFIG_SMP)) {
>> +               /* set up SMP */
>> +               register_smp_ops(&bmips_smp_ops);
>> +
>> +               /*
>> +                * BCM6328 might not have its second CPU enabled, while
>> BCM6358
>> +                * needs special handling for its shared TLB, so disable
>> SMP
>> +                * for now.
>> +                */
>> +               if (BCMCPU_IS_6328()) {
>> +                       bmips_smp_enabled = 0;
>> +               } else if (BCMCPU_IS_6358()) {
>> +                       bmips_smp_enabled = 0;
>> +               }
>
>
>     Doesn't scripts/checkpatch.pl complain here? You should not use {} on
> the single statement branches.

I left the braces intentionally there because Patch 2 adds code to the
first branch, so I would have to add them in the next patch anyway.
This way the changes of Patch 2 stays smaller and easier to review
(and are limited to actual code changes).


Jonas
