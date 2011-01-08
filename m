Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jan 2011 11:24:40 +0100 (CET)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:52978 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491022Ab1AHKYh convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Jan 2011 11:24:37 +0100
Received: by qyk10 with SMTP id 10so228758qyk.15
        for <linux-mips@linux-mips.org>; Sat, 08 Jan 2011 02:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eVAO3bOZwEJCQQYP+B7+6XVt2pdHeADu8OYzsWH8nUg=;
        b=jQ2OqWeWObEHHq4V2dg4kzdegv6QFBuWlk4bPQUkMkG0SorIOCH6H7mu1J0g56XL/i
         MW9y8dqk1gIK0+897DU1HJOnxTjyyK7vRdnKL/2PwrMAR1gp9o0gbcPPxjjcbUtjd/Pn
         JrZ8XyEeXmzM8H2I3qCbDyEskna/aMGWVNA4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=emuy8NLEVxoCqkTGWXLH6Br+1kdDmqOwOE+TPuwXPtsreE+WAUtyhmRFkpG/l/VNTr
         MbpKYoN/AzUpvKWadlPQ+VdL0t0l0MJiqOHVLne7IJ+5+KXNAnsRBEkO2c3RKY4VmYcL
         pyorrKfwWGJk1SyTJ+prISiAkM85h5s69/euo=
MIME-Version: 1.0
Received: by 10.229.81.12 with SMTP id v12mr3483728qck.132.1294482270626; Sat,
 08 Jan 2011 02:24:30 -0800 (PST)
Received: by 10.229.88.205 with HTTP; Sat, 8 Jan 2011 02:24:30 -0800 (PST)
In-Reply-To: <AANLkTi=zq=Tq+UxZMxdJRXWz=EZQ-oyf1gorm0uysPjk@mail.gmail.com>
References: <AANLkTikFNZiM9=Ym2sfZpstjse-zR69fh28OZ_aedUFe@mail.gmail.com>
        <AANLkTi=b52Aprg7G-bXo84W+_Ru6=VigUHRHGGDf-Y51@mail.gmail.com>
        <AANLkTimiXgBQr1arUdGgxGXnfqtoMvCMQivcujYc9VS0@mail.gmail.com>
        <AANLkTi=E7Q9kJvG1KUPv2xS3WK_12byksSrVH_g2UST2@mail.gmail.com>
        <AANLkTimR7PyJS000BsA-Q=pRXXY9Wht6_QtkRowv=OLM@mail.gmail.com>
        <AANLkTi=TgZd8XS410kYfiLp79M-=-8etgg0VEZGUme3N@mail.gmail.com>
        <AANLkTi=zq=Tq+UxZMxdJRXWz=EZQ-oyf1gorm0uysPjk@mail.gmail.com>
Date:   Sat, 8 Jan 2011 15:54:30 +0530
Message-ID: <AANLkTimGNYeg=xZJy4qr9KmSpAMsy5Ss_pF18mwi1KrM@mail.gmail.com>
Subject: Re: Questions about complete
From:   Rajat Sharma <fs.rajat@gmail.com>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <fs.rajat@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fs.rajat@gmail.com
Precedence: bulk
X-list: linux-mips

> B try to complete but cpu timer keep firing and at 8 it is time out.
> My platform is mips and is there any possibility to only let cpu timer
> be preemptible?
>

This seems really strange because when B calls complete, it sets up
condition variable value i.e. completion->done++ by disabling the
local interrupts. Following is code snippet from complete function:

        spin_lock_irqsave(&x->wait.lock, flags);
                   // This will disable interrupts
        x->done++;
                            // signals completion
        __wake_up_common(&x->wait, TASK_NORMAL, 1, 0, NULL);
        spin_unlock_irqrestore(&x->wait.lock, flags);

So now even if process A does not get a chance to execute and
completion timeout occurs before that, as you have shown in your
example, process A would still correctly knows about completion
because x->done was already set. Pleas look at the code snippet for
do_wait_for_common called from wait_for_completion_timeout:

          if (!x->done) {
                 ....
                 do {
                          ....
                 } while (!x->done && timeout);
                __remove_wait_queue(&x->wait, &wait);
                if (!x->done)
                        return timeout;
        }
        x->done--;
        return timeout ?: 1;

From above code, even if timeout expires i.e. timeout=0 and x->done is
already set, this function will still return 1.

> BTW, in x86 or other ARCH, will they try to let timer ISR be preemptible?

completion functions taking spin_lock_irqsave, so timer ISR should not
preempt the complete API.

Rajat

On Fri, Jan 7, 2011 at 7:51 PM, loody <miloody@gmail.com> wrote:
>
> hi all:
>
> 2011/1/6 Rajat Sharma <fs.rajat@gmail.com>:
> > Hi loody,
> >
> > calling complete will make the waiter process runnable but won't
> > necessarily switch to waiter thread and make it run. Its upto
> > scheduler to pick this process from run queue and execute based on its
> > priority value. I think there is not deterministic time in which the
> > waiter process will start executing.
> >
> > Probably what you want to do is calibrate timeout value in
> > wait_for_completion_timeout. I would suggest to do a binary search
> > between minimum timeout value (latency by which function A calls
> > complete, though this process can also schedule in between) to max
> > value (max your application can afford).
> >
> > Rajat
> >
> > On Thu, Jan 6, 2011 at 1:35 PM, loody <miloody@gmail.com> wrote:
> >> hi:
> >>
> >> 2011/1/6 Pavan Savoy <pavan_savoy@sify.com>:
> >>> On Thu, Jan 6, 2011 at 12:23 PM, loody <miloody@gmail.com> wrote:
> >>>> hi:
> >>>>
> >>>> 2011/1/6 Pavan Savoy <pavan_savoy@sify.com>:
> >>>>> On Thu, Jan 6, 2011 at 11:48 AM, loody <miloody@gmail.com> wrote:
> >>>>>>
> >>>>>> Dear all:
> >>>>>> I know complete will wake up the process who call wait_complete.
> >>>>>> Is there any methods I can use to measure how long from calling
> >>>>>> complete to the process that detect done=1?
> >>>>>> Regards,
> >>>>>> miloody
> >>>>>
> >>>>> returned value of wait_for_completion_timeout ?
> >>>> No.
> >>>> I want to measure the duration of complete to the time of wake up
> >>>> process who is pending on wait.
> >>>
> >>> Ah, Ok, Got it...
> >>> I would do a copy of jiffies before the complete and do a diff for
> >>> jiffies after the
> >>> wait_for_ ...
> >>>
> >>> I suppose there would be much more better/optimized way ....
> >> thank U :)
> >> why I ask so is I am porting kernel to other platform right now.
> >> and I found the time of getting complete is too long.
> >> What I mean is
> >> function A call wait_complete_timeout
> >> function B complete
> >> theoretically A will get complete and leave successfully
> >> but my platform A will told me that before timeout the complete is not got.
>
> I doubt my problem comes from cpu timer interrupt is so often such
> that when function B get the change to complete, the left time is
> almost exhausted.
> for not to be confused, I take following jiffies for example:
> 1               2            3            4            5
> 6            8
> start wait                                      B try complete
>       time out
>
> B try to complete but cpu timer keep firing and at 8 it is time out.
> My platform is mips and is there any possibility to only let cpu timer
> be preemptible?
>
> BTW, in x86 or other ARCH, will they try to let timer ISR be preemptible?
>
>
> --
> Regards,
> miloody
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
