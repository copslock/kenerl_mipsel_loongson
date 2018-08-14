Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 04:28:35 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:58538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990406AbeHNC2bmYmEj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2018 04:28:31 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 86360AEE7;
        Tue, 14 Aug 2018 02:28:25 +0000 (UTC)
To:     Rob Herring <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        linux-usb@vger.kernel.org
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Stefan Rehm <rehm@miromico.ch>,
        Xue Liu <liuxuenetmail@gmail.com>,
        "LoRa_Community_Support@semtech.com" 
        <LoRa_Community_Support@semtech.com>,
        Oliver Neukum <oneukum@suse.com>,
        Alexander Graf <agraf@suse.de>,
        Ben Whitten <ben.whitten@lairdtech.com>,
        devicetree@vger.kernel.org, Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: serdev: How to attach serdev devices to USB based tty devices?
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Date:   Tue, 14 Aug 2018 04:28:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <afaerber@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: afaerber@suse.de
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

Hi Rob et al.,

For my LoRa network driver project [1] I have found your serdev
framework to be a valuable help for dealing with hardware modules
exposing some textual or binary UART interface.

In particular on arm(64) and mips this allows to define an unlimited
number of serdev drivers [2] that are associated via their Device Tree
compatible string and can optionally be configured via DT properties.

And in theory it seems serdev has also grown support for ACPI.

Now, a growing number of vendors are placing such modules on a USB stick
for easy evaluation on x86_64 PC hardware, or are designing mPCIe or M.2
cards using their USB pins. While I do not yet have access to such a
device myself, it is my understanding that devices with USB-UART bridge
chipsets (e.g., FTDI) will show up as /dev/ttyUSBx and devices with an
MCU implementing the CDC USB protocol (e.g., Pico-cell gateway = picoGW)
will show up as /dev/ttyACMx.
On the Raspberry Pi I've seen that Device Tree nodes can be used to pass
information to on-board devices such as MAC address to Ethernet chipset,
but that does not seem all that useful for passing a serdev child node
to hot-plugged devices at unpredictable hub/port location (where it
should not interfere with regular USB-UART cables for debugging), nor
would it help ACPI based platforms such as x86_64.

My idea then was that if we had some unique criteria like vendor and
product IDs (or whatever is supported in usb_device_id), we could write
a usb_driver with suitable USB_DEVICE*() macro. In its probe function we
could call into the existing tty driver's probe function and afterwards
try creating and attaching the appropriate serdev device, i.e. a fixed
USB-to-serdev driver mapping. Problem is that most devices don't seem to
implement any unique identifier I could make this depend on - either by
using a standard FT232/FT2232/CH340G chip or by using STMicroelectronics
virtual com port identifiers in CDC firmware and only differing in the
textual description [3] the usb_device_id does not seem to match on.

The obvious solution would of course be if hardware vendors could revise
their designs to configure FTDI/etc. chips uniquely. I hear that that
may involve exchanging the chipset, increasing costs, and may impact
existing drivers. Wouldn't help for devices out there today either.

For the picoGW CDC firmware, Semtech does appear to own a USB vendor ID,
so it would seem possible to allocate their own product IDs for SX1301
and SX1308 respectively to replace the generic STMicroelectronics IDs,
which the various vendors could offer as firmware updates.

All outside my control though.

Oliver therefore suggested to not mess with USB drivers and instead use
a line discipline (ldisc). It seems that for example the userspace tool
slattach takes a tty device and performs an ioctl to switch the generic
tty device into a special N_SLIP protocol mode, implemented in [4].

However, the existing number of such ldisc modes appears to be below 30,
with hardly any vendor-specific implementation, so polluting its number
space seems undesirable? And in some cases I would like to use the same
protocol implementation over direct UART and over USB, so would like to
avoid duplicate serdev_device_driver and tty_ldisc_ops implementations.

Long story short, has there been any thinking about a userspace
interface to attach a given serdev driver to a tty device?

Or is there, on OF_DYNAMIC platforms, a way from userspace to associate
a DT fragment (!= DT Overlay) with a given USB device dynamically, to
attach a serdev node with sub-nodes?

Any other ideas how to cleanly solve this?

In some cases we're talking about a "simple" AT-like command interface;
the picoGW implements a semi-generic USB-SPI bridge that may host a
choice of 2+ chipsets, which in turn has two further sub-devices with 3+
chipset choices (theoretically clk output and rx/tx options etc.) each.
(For the latter I'm thinking we'll need a serdev driver exposing a
regmap_bus and then implement regmap_bus based versions of the SPI
drivers like Ben and I refactored SX1257 in [2] last weekend.)

Thanks,
Andreas

[1] https://patchwork.ozlabs.org/cover/937545/
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/tree/drivers/net/lora?h=lora-next
[3]
https://github.com/Lora-net/picoGW_mcu/blob/master/src/usb_cdc/Src/usbd_desc.cpp#L59
[4]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/slip/slip.c#n1281

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
