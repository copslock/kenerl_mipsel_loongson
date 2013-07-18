Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 22:45:51 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:64722 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824769Ab3GRUnNe6ze2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 22:43:13 +0200
Received: by mail-wi0-f182.google.com with SMTP id m6so3663986wiv.9
        for <linux-mips@linux-mips.org>; Thu, 18 Jul 2013 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bEAOUrG6d1r4lfTnGm5FVFznEHK9rJMZBHhvM5DpK+g=;
        b=MqSD3Gy2f/Qjnj7uE42PYPeHxF6ZHgK8H1ybHEvzO3Eh0DSXrklGDP/vqIm8jVxxoI
         xUzH6QNBMWyuO3+KJMkALnOYA6FpDENJhTWsXJ3G3pN55CUq7Eo3dbszli8Oo2nomDdc
         LOryhSqwnejodPS8JzUSYou2+/mFkfQgfypCcwEt3pRdIlKeMM7Jd3D6N5NeqkSPKT5Y
         t+FJc7xLiBa1FsaycBtWgG45WY/PZqN55G6JdbN5AI34K5Oge47vCwZ7YzHuD73AsL9z
         tYyCEOKcB+MtcTH5gN/z2HT+Ppst7lGSjGcuy+lIjzpyoaP4DeEJAAjsgkMRw6AI8w4/
         TjWA==
X-Received: by 10.180.90.73 with SMTP id bu9mr9316103wib.32.1374180188160;
 Thu, 18 Jul 2013 13:43:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.245.2 with HTTP; Thu, 18 Jul 2013 13:42:28 -0700 (PDT)
In-Reply-To: <51E84482.6090706@cogentembedded.com>
References: <20130718122556.GA19040@tty.gr> <51E817C6.3030706@gmail.com>
 <20130718180339.GH14385@blackmetal.musicnaut.iki.fi> <CAOLZvyE-KppwVkb4J8V5k3FHuHKUiQycQiXft5AijPxtSdcL-A@mail.gmail.com>
 <51E84482.6090706@cogentembedded.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 18 Jul 2013 22:42:28 +0200
Message-ID: <CAOLZvyENHhdo5B7ifmhYAciu6Z_aVRgA9FmjyvAcaaphRurQsA@mail.gmail.com>
Subject: Re: octeon: oops/panic with CONFIG_SERIO_I8042=y
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <ddaney.cavm@gmail.com>,
        Faidon Liambotis <paravoid@debian.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37330
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Thu, Jul 18, 2013 at 9:39 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 07/18/2013 11:34 PM, Manuel Lauss wrote:
>
>>>>> My goal is to run a standard Debian kernel and its octeon variant[1] on
>>>>> the Ubiquity EdgeRouter Lite. The ERLite needs a couple of patches
>>>>> to boot and work (octeon-ethernet patch, octeon-usb driver) but these
>>>>> are already merged 3.11 and I'll file Debian bugs to enable those
>>>>> settings appropriately.
>
>
>>>>> 1: e.g. http://packages.debian.org/sid/linux-image-3.10-1-octeon
>
>
>>>>> However, when trying to boot a standard Debian kernel in the ERLite I
>>>>> get a 7s delay followed by an oops for a Data bus error on
>>>>> i8042_flush()
>>>>> and ending up with a panic. It looks like the kernel is built with
>>>>> CONFIG_SERIO_I8042=y.  The Octeon machine Debian owns prints "i8042: No
>>>>> controller found" but works nevertheless.  This isn't the case with the
>>>>> ERLite; I tried 3.2 & 3.10 and got the same oops which went away as
>>>>> soon
>>>>> as I disabled CONFIG_SERIO_I8042.
>
>
>>>>> Are there even any octeon machines with i8042 anyway? Should I request
>>>>> for the setting to be disabled irrespective of this bug?
>
>
>>>> Yes.  There is a rare board called NAC38 that was produced by ASUS
>>>> in a 1U chassis.  I don't think it is important to support this, so
>>>> the best thing seems to be not to enable SERIO_I8042
>
>
>>> I think the real bug here is that IO space does not get properly
>>> initialized on Octeon when there is no PCI? So any drivers trying to
>>> probe IO space will produce some interesting results.
>
>
>> This is not specific to Octeon, I've seen it on Alchemy as well.  A lot of
>> drivers, coming from x86, simply assume that x86-Port-IO space is
>> always available without having to map it first.  I'd say it's a bug in
>> the various drivers.
>
>
>    Drivers don't have to map I/O space in any way, it's a complete nonsense.
>

isn't that what ioport_map is for?

Manuel
