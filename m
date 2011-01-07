Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2011 15:21:40 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:49075 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490991Ab1AGOVh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jan 2011 15:21:37 +0100
Received: by iyj21 with SMTP id 21so17047496iyj.36
        for <linux-mips@linux-mips.org>; Fri, 07 Jan 2011 06:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=38ptf/hfaArb6B2lWAvl25w6hV/ntRufgm44vJh4n14=;
        b=VhhkEJ68IGaNQEufOYwbEldDfJdg4HmMxzkbVvUxp8SwlfGH6lZ2klLmgicm5r4kXf
         HKnWVoYEmd37dN7gUBNGxzE9/mgobaKlDDF68iVEt64MtbF8cG0pVkIS+BdeE8fFcPpD
         wps++LGwtFXm97VTK8IKRRQYDo0MQ7kZ1ccuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=e6r9O+cXTiJl+AHHNAlwC7Fs1iZdnlAoUycP6dN2R0iGk5G/iKHU4W3stWC/giAgpz
         diJp/L51sVC+Fq/0bedABGoqJrnqkPj8hYR4ihGn1JMcmeTF0u9iVcRJffK7cO2PtKcR
         7fXvmYel5FPda8SotmfSU5qGHK5xteCSTVqWk=
MIME-Version: 1.0
Received: by 10.42.177.137 with SMTP id bi9mr885807icb.194.1294410090543; Fri,
 07 Jan 2011 06:21:30 -0800 (PST)
Received: by 10.42.174.131 with HTTP; Fri, 7 Jan 2011 06:21:30 -0800 (PST)
In-Reply-To: <AANLkTi=TgZd8XS410kYfiLp79M-=-8etgg0VEZGUme3N@mail.gmail.com>
References: <AANLkTikFNZiM9=Ym2sfZpstjse-zR69fh28OZ_aedUFe@mail.gmail.com>
        <AANLkTi=b52Aprg7G-bXo84W+_Ru6=VigUHRHGGDf-Y51@mail.gmail.com>
        <AANLkTimiXgBQr1arUdGgxGXnfqtoMvCMQivcujYc9VS0@mail.gmail.com>
        <AANLkTi=E7Q9kJvG1KUPv2xS3WK_12byksSrVH_g2UST2@mail.gmail.com>
        <AANLkTimR7PyJS000BsA-Q=pRXXY9Wht6_QtkRowv=OLM@mail.gmail.com>
        <AANLkTi=TgZd8XS410kYfiLp79M-=-8etgg0VEZGUme3N@mail.gmail.com>
Date:   Fri, 7 Jan 2011 22:21:30 +0800
Message-ID: <AANLkTi=zq=Tq+UxZMxdJRXWz=EZQ-oyf1gorm0uysPjk@mail.gmail.com>
Subject: Re: Questions about complete
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

hi all:

2011/1/6 Rajat Sharma <fs.rajat@gmail.com>:
> Hi loody,
>
> calling complete will make the waiter process runnable but won't
> necessarily switch to waiter thread and make it run. Its upto
> scheduler to pick this process from run queue and execute based on its
> priority value. I think there is not deterministic time in which the
> waiter process will start executing.
>
> Probably what you want to do is calibrate timeout value in
> wait_for_completion_timeout. I would suggest to do a binary search
> between minimum timeout value (latency by which function A calls
> complete, though this process can also schedule in between) to max
> value (max your application can afford).
>
> Rajat
>
> On Thu, Jan 6, 2011 at 1:35 PM, loody <miloody@gmail.com> wrote:
>> hi:
>>
>> 2011/1/6 Pavan Savoy <pavan_savoy@sify.com>:
>>> On Thu, Jan 6, 2011 at 12:23 PM, loody <miloody@gmail.com> wrote:
>>>> hi:
>>>>
>>>> 2011/1/6 Pavan Savoy <pavan_savoy@sify.com>:
>>>>> On Thu, Jan 6, 2011 at 11:48 AM, loody <miloody@gmail.com> wrote:
>>>>>>
>>>>>> Dear all:
>>>>>> I know complete will wake up the process who call wait_complete.
>>>>>> Is there any methods I can use to measure how long from calling
>>>>>> complete to the process that detect done=1?
>>>>>> Regards,
>>>>>> miloody
>>>>>
>>>>> returned value of wait_for_completion_timeout ?
>>>> No.
>>>> I want to measure the duration of complete to the time of wake up
>>>> process who is pending on wait.
>>>
>>> Ah, Ok, Got it...
>>> I would do a copy of jiffies before the complete and do a diff for
>>> jiffies after the
>>> wait_for_ ...
>>>
>>> I suppose there would be much more better/optimized way ....
>> thank U :)
>> why I ask so is I am porting kernel to other platform right now.
>> and I found the time of getting complete is too long.
>> What I mean is
>> function A call wait_complete_timeout
>> function B complete
>> theoretically A will get complete and leave successfully
>> but my platform A will told me that before timeout the complete is not got.

I doubt my problem comes from cpu timer interrupt is so often such
that when function B get the change to complete, the left time is
almost exhausted.
for not to be confused, I take following jiffies for example:
1               2            3            4            5
6            8
start wait                                      B try complete
       time out

B try to complete but cpu timer keep firing and at 8 it is time out.
My platform is mips and is there any possibility to only let cpu timer
be preemptible?

BTW, in x86 or other ARCH, will they try to let timer ISR be preemptible?


-- 
Regards,
miloody
