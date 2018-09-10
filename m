Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 16:37:40 +0200 (CEST)
Received: from mail-lj1-x241.google.com ([IPv6:2a00:1450:4864:20::241]:45469
        "EHLO mail-lj1-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993030AbeIJOhgVTdvl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2018 16:37:36 +0200
Received: by mail-lj1-x241.google.com with SMTP id u83-v6so18066749lje.12;
        Mon, 10 Sep 2018 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mt07X8Zmz1G3uxvR/fZyYOcCG9AjEq9iEAcCAq83phQ=;
        b=h/Kdph18ELX6NChXtcVkdABtkp/JfFncOKojMs3R/RDvgYRWfGehi8VjLnhf12yJih
         7tl4YpneipBSPLAgQqIioVSLxhvIfwm3WtoqmjfEmGOoTZpQXHLBMG+u6XqaZz2BzKdT
         hB1EmgN+rIK6IavVYSQtMqKIKRDtrb9vRuWJYBDInpyOkPyRsb9Xwewf7MSOwzB8O8DA
         2oPyJ08qe/wPNp/59Pet2HlgdJyccqcqtcNmMBpLQaJoTNbiB88eWSlWI7CGVOFhJXK6
         HxK7UwHQuLL8sooUzwqlX66o3Lhryt0oX9PMN6LopVIhGveRNevSAxzFBJtOTOAjabFc
         +52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mt07X8Zmz1G3uxvR/fZyYOcCG9AjEq9iEAcCAq83phQ=;
        b=I44RV6EGa7/AYb3iUO/f8p2wYzTaemmuusHfq72AxO99DaN6aoIIR2xFthzXezqwEk
         Ze1K9B3MUGXqmK75B6gShqAcBLfN5GP8e/Sj9vkJI0B3PZr810Oqfr8lVCjgxKDhOcm9
         ihHyL//LZyk40Mu2SsKgMnILrMNaO9E2amK1awDgjlqPmTgGlPOqOEQR8ZHZVzGDWpOt
         E0DoMhNFAnHn8EwnM6xkTVT5f8F3vgyDAKa+tJ9hUajWjLjFv3beHhuKxtaOOjLZhrh6
         8Sg4z6qGX1QtL52DcUmgXimCY7eSVykMoPXq+vNq8cIb8JOb80rc2yqy0VFZkwTuQjJv
         8GOA==
X-Gm-Message-State: APzg51BJPjfHd+TAY8Z8oQsF+d5O6Gaqpl4JdSqfCw4EDvOq3rTIQMtc
        BzkWj2wnrGRwRoBL+8F/hGcTaK8/KRAmT1HwS8s=
X-Google-Smtp-Source: ANB0VdbrBbbVM+4zL9VsiZVVdCRlmZjidZAtKeGLZB9fdH7E4/ZGK+Zf8eSdNAfnIpqNVfNm5Sm8rnMpY5GTefC1Cy0=
X-Received: by 2002:a2e:8098:: with SMTP id i24-v6mr12506697ljg.36.1536590250686;
 Mon, 10 Sep 2018 07:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
 <1536266581-7308-9-git-send-email-jim2101024@gmail.com> <20180906214955.2yzyj6tkmflnnvdx@pburton-laptop>
In-Reply-To: <20180906214955.2yzyj6tkmflnnvdx@pburton-laptop>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 10 Sep 2018 10:37:19 -0400
Message-ID: <CANCKTBumoy6mw2n+V7hN_T1SYxhq3JQMxgQUUSmOLuMX-Kv=zw@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] MIPS: BMIPS: add PCI bindings for 7425, 7435
To:     paul.burton@mips.com
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux@armlinux.org.uk, Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>, jhogan@kernel.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        yamada.masahiro@socionext.com, Arnd Bergmann <arnd@arndb.de>,
        nicolas.pitre@linaro.org, keescook@chromium.org,
        jinb.park7@gmail.com, vladimir.murzin@arm.com,
        alexandre.belloni@bootlin.com, palmer@sifive.com, stefan@agner.ch,
        eric@anholt.net, horms+renesas@verge.net.au, tony@atomide.com,
        stefan.wahren@i2se.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        martin.blumenstingl@googlemail.com, olof@lixom.net,
        thellstrom@vmware.com, alexander.deucher@amd.com, dirk@hohndel.org,
        tglx@linutronix.de, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
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
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

On Thu, Sep 6, 2018 at 5:50 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Jim,
>
> On Thu, Sep 06, 2018 at 04:42:57PM -0400, Jim Quinlan wrote:
> > Adds the PCIe nodes for the Broadcom STB PCIe root complex.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  arch/mips/boot/dts/brcm/bcm7425.dtsi     | 28 ++++++++++++++++++++++++++++
> >  arch/mips/boot/dts/brcm/bcm7435.dtsi     | 28 ++++++++++++++++++++++++++++
> >  arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
> >  arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
> >  4 files changed, 64 insertions(+)
>
> Do you have a preference for how this gets merged? If it goes via the
> PCI tree then for patches 8 & 9:
>
>     Acked-by: Paul Burton <paul.burton@mips.com>
>
Hi Paul,

I hope that the 12 commits  go together and will go through the PCI
tree.  I'm inclined to think I will have to do a V6, and in the cover
leter I will mention this request.

Thanks!
Jim

> Still looking at patch 6.
>
> Thanks,
>     Paul
