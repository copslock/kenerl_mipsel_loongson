Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 21:39:51 +0200 (CEST)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:62631 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817318Ab3GRTjrdeoiT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 21:39:47 +0200
Received: by mail-lb0-f175.google.com with SMTP id r10so2801223lbi.6
        for <linux-mips@linux-mips.org>; Thu, 18 Jul 2013 12:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=DFlJqxVSMctPAqsc9s0NK8cQ8YoKwJ2hpgyO6OD7W7g=;
        b=Zrb3Jhv5LkQjtYdrPehVySj3Z0g+lJm8x7yayt/ZjFHF1bpEkkgGzWUT7NrI1X1cSj
         rXC8HAxesrn3P77OdZgZnir7/RNh3g7Fbux7sV5I04gJ76y+OcR+XF3XVe549xlV92we
         NXLA+aiHm0A9cYWNkaXPr9HQkXrTJubYyq17RjsTlrYmBSwgRj+NmKCwnU9RAYiUoOc4
         3CRZhvZJBONbSq2mcAZ7cUbPuEfNX/eeH/duELiaOHpVp+hnhJtLXg4JvnZ5we2JDOVO
         skOrMhBYwouOa4d3E5E7Tdpcc9ZvP++XlW+F7yt7W5HGSLkaQYeTYVEc7/CxSH2j5nlk
         NHZA==
X-Received: by 10.152.87.234 with SMTP id bb10mr5978581lab.55.1374176381878;
        Thu, 18 Jul 2013 12:39:41 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-85-2.pppoe.mtu-net.ru. [91.76.85.2])
        by mx.google.com with ESMTPSA id n3sm4682687lag.9.2013.07.18.12.39.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 12:39:40 -0700 (PDT)
Message-ID: <51E84482.6090706@cogentembedded.com>
Date:   Thu, 18 Jul 2013 23:39:46 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <ddaney.cavm@gmail.com>,
        Faidon Liambotis <paravoid@debian.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: octeon: oops/panic with CONFIG_SERIO_I8042=y
References: <20130718122556.GA19040@tty.gr> <51E817C6.3030706@gmail.com> <20130718180339.GH14385@blackmetal.musicnaut.iki.fi> <CAOLZvyE-KppwVkb4J8V5k3FHuHKUiQycQiXft5AijPxtSdcL-A@mail.gmail.com>
In-Reply-To: <CAOLZvyE-KppwVkb4J8V5k3FHuHKUiQycQiXft5AijPxtSdcL-A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkt2Gm/ALdg1S4iRU5V6cjZu5lnZKcPHqn50ThBsFqokk2Su9hzT32DPwbQr6AOIKKg1hkb
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 07/18/2013 11:34 PM, Manuel Lauss wrote:

>>>> My goal is to run a standard Debian kernel and its octeon variant[1] on
>>>> the Ubiquity EdgeRouter Lite. The ERLite needs a couple of patches
>>>> to boot and work (octeon-ethernet patch, octeon-usb driver) but these
>>>> are already merged 3.11 and I'll file Debian bugs to enable those
>>>> settings appropriately.

>>>> 1: e.g. http://packages.debian.org/sid/linux-image-3.10-1-octeon

>>>> However, when trying to boot a standard Debian kernel in the ERLite I
>>>> get a 7s delay followed by an oops for a Data bus error on i8042_flush()
>>>> and ending up with a panic. It looks like the kernel is built with
>>>> CONFIG_SERIO_I8042=y.  The Octeon machine Debian owns prints "i8042: No
>>>> controller found" but works nevertheless.  This isn't the case with the
>>>> ERLite; I tried 3.2 & 3.10 and got the same oops which went away as soon
>>>> as I disabled CONFIG_SERIO_I8042.

>>>> Are there even any octeon machines with i8042 anyway? Should I request
>>>> for the setting to be disabled irrespective of this bug?

>>> Yes.  There is a rare board called NAC38 that was produced by ASUS
>>> in a 1U chassis.  I don't think it is important to support this, so
>>> the best thing seems to be not to enable SERIO_I8042

>> I think the real bug here is that IO space does not get properly
>> initialized on Octeon when there is no PCI? So any drivers trying to
>> probe IO space will produce some interesting results.

> This is not specific to Octeon, I've seen it on Alchemy as well.  A lot of
> drivers, coming from x86, simply assume that x86-Port-IO space is
> always available without having to map it first.  I'd say it's a bug in
> the various drivers.

    Drivers don't have to map I/O space in any way, it's a complete nonsense.

> Manuel

WBR, Sergei
