Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 00:42:42 +0100 (CET)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35748 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011376AbcBIXmkdAcHO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 00:42:40 +0100
Received: by mail-ig0-f180.google.com with SMTP id hb3so3206365igb.0
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 15:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pQe1UQwQkFBSSmSw1mYAlFeqWFFKyyYCnOMVm/TcLJI=;
        b=U42fCnkzu9ZcbsbSE+zWJGQGxYGsJ5wC0NoCJD7Kon1GQmIWg0UprlP0o+GQ8s7Tfo
         Q5oseYJSLQ0uGsV4AvmsiNsaqs3vESiGejGUdeUr01phqvuXFyRMmnmn/yO/luLI3N+k
         NRNFSZHkFx579YNttOlIg0bvkcABKR305au5kUv2CfBQePyk7g7Cnb6UbMGboTgS4Oaw
         j5kjqNL+/rlERGPIO12Y42xO9K2r4p/LRox34gndbrmILFAI8m0ok7V3Q7k+8OEpVuDO
         AhnfvXM20PnzTmc7xoxoCbc2eEa+beTlUaamj/rLYJUH5Rv7uP2X6eVZHNXW4PC7x0eL
         +B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pQe1UQwQkFBSSmSw1mYAlFeqWFFKyyYCnOMVm/TcLJI=;
        b=bdOcr4r7f1xpOEzexU0PfOk1edWmU8/nflgaBw2RDSwdK0II7TFqFSUIdNcjsAG7oc
         fufb78L6GP0/SPwUJK7zVXAvGZ9Bu6fCEBcefzbginUQ7p/kWGnih6QfJugpbeYb8z33
         QIai5msGnFdk7VgnewoL/w8LLd/mUxX4ZWHhbwBH4lFdVnBE4GFaGy0N9JXi2qurvZJl
         IRXMlblfNK3rnJuKNWRyGatyiZuPIr5pLmAxXk1Mm2KCW8QcqjyB/DApHc1cDYJGwYno
         TG6ZbgoDQxD4Ajeg8yg375vr076TIvhjwReNbGHE7sog5Hl/2sPMf9T1iJPKLc+scq2l
         iVAQ==
X-Gm-Message-State: AG10YOR4Pv4zd3AJwE3HYEXq3v6S4SDFq7NW1qiFSk21+iL97PNWGfzBsPIF9KeASdqTvNAtDqnTtzB60hZMzPZt
MIME-Version: 1.0
X-Received: by 10.50.138.72 with SMTP id qo8mr7008741igb.81.1455061354632;
 Tue, 09 Feb 2016 15:42:34 -0800 (PST)
Received: by 10.64.77.80 with HTTP; Tue, 9 Feb 2016 15:42:34 -0800 (PST)
In-Reply-To: <56BA53C1.3080004@gmail.com>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
        <1455051354-6225-2-git-send-email-f.fainelli@gmail.com>
        <56BA53C1.3080004@gmail.com>
Date:   Tue, 9 Feb 2016 15:42:34 -0800
Message-ID: <CAGXr9JHe3qHueWscFspfiOr3g3Jm9Gi0nZb3N76yvxNUve2J3A@mail.gmail.com>
Subject: Re: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
From:   Petri Gynther <pgynther@google.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        Kevin Cernekee <cernekee@gmail.com>, jon.fraser@broadcom.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <pgynther@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pgynther@google.com
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

On Tue, Feb 9, 2016 at 1:01 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 09/02/16 12:55, Florian Fainelli wrote:
>> Disable pref 30 by utilizing the standard quirk method and matching the
>> affected SoCs: 7344, 7436, 7425.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  arch/mips/bmips/setup.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
>> index 35535284b39e..9c8f15daf5e9 100644
>> --- a/arch/mips/bmips/setup.c
>> +++ b/arch/mips/bmips/setup.c
>> @@ -100,12 +100,28 @@ static void bcm6368_quirks(void)
>>       bcm63xx_fixup_cpu1();
>>  }
>>
>> +static void bmips5000_pref30_quirk(void)
>> +{
>> +     __asm__ __volatile__(
>> +     "       .word   0x4008b008\n"   /* mfc0 $8, $22, 8 */
>> +     "       lui     $9, 0x0100\n"
>> +     "       or      $8, $9\n"
>> +     /* disable "pref 30" on buggy CPUs */
>> +     "       lui     $9, 0x0800\n"
>> +     "       or      $8, $9\n"
>> +     "       .word   0x4088b008\n"   /* mtc0 $8, $22, 8 */
>> +     : : : "$8", "$9");
>
> We are missing an additional load here to $8, I will respin this patch,
> but would appreciate feedback on the other patches of the series so I
> can address everything at once. Thanks!
>

In our codebase, we currently have the following workarounds:
LEAF(set_zephyr)
        .set    noreorder

        /* enable read/write of CP0 #22 sel. 8 */
        li      t0, 0x5a455048
        .word   0x4088b00f      /* mtc0    t0, $22, 15 */

        .word   0x4008b008      /* mfc0    t0, $22, 8 */
        li      t1, 0x09000000  /* turn off pref */
        or      t0, t0, t1
        .word   0x4088b008      /* mtc0    t0, $22, 8 */
        sync

        /* disable read/write of CP0 #22 sel 8 */
        li      t0, 0x0
        .word   0x4088b00f      /* mtc0    t0, $22, 15 */


        jr      ra
        nop
        .set reorder

END(set_zephyr)


/* enable MIPS32R2 ROR instruction for XI TLB handlers */
        __asm__ __volatile__(
        "       li      $8, 0x5a455048\n"
        "       .word   0x4088b00f\n"   /* mtc0 $8, $22, 15 */
        "       nop; nop; nop\n"
        "       .word   0x4008b008\n"   /* mfc0 $8, $22, 8 */
        "       lui     $9, 0x0100\n"
        "       or      $8, $9\n"
        "       .word   0x4088b008\n"   /* mtc0 $8, $22, 8 */
        "       sync\n"
        "       li      $8, 0x0\n"
        "       .word   0x4088b00f\n"
        "       nop; nop; nop\n"
        : : : "$8", "$9");

#if defined(CONFIG_BCM7425)
        /* Disable PREF 30 */
        __asm__ __volatile__(
        "       li      $8, 0x5a455048\n"
        "       .word   0x4088b00f\n"
        "       nop; nop; nop\n"
        "       .word   0x4008b008\n"
        "       lui     $9, 0x0800\n"
        "       or      $8, $8, $9\n"
        "       .word   0x4088b008\n"
        "       sync\n"
        "       li      $8, 0x0\n"
        "       .word   0x4088b00f\n"
        "       nop; nop; nop\n"
        : : : "$8", "$9");
#endif

#if defined(CONFIG_BCM7425) || defined(CONFIG_BCM7429)
        /* Disable JTB and CRS */
        __asm__ __volatile__(
        "       li      $8, 0x5a455048\n"
        "       .word   0x4088b00f\n"
        "       nop; nop; nop\n"
        "       .word   0x4008b008\n"
        "       li      $9, 0xfbffffff\n"
        "       and     $8, $8, $9\n"
        "       li      $9, 0x0400c000\n"
        "       or      $8, $8, $9\n"
        "       .word   0x4088b008\n"
        "       sync\n"
        "       li      $8, 0x0\n"
        "       .word   0x4088b00f\n"
        "       nop; nop; nop\n"
        : : : "$8", "$9");
#endif


It looks like set_zephyr() does the same as the next two ("enable
MIPS32R2 ROR instruction for XI TLB handlers" + "Disable PREF 30")
combined?

Are you planning to add the JTB and CRS workaround?


>> +}
>> +
>>  static const struct bmips_quirk bmips_quirk_list[] = {
>>       { "brcm,bcm3384-viper",         &bcm3384_viper_quirks           },
>>       { "brcm,bcm33843-viper",        &bcm3384_viper_quirks           },
>>       { "brcm,bcm6328",               &bcm6328_quirks                 },
>>       { "brcm,bcm6368",               &bcm6368_quirks                 },
>>       { "brcm,bcm63168",              &bcm6368_quirks                 },
>> +     { "brcm,bcm7344",               &bmips5000_pref30_quirk         },
>> +     { "brcm,bcm7346",               &bmips5000_pref30_quirk         },
>> +     { "brcm,bcm7425",               &bmips5000_pref30_quirk         },
>>       { },
>>  };
>>
>>
>
>
> --
> Florian
