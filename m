Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 19:55:50 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.24]:55958 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013860AbaKQSzsgwd8e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 19:55:48 +0100
Received: from wuerfel.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue103) with ESMTP (Nemesis)
        id 0M3dNR-1Y8Nwj05JJ-00rJLg; Mon, 17 Nov 2014 19:55:16 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Jonas Gorski <jogo@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 22/22] MIPS: Add multiplatform BMIPS target
Date:   Mon, 17 Nov 2014 19:55:15 +0100
Message-ID: <14461008.6cZzGdpat2@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <CAJiQ=7An5eZ3j2+Zkx1crV9pBSVodkEQ+6ESGcFk5z0tDV7cHA@mail.gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com> <2018325.yOrLZndTTm@wuerfel> <CAJiQ=7An5eZ3j2+Zkx1crV9pBSVodkEQ+6ESGcFk5z0tDV7cHA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:421rEaFY5Yg1YBGWOhxVtojTlDLGGIEdfAI5x7x/YOB
 X2pIN5OencsOZN46tiNJIvDnsGix1xTt5VKUX80uhWcPspUHoz
 xKHzBylVrSGSgTyKR1hmDgbSKeVBXBhStFOSlOi/tWX/oosReF
 w36rd/FuzUffivJ9BZBX5iql0NnWvWhsueyfZ4RrFLny0+81S7
 opVhB+jmTt/vNc4uBSSDnNjmpsG0151TQEO5a2USgELhIu0fPu
 +ZMETO/t5VeX5eBiYb9/pzL3HlrU4uVD+hAVdyd0kGn9bo8X8z
 5z06/Dkwj1/Ui3aFTUQ+W6yy5/xeoLvja7C4M4XUcby4PK8x+e
 CFFnsybqEKCBzp/CAywU=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44242
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

On Monday 17 November 2014 09:19:17 Kevin Cernekee wrote:
> On Mon, Nov 17, 2014 at 8:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > This is not just DT, it's actually an implementation of a boot
> > interface. The situation here seems much more to what we had on
> > PowerPC a long time ago than what we had on ARM before the DT
> > conversion. I think the best approach here would be to move the
> > platform specific bits into the decompressor code, and allow
> > multiple implementations of that. This way you can have the
> > generic vmlinux file that has a common DT parser, and you wrap
> > that into one decompressor per platform, some of which can have
> > their own board detection logic or pre-boot setup where necessary.
> >
> > To be honest, I think having multiple DT files linked into the
> > kernel is a really bad idea, because it doesn't solve the
> > scalability problem at all. What we did on ARM was to force those
> > hacks out into external projects such as the PXA impedence
> > matcher [https://github.com/zonque/pxa-impedance-matcher]. This
> > can handle all weird boot protocol and adapt them to the normal
> > well-defined interfaces we have in the kernel.
> 
> To some extent this is how BCM3384 was done[1].
> 
> There is a tradeoff here: to add support for the older platforms it is
> easy to build a new DTB file into the kernel image, but it is a lot of
> trouble to write a new 3rd stage bootloader.  Do we want to maximize
> our list of supported boards, or are we shooting for a super clean
> kernel implementation right off the bat?

Right, when the norm is that you can't detect the board, having
the wrapper in the kernel is the better approach, as PowerPC, which
has a few dozen ways of linking the compressed kernel, while the
vmlinux file uses a common method and passes everything in DT.

That way you can have the best of both.

> >> And unless there is one, having a
> >> multiplatform kernel does not make much sense, as there is no sane way
> >> to tell apart different platforms on boot.
> >
> > How do you normally tell boards apart on MIPS when you don't use DT?
> 
> On BCM7xxx (STB) kernels, we could assume the chip ID was in a known
> register, and also we could call back into the bootloader to get a
> somewhat-accurate board name.
> 
> On BCM63xx there is logic in arch/mips/bcm63xx/cpu.c to try to guess
> the chip identity from the CPU type/revision (because the latter can
> be read directly from CP0).
> 
> These systems were never really designed to support multiplatform
> kernels.  The ARM BCM7xxx variants, by contrast, were.

Guessing the chip doesn't really help you all that much of course
as long as you don't know the board, and once you know that,
the chip is implied.

	Arnd
