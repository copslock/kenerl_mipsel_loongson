Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 13:55:29 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:39762 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993310AbdKBMzVdsKgN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 13:55:21 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 02 Nov 2017 12:53:45 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 2 Nov 2017
 05:53:05 -0700
Date:   Thu, 2 Nov 2017 12:53:59 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Miodrag Dinic <Miodrag.Dinic@mips.com>
CC:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Message-ID: <20171102125359.GN15235@jhogan-linux>
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1509364642-21771-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <20171030164523.GA15235@jhogan-linux>
 <48924BBB91ABDE4D9335632A6B179DD6A74206@MIPSMAIL01.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <48924BBB91ABDE4D9335632A6B179DD6A74206@MIPSMAIL01.mipstec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509627225-321458-20098-76388-1
X-BESS-VER: 2017.12-r1709122024
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
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60675
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

On Thu, Nov 02, 2017 at 12:47:27PM +0000, Miodrag Dinic wrote:
> > > +static __init uint64_t read_rtc_time(void __iomem *base)
> > > +{
> > > +     u64 time_low;
> > > +     u64 time_high;
> > > +
> > > +     time_low = readl(base + GOLDFISH_TIMER_LOW);
> > > +     time_high = readl(base + GOLDFISH_TIMER_HIGH);
> > > +
> > > +     return (time_high << 32) | time_low;
> > 
> > What if high changes while reading this?
> > 
> > E.g.
> > TIMER_LOW        0x00000000 *0xffffffff*
> > TIMER_HIGH      *0x00000001* 0x00000000
> > 
> > You'd presumably get 0x00000001ffffffff.
> > 
> > Perhaps it should read HIGH before too, and retry if it has changed.
> 
> This was already discussed in some earlier posts. (https://patchwork.linux-mips.org/patch/16628/)
> Reading the low value first actually latches the high value,
> so it is safe to leave it this way. Here is the relevant RTC device
> implementation in QEMU:
> 
> static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset, unsigned size)
> {
>     struct rtc_state *s = (struct rtc_state *)opaque;
>     switch(offset) {
>         case TIMER_TIME_LOW:
>             s->now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->time_base;
>             return s->now_ns;
>         case TIMER_TIME_HIGH:
>             return s->now_ns >> 32;

Ah okay. In that case the side effect of reading low clearly isn't
obvious enough reading the driver code and it needs a comment to clarify
the hardware behaviour :-)

Cheers
James
