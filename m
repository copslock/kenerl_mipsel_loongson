Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2010 12:38:17 +0100 (CET)
Received: from lechat.rtp-net.org ([88.191.19.38]:55621 "EHLO
        lechat.rtp-net.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491083Ab0KULiO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Nov 2010 12:38:14 +0100
Received: by lechat.rtp-net.org (Postfix, from userid 5001)
        id 9E5291009C; Sun, 21 Nov 2010 12:40:36 +0100 (CET)
Received: from lechat.rtp-net.org (ip6-localhost [IPv6:::1])
        by lechat.rtp-net.org (Postfix) with ESMTP id 4FBD910096;
        Sun, 21 Nov 2010 12:40:31 +0100 (CET)
From:   Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
To:     shmprtd@googlemail.com
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for Realtek Media Player SoCs
Organization: RtpNet
References: <tkrat.a6310f0563cae06d@googlemail.com>
        <87r5efyozy.fsf@lechat.rtp-net.org> <4CE8FA88.2020107@googlemail.com>
Date:   Sun, 21 Nov 2010 12:40:31 +0100
In-Reply-To: <4CE8FA88.2020107@googlemail.com> (shmprtd@googlemail.com's
        message of "Sun, 21 Nov 2010 11:55:04 +0100")
Message-ID: <87mxp2zyz4.fsf@lechat.rtp-net.org>
User-Agent: Gnus/5.110009 (No Gnus v0.9) Emacs/22.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@rtp-net.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.patard@rtp-net.org
Precedence: bulk
X-list: linux-mips

shmprtd@googlemail.com writes:

> Arnaud Patard (Rtp) wrote:
>> Please read Documentation/SubmittingPatches. One big patch is just
>> impossible to review (at least for me), please split it in fewer
>> chunks.
>
> I already spoke to Ralf about this. I wanted to submit smaller patches
> but as adding initial support is "one logical change" I stuck to one large
> patch for now. But I understand the need for a nicer way to review the
> changes. Although most of them are new files for the mach anyway.

Ok, will harder to look at it, then. At least, that should not prevent
you to follow SubmittingPatches way (For instance, there's no
signed-off-by in your patch submission).

At least, I will try to find time to test it on my rtd1261 board.

>
>> Do you have an exact status of the different platform device support ?
>> How do you deal with the audio/video support (for instance firmware
>> loading & their rpc stuff) ?
>
> I have no exact status except the 2.6.12 source that is delivered with
> most (all?) of the media players. As far as I checked the a/v code everything
> interesting is done in userspace by ioctls. I don't like it that way but
> for a first shot it would be easier to keep it that way and then start to
> port it to common kernel interfaces. Can't tell now if this will be possible
> at all without any documentation available.

yeah, afaik it's ioctl but the code is horrible which makes it hard to
understand (see RPCpoll.c, RPCintr.c, se* for instance) and is not
necessary the best way to handle that. I've only given a brief look at
the realtek 2.6.12.6 tree so I may be missing some stuff.

>
> The firmware for the Lexras gets copied to reserved mem areas by the bootloader.
>>From the debug messages of the original bootloader and kernel I would guess
> you can halt, reset and run the Lexras by writing into some registers. 

ok.

>
> Other devices include sata, usb, and eth. The eth is a rtl8139c+ where there
> is a driver available already but relies on pci. Realtek itself took this
> code and modified it for bus accesses. Usb and sata drivers are there from 
> the 2.6.12 but again I did no in-depth study of the code, yet.

yeah but the realtek way of duplicating 8139 code is not really
a good path to follow. finding a better way would be nice. I was
thinking about a phy driver. I don't know if it's a good idea.

Getting ethernet and sata would be first thing to do. This would help
testing/developing imho.

>
>> Do you know the differences between the different versions and/or have
>> public specs of the SoCs ?
>
> I cannot tell you the exact differences between the SoCs and I have no
> documentation at all.
>

too bad. This means we're stuck at parsing the realtek code :/

>> Also, I'm seeing a lot of rtd128x in the file names... Commercial name
>> for the Venus is rtd1261 for instance. I find this really
>> confusing. I would be tempted to use mach-realtek but I don't know
>> enough the realtek mips SoCs to say if it's a good idea.
>
> Yeah, this is confusing but may be caused by the confusing way realtek
> calls their chips. I always thought the rtd1261 is Mars and rtd1071 is
> Venus (so the other way round). But the chip id of the rtd1071 tells me 
> it is Mars and I have no other SoC available.

The boot logs of my board are saying "cpu id: 0". In the 2.6.12.6 code I
have, it maps to

typedef enum {
       realtek_venus_cpu       =0x0,
       realtek_venus2_cpu      =0x10,
       realtek_neptune_cpu     =0x1,
       realtek_neptuneB_cpu    =0x11
} cpu_id_t;

So I have a Venus and on it, it's written rtd1261.


>
> I chose rtd128x because the chip id register for all SoCs named by planets
> is 0x1281, 0x1282, 0x1283, aso. Therefore, I thought using value-based
> naming would be nicer than weird commercial names.

Finding good naming is hard. At least, I wouldn't look for rtd1261
support in something called rtd128x.

>
> I guess mach-realtek would be to generic (think of rtl8181) but maybe
> galaxy could be used because of the planet names of the SoCs.

I see. So, maybe galaxy as you're suggesting is better. Ralf, any
opinion ?

Arnaud
