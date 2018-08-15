Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2018 21:54:06 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994585AbeHOTyC2Ry1a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Aug 2018 21:54:02 +0200
Received: from mail-qt0-f169.google.com (mail-qt0-f169.google.com [209.85.216.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E4522150A
        for <linux-mips@linux-mips.org>; Wed, 15 Aug 2018 19:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534362836;
        bh=kVnO4ZQwDfPSuBvxaLiLtpF3EHdWoHGpmelmSJIijWA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P7dwg08vu3HEKNEjWpb2olHTW8Quravo46sj7gG1hmjVG/sXUJj+Q9tR0ONjGqolB
         ivTmxsJ1rJswBRXNzChHLWxIshTg5OVpNKwCgriXSgcgh3/DxygFPtE0Z0PoxNktOU
         Ddamr2jmXlx5RYXZyn0V5lPizRdLKnsfg9XCtZ0A=
Received: by mail-qt0-f169.google.com with SMTP id z8-v6so2545427qto.9
        for <linux-mips@linux-mips.org>; Wed, 15 Aug 2018 12:53:55 -0700 (PDT)
X-Gm-Message-State: AOUpUlF0HkadpnnmQQW7lOXophWVsjERceznynd5nh/1WsXz8+ZUOhCu
        Rv0WBcebOZekRHAZ17aZaRVOSFCl7kodUEDq8g==
X-Google-Smtp-Source: AA+uWPzCVK4y0dOEGCzvSHtgOJvRl2owUXnnJSXdUb2ipSDmaa2XnlfmpbWBrEvD1KWvDADhlKBGvM0EG3H1Q1pvuDY=
X-Received: by 2002:ac8:2c72:: with SMTP id e47-v6mr27906319qta.60.1534362834571;
 Wed, 15 Aug 2018 12:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 15 Aug 2018 13:53:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLofD1q=jTkY15um+fFw0ADL6ooRWRYSMMKbkqOM=TY9w@mail.gmail.com>
Message-ID: <CAL_JsqLofD1q=jTkY15um+fFw0ADL6ooRWRYSMMKbkqOM=TY9w@mail.gmail.com>
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, rehm@miromico.ch,
        Xue Liu <liuxuenetmail@gmail.com>,
        LoRa_Community_Support@semtech.com, oneukum@suse.com,
        Alexander Graf <agraf@suse.de>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        devicetree@vger.kernel.org, starnight@g.ncu.edu.tw,
        netdev <netdev@vger.kernel.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Mon, Aug 13, 2018 at 8:28 PM Andreas Färber <afaerber@suse.de> wrote:
>
> Hi Rob et al.,
>
> For my LoRa network driver project [1] I have found your serdev
> framework to be a valuable help for dealing with hardware modules
> exposing some textual or binary UART interface.
>
> In particular on arm(64) and mips this allows to define an unlimited
> number of serdev drivers [2] that are associated via their Device Tree
> compatible string and can optionally be configured via DT properties.
>
> And in theory it seems serdev has also grown support for ACPI.
>
> Now, a growing number of vendors are placing such modules on a USB stick
> for easy evaluation on x86_64 PC hardware, or are designing mPCIe or M.2
> cards using their USB pins. While I do not yet have access to such a
> device myself, it is my understanding that devices with USB-UART bridge
> chipsets (e.g., FTDI) will show up as /dev/ttyUSBx and devices with an
> MCU implementing the CDC USB protocol (e.g., Pico-cell gateway = picoGW)
> will show up as /dev/ttyACMx.
> On the Raspberry Pi I've seen that Device Tree nodes can be used to pass
> information to on-board devices such as MAC address to Ethernet chipset,
> but that does not seem all that useful for passing a serdev child node
> to hot-plugged devices at unpredictable hub/port location (where it
> should not interfere with regular USB-UART cables for debugging), nor
> would it help ACPI based platforms such as x86_64.
>
> My idea then was that if we had some unique criteria like vendor and
> product IDs (or whatever is supported in usb_device_id), we could write
> a usb_driver with suitable USB_DEVICE*() macro. In its probe function we
> could call into the existing tty driver's probe function and afterwards
> try creating and attaching the appropriate serdev device, i.e. a fixed
> USB-to-serdev driver mapping. Problem is that most devices don't seem to
> implement any unique identifier I could make this depend on - either by
> using a standard FT232/FT2232/CH340G chip or by using STMicroelectronics
> virtual com port identifiers in CDC firmware and only differing in the
> textual description [3] the usb_device_id does not seem to match on.
>
> The obvious solution would of course be if hardware vendors could revise
> their designs to configure FTDI/etc. chips uniquely. I hear that that
> may involve exchanging the chipset, increasing costs, and may impact
> existing drivers. Wouldn't help for devices out there today either.
>
> For the picoGW CDC firmware, Semtech does appear to own a USB vendor ID,
> so it would seem possible to allocate their own product IDs for SX1301
> and SX1308 respectively to replace the generic STMicroelectronics IDs,
> which the various vendors could offer as firmware updates.
>
> All outside my control though.
>
> Oliver therefore suggested to not mess with USB drivers and instead use
> a line discipline (ldisc). It seems that for example the userspace tool
> slattach takes a tty device and performs an ioctl to switch the generic
> tty device into a special N_SLIP protocol mode, implemented in [4].
>
> However, the existing number of such ldisc modes appears to be below 30,
> with hardly any vendor-specific implementation, so polluting its number
> space seems undesirable? And in some cases I would like to use the same
> protocol implementation over direct UART and over USB, so would like to
> avoid duplicate serdev_device_driver and tty_ldisc_ops implementations.
>
> Long story short, has there been any thinking about a userspace
> interface to attach a given serdev driver to a tty device?

There was this[1] posted.

The main problem is the only way we know to instantiate a serdev ctrlr
is if there's a slave device described. I did make a series[2] that
makes serdev and tty device co-exist. Then you can more easily
manually attach a device. The problems are you get mismatches in
opens/closes in the tty layer and what should the behavior be if
userspace is trying to access the same port via both the tty and
serdev. After breaking things last time I touched tty open and close,
I'm hesitant to do that again. :)

> Or is there, on OF_DYNAMIC platforms, a way from userspace to associate
> a DT fragment (!= DT Overlay) with a given USB device dynamically, to
> attach a serdev node with sub-nodes?

There's been some discussions but no real progress. I think we need to
be able to support multiple DT roots and then assign/apply DTs to
arbitrary devices. That's first going to require that of_root is not
exposed outside of drivers/of/ and then there could be some issues
with assuming root==NULL is the base of the single DT. Beyond that, I
haven't given it too much thought.

An alternative is we create DT nodes for all devices which don't have
them (or only certain buses) and then we can apply overlays. This is
kind of headed down the path of doing an OpenFirmware implementation
which would enumerate all the devices and pass that DT to the OS.

Rob

[1] https://www.spinics.net/lists/linux-serial/msg30732.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=serdev-ldisc-v2
