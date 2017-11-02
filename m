Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2017 21:51:15 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:58879 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdKBUvGQ7atK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Nov 2017 21:51:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 02 Nov 2017 20:49:23 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Thu, 2 Nov 2017 13:48:42 -0700
Date:   Thu, 2 Nov 2017 13:49:47 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Miodrag Dinic <Miodrag.Dinic@mips.com>
CC:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
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
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Message-ID: <20171102204947.tnahab2h4xep7m3y@pburton-laptop>
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1509364642-21771-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <20171101175820.nhepxzdwfokof6q2@pburton-laptop>
 <48924BBB91ABDE4D9335632A6B179DD6A74236@MIPSMAIL01.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <48924BBB91ABDE4D9335632A6B179DD6A74236@MIPSMAIL01.mipstec.com>
User-Agent: NeoMutt/20171013
X-BESS-ID: 1509655763-321459-32683-2746-1
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.61
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186523
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.61 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Miodrag,

On Thu, Nov 02, 2017 at 06:47:05AM -0700, Miodrag Dinic wrote:
> > > +static const struct of_device_id ranchu_of_match[];
> > > +
> > > +MIPS_MACHINE(ranchu) = {
> > > +     .matches = ranchu_of_match,
> > > +     .measure_hpt_freq = ranchu_measure_hpt_freq,
> > > +};
> > > +
> > > +static const struct of_device_id ranchu_of_match[] = {
> > > +     {
> > > +             .compatible = "mti,ranchu",
> > > +             .data = &__mips_mach_ranchu,
> > > +     },
> > > +};
> > 
> > Could you move ranchu_of_match before the MIPS_MACHINE & drop the forward
> > declaration? That would feel tidier to me. It could also be marked as
> > __initdata.
> 
> We can not remove the forward declaration because we need to define
> __mips_mach_ranchu (which is done by MIPS_MACHINE(ranchu)) before ranchu_of_match.

Why? Why do you need to set the struct of_device_id data field? The generic
code only provides the match data to the machine fixup_fdt callback which you
don't implement, so the value is never used.

Thanks,
    Paul
