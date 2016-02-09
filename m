Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 00:46:35 +0100 (CET)
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34491 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011376AbcBIXq3bks4O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 00:46:29 +0100
Received: by mail-pf0-f176.google.com with SMTP id x65so1814308pfb.1;
        Tue, 09 Feb 2016 15:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=QHklkRNKZWMLPp1VwOmkAuahUyYrpXye9QrHlmdz9QA=;
        b=TXhjW686C5apHnkUw0QNeOROFiLxnLdwPHQ5dPOeDvHzIF/+R3aECCEWtLMNcPO/JT
         wneoMtBxFnCSCCxifNvmPf0fU/dq0Kc2jLSy1TIzLrCyO+3rFMXISaLmRxpeMVwVx5wi
         dHF6G0D5Hx2dS5PGoIsJ125Fb8ukEl6vI+dds8aQlph+zEw1qP9SqtzAnj6GuHIdDtSA
         yhG0fur3BRw9OVDDtdCp6Lf73jlhlg83zfdlVHQJYAdDGtvEZsy9a+C2YCCIqqBCiDAj
         9+qhBwA+vEHxZfRVEQhCUxkcMV4Jjqn8uYOJWp9HGRe4axWx4kUMmjv7fsU79X1vk8/C
         Mk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QHklkRNKZWMLPp1VwOmkAuahUyYrpXye9QrHlmdz9QA=;
        b=BBr61VsXsv6EBGctVMqyuujEbCeisdAFhRODmt1PdF183CNALQk7hAhJ8rXWGvo9bU
         G9wt0RYqzwM1HLwdiWja8uWjpoRUJNhJce99mz9ognUFtA60kfnrGnDEXttPS1fTS71/
         T4nxkGMJuX9xH4TWoreTb2VxrcPjadXWyVklYnOr7j0QD0UTRlbnj8C5ec8onMO1Ed4j
         M1XNmC9jDCLxIfRNvv5VBUbKmB9WQejH++1qHDxDDyxfGjo5+gDR+FKJ1Sjzl2koYbO8
         bxoqDgKe/xF7T/1PjjwMK5Ua2dyWpu+xclp4yAXqrLSW49ISNygPbogexlfpWfuY+nJ4
         j0qw==
X-Gm-Message-State: AG10YOTs+nk23d0bQOzhgL2XpwWCS7w5B5lDXSajYpdBkawb0kshFP3MCbvh4WIceM+Y4Q==
X-Received: by 10.98.72.202 with SMTP id q71mr54072484pfi.69.1455061583479;
        Tue, 09 Feb 2016 15:46:23 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id 195sm346624pfa.5.2016.02.09.15.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 15:46:22 -0800 (PST)
Subject: Re: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
To:     Petri Gynther <pgynther@google.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
 <1455051354-6225-2-git-send-email-f.fainelli@gmail.com>
 <56BA53C1.3080004@gmail.com>
 <CAGXr9JHe3qHueWscFspfiOr3g3Jm9Gi0nZb3N76yvxNUve2J3A@mail.gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        Kevin Cernekee <cernekee@gmail.com>, jon.fraser@broadcom.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56BA7A0E.1080003@gmail.com>
Date:   Tue, 9 Feb 2016 15:45:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <CAGXr9JHe3qHueWscFspfiOr3g3Jm9Gi0nZb3N76yvxNUve2J3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51934
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

On 09/02/16 15:42, Petri Gynther wrote:
> On Tue, Feb 9, 2016 at 1:01 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 09/02/16 12:55, Florian Fainelli wrote:
>>> Disable pref 30 by utilizing the standard quirk method and matching the
>>> affected SoCs: 7344, 7436, 7425.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>  arch/mips/bmips/setup.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
>>> index 35535284b39e..9c8f15daf5e9 100644
>>> --- a/arch/mips/bmips/setup.c
>>> +++ b/arch/mips/bmips/setup.c
>>> @@ -100,12 +100,28 @@ static void bcm6368_quirks(void)
>>>       bcm63xx_fixup_cpu1();
>>>  }
>>>
>>> +static void bmips5000_pref30_quirk(void)
>>> +{
>>> +     __asm__ __volatile__(
>>> +     "       .word   0x4008b008\n"   /* mfc0 $8, $22, 8 */
>>> +     "       lui     $9, 0x0100\n"
>>> +     "       or      $8, $9\n"
>>> +     /* disable "pref 30" on buggy CPUs */
>>> +     "       lui     $9, 0x0800\n"
>>> +     "       or      $8, $9\n"
>>> +     "       .word   0x4088b008\n"   /* mtc0 $8, $22, 8 */
>>> +     : : : "$8", "$9");
>>
>> We are missing an additional load here to $8, I will respin this patch,
>> but would appreciate feedback on the other patches of the series so I
>> can address everything at once. Thanks!
>>
> 
> In our codebase, we currently have the following workarounds:
> LEAF(set_zephyr)
>         .set    noreorder
> 
>         /* enable read/write of CP0 #22 sel. 8 */
>         li      t0, 0x5a455048
>         .word   0x4088b00f      /* mtc0    t0, $22, 15 */
> 
>         .word   0x4008b008      /* mfc0    t0, $22, 8 */
>         li      t1, 0x09000000  /* turn off pref */
>         or      t0, t0, t1
>         .word   0x4088b008      /* mtc0    t0, $22, 8 */
>         sync
> 
>         /* disable read/write of CP0 #22 sel 8 */
>         li      t0, 0x0
>         .word   0x4088b00f      /* mtc0    t0, $22, 15 */
> 
> 
>         jr      ra
>         nop
>         .set reorder
> 
> END(set_zephyr)
> 
> 
> /* enable MIPS32R2 ROR instruction for XI TLB handlers */
>         __asm__ __volatile__(
>         "       li      $8, 0x5a455048\n"
>         "       .word   0x4088b00f\n"   /* mtc0 $8, $22, 15 */
>         "       nop; nop; nop\n"
>         "       .word   0x4008b008\n"   /* mfc0 $8, $22, 8 */
>         "       lui     $9, 0x0100\n"
>         "       or      $8, $9\n"
>         "       .word   0x4088b008\n"   /* mtc0 $8, $22, 8 */
>         "       sync\n"
>         "       li      $8, 0x0\n"
>         "       .word   0x4088b00f\n"
>         "       nop; nop; nop\n"
>         : : : "$8", "$9");
> 
> #if defined(CONFIG_BCM7425)
>         /* Disable PREF 30 */
>         __asm__ __volatile__(
>         "       li      $8, 0x5a455048\n"
>         "       .word   0x4088b00f\n"
>         "       nop; nop; nop\n"
>         "       .word   0x4008b008\n"
>         "       lui     $9, 0x0800\n"
>         "       or      $8, $8, $9\n"
>         "       .word   0x4088b008\n"
>         "       sync\n"
>         "       li      $8, 0x0\n"
>         "       .word   0x4088b00f\n"
>         "       nop; nop; nop\n"
>         : : : "$8", "$9");
> #endif
> 
> #if defined(CONFIG_BCM7425) || defined(CONFIG_BCM7429)
>         /* Disable JTB and CRS */
>         __asm__ __volatile__(
>         "       li      $8, 0x5a455048\n"
>         "       .word   0x4088b00f\n"
>         "       nop; nop; nop\n"
>         "       .word   0x4008b008\n"
>         "       li      $9, 0xfbffffff\n"
>         "       and     $8, $8, $9\n"
>         "       li      $9, 0x0400c000\n"
>         "       or      $8, $8, $9\n"
>         "       .word   0x4088b008\n"
>         "       sync\n"
>         "       li      $8, 0x0\n"
>         "       .word   0x4088b00f\n"
>         "       nop; nop; nop\n"
>         : : : "$8", "$9");
> #endif
> 
> 
> It looks like set_zephyr() does the same as the next two ("enable
> MIPS32R2 ROR instruction for XI TLB handlers" + "Disable PREF 30")
> combined?

The downstream stblinux kernel has separate build options for each SoC
(which I am trying to move away from), so we cannot just fold the two
writes into the same function, the point here is to use the
BMIPS_GENERIC quirk list to disable pref 30, which is per-chip, and do
the common Zephyr initialization during bmips_cpu_setup().

> 
> Are you planning to add the JTB and CRS workaround?

They should be in patch 2 AFAICT.
-- 
Florian
