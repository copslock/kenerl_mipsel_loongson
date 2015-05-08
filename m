Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 20:33:46 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.24]:51657 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012837AbbEHSdok3x0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 20:33:44 +0200
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0LqWMz-1ZUGZs37Mv-00e6Zn; Fri, 08 May
 2015 20:33:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: BMIPS: dts: remove unsupported entry for bcm7362
Date:   Fri, 08 May 2015 20:33:36 +0200
Message-ID: <29249313.0p3GP5279g@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAJiQ=7Ajkae60eKfzr=mjPDov=bzoq7jBVDdQhGO37G8GGKK3w@mail.gmail.com>
References: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com> <10776752.kPn2ooXz5Z@wuerfel> <CAJiQ=7Ajkae60eKfzr=mjPDov=bzoq7jBVDdQhGO37G8GGKK3w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:VVcALXICk8ndtdiFZi00GlNHoen7B+wJYjupB5ikmS2LmMTSEUV
 9hASiStTPB35RaFBqrAH2vZicxiIxP5aM/JHTCH1tlxDxPjuqQXiJU2SrmrYbl7u+ZHPVyy
 zO05WS/HlWm5TKB0ALUis4kLl+ly+gGNlPO7HTDRMZWvVO0c15eQecqN3lk/slll/oqpKBP
 eITQDx50To1mWNAq3OVsw==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47291
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

On Friday 08 May 2015 09:40:03 Kevin Cernekee wrote:
> On Fri, May 8, 2015 at 8:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 08 May 2015 07:40:44 Kevin Cernekee wrote:
> >> On Fri, May 8, 2015 at 5:59 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> >> > Remove unsupported memory entry for the bcm7362 platform. The BMIPS4380
> >> > processor only supports ZONE_NORMAL is not available for HIGHMEM.
> >> >
> >> > Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> >> > ---
> >> >  arch/mips/boot/dts/brcm/bcm97362svmb.dts | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> >> > index b7b88e5dc9e7..ab8b01fa7dcf 100644
> >> > --- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> >> > +++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
> >> > @@ -8,7 +8,7 @@
> >> >
> >> >         memory@0 {
> >> >                 device_type = "memory";
> >> > -               reg = <0x00000000 0x10000000>, <0x20000000 0x30000000>;
> >> > +               reg = <0x00000000 0x10000000>;
> >>
> >> Hmm, this is more of a kernel limitation than a hardware limitation,
> >> though.  The board physically has 1GB of memory, right?  It is best if
> >> the DT entry reflects the actual hardware configuration.
> >>
> >> The Broadcom kernels enable the CPU's special "XKS01" feature to put
> >> 1GB of memory in ZONE_NORMAL:
> >>
> >> https://github.com/Broadcom/stblinux-3.3/tree/master/linux
> >>
> >
> > What exactly is the kernel limitation here?
> 
> If we can't enable HIGHMEM, e.g. because the MIPS CPU has D$ aliases,
> then Linux is supposed to ignore any RAM above the highmem/lowmem
> boundary.
> 
> There is code in paging_init() that tries to do this.  Several years
> ago it used to work, but the last time I tried it (~Oct 2014) it was
> broken due to some other changes in MIPS early memory init, so Linux
> hangs on boot unless you take the excess RAM out of DT.  Jaedon may be
> running into the same issue.

Ok, I see. Could you avoid the problem by not requiring highmem?

We have some hacks on arch/arm/mach-realview to provide a nonlinear
virt_to_phys() function, which ends up moving all RAM underneath the
lowmem limit.

	Arnd
