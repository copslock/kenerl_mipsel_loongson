Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2010 18:34:08 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:51530 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492335Ab0LBReA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Dec 2010 18:34:00 +0100
Received: by fxm19 with SMTP id 19so3474129fxm.36
        for <multiple recipients>; Thu, 02 Dec 2010 09:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yydP2uiy442hR+TIm/kShJP+obcsROR/MsBao3CxDZc=;
        b=HWfiutyxl3oDpVvgsQH8aJ9A7GwYGQOHJi7Egez+ZZwI3HgR8jVoNucSXeEPP/HnbS
         kXdDhm5eKN8dXEMcWbR5lTefkzX7VqTlsRvKFudKb/8bRCleLvuTAVhzCso/IeTE8Sio
         PUPX5DGR0mtspSoFDF2G35yFCTNVrdzVNXMco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wTIsszDExjYw8lHlPnIDUzYQva2I6AhdUOpP9bXgz2hSGP2ZcRHIgGHGptIPZK8vvn
         4YIk9ntlpQRvpc8+QRyJAP+Go2FxMt8vWN8n9gTgq+FGOnePMm+x+O98yY9hQQK52EFX
         bfhB9vg4HDt0Jx5VkKP1V0Wgcw9fy2sSL97WU=
MIME-Version: 1.0
Received: by 10.223.79.72 with SMTP id o8mr878180fak.83.1291310849161; Thu, 02
 Dec 2010 09:27:29 -0800 (PST)
Received: by 10.223.101.198 with HTTP; Thu, 2 Dec 2010 09:27:29 -0800 (PST)
In-Reply-To: <4CF78755.2070109@mvista.com>
References: <1291220307.31413.14.camel@paanoop1-desktop>
        <4CF78755.2070109@mvista.com>
Date:   Thu, 2 Dec 2010 22:57:29 +0530
Message-ID: <AANLkTinkF8_2hO7Ko=S6w2NPPX8oGTcdbRyd=7N0mUbM@mail.gmail.com>
Subject: Re: [RFC 1/3] VSMP support for msp71xx family of platforms.
From:   anoop pa <anoop.pa@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        mcdonald.shane@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Dec 2, 2010 at 5:17 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> On 01.12.2010 19:18, Anoop P A wrote:
>
>   Don't include this into the patch, or Ralf will have to hand edit it out.
>

Sure. Will take care in next patch series onwards.

>> Cc: anoop.pa@gmail.com
>
>   This should be in the signoff section.
>
OK

>> msp_smp.c initiliase IPI call and resched irq.
>
>   Only "initializes".
>

Sorry my bad.

>> -obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o
>> +obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o msp_irq_per.o
>
>   What does this change have to do with the rest of the patch?
>
This change is required for next patch in this. series.Is this
potentially wrong .
 Do I want to move this to next patch?

>   Your patch is line-wrapped.
>

Will take care while creating next set of patches.


>> +#define MIPS_CPU_IPI_CALL_IRQ 1                /* SW int 1 for call */
>
>   Align the comments please, and align the macro values with a tab.
>
Ok

>> +static struct irqaction irq_resched = {
>> +       .handler        = ipi_resched_interrupt,
>> +       .flags          = IRQF_DISABLED|IRQF_PERCPU,
>
>   Need spaces around |.
>

O.k

>   Need an empty line here.
>

Ok

>> +       set_vi_handler (MIPS_CPU_IPI_CALL_IRQ, ipi_call_dispatch);
>
>   Spaces between the function name and ( are not allowed -- run your patch
> thru scripts/checkpatch.pl.
Not sure what went wrong. I had checked it before sending .

linux.git$ ./scripts/checkpatch.pl
0001-VSMP-support-for-msp71xx-family-of-platforms.patch
total: 0 errors, 0 warnings, 84 lines checked

0001-VSMP-support-for-msp71xx-family-of-platforms.patch has no obvious
style problems and is ready for submission.

>
> WBR, Sergei
>
Sergei Thank you very much reviewing the code.

Regards,
Anoop
