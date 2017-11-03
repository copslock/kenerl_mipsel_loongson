Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Nov 2017 15:10:05 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:40214 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990740AbdKCOJ6ZxvcV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Nov 2017 15:09:58 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 03 Nov 2017 14:07:58 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Fri, 3 Nov 2017 07:04:19 -0700
From:   Miodrag Dinic <Miodrag.Dinic@mips.com>
To:     Paul Burton <Paul.Burton@mips.com>
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
        "Raghu Gandham" <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Thread-Topic: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Thread-Index: AQHTUXZuvGrl+bRRXEyMdpcukfrmmqMASGwAgADJreqAAPiPgIAAqvTF
Date:   Fri, 3 Nov 2017 14:04:19 +0000
Message-ID: <48924BBB91ABDE4D9335632A6B179DD6A77728@MIPSMAIL01.mipstec.com>
References: <1509364642-21771-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1509364642-21771-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <20171101175820.nhepxzdwfokof6q2@pburton-laptop>
 <48924BBB91ABDE4D9335632A6B179DD6A74236@MIPSMAIL01.mipstec.com>,<20171102204947.tnahab2h4xep7m3y@pburton-laptop>
In-Reply-To: <20171102204947.tnahab2h4xep7m3y@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1509718078-452060-31104-709155-3
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.61
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186549
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.61 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Miodrag.Dinic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60701
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

> > We can not remove the forward declaration because we need to define
> > __mips_mach_ranchu (which is done by MIPS_MACHINE(ranchu)) before ranchu_of_match.
> 
> Why? Why do you need to set the struct of_device_id data field? The generic
> code only provides the match data to the machine fixup_fdt callback which you
> don't implement, so the value is never used.

Oooh, yes you are right. This was a leftover when we started porting Ranchu as a legacy platform.
We will fix it in V8. Thank you.

Kind regards,
Miodrag

________________________________________
From: Paul Burton [paul.burton@mips.com]
Sent: Thursday, November 2, 2017 9:49 PM
To: Miodrag Dinic
Cc: Aleksandar Markovic; linux-mips@linux-mips.org; Goran Ferenc; Aleksandar Markovic; David S. Miller; Douglas Leung; Greg Kroah-Hartman; James Hogan; linux-kernel@vger.kernel.org; Mauro Carvalho Chehab; Miodrag Dinic; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Randy Dunlap
Subject: Re: [PATCH v6 5/5] MIPS: ranchu: Add Ranchu as a new generic-based board

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
