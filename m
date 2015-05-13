Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 21:19:36 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55060 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013148AbbEMTTeEkW-Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 May 2015 21:19:34 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id C0AFE284480;
        Wed, 13 May 2015 21:18:17 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com [209.85.216.172])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 86E17280BD3;
        Wed, 13 May 2015 21:18:14 +0200 (CEST)
Received: by qcyk17 with SMTP id k17so28101068qcy.1;
        Wed, 13 May 2015 12:19:28 -0700 (PDT)
X-Received: by 10.141.28.142 with SMTP id f136mr590867qhe.67.1431544768701;
 Wed, 13 May 2015 12:19:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.82.200 with HTTP; Wed, 13 May 2015 12:19:08 -0700 (PDT)
In-Reply-To: <55539B68.8060304@broadcom.com>
References: <55539B68.8060304@broadcom.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 13 May 2015 21:19:08 +0200
Message-ID: <CAOiHx==e0MTorbgAgmL13nT=5ChW2OnFB7RKxenjaRZbnzS1-A@mail.gmail.com>
Subject: Re: 4.1-rc2: build issue with duplicate redefinition of _PAGE_GLOBAL_SHIFT
To:     Arend van Spriel <arend@broadcom.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        brcm80211 development <brcm80211-dev-list@broadcom.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi Arend,

On Wed, May 13, 2015 at 8:43 PM, Arend van Spriel <arend@broadcom.com> wrote:
> For our upstream brcm80211 drivers we build for a number of architectures
> including MIPS. In recent builds we get an error/warning:
>
>   CC [M]  drivers/net/wireless/brcm80211/brcmfmac/cfg80211.o
> In file included from ./arch/mips/include/asm/io.h:27:0,
>                  from ./arch/mips/include/asm/page.h:176,
>                  from include/linux/mm_types.h:15,
>                  from include/linux/kmemcheck.h:4,
>                  from include/linux/skbuff.h:18,
>                  from include/linux/if_ether.h:23,
>                  from include/linux/etherdevice.h:25,
>                  from drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c:20:
> ./arch/mips/include/asm/pgtable-bits.h:164:0: error: "_PAGE_GLOBAL_SHIFT"
> redefined [-Werror]
> ./arch/mips/include/asm/pgtable-bits.h:141:0: note: this is the location of
> the previous definition
>
> As it is likely a Kconfig issue I have attached the config file that was
> used for the build. I started out with mips_config.old and ran 'make
> oldconfig' and just hit enter a couple of times selecting all defaults which
> ends up with the mips_config file having the issue. As I have no clue what
> Kconfig combinations are valid I am hoping anyone on the mips list can shed
> some light on this.

this isn't a config issue, it's a clear bug which

https://patchwork.linux-mips.org/patch/9960/

intends to fix.


Regards
Jonas
