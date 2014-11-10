Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 20:10:49 +0100 (CET)
Received: from mail-qc0-f175.google.com ([209.85.216.175]:62856 "EHLO
        mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013262AbaKJTKqtoFFg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 20:10:46 +0100
Received: by mail-qc0-f175.google.com with SMTP id b13so7111695qcw.34
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 11:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hiFm1BclDzR2tCkdjtRz6NqLS89/fTCJeToijthx6QI=;
        b=cgKTgKDiZCJq+DS7DqF2rnMySrZfuvZDtP3hMHlsL1/ofwvXy04PMqGEuWXH6poIVc
         sGjyeDjjEaad45ylniza9tkegnPHdKYo62vvPyuU5ZGBF8dbgUG7xKZrtBudDSlF7RIz
         0XQxeZE4tQ3VIm3oXfGkM26jtwm9gJlbNhaWBsSxlE+hls1B16Z0RPxC6Qq31VwxiPOd
         lmB1wknzrIKu6KZ0VMs1LGOje6b3DknzT8HHBa2VOxq3pQoxrB3ONbnYbXEoPCJn6PDU
         lAPEFNnOCag0XW+oyjzyKj1qUvpWWReKHLDUVe9mm6sDk6ofRjFtZIOYF4Xuf/KnkABg
         0rfQ==
X-Received: by 10.140.46.98 with SMTP id j89mr44098374qga.106.1415646641016;
 Mon, 10 Nov 2014 11:10:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Mon, 10 Nov 2014 11:10:20 -0800 (PST)
In-Reply-To: <20141110183056.GA14178@kroah.com>
References: <1415523348-4631-1-git-send-email-cernekee@gmail.com>
 <1415523348-4631-2-git-send-email-cernekee@gmail.com> <CAL_JsqLXznpCo3YjN+XqF6cDG38C6dKzO9DHJmzi6=sNnAU=hQ@mail.gmail.com>
 <CAJiQ=7DUV0isdRooz6112Ncx07+9RE5DS5tMBwxr47hTWA8PAw@mail.gmail.com> <20141110183056.GA14178@kroah.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 10 Nov 2014 11:10:20 -0800
Message-ID: <CAJiQ=7Cx4++GzWV9sscjLH8v+3DfRhz2VgBeLGfxAjBfD1j-vA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: bcm63xx: Allow device nodes to be
 renamed to /dev/ttyBCM*
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, Jiri Slaby <jslaby@suse.cz>,
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
X-archive-position: 43967
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

On Mon, Nov 10, 2014 at 10:30 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Nov 10, 2014 at 07:05:14AM -0800, Kevin Cernekee wrote:
>> On Mon, Nov 10, 2014 at 6:25 AM, Rob Herring <robh@kernel.org> wrote:
>> > On Sun, Nov 9, 2014 at 2:55 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
>> >> By default, bcm63xx_uart.c uses the standard 8250 device naming and
>> >> major/minor numbers.  There are at least two situations where this could
>> >> be a problem:
>> >>
>> >> 1) Multiplatform kernels that need to support some chips that have 8250
>> >> UARTs and other chips that have bcm63xx UARTs.
>> >>
>> >> 2) Some older chips like BCM7125 have a mix of both UART types.
>> >>
>> >> Add a new Kconfig option to tell the driver whether to register itself
>> >> as ttyS or ttyBCM.  By default it will retain the existing "ttyS"
>> >> behavior to avoid surprises.
>> >
>> > While I understand the desire to have stable names, this is the
>> > opposite direction we want to go. Per platform tty names complicates
>> > having a generic userspace. It is not so bad since most ARM platforms
>> > use ttyS or ttyAMA, but just think what the kernel and userspace side
>> > would look like if every single platform did this. We can't change
>> > everything to ttyS because the other names are already an ABI.
>> >
>> > This can be solved with a udev rule to create sym links.
>>
>> Is it safe to register two console drivers named "ttyS" with the same
>> major/minor numbers?
>
> Not at all, think about what you are asking for here.
>
> Is the kernel allowed to register two block devices with the same
> major/minor numbers?

So, is there a recommended solution for building a multiplatform
kernel that includes more than one serial driver that wants to claim
major 4, minor 64?  Let's start with the easy case (#1 from above):
only one of the drivers actually has a DT entry and gets probed.

Browsing around drivers/tty/serial I identified several other drivers
that use 4/64: apbuart, dz, ip22zilog, m32r_sio, mcf, mrst_max3110,
pxa, sunhv, zs.  Unfortunately none of these seem to be built as part
of ARM's MULTI_V7 kernel.

My other idea was to keep using "ttyS" for bcm63xx_uart, but remove
the major/minor numbers from the driver code so the kernel
auto-assigns them.  In this case I also need to set
CONFIG_SERIAL_8250_RUNTIME_UARTS=0 to prevent the 8250 driver from
creating ttyS[0-3] on its own, and then I'll need to retest the 8250
based platform to make sure it didn't break.  Does that sound
plausible?
