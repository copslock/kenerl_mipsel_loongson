Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 16:43:07 +0200 (CEST)
Received: from mail-lj1-x244.google.com ([IPv6:2a00:1450:4864:20::244]:43885
        "EHLO mail-lj1-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeIJOnDaL6sl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2018 16:43:03 +0200
Received: by mail-lj1-x244.google.com with SMTP id m84-v6so18090796lje.10;
        Mon, 10 Sep 2018 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnFGGnHhWxIC6mS7/G9pK9gNLGNPEC7YGgvXN1jUgoY=;
        b=jZrfBJq+k1aIaVzDefoJgKNzgUZV6xK1qgWMf6qOYb3mcNVF6EAjR+hR+Rj3CKn4BT
         c0KCxAq9w8DGoNbtdq7Yy9tsRaS+nYbM1zzm5hrsxd6RXd9kiBWQb5Hw3Nl5ZYW67qiW
         yS9BYViSRBTyoGBinEpg78G0GfOCkxAfMA626U72seN5ucKcV/LvKs+OC8KXudCdRMAI
         6jacOZz7lzn0qOKGJnjjqDxKOj/DHLkgxtSlzkLazT6P61B9t/nbWSGUb1qsQJkLU8AQ
         P5EAkzbWibB7kRs37K1PlTiCmtgM2o/jzTQfg/yyI3Zc1K5QTi9uC7rGFOPNx6RVm86Z
         BQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnFGGnHhWxIC6mS7/G9pK9gNLGNPEC7YGgvXN1jUgoY=;
        b=cWE2SyFdyt/zG2QVA5mnhCHL9U1y+R0S2XAbvc55qm5bNf9WEiJs5dpGWij8hrhmtC
         JtZd+uPY1B946zTO6GIN0+aZ6Y+HJnWzVj15NvAR+52xobHIE3ZYOrGEVab9kICAtv0F
         vV3ozaRhE3AKQObgJBDGgNjYE5dQL6hUa5i9n34xK8i7BomZO6ourICtrsnAkiNl9FyH
         a+9vmCAMjThPKvtOavgAglgkZovXcVyIXo51cTQpmXXpN7gAz7yDdMq110tt3tuoKEgJ
         HFo84pVqA1ONfQCPXkFYf78lAC7PfuXdJh8Uwb4UP6bIg+cuQ3z6yVqWv4iLC+Apkmmf
         BF0w==
X-Gm-Message-State: APzg51CNbJXm1fDSQ+YXpO1vY3syrWzhb6AvEubL3Y2bOvK98RWymkFx
        FHR3VQ2cLUUYrGn4GwxKHDuKeWHP8GKrk9kTm90=
X-Google-Smtp-Source: ANB0VdbyqplGAFSaQceSQIFoHVANC9x+c6lkT4mDnnK7uO/rAMRp2hUQnnxDbmS+tlk3Cr3s1q4sQ5Q6SjVPT+mkg/4=
X-Received: by 2002:a2e:3e0d:: with SMTP id l13-v6mr12673531lja.151.1536590574469;
 Mon, 10 Sep 2018 07:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
 <1536266581-7308-8-git-send-email-jim2101024@gmail.com> <20180906214549.y4xpleiukzw5rmqs@pburton-laptop>
In-Reply-To: <20180906214549.y4xpleiukzw5rmqs@pburton-laptop>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 10 Sep 2018 10:42:43 -0400
Message-ID: <CANCKTBsuEaeW=95tpjOPF2RecfTbdUP+C7a1QwFdvOBFG6o8Vg@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] PCI/MSI: enable PCI_MSI_IRQ_DOMAIN support for MIPS
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
X-archive-position: 66181
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

On Thu, Sep 6, 2018 at 5:46 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Jim,
>
> On Thu, Sep 06, 2018 at 04:42:56PM -0400, Jim Quinlan wrote:
> > Add MIPS as an arch that supports PCI_MSI_IRQ_DOMAIN and add
> > generation of msi.h in the MIPS arch.
>
> I guess the second part of this probably became untrue after rebasing
> atop something including commit 34a4399f196c ("mips: use asm-generic
> version of msi.h"), and ought to be removed.
Hi Paul,

Yes, the second clause of this commit message will be removed.

Thanks,
Jim

>
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Otherwise this looks fine:
>
>     Acked-by: Paul Burton <paul.burton@mips.com>
>
> Thanks,
>     Paul
