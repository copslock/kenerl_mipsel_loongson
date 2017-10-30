Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2017 17:51:10 +0100 (CET)
Received: from 5pmail.ess.barracuda.com ([64.235.154.203]:45892 "EHLO
        5pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992181AbdJ3QvDEsJgk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Oct 2017 17:51:03 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 30 Oct 2017 16:49:58 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 30 Oct
 2017 09:44:45 -0700
Date:   Mon, 30 Oct 2017 16:45:24 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     <linux-mips@linux-mips.org>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        "Goran Ferenc" <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        "Paul Burton" <paul.burton@imgtec.com>,
        Paul Burton <paul.burton@mips.com>,
        "Petar Jovanovic" <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Message-ID: <20171030164523.GA15235@jhogan-linux>
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1509364642-21771-6-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1509364642-21771-6-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509382195-452059-3070-332247-2
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186424
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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
> @@ -11308,6 +11308,12 @@ S:	Maintained
>  F:	Documentation/blockdev/ramdisk.txt
>  F:	drivers/block/brd.c
>  
> +RANCHU VIRTUAL BOARD FOR MIPS
> +M:	Miodrag Dinic <miodrag.dinic@mips.com>
> +L:	linux-mips@linux-mips.org
> +S:	Supported
> +F:	arch/mips/generic/board-ranchu.c

Maybe worth adding arch/mips/configs/generic/board-ranchu.config too.

> +
>  RANDOM NUMBER DRIVER
>  M:	"Theodore Ts'o" <tytso@mit.edu>
>  S:	Maintained

> diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> index e0436aa..93582be 100644
> --- a/arch/mips/generic/Kconfig
> +++ b/arch/mips/generic/Kconfig
> @@ -42,4 +42,14 @@ config FIT_IMAGE_FDT_NI169445
>  	  Enable this to include the FDT for the 169445 platform from
>  	  National Instruments in the FIT kernel image.
>  
> +config VIRT_BOARD_RANCHU
> +	bool "Ranchu platform for Android emulator"
> +	help
> +	  This enables support for the platform used by Android emulator.
> +
> +	  Ranchu platform consists of a set of virtual devices. This platform
> +	  enables emulation of variety of virtual configurations while using
> +	  Android emulator. Android emulator is based on Qemu, and contains
> +	  the support for the same set of virtual devices.

This is effectively in the section "FIT/UHI Boards", but it has a
platform file and no DT/FIT stuff in tree a bit like the boards in the
section "Legacy (non-UHI/non-FIT) Boards".

I'm guessing it might be something in between, with UHI + platform code,
but DT provided by QEMU (i.e. FIT support makes no sense)?

If it uses UHI I suppose it doesn't belong in the legacy section, but I
think a consistent prompt would be beneficial, e.g.

+config VIRT_BOARD_RANCHU
+	bool "Support Ranchu platform for Android emulator"
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
> +#define GOLDFISH_TIMER_LOW		0x00
> +#define GOLDFISH_TIMER_HIGH		0x04
> +
> +static __init uint64_t read_rtc_time(void __iomem *base)
> +{
> +	u64 time_low;
> +	u64 time_high;
> +
> +	time_low = readl(base + GOLDFISH_TIMER_LOW);
> +	time_high = readl(base + GOLDFISH_TIMER_HIGH);
> +
> +	return (time_high << 32) | time_low;

What if high changes while reading this?

E.g.
TIMER_LOW	 0x00000000 *0xffffffff*
TIMER_HIGH	*0x00000001* 0x00000000

You'd presumably get 0x00000001ffffffff.

Perhaps it should read HIGH before too, and retry if it has changed.

Cheers
James
