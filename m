Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Mar 2010 04:44:26 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:46747 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490970Ab0CDDoV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Mar 2010 04:44:21 +0100
Received: by smtp.gentoo.org (Postfix, from userid 2181)
        id C5A971B4001; Thu,  4 Mar 2010 03:44:09 +0000 (UTC)
Date:   Thu, 4 Mar 2010 03:44:09 +0000
From:   Zhang Le <r0bertz@gentoo.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
Subject: Re: [PATCH v11 0/9] Loongson: YeeLoong: add platform drivers
Message-ID: <20100304034409.GA11523@woodpecker.gentoo.org>
Mail-Followup-To: Wu Zhangjin <wuzhangjin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
        linux-mips@linux-mips.org, zhangfx@lemote.com
References: <cover.1264940063.git.wuzhangjin@gmail.com> <1264940423.21259.2.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264940423.21259.2.camel@falcon>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 20:20 Sun 31 Jan     , Wu Zhangjin wrote:
> On Sun, 2010-01-31 at 20:15 +0800, Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> (ooh, just re-generate the patchset with "git format-patch" but forgot
> to put the comments, here it is!)
> 
> This patchset adds several platform specific drivers for the YeeLoong
> netbook
> made by Lemote.
> 
> It is completely based on the v10 revision and with the following
> changes:
> 
>   O Rebased on the latest linux-queue git tree of Ralf.
>   O Split the EC revision related handling out of the "input/hotkey"
> driver.
>   O Rewrite the AC & Battery driver with the new power_supply interface
> as "Pavel Machek" suggested.
> 
> All of them have been tested again.
> 
> Best Regards,
> 	Wu Zhangjin
> 
> > 
> > Wu Zhangjin (9):
> >   MIPS: add subdirectory for platform extension drivers
> >   Loongson: YeeLoong: add platform driver
> >   Loongson: YeeLoong: add backlight driver
> >   Loongson: YeeLoong: add hardware monitoring driver
> >   Loongson: YeeLoong: add video output driver
> >   Loongson: YeeLoong: add suspend support
> >   Loongson: YeeLoong: add input/hotkey driver
> >   Loongson: YeeLoong: Co-operate with the revisions of EC
> >   Loongson: YeeLoong: add power_supply based battery driver
> > 
> >  arch/mips/include/asm/mach-loongson/ec_kb3310b.h |  188 ++++
> >  arch/mips/include/asm/mach-loongson/loongson.h   |    6 +
> >  arch/mips/loongson/common/cmdline.c              |    8 +
> >  arch/mips/loongson/lemote-2f/Makefile            |    2 +-
> >  arch/mips/loongson/lemote-2f/ec_kb3310b.c        |   12 +-
> >  arch/mips/loongson/lemote-2f/ec_kb3310b.h        |  188 ----
> >  arch/mips/loongson/lemote-2f/platform.c          |   39 +
> >  arch/mips/loongson/lemote-2f/pm.c                |    4 +-
> >  arch/mips/loongson/lemote-2f/reset.c             |    2 +-
> >  drivers/platform/Kconfig                         |    4 +
> >  drivers/platform/Makefile                        |    1 +
> >  drivers/platform/mips/Kconfig                    |   32 +
> >  drivers/platform/mips/Makefile                   |    5 +
> >  drivers/platform/mips/yeeloong_laptop.c          | 1192 ++++++++++++++++++++++
> >  14 files changed, 1483 insertions(+), 200 deletions(-)
> >  create mode 100644 arch/mips/include/asm/mach-loongson/ec_kb3310b.h
> >  delete mode 100644 arch/mips/loongson/lemote-2f/ec_kb3310b.h
> >  create mode 100644 arch/mips/loongson/lemote-2f/platform.c
> >  create mode 100644 drivers/platform/mips/Kconfig
> >  create mode 100644 drivers/platform/mips/Makefile
> >  create mode 100644 drivers/platform/mips/yeeloong_laptop.c
> > 

What's the status of these patches?

Ralf, any chance for 2.6.34?
Thanks!

Zhang, Le
