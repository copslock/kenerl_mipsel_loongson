Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 20:03:42 +0100 (CET)
Received: from mail-fx0-f217.google.com ([209.85.220.217]:58189 "EHLO
        mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491940Ab0CJTDg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Mar 2010 20:03:36 +0100
Received: by fxm9 with SMTP id 9so4178073fxm.24
        for <multiple recipients>; Wed, 10 Mar 2010 11:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=tf9EaUrKYoMk4jXBEAiNDG2slOj0Dmw6Ip+tXcn3krE=;
        b=KWipMntl3xauDGSPiIsJvvAaKBlNyxEkjWBoAGcyR76AFFYKHeShSHi6WT22L+fAqc
         BjzoZFweiilGGzmBMyyIUf0VUfVit1NdlaHaLhui/zfO2g1I7+NwpdZ3VQKMLdgHsJwJ
         CoVB3tXekurzPEG8oCB2EWAZE+W3Qmo0gFArs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=C2v/drgYWR2nvHXzP2hY/1S5wHG2nnZX6iwlogzHHu1Y+rUUQUwKJfY7vw2+i7J7IB
         eOD+dZhigIkzS1aUu2NjqmguH+q3cMzU/5zVA1XKv8grJnYgAXKPluCg6Q92+Aum+jUL
         hvZhG2XPgLkF/pFVEttRurkouvM1XiRrlU4W4=
MIME-Version: 1.0
Received: by 10.223.76.74 with SMTP id b10mr2146451fak.55.1268247809521; Wed, 
        10 Mar 2010 11:03:29 -0800 (PST)
In-Reply-To: <20100310161312.GB15118@linux-mips.org>
References: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>
         <1268076181-29642-2-git-send-email-manuel.lauss@gmail.com>
         <20100310161312.GB15118@linux-mips.org>
Date:   Wed, 10 Mar 2010 20:03:29 +0100
Message-ID: <f861ec6f1003101103k39ba8b1cn4f80ecfe486f77ed@mail.gmail.com>
Subject: Re: [RFC PATCH] MIPS: Alchemy: add sysdev for both irq controllers
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 10, 2010 at 5:13 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Mar 08, 2010 at 08:23:00PM +0100, Manuel Lauss wrote:
>
>> From: Manuel Lauss <mano@roarinelk.homelinux.net>
>>
>> Use a sysdev to implement PM methods for the Au1000 interrupt controllers.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>> Works on DB1200, not sure though whether this is the correct approach.
>> Applies cleanly only on top of "sleepcode-without-compile-time-cputype"
>> patch.
>
> At a quick glance this looks good but since you marked your patch as RFC
> I'll do the same in patchwork (http://patchwork.linux-mips.org/patch/1039/)
> until you ask me to queue it or resubmit.

I'll resend a refined version.

Manuel
