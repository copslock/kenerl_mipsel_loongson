Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 May 2013 23:56:55 +0200 (CEST)
Received: from mail-qe0-f54.google.com ([209.85.128.54]:36410 "EHLO
        mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835081Ab3E2V4ujlH8S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 May 2013 23:56:50 +0200
Received: by mail-qe0-f54.google.com with SMTP id i11so5397780qej.41
        for <linux-mips@linux-mips.org>; Wed, 29 May 2013 14:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :x-gm-message-state;
        bh=5N3JJoghF4bWQpbjPEBLtJYNqEq0PRQlMt/KniGeCPk=;
        b=mCHtWgm0JggH11hp7MIy1wlzIwU/hlILqoTg8QlGhkdz2cHpJS/Akh+pqG6IzhQH/Z
         IDexWFScVBAhpGNASmhRtMSBwuTDqm26gLaJp84uAx8jjDu70V7yUSWIueE8iqaRMeIn
         eG4U7cfDcvnOr+jhLhhyX/N7ybNRXFRYS0f6tFaVFNmm6kl2trQdzK57iP0BjRewT47m
         53sjN/ezwIfOBm+wVjnSpmGFJKGjONiFzICqAGe4zL2uKGck2kjPt45mlcmKk2fle4H5
         21OtcrRl6aM9UEfnae3QUluOKsju7Iz1FMvyv2f0tF1vbUlJDUyvIqFIFGZWjw+BXl+P
         ddGg==
MIME-Version: 1.0
X-Received: by 10.229.77.99 with SMTP id f35mr1728287qck.65.1369864604248;
 Wed, 29 May 2013 14:56:44 -0700 (PDT)
Received: by 10.49.63.73 with HTTP; Wed, 29 May 2013 14:56:44 -0700 (PDT)
X-Originating-IP: [212.159.75.221]
In-Reply-To: <20130529173634.GA2020@redhat.com>
References: <1369846916-13202-1-git-send-email-james.hogan@imgtec.com>
        <51A638A4.2000705@gmail.com>
        <20130529173634.GA2020@redhat.com>
Date:   Wed, 29 May 2013 22:56:44 +0100
X-Google-Sender-Auth: 0UnJQ0Vw4BWJ322ZjkdkCqs6n3s
Message-ID: <CAAG0J9_yJd5mf0t7whnKDYtf0AdZDnErjOgUga7t0p3TEL_9YQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kernel/signal.c: avoid BUG_ON with SIG128 (MIPS)
From:   James Hogan <james.hogan@imgtec.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQmKe3Qs0VH+jD/7d9ciDbkwoUtWA+2TYaEPIpbQYEF/EgESKRrnEiX02AZYfq0ISYhtAXQt
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36635
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 29 May 2013 18:36, Oleg Nesterov <oleg@redhat.com> wrote:
> On 05/29, David Daney wrote:
>>
>> On 05/29/2013 10:01 AM, James Hogan wrote:
>>> MIPS has 128 signals, the highest of which has the number 128. The
>>
>> I wonder if we should change the ABI and reduce the number of signals to
>> 127 instead of this patch.
>
> Same thoughts...

I'll give it a try. I wouldn't have thought it'd break anything, but
you never know. glibc (incorrectly) sets [__]SIGRTMAX to 127 already.
On the other hand uClibc sets it to 128, so anything built against
uClibc that uses signals SIGRTMAX-n (where n may be 0) or uses an
excessive number of rt signals starting from SIGRTMIN (sounds
unlikely) could well need an updated uClibc (or a full rebuild if it's
crazy enough to use __SIGRTMAX).

>>> @@ -2366,8 +2366,12 @@ relock:
>>>
>>>              /*
>>>               * Death signals, no core dump.
>>> +             *
>>> +             * MIPS has a signal number 128 which clashes with the core dump
>>> +             * bit. If this was the signal we still want to report a valid
>>> +             * exit code, so round it down to 127.
>>>               */
>>> -            do_group_exit(info->si_signo);
>>> +            do_group_exit(min(info->si_signo, 127));
>
> This avoids BUG_ON() but obviously fools WIFSIGNALED(), doesn't look
> very nice.

Agreed.

Cheers
James
