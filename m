Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 09:53:39 +0200 (CEST)
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35515 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991162AbeJAHxfawT7G convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Oct 2018 09:53:35 +0200
Received: by mail-vs1-f66.google.com with SMTP id c10so1610365vsk.2;
        Mon, 01 Oct 2018 00:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fse7KpQK4D3pkd1OwWmBP3xPIZzYRxGU9L0taz7PM74=;
        b=HiZfiqc+5DsTw1F1kYj0hSutJ51KS3icxev2edjga2OcwpPViNN4qgVRmQjOcogmTl
         FFSAdg3Z4CgaEhckehRUmjh3T12w8Hy9znREjvYSjTQ7Ob1G6VuRBHAOMxil8kdKNJsD
         qtMVD6t+xw+e1yeR4uEpXdAt9d2tJ0RiY8YODdRia62EGiXkxWjCHd5HFCOc/NZp0hfF
         Itwi0oQvYdhXvvEm0aeLG2MYz2W4RzIRFtG2iwVQOzc8x1oWsZ6gPG4fMVtTPS67g8XJ
         3vgbszWR9mi7kLF6le1/pMtNabukM9ezKjL2FF1EhlWljcxuY2Qmxg3vTmZEdtu9ne6r
         E/mg==
X-Gm-Message-State: ABuFfogMOtsqTnriiwgupvXEGWDKJuu5O4xejY8HywsuJF3J8AljlpD9
        Z4XtUB9ALwtZ1fDu+1oCYY3TUpCyePeD0owWOZ0=
X-Google-Smtp-Source: ACcGV609Lnu4FrPRGnyP3xS+u5v5KhwZ0H6OXDWYS6T9uI8bo8Xc8VsCR1ipQNkeRLUb/myWD7qYgFOZKy5VkxSRMSA=
X-Received: by 2002:a67:68ce:: with SMTP id d197-v6mr3626847vsc.152.1538380409478;
 Mon, 01 Oct 2018 00:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <75740733-d0d4-4c0c-838c-f01a5e7291d3@suse.de> <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
In-Reply-To: <CAL_JsqKLOohxGx0Je9niMQ5H3o0Y=EcMQTB6YkbV0sfUOZHu8g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 1 Oct 2018 09:53:15 +0200
Message-ID: <CAMuHMdW_+PNZrh5JXo8MxVwg3YSZL7bszMcUJjCqMFfBz8HDPQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>, ley.foon.tan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Fri, Sep 28, 2018 at 8:42 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Sep 28, 2018 at 12:21 PM Andreas Färber <afaerber@suse.de> wrote:
> > Am 13.09.18 um 17:51 schrieb Geert Uytterhoeven:
> > > On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > >> Even x86 can enable OF and OF_UNITTEST.
> > >>
> > >> Another solution might be,
> > >> guard it by 'depends on ARCH_SUPPORTS_OF'.
> > >>
> > >> This is actually what ACPI does.
> > >>
> > >> menuconfig ACPI
> > >>         bool "ACPI (Advanced Configuration and Power Interface) Support"
> > >>         depends on ARCH_SUPPORTS_ACPI
> > >>          ...
> > >
> > > ACPI is a real platform feature, as it depends on firmware.
> > >
> > > CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
> > > even if it has ACPI ;-)
> >
> > How would loading a DT overlay work on an ACPI platform? I.e., what
> > would it overlay against and how to practically load such a file?
>
> The DT unittests do just that. I run them on x86 and UM builds. In
> this case, the loading source is built-in.
>
> > I wonder whether that could be helpful for USB devices and serdev...
>
> How to load the overlays is pretty orthogonal to the issues to be
> solved here. It would certainly be possible to move forward with
> prototyping this and just have the overlay built-in. It may not even
> need to be an overlay if we can support multiple root nodes.

You indeed need to refer to some anchors for most use cases, although a
simple MMIO device could just be anchored to the root node.

Topologies hanging off a USB device would be my first use case, too,
for serdev, or for e.g. the mcp2210 USB-SPI bridge.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
