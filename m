Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Aug 2014 10:32:12 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:53415 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006614AbaHWO72k26OH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2014 16:59:28 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue105) with ESMTP (Nemesis)
        id 0Lwqt6-1WEupN2EeW-016OtY; Sat, 23 Aug 2014 16:59:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Andrew Bresticker <abrestic@chromium.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
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
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
Date:   Sat, 23 Aug 2014 16:59:04 +0200
Message-ID: <64044023.tHj6rvEyXT@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.11.0-26-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAOiHx=noe=614vv4GyhuvfoAYj0jYDhO5vX+7M2RbQBpE-uPnQ@mail.gmail.com>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org> <201408231556.42571.arnd@arndb.de> <CAOiHx=noe=614vv4GyhuvfoAYj0jYDhO5vX+7M2RbQBpE-uPnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:MBYTySjxA2D/clWyPFYjtm74J4lB0LGeTuFXVerBMxe
 Y5Q/P6ttBckbjY84xcOcKMQOzwNAP0WWyQguVINukXiRvyufDu
 Tl2542AffJaQ2O3NvXdcTIsgyMiZp0E2PyqvUmg2E1aENrfKEJ
 r8lIbnL47OL5FqwMHVTuMxBz6YU8Y7ECV1WFPSGlGEULZ0SYbE
 SZ7N5PrdWA23tNI1x5AGoUfTO+BzREckYNM/LcavF60xRM6UG7
 gWcnDBBsP976JQPt5rdNncVhCAJur9x7hx3Lc4wMAsRmOQZFia
 C9Ab8YmctjeWdH5dKsm34P1pD8MOxcD/5x2yuCJZyfoafv12t8
 TrB9bYjdmCPSMsiYfxPU=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42188
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

On Saturday 23 August 2014 16:48:52 Jonas Gorski wrote:
> On Sat, Aug 23, 2014 at 3:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Another argument is that we plan to actually move all the dts files out of
> > the kernel into a separate project in the future. We really don't want to
> > have the churn of moving all the files now when they get deleted in one
> > of the next merge windows.
> >
> > I don't know if we talked about whether that move should be done for
> > all architectures at the same time. If that is the plan, I think it
> > would be best to not move the MIPS files at all but also wait until
> > they can get removed from the kernel tree.
> 
> I wonder how this is supposed to work with dtbs that are currently
> expected to be built into the kernel?

Most architectures use appended dtb blobs to work around legacy boot
loaders that are lacking native dtb support. For these, combining the
kernel and dtb is part of the installation or system image creation
process, not part of the kernel build.

For the architectures that currently link the dtb into the kernel,
(arc, metag, openrisc, xtensa), I suppose the best way is to move
to use the same method as the other architectures. This also solves
the problem of building a kernel that runs on multiple machines.

	Arnd
