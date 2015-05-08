Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 17:32:51 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:49677 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026568AbbEHPctntIwQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 17:32:49 +0200
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0LmLVi-1ZQM073lFy-00a13j; Fri, 08 May
 2015 17:32:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: BMIPS: dts: remove unsupported entry for bcm7362
Date:   Fri, 08 May 2015 17:32:44 +0200
Message-ID: <10776752.kPn2ooXz5Z@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAJiQ=7CQshXhGJ7ftWQSu_UxgKVaRprZPEPXWNP6ci_1bLrJrw@mail.gmail.com>
References: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com> <1431089958-2626-2-git-send-email-jaedon.shin@gmail.com> <CAJiQ=7CQshXhGJ7ftWQSu_UxgKVaRprZPEPXWNP6ci_1bLrJrw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:bXVx86zUJM1QSuE4ZkZSV409+2KTceu7E+kFgFz9xwmS5byJIon
 6+TQkeRoHuuv6L7p5gfzcO6GMeCNT3fvdSQEqcAIgblKz2x9MBPc48hWmJtlTTcuAezR4vu
 fiISZJoZPMe967H95QVOjq/VBqD7qlcABzM4gpKCK9Qexq6DZ/W5wF7I9jLrHJlTgTC6b4+
 Y4mT+gCy8w4GIN6yLjnpw==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Friday 08 May 2015 07:40:44 Kevin Cernekee wrote:
> On Fri, May 8, 2015 at 5:59 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> > Remove unsupported memory entry for the bcm7362 platform. The BMIPS4380
> > processor only supports ZONE_NORMAL is not available for HIGHMEM.
> >
> > Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> > ---
> >  arch/mips/boot/dts/brcm/bcm97362svmb.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> > index b7b88e5dc9e7..ab8b01fa7dcf 100644
> > --- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> > +++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> > @@ -8,7 +8,7 @@
> >
> >         memory@0 {
> >                 device_type = "memory";
> > -               reg = <0x00000000 0x10000000>, <0x20000000 0x30000000>;
> > +               reg = <0x00000000 0x10000000>;
> 
> Hmm, this is more of a kernel limitation than a hardware limitation,
> though.  The board physically has 1GB of memory, right?  It is best if
> the DT entry reflects the actual hardware configuration.
> 
> The Broadcom kernels enable the CPU's special "XKS01" feature to put
> 1GB of memory in ZONE_NORMAL:
> 
> https://github.com/Broadcom/stblinux-3.3/tree/master/linux
> 

What exactly is the kernel limitation here?

	Arnd
