Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jul 2013 16:13:44 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:44896 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827499Ab3GPONmZ5l5j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Jul 2013 16:13:42 +0200
Received: from mail-vb0-x230.google.com (mail-vb0-x230.google.com [IPv6:2607:f8b0:400c:c02::230])
        by mail.nanl.de (Postfix) with ESMTPSA id E4B6545FA3;
        Tue, 16 Jul 2013 14:13:17 +0000 (UTC)
Received: by mail-vb0-f48.google.com with SMTP id w15so482997vbf.21
        for <multiple recipients>; Tue, 16 Jul 2013 07:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6UlhnlFWGc0IoLlA3/ZLbGEK7Tu0xJlU9haoXPAxK5w=;
        b=kvNmZ3n6T14O1eBk7BTaufFkBPXRDxEqQAAvZB02OEpAC0lUFXiRvO+HDcmSMid+XN
         6kdiUxNsH6f1/t0F2rS/dtaygPinRNnKmfjRQOwlxKwxX5pVKF59+Enl7010PKEMxmdT
         5EDyppLe2QN9c0C8AK7BNEDAIqaeb0LsukcBb3CpCizAVhQzdIO5EtemF5/sSXNlnpXv
         HEtzcrw6c+dnChw+nPdAPnCrqQdWDYHsDC1egiINFAbPbbX90PlrQNiiZ/9E2MtxzPRJ
         dIpb4bNUKfvz9Lyg+gdbGRxCDhqrG7Qa1HIwrlm4tbo2yS/R2eOP1vB30+32zLUW7z4r
         rm/g==
X-Received: by 10.52.17.196 with SMTP id q4mr437649vdd.2.1373984016920; Tue,
 16 Jul 2013 07:13:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.177.193 with HTTP; Tue, 16 Jul 2013 07:13:16 -0700 (PDT)
In-Reply-To: <CAGVrzcbJ1N=Tr8jUpk1YHjMUZ1+psDRYj8edb3JKbb6EBkozWg@mail.gmail.com>
References: <1372537073-27370-1-git-send-email-jogo@openwrt.org> <CAGVrzcbJ1N=Tr8jUpk1YHjMUZ1+psDRYj8edb3JKbb6EBkozWg@mail.gmail.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 16 Jul 2013 16:13:16 +0200
Message-ID: <CAOiHx=mjB11ofxk3dLP-WEHyygg4awSurL7qBuVohQz0N98m=w@mail.gmail.com>
Subject: Re: [PATCH 00/10] MIPS: BCM63XX: improve BMIPS support
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37300
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

On Tue, Jul 16, 2013 at 3:06 PM, Florian Fainelli <florian@openwrt.org> wrote:
> Hello Jonas,
>
> 2013/6/29 Jonas Gorski <jogo@openwrt.org>:
>> This patchset aims at unifying the different BMIPS support code to allow
>> building a kernel that runs on multiple BCM63XX SoCs which might have
>> different BMIPS flavours on them, regardless of SMP support enabled in
>> the kernel.
>>
>> The first few patches clean up BMIPS itself and prepare it for multi-cpu
>> support, while the latter add support to BCM63XX for running a SMP kernel
>> with support for all SoCs, even those that do not have a SMP capable
>> CPU.
>>
>> This patchset is runtime tested on BCM6348, BCM6328 and BCM6368, to
>> verify that it actually does what it claims it does.
>>
>> Lacking hardware, it is only build tested for BMIPS4380 and BMIPS5000.
>>
>> Jonas Gorski (10):
>>   MIPS: bmips: fix compilation for BMIPS5000
>>   MIPS: allow asm/cpu.h to be included from assembly
>>   MIPS: bmips: add macros for testing the current bmips CPU
>>   MIPS: bmips: change compile time checks to runtime checks
>>   MIPS: bmips: merge CPU options into one option
>>   MIPS: BCM63XX: let the individual SoCs select the appropriate CPUs
>>   MIPS: bmips: add a helper function for registering smp ops
>>   MIPS: BCM63XX: always register bmips smp ops
>>   MIPS: BCM63XX: change the guard to a BMIPS4350 check
>>   MIPS: BCM63XX: disable SMP also on BCM3368
>
> After fixing the typo on BMIPS4350 vs BMIPS4380 and fixing the
> following (which I will submit just in a few minutes)
>
> @@ -187,7 +187,7 @@ static void bmips_boot_secondary(int cpu, struct task_struct
>         } else {
>                 if (cpu_is_bmips4350() || cpu_is_bmips4380()) {
>                         /* Reset slave TP1 if booting from TP0 */
> -                       if (cpu_logical_map(cpu) == 0)
> +                       if (cpu_logical_map(cpu) == 1)
>                                 set_c0_brcm_cmt_ctrl(0x01);
>                 } else if (cpu_is_bmips5000()) {
>                         if (cpu & 0x01)
>
> it works just nicely on BMIPS4380. I plan on doing some testing on
> BMIPS5000 later this week.

Great, thanks for testing. This change looks quite correct. I'll
rebase my patchset then onto your patch.


Regards
Jonas
