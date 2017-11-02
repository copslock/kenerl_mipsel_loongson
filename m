Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 13:49:53 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:38394 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993310AbdKBMtmoqE2N convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 13:49:42 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 02 Nov 2017 12:48:09 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Thu, 2 Nov 2017 05:47:28 -0700
From:   Miodrag Dinic <Miodrag.Dinic@mips.com>
To:     James Hogan <James.Hogan@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Paul Burton <Paul.Burton@mips.com>,
        "Petar Jovanovic" <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Thread-Topic: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Thread-Index: AQHTUXZuvGrl+bRRXEyMdpcukfrmmqL9D2IAgAPGjFY=
Date:   Thu, 2 Nov 2017 12:47:27 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD6A74206@MIPSMAIL01.mipstec.com>
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1509364642-21771-6-git-send-email-aleksandar.markovic@rt-rk.com>,<20171030164523.GA15235@jhogan-linux>
In-Reply-To: <20171030164523.GA15235@jhogan-linux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1509626888-298553-13666-65379-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.61
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186513
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains 
        popular marketing words 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.61 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Miodrag.Dinic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Miodrag.Dinic@mips.com
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

Hello James,

sorry for a late reply, please find the answers in-lined :

> On Mon, Oct 30, 2017 at 12:56:36PM +0100, Aleksandar Markovic wrote:
> > From: Miodrag Dinic <miodrag.dinic@mips.com>
> > 
> > Provide amendments to the MIPS generic platform framework so that
> > the new generic-based board Ranchu can be chosen to be built.
> 
> A bit more info about the board would be good here. What boot protocol
> is used? Does QEMU generate the DT dynamically?

I agree, we will fill the commit message with necessary information about
the newly introduced virtual board.

> > 
> > Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> > Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> > ---
> >  MAINTAINERS                                   |  6 ++
> >  arch/mips/configs/generic/board-ranchu.config | 30 ++++++++++
> >  arch/mips/generic/Kconfig                     | 10 ++++
> >  arch/mips/generic/Makefile                    |  1 +
> >  arch/mips/generic/board-ranchu.c              | 79 +++++++++++++++++++++++++++
> >  5 files changed, 126 insertions(+)
> >  create mode 100644 arch/mips/configs/generic/board-ranchu.config
> >  create mode 100644 arch/mips/generic/board-ranchu.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f1be016..e429cc2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11308,6 +11308,12 @@ S:   Maintained
> >  F:   Documentation/blockdev/ramdisk.txt
> >  F:   drivers/block/brd.c
> >  
> > +RANCHU VIRTUAL BOARD FOR MIPS
> > +M:   Miodrag Dinic <miodrag.dinic@mips.com>
> > +L:   linux-mips@linux-mips.org
> > +S:   Supported
> > +F:   arch/mips/generic/board-ranchu.c
> 
> Maybe worth adding arch/mips/configs/generic/board-ranchu.config too.

It will be addressed in V7.

> > +
> >  RANDOM NUMBER DRIVER
> >  M:   "Theodore Ts'o" <tytso@mit.edu>
> >  S:   Maintained
> 
> > diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> > index e0436aa..93582be 100644
> > --- a/arch/mips/generic/Kconfig
> > +++ b/arch/mips/generic/Kconfig
> > @@ -42,4 +42,14 @@ config FIT_IMAGE_FDT_NI169445
> >          Enable this to include the FDT for the 169445 platform from
> >          National Instruments in the FIT kernel image.
> >  
> > +config VIRT_BOARD_RANCHU
> > +     bool "Ranchu platform for Android emulator"
> > +     help
> > +       This enables support for the platform used by Android emulator.
> > +
> > +       Ranchu platform consists of a set of virtual devices. This platform
> > +       enables emulation of variety of virtual configurations while using
> > +       Android emulator. Android emulator is based on Qemu, and contains
> > +       the support for the same set of virtual devices.
> 
> This is effectively in the section "FIT/UHI Boards", but it has a
> platform file and no DT/FIT stuff in tree a bit like the boards in the
> section "Legacy (non-UHI/non-FIT) Boards".
> 
> I'm guessing it might be something in between, with UHI + platform code,
> but DT provided by QEMU (i.e. FIT support makes no sense)?

The Ranchu emulator was designed to provide the DT dynamically generated on
the QEMU side and passed to the kernel using UHI boot protocol in DTB handover mode.
Currently we do not support FIT, but I think it is doable to enable it
at some point later in time when we stop supporting android 3.10/3.18 kernels
in Ranchu.

> If it uses UHI I suppose it doesn't belong in the legacy section, but I
> think a consistent prompt would be beneficial, e.g.
> 
> +config VIRT_BOARD_RANCHU
> +       bool "Support Ranchu platform for Android emulator"
> ...

It will be addressed in V7.

> > diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-ranchu.c
> > new file mode 100644
> > index 0000000..0397752
> > --- /dev/null
> > +++ b/arch/mips/generic/board-ranchu.c
> > @@ -0,0 +1,79 @@
> > +/*
> > + * Support code for virtual Ranchu board for MIPS.
> > + *
> > + * Author: Miodrag Dinic <miodrag.dinic@mips.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/of_address.h>
> > +
> > +#include <asm/machine.h>
> > +#include <asm/time.h>
> > +
> > +#define GOLDFISH_TIMER_LOW           0x00
> > +#define GOLDFISH_TIMER_HIGH          0x04
> > +
> > +static __init uint64_t read_rtc_time(void __iomem *base)
> > +{
> > +     u64 time_low;
> > +     u64 time_high;
> > +
> > +     time_low = readl(base + GOLDFISH_TIMER_LOW);
> > +     time_high = readl(base + GOLDFISH_TIMER_HIGH);
> > +
> > +     return (time_high << 32) | time_low;
> 
> What if high changes while reading this?
> 
> E.g.
> TIMER_LOW        0x00000000 *0xffffffff*
> TIMER_HIGH      *0x00000001* 0x00000000
> 
> You'd presumably get 0x00000001ffffffff.
> 
> Perhaps it should read HIGH before too, and retry if it has changed.

This was already discussed in some earlier posts. (https://patchwork.linux-mips.org/patch/16628/)
Reading the low value first actually latches the high value,
so it is safe to leave it this way. Here is the relevant RTC device
implementation in QEMU:

static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset, unsigned size)
{
    struct rtc_state *s = (struct rtc_state *)opaque;
    switch(offset) {
        case TIMER_TIME_LOW:
            s->now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->time_base;
            return s->now_ns;
        case TIMER_TIME_HIGH:
            return s->now_ns >> 32;

Kind regards,
Miodrag


________________________________________
From: James Hogan
Sent: Monday, October 30, 2017 5:45 PM
To: Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; David S. Miller; Douglas Leung; Greg Kroah-Hartman; linux-kernel@vger.kernel.org; Mauro Carvalho Chehab; Miodrag Dinic; Paul Burton; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Randy Dunlap
Subject: Re: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based board

On Mon, Oct 30, 2017 at 12:56:36PM +0100, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@mips.com>
>
> Provide amendments to the MIPS generic platform framework so that
> the new generic-based board Ranchu can be chosen to be built.

A bit more info about the board would be good here. What boot protocol
is used? Does QEMU generate the DT dynamically?

>
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  MAINTAINERS                                   |  6 ++
>  arch/mips/configs/generic/board-ranchu.config | 30 ++++++++++
>  arch/mips/generic/Kconfig                     | 10 ++++
>  arch/mips/generic/Makefile                    |  1 +
>  arch/mips/generic/board-ranchu.c              | 79 +++++++++++++++++++++++++++
>  5 files changed, 126 insertions(+)
>  create mode 100644 arch/mips/configs/generic/board-ranchu.config
>  create mode 100644 arch/mips/generic/board-ranchu.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1be016..e429cc2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11308,6 +11308,12 @@ S:   Maintained
>  F:   Documentation/blockdev/ramdisk.txt
>  F:   drivers/block/brd.c
>
> +RANCHU VIRTUAL BOARD FOR MIPS
> +M:   Miodrag Dinic <miodrag.dinic@mips.com>
> +L:   linux-mips@linux-mips.org
> +S:   Supported
> +F:   arch/mips/generic/board-ranchu.c

Maybe worth adding arch/mips/configs/generic/board-ranchu.config too.

> +
>  RANDOM NUMBER DRIVER
>  M:   "Theodore Ts'o" <tytso@mit.edu>
>  S:   Maintained

> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index e0436aa..93582be 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -42,4 +42,14 @@ config FIT_IMAGE_FDT_NI169445
>         Enable this to include the FDT for the 169445 platform from
>         National Instruments in the FIT kernel image.
>
> +config VIRT_BOARD_RANCHU
> +     bool "Ranchu platform for Android emulator"
> +     help
> +       This enables support for the platform used by Android emulator.
> +
> +       Ranchu platform consists of a set of virtual devices. This platform
> +       enables emulation of variety of virtual configurations while using
> +       Android emulator. Android emulator is based on Qemu, and contains
> +       the support for the same set of virtual devices.

This is effectively in the section "FIT/UHI Boards", but it has a
platform file and no DT/FIT stuff in tree a bit like the boards in the
section "Legacy (non-UHI/non-FIT) Boards".

I'm guessing it might be something in between, with UHI + platform code,
but DT provided by QEMU (i.e. FIT support makes no sense)?

If it uses UHI I suppose it doesn't belong in the legacy section, but I
think a consistent prompt would be beneficial, e.g.

+config VIRT_BOARD_RANCHU
+       bool "Support Ranchu platform for Android emulator"
...

> diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-ranchu.c
> new file mode 100644
> index 0000000..0397752
> --- /dev/null
> +++ b/arch/mips/generic/board-ranchu.c
> @@ -0,0 +1,79 @@
> +/*
> + * Support code for virtual Ranchu board for MIPS.
> + *
> + * Author: Miodrag Dinic <miodrag.dinic@mips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/of_address.h>
> +
> +#include <asm/machine.h>
> +#include <asm/time.h>
> +
> +#define GOLDFISH_TIMER_LOW           0x00
> +#define GOLDFISH_TIMER_HIGH          0x04
> +
> +static __init uint64_t read_rtc_time(void __iomem *base)
> +{
> +     u64 time_low;
> +     u64 time_high;
> +
> +     time_low = readl(base + GOLDFISH_TIMER_LOW);
> +     time_high = readl(base + GOLDFISH_TIMER_HIGH);
> +
> +     return (time_high << 32) | time_low;

What if high changes while reading this?

E.g.
TIMER_LOW        0x00000000 *0xffffffff*
TIMER_HIGH      *0x00000001* 0x00000000

You'd presumably get 0x00000001ffffffff.

Perhaps it should read HIGH before too, and retry if it has changed.

Cheers
James
