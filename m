Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Oct 2011 09:13:42 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:42020 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490993Ab1JBHNf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Oct 2011 09:13:35 +0200
Received: by wyi11 with SMTP id 11so2921582wyi.36
        for <multiple recipients>; Sun, 02 Oct 2011 00:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=InfL9PfFLh7NXF75ElkvYYLBfxg1FvvPycS5vaOkt8M=;
        b=pAwkfxtruTkfyXVdiDIEHCnsRmzaFUU9VsydV/wH2yfn547+DnLgTEU92R/XiqEZWO
         HZEjjmQgIteW41NeTplA+oG/wiszcgF0N0G4n9cr1t+YzNVQZhCBr4ndZSceyDH3EzXB
         ArPZX8vMLo1CGViLHEotOkQQFL3JmPzNjCx98=
MIME-Version: 1.0
Received: by 10.216.230.2 with SMTP id i2mr1869147weq.28.1317539609717; Sun,
 02 Oct 2011 00:13:29 -0700 (PDT)
Received: by 10.216.73.193 with HTTP; Sun, 2 Oct 2011 00:13:29 -0700 (PDT)
In-Reply-To: <20111001073936.GA15674@jayachandranc.netlogicmicro.com>
References: <CAJd=RBDQ9eyfgWkgsdUrojteqbnribZyk0QATr3CgPXLbBDkPQ@mail.gmail.com>
        <20111001073936.GA15674@jayachandranc.netlogicmicro.com>
Date:   Sun, 2 Oct 2011 15:13:29 +0800
Message-ID: <CAJd=RBCizzWyLT_U97RBWC=WAfJaY0Dbr6PH+6bxUvW-JdFhuQ@mail.gmail.com>
Subject: Re: [RFC] count TLB refill for Netlogic XLR chip
From:   Hillf Danton <dhillf@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhillf@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 428

On Sat, Oct 1, 2011 at 3:39 PM, Jayachandran C.
<jayachandranc@netlogicmicro.com> wrote:
> On Sat, Oct 01, 2011 at 01:19:53PM +0800, Hillf Danton wrote:
>> TLB miss is one of the concerned factors when tuning the performance of user
>> applications, and there are on netlogic XLR chip eight 64-bit registers,
>> c0 register 22 select 0-7, which could be used as temporary storage.
>>
>> One of them is used for counting TLB refill, and any comment is appreciated.
>>
>
> Few comments:
>
> Adding this unconditionally will add overhead to the TLB refill handler, this
> should be probably controlled by a boot-time variable, or with some
> perf/profile framework.
>

Boot-time variable will be added.

> If you have access to our SDK, it uses register 22,2 for counting TLB misses
> it would be good to retain that compability, otherwise it will mess up when
> we merge this back to our internal code.
>

It is clear for all users if the usage of reg 22 is defined in , say,
mips-extns.h?

> The reporting part currently will only print the misses on a crash (if I am
> not mistaken), again this has to be tied in with some standard framework.
>

How about one line added in /proc/interrupts?

Thanks
Hillf
