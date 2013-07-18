Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 22:56:10 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:43481 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824795Ab3GRU4HGfUKi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 22:56:07 +0200
Received: by mail-pd0-f181.google.com with SMTP id 14so3463543pdj.40
        for <linux-mips@linux-mips.org>; Thu, 18 Jul 2013 13:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WYA0gWFjea0oGw+PseujxpmEobdNy0gO/Q176LpNRiI=;
        b=syATgUgsH3LgsQsJi55Sl2/liG52jQxJjpn1tq9KYiHPGK6vb4+KaMCNyQwPeCMQxg
         z1m0YfJ5eY/msefbhsU9VOTYm3YyQv+4cvmlbh548UsoJyccCeJ756JBBG3bfwj8mAkq
         nhyke1dZO1wSjGUbDy4ZvahEKxGFDqHx4z8kwrvIPxJZ/dvbPcGYwpnSBPT6KhK5fbpL
         u5TcfNF9KQJR1OJgpN19B8UW3H2VsZx+9c0UDQDXRK8Dwvq6A+2zIcsmHy8hlA3/2Xlq
         0qyOwFVgK/VKDQvj1YJEMfuYDuNS4tBnoX76DYJzw2GrHuodUMf69qEGHX+Abkdw7RuP
         s/8g==
X-Received: by 10.66.14.196 with SMTP id r4mr15147566pac.57.1374180960805;
        Thu, 18 Jul 2013 13:56:00 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id iq3sm15527713pbb.20.2013.07.18.13.55.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 13:55:59 -0700 (PDT)
Message-ID: <51E8565E.9050300@gmail.com>
Date:   Thu, 18 Jul 2013 13:55:58 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Manuel Lauss <manuel.lauss@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Faidon Liambotis <paravoid@debian.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: octeon: oops/panic with CONFIG_SERIO_I8042=y
References: <20130718122556.GA19040@tty.gr> <51E817C6.3030706@gmail.com> <20130718180339.GH14385@blackmetal.musicnaut.iki.fi> <CAOLZvyE-KppwVkb4J8V5k3FHuHKUiQycQiXft5AijPxtSdcL-A@mail.gmail.com> <51E84482.6090706@cogentembedded.com> <CAOLZvyENHhdo5B7ifmhYAciu6Z_aVRgA9FmjyvAcaaphRurQsA@mail.gmail.com> <51E854CD.9070405@cogentembedded.com>
In-Reply-To: <51E854CD.9070405@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 07/18/2013 01:49 PM, Sergei Shtylyov wrote:
> On 07/19/2013 12:42 AM, Manuel Lauss wrote:
>
>>> On 07/18/2013 11:34 PM, Manuel Lauss wrote:
>
>>>>>>> My goal is to run a standard Debian kernel and its octeon
>>>>>>> variant[1] on
>>>>>>> the Ubiquity EdgeRouter Lite. The ERLite needs a couple of patches
>>>>>>> to boot and work (octeon-ethernet patch, octeon-usb driver) but
>>>>>>> these
>>>>>>> are already merged 3.11 and I'll file Debian bugs to enable those
>>>>>>> settings appropriately.
>
>>>>>>> 1: e.g. http://packages.debian.org/sid/linux-image-3.10-1-octeon
>
>>>>>>> However, when trying to boot a standard Debian kernel in the
>>>>>>> ERLite I
>>>>>>> get a 7s delay followed by an oops for a Data bus error on
>>>>>>> i8042_flush()
>>>>>>> and ending up with a panic. It looks like the kernel is built with
>>>>>>> CONFIG_SERIO_I8042=y.  The Octeon machine Debian owns prints
>>>>>>> "i8042: No
>>>>>>> controller found" but works nevertheless.  This isn't the case
>>>>>>> with the
>>>>>>> ERLite; I tried 3.2 & 3.10 and got the same oops which went away as
>>>>>>> soon
>>>>>>> as I disabled CONFIG_SERIO_I8042.
>
>>>>>>> Are there even any octeon machines with i8042 anyway? Should I
>>>>>>> request
>>>>>>> for the setting to be disabled irrespective of this bug?
>
>>>>>> Yes.  There is a rare board called NAC38 that was produced by ASUS
>>>>>> in a 1U chassis.  I don't think it is important to support this, so
>>>>>> the best thing seems to be not to enable SERIO_I8042
>
>>>>> I think the real bug here is that IO space does not get properly
>>>>> initialized on Octeon when there is no PCI? So any drivers trying to
>>>>> probe IO space will produce some interesting results.
>
>>>> This is not specific to Octeon, I've seen it on Alchemy as well.  A
>>>> lot of
>>>> drivers, coming from x86, simply assume that x86-Port-IO space is
>>>> always available without having to map it first.  I'd say it's a bug in
>>>> the various drivers.
>
>>>     Drivers don't have to map I/O space in any way, it's a complete
>>> nonsense.
>
>> isn't that what ioport_map is for?
>
>     ioport_map() permits to use ioread*()/iowrite*(). in*()/out*() don't
> need it. It's a job of the arch platform code to map I/O ports into
> specific memory range if true I/O space doesn't exist.

Yes, somebody should write a patch to do that.

Probably we should allocate 64K worth of contiguous pages for this if 
PCI is not enabled.

Who wants to write the patch?  I can test it.

David Daney
