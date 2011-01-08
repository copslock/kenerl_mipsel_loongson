Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jan 2011 20:34:03 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:41674 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491026Ab1AHTeA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Jan 2011 20:34:00 +0100
Received: by fxm19 with SMTP id 19so17220132fxm.36
        for <linux-mips@linux-mips.org>; Sat, 08 Jan 2011 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s3x+vER1dHBDK5f6jr2dRooywVSNQNKrAMpNtHlyLaw=;
        b=CB3Df+MY/Hu9VqfUK5Jy3dFUpiwRJ0zNaApaCqF+VZpaEN97qJsxnArfC8QMdA/2ii
         RUYRwT2tQ5BmEbxpP1N3c/VLr3IwQd7GNSJ3f55C8TMvLYTkumaXXtxlDbV27eOxjjTY
         WO4CvP1TGMPhlYqzw09k4ck5VpW6JfaRf7QjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aRCBSJ8EHQbUNniuZs+vA5YKSU+BJBRktG+dc1kUP94NZwbul3w1LmfYf86paymPEz
         LcqNNCkJ4liuJ0gtPLCUFhMUww2XAuh60bnRbvki2uci+t7U4L303V/28j/pxXhLMZlM
         hg2RLyBiS0JP0CrYtMtir+5daHrJ/U7rAzMHA=
MIME-Version: 1.0
Received: by 10.223.100.16 with SMTP id w16mr181825fan.85.1294515233261; Sat,
 08 Jan 2011 11:33:53 -0800 (PST)
Received: by 10.223.74.136 with HTTP; Sat, 8 Jan 2011 11:33:53 -0800 (PST)
In-Reply-To: <4D275F80.2000307@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>
        <1293470392.27661.202.camel@paanoop1-desktop>
        <1293524389.27661.210.camel@paanoop1-desktop>
        <4D19A31E.1090905@paralogos.com>
        <1293798476.27661.279.camel@paanoop1-desktop>
        <4D1EE913.1070203@paralogos.com>
        <1294067561.27661.293.camel@paanoop1-desktop>
        <4D21F5D3.50604@paralogos.com>
        <1294082426.27661.330.camel@paanoop1-desktop>
        <4D22D7B3.2050609@paralogos.com>
        <1294146165.27661.361.camel@paanoop1-desktop>
        <1294151822.27661.375.camel@paanoop1-desktop>
        <4D235717.1000603@paralogos.com>
        <1294163657.27661.386.camel@paanoop1-desktop>
        <4D2367EE.7000702@paralogos.com>
        <1294233097.27661.391.camel@paanoop1-desktop>
        <4D24C525.5000306@paralogos.com>
        <1294345396.27661.422.camel@paanoop1-desktop>
        <4D2650D6.4030102@paralogos.com>
        <1294387019.27661.458.camel@paanoop1-desktop>
        <4D275F80.2000307@paralogos.com>
Date:   Sun, 9 Jan 2011 01:03:53 +0530
Message-ID: <AANLkTi=CD+RmXNsukqmpH5xwTbwfnEr5LK92tJf-FsSn@mail.gmail.com>
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Jan 8, 2011 at 12:16 AM, Kevin D. Kissell <kevink@paralogos.com> wrote:
> On 01/06/11 23:56, Anoop P A wrote:
>>
>> On Thu, 2011-01-06 at 15:31 -0800, Kevin D. Kissell wrote:
>>>
>>> I'm sure I've said this before, and it's in various comments in the SMTC
>>> code, but...
>
> As an aside to this conversation, would it be possible to create a
> Documentation/mips/SMTC.txt file that would actually propagate
> upstream, so that I'd stop being the sole repository of SMTC folklore?
> I only maintain it as a hobby.
>>
>> Ok. Well thanks much for your detailed explanation. Well I hope I found
>> the root cause . smtc_clockevent_init() was overriding irq_hwmask even
>> if are using platform specific get_c0_compare_int. With following patch
>> everything seems to be working for me.
>> ------------------------------------------------------------------------
>> diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
>> index 2e72d30..a25fc59 100644
>> --- a/arch/mips/kernel/cevt-smtc.c
>> +++ b/arch/mips/kernel/cevt-smtc.c
>> @@ -310,9 +310,14 @@ int __cpuinit smtc_clockevent_init(void)
>>                return 0;
>>        /*
>>         * And we need the hwmask associated with the c0_compare
>> -        * vector to be initialized.
>> +        * vector to be initialized. However incase of platform
>> +        * specific get_co_compare_int, don't override irq_hwmask
>> +        * expect platform code to set a valid mask value.
>>         */
>> -       irq_hwmask[irq] = (0x100<<  cp0_compare_irq);
>> +
>> +       if (!get_c0_compare_int)
>> +               irq_hwmask[irq] = (0x100<<  cp0_compare_irq);
>> +
>>        if (cp0_timer_irq_installed)
>>                return 0;
>> -----------------------------------------------------------------------
>
> I'm still not clear on one point that, to me, is pretty important when
> engineering a fix here.  Are you, in fact, using the Count/Compare
> interrupt system, but having the externalization of the compare
> interrupt routed back through an intervening interrupt controller,
> or is your timer coming from another source?
>
> In the former case, I think you're on the right track as to the
> possible cause of a problem, but the fix should actually be simpler
> and rather more elegant.  Why can't you simply see to it that
> cp0_compare_irq is set to the right value, either at compile time,
> or in your earliest platform initialization of the interrupt controller?
> That would be a one-line, inline change and spare us another
> cryptic conditional.

Yes ,it is first case.

http://git.linux-mips.org/?p=linux.git;a=commit;h=38760d40ca61b18b2809e9c28df8b3ff9af8a02b

Above mentioned patch enables platforms to utilize 4k timer code with
platform specific timer interrupts. cevt-smtc also had ( copied from cevt-r4k)
referred code. Given the specific irq  support in cevt-smtc we should add
support for specific hwmask , IMHO.

>
> In the later case, you'll presumably be having lots of other problems,
> as cevt-smtc.c is intertwined with cevt-r4k.c and the Count/Compare
> paradigm.
>
>            Regards,
>
>            Kevin K.
>
>
