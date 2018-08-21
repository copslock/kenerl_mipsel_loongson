Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 20:01:56 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:51128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993973AbeHUSBxYfhYE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 20:01:53 +0200
Received: from mail-qt0-f171.google.com (mail-qt0-f171.google.com [209.85.216.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2672186C
        for <linux-mips@linux-mips.org>; Tue, 21 Aug 2018 18:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534874506;
        bh=19KuPt2NTvBQdVcS8JK5HhZEK13d+XotPGu/tjP6pwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bzwhgttRZuZfcFZhF7kGjSSfLp6zW87GwiU+IFlba31a9uIW+jZ6ySxHyZPORizoz
         ZgcOrMh/51OnQtnSsK2mWJzIrho3aUcTivrktOM+47t3gvPRqSd8weLsig4UGnhOGj
         RdeL0L8yJL/VhryQpNnWBembwYUHvbrGHX6gldZg=
Received: by mail-qt0-f171.google.com with SMTP id y5-v6so21250711qti.12
        for <linux-mips@linux-mips.org>; Tue, 21 Aug 2018 11:01:46 -0700 (PDT)
X-Gm-Message-State: APzg51CdrP8jLzjcaxuhcfhLsJIQkRxDKi+ChBmbqYYyEU6Mb2GhR0th
        DZg2Pl/HjEgcR6kZgiTb77SGHdvQAf0F0gyz1g==
X-Google-Smtp-Source: ANB0Vdad/vaIbqSllLBN3Xv+nPKcu7mvg5Gml15XAmNQyIHa8j/goXq6o2+q8UjOkeB6mSTEa+GJw0Rtx0L6RLhB32s=
X-Received: by 2002:a0c:db87:: with SMTP id m7-v6mr357431qvk.90.1534874505458;
 Tue, 21 Aug 2018 11:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de> <b00d8330-dab4-e444-e02c-dee6b54abc81@kunz-im-inter.net>
In-Reply-To: <b00d8330-dab4-e444-e02c-dee6b54abc81@kunz-im-inter.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 21 Aug 2018 13:01:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKasgjf5BkEN-ATbLQdDaWxMLoeACkVPUe4vjs+Z0ziGw@mail.gmail.com>
Message-ID: <CAL_JsqKasgjf5BkEN-ATbLQdDaWxMLoeACkVPUe4vjs+Z0ziGw@mail.gmail.com>
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
To:     mailinglists@kunz-im-inter.net
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Xue Liu <liuxuenetmail@gmail.com>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        oneukum@suse.com, Alexander Graf <agraf@suse.de>,
        LoRa_Community_Support@semtech.com,
        =?UTF-8?B?5r2Y5bu65a6P?= <starnight@g.ncu.edu.tw>,
        rehm@miromico.ch,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65709
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

On Tue, Aug 21, 2018 at 11:33 AM Frank Kunz
<mailinglists@kunz-im-inter.net> wrote:
>
> Am 14.08.2018 um 04:28 schrieb Andreas Färber:
> > Hi Rob et al.,
> >
> > For my LoRa network driver project [1] I have found your serdev
> > framework to be a valuable help for dealing with hardware modules
> > exposing some textual or binary UART interface.
> >
> > In particular on arm(64) and mips this allows to define an unlimited
> > number of serdev drivers [2] that are associated via their Device Tree
> > compatible string and can optionally be configured via DT properties.
> >
> > And in theory it seems serdev has also grown support for ACPI.
> >
> > Now, a growing number of vendors are placing such modules on a USB stick
> > for easy evaluation on x86_64 PC hardware, or are designing mPCIe or M.2
> > cards using their USB pins. While I do not yet have access to such a
> > device myself, it is my understanding that devices with USB-UART bridge
> > chipsets (e.g., FTDI) will show up as /dev/ttyUSBx and devices with an
> > MCU implementing the CDC USB protocol (e.g., Pico-cell gateway = picoGW)
> > will show up as /dev/ttyACMx.
> > On the Raspberry Pi I've seen that Device Tree nodes can be used to pass
> > information to on-board devices such as MAC address to Ethernet chipset,
> > but that does not seem all that useful for passing a serdev child node
> > to hot-plugged devices at unpredictable hub/port location (where it
> > should not interfere with regular USB-UART cables for debugging), nor
> > would it help ACPI based platforms such as x86_64.
> >
> > My idea then was that if we had some unique criteria like vendor and
> > product IDs (or whatever is supported in usb_device_id), we could write
> > a usb_driver with suitable USB_DEVICE*() macro. In its probe function we
> > could call into the existing tty driver's probe function and afterwards
> > try creating and attaching the appropriate serdev device, i.e. a fixed
> > USB-to-serdev driver mapping. Problem is that most devices don't seem to
> > implement any unique identifier I could make this depend on - either by
> > using a standard FT232/FT2232/CH340G chip or by using STMicroelectronics
> > virtual com port identifiers in CDC firmware and only differing in the
> > textual description [3] the usb_device_id does not seem to match on.
> >
> > The obvious solution would of course be if hardware vendors could revise
> > their designs to configure FTDI/etc. chips uniquely. I hear that that
> > may involve exchanging the chipset, increasing costs, and may impact
> > existing drivers. Wouldn't help for devices out there today either.
>
> They need to put an extra eeprom (cents) into their design and program it.
>
> >
> > For the picoGW CDC firmware, Semtech does appear to own a USB vendor ID,
> > so it would seem possible to allocate their own product IDs for SX1301
> > and SX1308 respectively to replace the generic STMicroelectronics IDs,
> > which the various vendors could offer as firmware updates.
> >
> > All outside my control though.
> >
> > Oliver therefore suggested to not mess with USB drivers and instead use
> > a line discipline (ldisc). It seems that for example the userspace tool
> > slattach takes a tty device and performs an ioctl to switch the generic
> > tty device into a special N_SLIP protocol mode, implemented in [4].
> >
> > However, the existing number of such ldisc modes appears to be below 30,
> > with hardly any vendor-specific implementation, so polluting its number
> > space seems undesirable? And in some cases I would like to use the same
> > protocol implementation over direct UART and over USB, so would like to
> > avoid duplicate serdev_device_driver and tty_ldisc_ops implementations.
> >
> > Long story short, has there been any thinking about a userspace
> > interface to attach a given serdev driver to a tty device?
> >
> > Or is there, on OF_DYNAMIC platforms, a way from userspace to associate
> > a DT fragment (!= DT Overlay) with a given USB device dynamically, to
> > attach a serdev node with sub-nodes?
> >
> > Any other ideas how to cleanly solve this?
> >
> > In some cases we're talking about a "simple" AT-like command interface;
> > the picoGW implements a semi-generic USB-SPI bridge that may host a
> > choice of 2+ chipsets, which in turn has two further sub-devices with 3+
> > chipset choices (theoretically clk output and rx/tx options etc.) each.
> > (For the latter I'm thinking we'll need a serdev driver exposing a
> > regmap_bus and then implement regmap_bus based versions of the SPI
> > drivers like Ben and I refactored SX1257 in [2] last weekend.)>
>
> There is a mPCIe module (RAK833) available by RAK wireless that uses a
> FT2232 as USB-SPI bridge, not uart. I have one here for experiments. It
> is detected as generic FT2232 device on usb. As far as I understood so
> far the serdev does only support uart based communication, is there a
> chance to get USB-SPI bridged modules also working?

That should be somewhat easier than a UART because there's not the
interactions with the tty layer to deal with. You still have the issue
of what is the DT root for the FTDI device.

Rob
