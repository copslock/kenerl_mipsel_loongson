Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2018 16:37:24 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:50589
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992871AbeILOhURkZMt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2018 16:37:20 +0200
Received: by mail-wm0-x242.google.com with SMTP id s12-v6so2703426wmc.0;
        Wed, 12 Sep 2018 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RaPdjDggpSScvgAXTgCTVtzfZXKAR9gjcl9YQq6a0WY=;
        b=ogVQ3XUgCYPPDO/KHW+tx3upbcTnBenlDSoGeX2z2qtaI5bGXJmMKe9xuvtDUc3ke0
         rANc7UAjvsanFRSAiiGanUZPdfUPtAgjLRgbiWIaGAnHDjznK9+4kRLf1X32OC/fqucO
         jteE+/9jp9UftMQ43LU6TqMHpwj/XNYl8Le+9wA+XOC54X0QhZHjoEIZpoxxS9lq4JV0
         PzSvrR6K9MVSDDYxbaz5Upt46X9npCLIRZDPwC3IeSfI0j8iEMQvExuyYBHXpJBlyxAM
         UpTcoqZysslQoUcgufpwwPi6PEaYoKeOmrTUeJxLc144GE/Dn/qzhiFPSuma2Hj37iul
         4zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RaPdjDggpSScvgAXTgCTVtzfZXKAR9gjcl9YQq6a0WY=;
        b=CZw+h9AnvND9Y6fOqW2OPaG3Z8X4NhmOE1DT8pDMA4sh6/SAc0HLKcVAhV187gtUD8
         CgwRpaSxIxnTYi67d2avd52NNXSDuHMRygSvJxN8Ru8IC+aSJ6hmFPpIiKIzo4lLAu8D
         8u5Z6AgyzjzPZ6Adko9zsjOR7hO/m5DqJ6llALhG+1GVaUq41bEgD5kyR59e4+p5H9Mm
         SN8nqtqsLKBwImk7wvt2Vc2kmk7pMCpz6bcNTKKh8hy6ZHKUe2bmN3qNMseDLxQq9mLd
         hvlmNaa3jAF331tKDxpoGa7MiI7tZKIdJxLrnfp/6XshW1MSjB8Vo6DVdCii5sfqkWAU
         uWkQ==
X-Gm-Message-State: APzg51A5osGM72RUJtoUS+i+D/1ogZ4jBqNxod5afR2/Js3que6eLOBH
        SHmrDeTH/s5ZUT1Ymeowi0pV/0cfU7IPGC0i4wM=
X-Google-Smtp-Source: ANB0VdbtIlMt7wgTdUBbpsNnGOGZuMXWGVVxk3tnIJgmSgp/R5a/55daARobDrQ2k54/pPfRKq/FcApLRA8BtS/FRTo=
X-Received: by 2002:a7b:c086:: with SMTP id r6-v6mr1695737wmh.119.1536763034806;
 Wed, 12 Sep 2018 07:37:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4c86:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 07:36:54
 -0700 (PDT)
In-Reply-To: <CANCKTBumoy6mw2n+V7hN_T1SYxhq3JQMxgQUUSmOLuMX-Kv=zw@mail.gmail.com>
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
 <1536266581-7308-9-git-send-email-jim2101024@gmail.com> <20180906214955.2yzyj6tkmflnnvdx@pburton-laptop>
 <CANCKTBumoy6mw2n+V7hN_T1SYxhq3JQMxgQUUSmOLuMX-Kv=zw@mail.gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 12 Sep 2018 16:36:54 +0200
Message-ID: <CAOiHx=khXs6x-EByPXRF=xEpL4eSiBfwxgJFV=3X8J5rXWNEMw@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] MIPS: BMIPS: add PCI bindings for 7425, 7435
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     paul.burton@mips.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, nicolas.pitre@linaro.org,
        keescook@chromium.org, jinb.park7@gmail.com,
        vladimir.murzin@arm.com, alexandre.belloni@bootlin.com,
        palmer@sifive.com, stefan@agner.ch, eric@anholt.net,
        Simon Horman <horms+renesas@verge.net.au>, tony@atomide.com,
        stefan.wahren@i2se.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>, thellstrom@vmware.com,
        alexander.deucher@amd.com, dirk@hohndel.org,
        Thomas Gleixner <tglx@linutronix.de>, pombredanne@nexb.com,
        kstewart@linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>, justinpopo6@gmail.com,
        markus.mayer@broadcom.com, gpowell@broadcom.com, opendmb@gmail.com,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

On 10 September 2018 at 16:37, Jim Quinlan <jim2101024@gmail.com> wrote:
> On Thu, Sep 6, 2018 at 5:50 PM Paul Burton <paul.burton@mips.com> wrote:
>>
>> Hi Jim,
>>
>> On Thu, Sep 06, 2018 at 04:42:57PM -0400, Jim Quinlan wrote:
>> > Adds the PCIe nodes for the Broadcom STB PCIe root complex.
>> >
>> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>> > ---
>> >  arch/mips/boot/dts/brcm/bcm7425.dtsi     | 28 ++++++++++++++++++++++++++++
>> >  arch/mips/boot/dts/brcm/bcm7435.dtsi     | 28 ++++++++++++++++++++++++++++
>> >  arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
>> >  arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
>> >  4 files changed, 64 insertions(+)
>>
>> Do you have a preference for how this gets merged? If it goes via the
>> PCI tree then for patches 8 & 9:
>>
>>     Acked-by: Paul Burton <paul.burton@mips.com>
>>
> Hi Paul,
>
> I hope that the 12 commits  go together and will go through the PCI
> tree.  I'm inclined to think I will have to do a V6, and in the cover
> leter I will mention this request.

Somehow nothing of the v5 patch series seem to have made it to any
mailing lists, at least I can't find them in my inbox (or spam) in any
of the mailing lists, nor through the public archives of e.g. LKML.
Patchwork (ozlabs and kernel) doesn't know of them either.


Regards
Jonas
