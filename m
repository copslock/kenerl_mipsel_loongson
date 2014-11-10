Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 16:05:41 +0100 (CET)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:39420 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011908AbaKJPFk2IBII (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 16:05:40 +0100
Received: by mail-qc0-f169.google.com with SMTP id i17so5968720qcy.14
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 07:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A0lJJ/Ye6tKo2BIuBgC3/ORQQ6OkZ4eU1ttOD+7O8p8=;
        b=mxq9jTeWlncxGFFV091HBhkcVU0/8fgXgPUG3BG6LOeSV5PR+eRTbXB/C2j9QnfEJh
         5Hr6JXxRP/0pmt8WNFLrvAvnXWzXTuvM5Vt59YxGSPOVxDQDKADA45YpjIM+OdcpP+4I
         mhzyw22Y5R1AObOK+aI0z5+Y7G722cPj6HIrgrcY2jUlHQzuFr+NZ27IMFFcrdrJ/2YY
         A4Rv2VUPOIEU0/jII303FeT4YZVcx1+okTzgEEXZNJVBswWbLDHct+dmyzfIZgAM9nrN
         YDM0nfclyle82YNKLwo/CbPVnrZBMQvf3iVFf2C66DqZHa/6k+GtppOlTpAXxUPyXTbZ
         aozg==
X-Received: by 10.140.46.98 with SMTP id j89mr42611022qga.106.1415631934597;
 Mon, 10 Nov 2014 07:05:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 10 Nov 2014 07:05:14 -0800 (PST)
In-Reply-To: <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
 <1415523348-4631-2-git-send-email-cernekee@gmail.com> <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 10 Nov 2014 07:05:14 -0800
Message-ID: <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Nov 10, 2014 at 6:25 AM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Nov 9, 2014 at 2:55 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>> By default, bcm63xx_uart.c uses the standard 8250 device naming and
>> major/minor numbers.  There are at least two situations where this could
>> be a problem:
>>
>> 1) Multiplatform kernels that need to support some chips that have 8250
>> UARTs and other chips that have bcm63xx UARTs.
>>
>> 2) Some older chips like BCM7125 have a mix of both UART types.
>>
>> Add a new Kconfig option to tell the driver whether to register itself
>> as ttyS or ttyBCM.  By default it will retain the existing "ttyS"
>> behavior to avoid surprises.
>
> While I understand the desire to have stable names, this is the
> opposite direction we want to go. Per platform tty names complicates
> having a generic userspace. It is not so bad since most ARM platforms
> use ttyS or ttyAMA, but just think what the kernel and userspace side
> would look like if every single platform did this. We can't change
> everything to ttyS because the other names are already an ABI.
>
> This can be solved with a udev rule to create sym links.

Is it safe to register two console drivers named "ttyS" with the same
major/minor numbers?  Maybe there is a trick to making them coexist?

What I found is that everything worked fine on a system with
bcm63xx_uart hardware until I enabled the 8250 driver in .config.  At
that point the drivers clashed and I had no serial output
post-bootconsole.  It didn't even get to userland before it failed.
There are no DT entries mentioning 8250; the mere presence of the 8250
driver killed my console.

If this behavior is unexpected I can keep digging to find out what went wrong.

> Or if you
> just need to know which dev node is h/w uart X, you can get that from
> sysfs.

Right - I use busybox cttyhack in the init scripts to figure out the
console name, so the same rootfs image can be used for both ttyS0 and
ttyBCM0:

# Put a shell on the serial port
::respawn:/bin/cttyhack /bin/sh -l
