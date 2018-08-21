Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 18:32:48 +0200 (CEST)
Received: from server1044-han.de-nserver.de ([77.75.251.205]:17793 "EHLO
        server1044-han.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993016AbeHUQcpUdx8D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 18:32:45 +0200
Received: (qmail 11766 invoked from network); 21 Aug 2018 18:32:44 +0200
X-Fcrdns: Yes
Received: from p5B2C7149.dip0.t-ipconnect.de (HELO [192.168.0.56]) (91.44.113.73)
  (smtp-auth username mailinglists@kunz-im-inter.net, mechanism plain)
  by server1044-han.de-nserver.de (qpsmtpd/0.92) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPSA; Tue, 21 Aug 2018 18:32:44 +0200
Subject: Re: serdev: How to attach serdev devices to USB based tty devices?
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Rob Herring <robh@kernel.org>,
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
References: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
From:   Frank Kunz <mailinglists@kunz-im-inter.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mailinglists@kunz-im-inter.net; prefer-encrypt=mutual;
 keydata=
 xsDiBEBcTn4RBADTVXx2rxejOvpg+K3IuzBCTeDBxoyCE5hGWjWhPhVFGVNzuXUvJtrz53Gc
 8tasoTb28cOTR5RFA+ZccEqr+Utl+x32uNcAUge8GvfCezQ/m/FzkjFIBHO/PwvRVl5Httut
 Q0JAyhYTyWQXh6meGeLF0nbeV7TrOwVBfIex6c7QRwCgmIwD6CfTLDAiPVCoFCh8EBo0fvMD
 /3W/ZaaAghqD00eK3YNndWVJRskijld744k4cmAIFl67rDU2B3GpslyKxBC3sPgcgZ2yL8Fa
 k4EYG+HL+odvrnjMnB3QZ4oPTdkw2gwWay0EljQ7K7f3Y7hACvWE3GBbVoKaRhsWtuQkQQUo
 DvRVnp5iV609nkpIhyMf4F0wCyoqA/sHPsQYjnwyCsQmb0NCvWIxUgX9rB94Q/TXG0xgCEwt
 1fenftJY+AePPu1e6Qd8BkkJ+ooSWAfP4aXlXEJfvmEIcMa5Yo8j5F4cQpifTV57H+M1MFiJ
 RWPBYCWLATJ2b3R1Mevxi+KTuMXc275YNHA5YiPDXKBdt6/qLHS1a4N/MM0kRnJhbmsgS3Vu
 eiA8ZnJhbmtAa3Vuei1pbS1pbnRlci5uZXQ+wlsEExECABsFAkBcTn4GCwkIBwMCAxUCAwMW
 AgECHgECF4AACgkQZ1DjqcEsjXn+LQCeM8JNYhD7DCig8SZEKXIkpZZxjZgAnRy3EgJ5h1FJ
 w+4CZoNCFKAcrIe9zsBNBEBcToAQBACpwIdSn7xurAlTHg77yDzpAiKMLLwbd3jpNE+T6zN3
 5uoYhpAwYrcrtTydSihFzznNAKAG2sd229EUY4LkkrlIK7pAd6PMBH9Ji3KqDARB1Rngh1dM
 BcQkg2roJq1z2mnMLF2+wM3+IgD6KGbO0scU8oQ4Onju5k7CZspGaGA+xwADBQQApuZHYBSy
 7R2G7SzzEesr721SmrdXPo6zOC7DV3+A/oka1ZRWDkHpDxLsy5s/vTaNsLbVcodnItdrgsYQ
 mIUQhLDnp+0dVPpeyHLZ8cR8jK2IxlIrsIREc4P7EkZVVc9EfL9RvAGEckZxvtxMPAtfXwxu
 BYxXsWJuFPOdPybeoFnCRgQYEQIABgUCQFxOgAAKCRBnUOOpwSyNeQzyAJwIcdKVplSqfZy7
 Fdv1LRVZy3uDFACdHdyyhm0xvjG5iJJtWCBJRzeUovQ=
Message-ID: <b00d8330-dab4-e444-e02c-dee6b54abc81@kunz-im-inter.net>
Date:   Tue, 21 Aug 2018 18:32:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3639955d-5990-1c82-7158-ac07b33c41f2@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-User-Auth: Auth by mailinglists@kunz-im-inter.net through 91.44.113.73
Return-Path: <mailinglists@kunz-im-inter.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mailinglists@kunz-im-inter.net
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

Am 14.08.2018 um 04:28 schrieb Andreas Färber:
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

They need to put an extra eeprom (cents) into their design and program it.

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
> 
> Or is there, on OF_DYNAMIC platforms, a way from userspace to associate
> a DT fragment (!= DT Overlay) with a given USB device dynamically, to
> attach a serdev node with sub-nodes?
> 
> Any other ideas how to cleanly solve this?
> 
> In some cases we're talking about a "simple" AT-like command interface;
> the picoGW implements a semi-generic USB-SPI bridge that may host a
> choice of 2+ chipsets, which in turn has two further sub-devices with 3+
> chipset choices (theoretically clk output and rx/tx options etc.) each.
> (For the latter I'm thinking we'll need a serdev driver exposing a
> regmap_bus and then implement regmap_bus based versions of the SPI
> drivers like Ben and I refactored SX1257 in [2] last weekend.)>

There is a mPCIe module (RAK833) available by RAK wireless that uses a
FT2232 as USB-SPI bridge, not uart. I have one here for experiments. It
is detected as generic FT2232 device on usb. As far as I understood so
far the serdev does only support uart based communication, is there a
chance to get USB-SPI bridged modules also working?

Br,
Frank

> Thanks,
> Andreas
> 
> [1] https://patchwork.ozlabs.org/cover/937545/
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/tree/drivers/net/lora?h=lora-next
> [3]
> https://github.com/Lora-net/picoGW_mcu/blob/master/src/usb_cdc/Src/usbd_desc.cpp#L59
> [4]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/slip/slip.c#n1281
> 
