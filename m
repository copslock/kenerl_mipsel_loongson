Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 17:51:15 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35081 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823119Ab3ILPvMzW1lV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Sep 2013 17:51:12 +0200
Received: by mail-pd0-f173.google.com with SMTP id p10so10910920pdj.32
        for <multiple recipients>; Thu, 12 Sep 2013 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MGaJ0sT7ON2vof9rxXS72tPDzBqNjk0VtPHfAxzH/Xs=;
        b=dI+1Z0KNOZn0F0vEv405B6fS12tCwe4S3oz0iQOiOprTnc1dJ4McTkOe4l4JYaRCc3
         /DqFMymtLJKWI06y0q7qw2qEHO8bWFHDSMs+OOoM12rEeekCGpZVl73zJkw+EIJ+b2cl
         pDNyMtv7MDgdK58zkfm2omCEZWZUX8LE2b3TKOZycp3L0GgiZ4+ZrhlzxFLmHJKh0KWg
         J6SRbgtyBqSQmff7wBNs5kmM0B8xciF8HOrlMgGMAMhEq83cJ9T2dB5HKP2z4om/6x2J
         mQoB7J5e1w6VLxTgMDuH6rRV/ocrG71bR1xhvR7Y6O71yEDiIsaijuHQIaQ3HjI+7E1n
         QdcA==
X-Received: by 10.66.121.234 with SMTP id ln10mr10144469pab.20.1379001065856;
 Thu, 12 Sep 2013 08:51:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.38.99 with HTTP; Thu, 12 Sep 2013 08:50:25 -0700 (PDT)
In-Reply-To: <5231DE0F.8080302@imgtec.com>
References: <1378929708-7253-1-git-send-email-Steven.Hill@imgtec.com>
 <52318BC6.7030903@imgtec.com> <j0d17e3bxlvp3famj4e32xv9.1378997855738@email.android.com>
 <CAGVrzcY_OWUSK4dfZ8fnV49ELSYE6exSYQi5AwxuGoKnvx5Rtg@mail.gmail.com>
 <5231D9E5.2080002@imgtec.com> <5231DE0F.8080302@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 12 Sep 2013 16:50:25 +0100
Message-ID: <CAGVrzcYxyWv2F1HDkOUCo2Ezicxq+UsxouOsUtz+UZAWFew18A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix errata for some 1074K cores.
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37809
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

Hello,

2013/9/12 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>:
> It is not mine, I just fixed an existent code which applies a wrong errata
> to 1074K.
> Errata fix did exist before me.

Are there any reasons why you cannot quote an internal note about this
errata which would give a better idea of what this code is about?
Sorry but the diff really does not help understand what is happening
without a proper explanation of why this is required. At first glance
it would like some revisions of the CPU are affected by some D$ bug?

>
> - Leonid.
>
>
>
> On 09/12/2013 08:12 AM, Paul Burton wrote:
>>
>> Agreed, my point is not about your code but your commit message. If I'm
>> reading a commit which works around CPU errata I should not have to go and
>> ask the hardware engineers or even read an errata document in order to know
>> what you're doing. Your commit message should explain the errata, its
>> effects and how your patch works around the problem.
>>
>> Paul
>>
>> On 12/09/13 16:05, Florian Fainelli wrote:
>>>
>>> 2013/9/12 Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>:
>>>>
>>>> Treat it as is.
>>>>
>>>> It is a dirty laundry of HW engineers and you may need to communicate
>>>> with them or read Errata docs on CPU.
>>>>
>>>> If it is about a way how it is written - ask Steven, initially it was in
>>>> mainland probe code but he think it should be a separate function. I just
>>>> corrected him, pointing that erratas on 74K and 1074K are different. But
>>>> because he insist on having the same CPU_74K for both, so...
>>>
>>> If you take a look at another CPU company such as ARM, they provide
>>> lengthy explanations for their various Erratas:
>>>
>>> config PJ4B_ERRATA_4742
>>>          bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the
>>> CPU Core to Cease Operation"
>>>          depends on CPU_PJ4B && MACH_ARMADA_370
>>>          default y
>>>          help
>>>            When coming out of either a Wait for Interrupt (WFI) or a Wait
>>> for
>>>            Event (WFE) IDLE states, a specific timing sensitivity exists
>>> between
>>>            the retiring WFI/WFE instructions and the newly issued
>>> subsequent
>>>            instructions.  This sensitivity can result in a CPU hang
>>> scenario.
>>>            Workaround:
>>>            The software must insert either a Data Synchronization Barrier
>>> (DSB)
>>>            or Data Memory Barrier (DMB) command immediately after the
>>> WFI/WFE
>>>            instruction
>>>
>>> I really think that you should aim for the same level of information
>>> so that people know whether this is relevant for their platform,
>>> whether they have the ECO applied etc...
>>
>>
>
>



-- 
Florian
