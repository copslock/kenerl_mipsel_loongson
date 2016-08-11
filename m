Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2016 04:00:18 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33195 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992936AbcHKCAMUl03E convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Aug 2016 04:00:12 +0200
Received: by mail-pa0-f66.google.com with SMTP id vy10so3736416pac.0;
        Wed, 10 Aug 2016 19:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Mkj1K/D4i85RTsitJHdvZtjXGfuGjaPzHk3V8xek7tU=;
        b=eWoEJhT0F9TQlpoP/x1k5Q91Hjv2jOH0gQy2WAkFo0ZUl3hSN+nvdS2iidAQyLF8X3
         1kWSqbJy+BJS/3TiMZNL9Bf7xs6s76dBcSRrqAyb9glk060rXuYhz0kbotiYIJqToY5Q
         jgH+aUc6T6eacR6NTP8/HBZsrPM9IjlPy7rPkAyfDvG6poCJpRl+KpTTk3Fw4PxKqgAl
         dkgzkNPDspeQ6bT+Lxtw2iUDAUkAewvYt1u3VYOZchZZUsNFTd+xWUWJwoox6KCMsxr2
         txhXSW1DQfhUBdq1VnsPA+Oah2lM1yNUr6kTkJ/X2smDVFbOryyIwbw07gsFv45OmT14
         kOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Mkj1K/D4i85RTsitJHdvZtjXGfuGjaPzHk3V8xek7tU=;
        b=hS0UQPrOOVukEYYMzu8el1AvgWR/ss3CZBYp+TPm+hYALNGD8jjYy4zW1N1EGj6hOP
         VvFZhZ1d6Ez7QG3f0iDvNnu/jJg8ZB5ZGjHE0xPcmXKs0YRK8FjgpEl1YMOYVyDAwMp2
         LoUYPrtJdiSoxt4Me4dCgLknMVUPFXi1ghJVNZhWJeXX0JM/O3lhIGv8FP2XLKnwqzrX
         tckKM71WiNoFeBZPnZEELTvdVO1qhp3L2yJkRpnb72r+a+2znEog7jALGBfad7W639U3
         /I3rt2cPSMWpqYaRvf6ETWMwFo3CLhTglabUp3DseUEsv8/69Okz0fVarFo//YZBJ4vI
         t8yw==
X-Gm-Message-State: AEkoouvtCuKTdDyOyKOOYmjKgh3Ki0kl9GUrEXAHpfZ4tJk1K6SFVVLWt/JalIFRq9q+KQ==
X-Received: by 10.66.43.7 with SMTP id s7mr12695085pal.27.1470880806141;
        Wed, 10 Aug 2016 19:00:06 -0700 (PDT)
Received: from [172.16.1.101] ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id o8sm282154pav.5.2016.08.10.19.00.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 19:00:05 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/4] MIPS: BMIPS: Add support GPIO device nodes
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <CAOiHx=n19Sb3B1_FGkdzqxWqi5Vpy5PQbYWdaVvNaUTW+Njcog@mail.gmail.com>
Date:   Thu, 11 Aug 2016 11:00:00 +0900
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <2D0C8F56-B6B7-4079-B0D1-7277781C27E4@gmail.com>
References: <20160808021719.4680-1-jaedon.shin@gmail.com> <20160808021719.4680-3-jaedon.shin@gmail.com> <CAOiHx=kxjXiYm_4S3rLOjB0wM-UpQsqfXn+EVq6+FGOH4whuuQ@mail.gmail.com> <D5F26D94-8312-4CAC-8577-205A1AAFB0E5@gmail.com> <CAOiHx=n19Sb3B1_FGkdzqxWqi5Vpy5PQbYWdaVvNaUTW+Njcog@mail.gmail.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
X-Mailer: Apple Mail (2.3124)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Jonas,

On Aug 9, 2016, at 11:14 PM, Jonas Gorski <jonas.gorski@gmail.com> wrote:
> 
> Hi,
> 
> On 9 August 2016 at 03:44, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> Hi Jonas,
>> 
>> On Aug 8, 2016, at 11:06 PM, Jonas Gorski <jonas.gorski@gmail.com> wrote:
>>> 
>>> Hi,
>>> 
>>> please always include devicetree for any dts(i) related changes.
>>> 
>>> On 8 August 2016 at 04:17, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>>>> (snip)
>>>> diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>>>> index 9db84f2a6664..dd8b8fb97053 100644
>>>> --- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>>>> +++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>>>> @@ -59,6 +59,14 @@
>>>>       status = "okay";
>>>> };
>>>> 
>>>> +&upg_gio {
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&upg_gio_aon {
>>>> +       status = "okay";
>>>> +};
>>>> +
>>> 
>>> You don't set their status in the dtsi, they will be enabled by
>>> default, and you can drop this change.
>>> 
>>>> &enet0 {
>>>>       status = "okay";
>>>> };
>>> 
>>> 
>>> Regards
>>> Jonas
>> 
>> The status="disabled" has been missing. It will be added in v2.
>> The interrupt-controller@ will also be changed.
> 
> I thought that was indented, since GPIO controllers usually are always
> present (you don't disable the irq controllers by default either).
> 
> Not that I want to tell you how you do your dts(i) files, but I would
> expect things that you usually always need (irq, clocks, gpios) are
> present by default.
> 
> 
> Regards
> Jonas

I checked the BCM7445 ARM based SoC device tree and other BRCM boards, and
I agree with your point. The status="okay" nodes will be removed in v2.

Thanks,
Jaedon
From Marcin.Nowakowski@imgtec.com Thu Aug 11 09:02:49 2016
Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2016 09:02:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22130 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990510AbcHKHCt3gfMm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2016 09:02:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E2804D3725784;
        Thu, 11 Aug 2016 08:02:30 +0100 (IST)
Received: from WR-NOWAKOWSKI.wr.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 11 Aug 2016 08:02:32 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: uprobes: fix incorrect uprobe brk handling
Date:   Thu, 11 Aug 2016 09:02:30 +0200
Message-ID: <1470898950-26077-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

When a uprobe-replacement breakpoint instruction is handled, a notifier
is called with DIE_UPROBE argument, but a corresponding exception notify
handler for MIPS attempts to handle DIE_BREAK instead. As a result
the breakpoint instruction isn't handled by the uprobe code and the probed
application terminates with SIGTRAP.
Fix this by changing arch_uprobe_exception_notify code to handle
DIE_UPROBE as a pre-singlestep condition instead of DIE_BREAK.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 8452d93..1149b30 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -222,7 +222,7 @@ int arch_uprobe_exception_notify(struct notifier_block *self,
 		return NOTIFY_DONE;
 
 	switch (val) {
-	case DIE_BREAK:
+	case DIE_UPROBE:
 		if (uprobe_pre_sstep_notifier(regs))
 			return NOTIFY_STOP;
 		break;
-- 
2.7.4
