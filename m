Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 14:49:23 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:49446 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993373AbdKBNtQskF0w convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 Nov 2017 14:49:16 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 02 Nov 2017 13:47:48 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Thu, 2 Nov 2017 06:47:06 -0700
From:   Miodrag Dinic <Miodrag.Dinic@mips.com>
To:     Paul Burton <Paul.Burton@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <James.Hogan@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        "Raghu Gandham" <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Thread-Topic: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Thread-Index: AQHTUXZuvGrl+bRRXEyMdpcukfrmmqMASGwAgADJreo=
Date:   Thu, 2 Nov 2017 13:47:05 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD6A74236@MIPSMAIL01.mipstec.com>
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1509364642-21771-6-git-send-email-aleksandar.markovic@rt-rk.com>,<20171101175820.nhepxzdwfokof6q2@pburton-laptop>
In-Reply-To: <20171101175820.nhepxzdwfokof6q2@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1509630467-321459-8332-77292-1
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.61
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186514
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
X-archive-position: 60677
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

Hi Paul,

thank you for the review. Please find the answers in-lined:

> > +#include <linux/of_address.h>
> > +
> > +#include <asm/machine.h>
> 
> You should also include asm/mipsregs.h for read_c0_count(), even though it's
> presumably being pulled in indirectly as-is.

Thanks, we will address this in V7.

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
> > +}
> > +
> > +static __init unsigned int ranchu_measure_hpt_freq(void)
> > +{
> > +     u64 rtc_start, rtc_current, rtc_delta;
> > +     unsigned int start, count;
> > +     struct device_node *np;
> > +     void __iomem *rtc_base;
> > +
> > +     np = of_find_compatible_node(NULL, NULL, "google,goldfish-rtc");
> > +     if (!np)
> > +             panic("%s(): Failed to find 'google,goldfish-rtc' dt node!",
> > +                   __func__);
> > +
> > +     rtc_base = of_iomap(np, 0);
> > +     if (!rtc_base)
> > +             panic("%s(): Failed to ioremap Goldfish RTC base!", __func__);
> > +
> > +     /*
> > +      * poll the nanosecond resolution RTC for 1 second
> > +      * to calibrate the CPU frequency
> > +      */
> > +     rtc_start = read_rtc_time(rtc_base);
> > +     start = read_c0_count();
> > +
> > +     do {
> > +             rtc_current = read_rtc_time(rtc_base);
> > +             rtc_delta = rtc_current - rtc_start;
> > +     } while (rtc_delta < NSEC_PER_SEC);
> > +
> > +     count = read_c0_count() - start;
> > +
> > +     count += 5000;  /* round */
> > +     count -= count % 10000;
> > +
> > +     return count;
> > +}
> 
> Would it be possible to have the emulator write the frequency into the
> devicetree, as the frequency of a fixed-clock used as the CPU's clock? If that
> were possible then there'd be no need for this board setup code at all. Not a
> big deal, but it'd be nice.

Well, yes I think that would be possible, but since this will be run on the emulator,
fixed-clock may not be the best because the point of this code is to make emulator
calibrate itself according to speed of the host which runs the emulation.
We may consider more advanced approach on this issue in the future, but for now
this works fine for us.

> > +
> > +static const struct of_device_id ranchu_of_match[];
> > +
> > +MIPS_MACHINE(ranchu) = {
> > +     .matches = ranchu_of_match,
> > +     .measure_hpt_freq = ranchu_measure_hpt_freq,
> > +};
> > +
> > +static const struct of_device_id ranchu_of_match[] = {
> > +     {
> > +             .compatible = "mti,ranchu",
> > +             .data = &__mips_mach_ranchu,
> > +     },
> > +};
> 
> Could you move ranchu_of_match before the MIPS_MACHINE & drop the forward
> declaration? That would feel tidier to me. It could also be marked as
> __initdata.

We can not remove the forward declaration because we need to define
__mips_mach_ranchu (which is done by MIPS_MACHINE(ranchu)) before ranchu_of_match.

Kind regards,
Miodrag

________________________________________
From: Paul Burton [paul.burton@mips.com]
Sent: Wednesday, November 1, 2017 6:58 PM
To: Aleksandar Markovic
Cc: linux-mips@linux-mips.org; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; David S. Miller; Douglas Leung; Greg Kroah-Hartman; James Hogan; linux-kernel@vger.kernel.org; Mauro Carvalho Chehab; Miodrag Dinic; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Randy Dunlap
Subject: Re: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based board

Hi Aleksandar,

On Mon, Oct 30, 2017 at 12:56:36PM +0100, Aleksandar Markovic wrote:
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

You should also include asm/mipsregs.h for read_c0_count(), even though it's
presumably being pulled in indirectly as-is.

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
> +}
> +
> +static __init unsigned int ranchu_measure_hpt_freq(void)
> +{
> +     u64 rtc_start, rtc_current, rtc_delta;
> +     unsigned int start, count;
> +     struct device_node *np;
> +     void __iomem *rtc_base;
> +
> +     np = of_find_compatible_node(NULL, NULL, "google,goldfish-rtc");
> +     if (!np)
> +             panic("%s(): Failed to find 'google,goldfish-rtc' dt node!",
> +                   __func__);
> +
> +     rtc_base = of_iomap(np, 0);
> +     if (!rtc_base)
> +             panic("%s(): Failed to ioremap Goldfish RTC base!", __func__);
> +
> +     /*
> +      * poll the nanosecond resolution RTC for 1 second
> +      * to calibrate the CPU frequency
> +      */
> +     rtc_start = read_rtc_time(rtc_base);
> +     start = read_c0_count();
> +
> +     do {
> +             rtc_current = read_rtc_time(rtc_base);
> +             rtc_delta = rtc_current - rtc_start;
> +     } while (rtc_delta < NSEC_PER_SEC);
> +
> +     count = read_c0_count() - start;
> +
> +     count += 5000;  /* round */
> +     count -= count % 10000;
> +
> +     return count;
> +}

Would it be possible to have the emulator write the frequency into the
devicetree, as the frequency of a fixed-clock used as the CPU's clock? If that
were possible then there'd be no need for this board setup code at all. Not a
big deal, but it'd be nice.

> +
> +static const struct of_device_id ranchu_of_match[];
> +
> +MIPS_MACHINE(ranchu) = {
> +     .matches = ranchu_of_match,
> +     .measure_hpt_freq = ranchu_measure_hpt_freq,
> +};
> +
> +static const struct of_device_id ranchu_of_match[] = {
> +     {
> +             .compatible = "mti,ranchu",
> +             .data = &__mips_mach_ranchu,
> +     },
> +};

Could you move ranchu_of_match before the MIPS_MACHINE & drop the forward
declaration? That would feel tidier to me. It could also be marked as
__initdata.

In general though, with those & James' comments addressed, I think this is
looking good.

Thanks,
    Paul
