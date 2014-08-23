Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2014 15:57:04 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.130]:64138 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006524AbaHWN5DsBs8Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2014 15:57:03 +0200
Received: from klappe2.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
        id 0LpRgn-1Wio362CMX-00fBr9; Sat, 23 Aug 2014 15:56:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
Date:   Sat, 23 Aug 2014 15:56:42 +0200
User-Agent: KMail/1.12.2 (Linux/3.8.0-35-generic; KDE/4.3.2; x86_64; ; )
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Linux-MIPS" <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org> <CAL1qeaGb-o0P7x4nZPJ+dGfoSKz+2ANrB0gGrBi19TtPxVTAZQ@mail.gmail.com> <20140823063113.GC23715@localhost>
In-Reply-To: <20140823063113.GC23715@localhost>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201408231556.42571.arnd@arndb.de>
X-Provags-ID: V02:K0:amijnnnDsKoWdWE8F2RgkY55G2QwEm/B5S9drzsErmJ
 bWRyYLixFA9gAxfuFgiB8wnPNWT0DwainAq1vQMaZFEIACtq/Z
 Z3xPJw1E9yXhpzjaAfFmoBsnt/JR9UbSGsE3woqiGiBcmm4IGI
 Nl8YtviZtdzzYxZMClB3W//HV3DqOgm8YM9BpSmeXYDeXpbLSr
 2RqmDki9v/JadbZJibzkh1tmfc/aZBv40Q7gLBcxSvN4X7w43a
 yc5DntfLl47G9W4wtJbwrIUp6Vtp9vZoR/cUcaR3bq9hQDM5dp
 AbepNbB/GxuxZ/h3vM5TX9IoWYykyia4MCd2U0+PdIF61e7v4y
 Bx7cN+k7MqMnyFT7bq9k=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42187
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

On Saturday 23 August 2014, Olof Johansson wrote:
> On Fri, Aug 22, 2014 at 02:10:23PM -0700, Andrew Bresticker wrote:
> > On Fri, Aug 22, 2014 at 1:42 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> > >
> > > On Aug 21, 2014 3:05 PM, "Andrew Bresticker" <abrestic@chromium.org> wrote:
> > > >
> > > > To be consistent with other architectures and to avoid unnecessary
> > > > makefile duplication, move all MIPS device-trees to arch/mips/boot/dts
> > > > and build them with a common makefile.
> > >
> > > I recall reading that the ARM organization for DTS files was a bit unfortunate
> > > and should have been something like:
> > >
> > > arch/arm/boot/dts/<vendor>/
> > >
> > > Is this something we should do for the MIPS and update the other architectures
> > > to follow that scheme?
> > 
> > I recall reading that as well and that it would be adopted for ARM64,
> > but that hasn't seemed to have happened.  Perhaps Olof (CC'ed) will no
> > more.
> 
> Yeah, I highly recommend having a directory per vendor. We didn't on ARM,
> and the amount of files in that directory is becoming pretty
> insane. Moving to a subdirectory structure later gets messy which is
> why we've been holding off on it.

Another argument is that we plan to actually move all the dts files out of
the kernel into a separate project in the future. We really don't want to
have the churn of moving all the files now when they get deleted in one
of the next merge windows.

I don't know if we talked about whether that move should be done for
all architectures at the same time. If that is the plan, I think it
would be best to not move the MIPS files at all but also wait until
they can get removed from the kernel tree.

	Arnd
