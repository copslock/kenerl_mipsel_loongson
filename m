Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 14:11:52 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:56157 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023598AbZFHNLp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jun 2009 14:11:45 +0100
Received: by bwz25 with SMTP id 25so3052627bwz.0
        for <multiple recipients>; Mon, 08 Jun 2009 06:11:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0i+zqcf0RreQvuOC9RvXBTLLCqN10rDB1/qgsWDGYHc=;
        b=GWfGkKHVjN3B7kl2U66/3Xdk+hAjhmrwz/ZbigC4Q0kHyeF/p1s0UO1BHrsyB/IIOu
         Ii0K/5a6eImPLFJ86zKN2ZvrBPsXlEhZbflruBeC98Hv26kQrmQ1UuX5H1ufXlVr8baU
         GlPU4D3zym6Xl6rHQFAJvookVkdXa+mOs4Xxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JumQicdlTumBPF5mLjXOzzJHMg8OGmR+fbpKanvcwCE2OaF7d9VhzRfhmIGQ3GSLVT
         E2ByGb6IItRZrcm7vwnqfp3MnJoS0mDVPvrlXYQbgsp3xuQMLySR+0iKmEmOviRWCCeh
         fh9le8HFsPoLj439JSWF72FSoSacZpDdg7Hj4=
MIME-Version: 1.0
Received: by 10.223.115.80 with SMTP id h16mr4041988faq.94.1244466699484; Mon, 
	08 Jun 2009 06:11:39 -0700 (PDT)
In-Reply-To: <20090608124411.GA3396@rakim.wolfsonmicro.main>
References: <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
	 <20090608092521.GA7858@sirena.org.uk>
	 <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
	 <20090608102018.GA6547@rakim.wolfsonmicro.main>
	 <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
	 <20090608115336.GA25827@rakim.wolfsonmicro.main>
	 <f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
	 <20090608124411.GA3396@rakim.wolfsonmicro.main>
Date:	Mon, 8 Jun 2009 15:11:39 +0200
Message-ID: <f861ec6f0906080611i2c03709cg621aeb87d084dd00@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Mark,

>> I see now what you mean, but this is ugly as sin:
>> I now need to register 2 platform devices in the board code: 1 for the DAI
>> (with resources mmio + irq) and 1 for the DMA engine (with ddma id resources),
>> or register the DMA engine device from within the AC97/I2S drivers.
>
>> This is in my opinion even worse than the current scheme, which at least allows
>> me to group all PSC resources into one struct resource which all audio-related
>> drivers can share without too much uglyness.
>
> If you trigger registration the DMA engine from within the I2S and AC97
> devices you can still group everything together like you want to so I
> don't really see the problem - they're peering at a different device for
> the data but other than that things are unchanged.  At the minute you're
> loosing a lot of sharing by having this in the individual machine
> drivers.

All 3 drivers are now platform_devices -- and now I still have the
same problem as
before: I can't really share the whole struct resource;  i need to allocate
a new resource struct, fill in the dma ids and register the dma device with it.

Btw, the davinci-evm in asoc-git also registers mmio and dma from within
the machine code.

I can't shake the feeling that there's something wrong with the whole asoc
device model (and that asoc was designed with pxa2xx devices in mind which
have single audio units with fixed resources that the driver code can
hardcode inside it).


> Note that one of the possibilities once multiple sound card support is
> introduced is that DAIs could be shared between multiple cards.  This is

I wrote the au1x audio drivers with this in mind: the DAI really describes how
to interact with a PSC; I didn't see any point in duplicating the dai
description
for each possible PSC.


To put an end to this thread:  I really don't want to change the machine code
or dai drivers at this time, because I have the feeling that it's a few steps
backwards.  If you don't agree with this then I'll leave the audio parts out of
the submission; I don't really care if it goes in or not, I just saw
it as a nice
sample machine driver for both AC97 and I2S on Alchemy.


        Manuel Lauss
