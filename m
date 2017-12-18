Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Dec 2017 16:39:31 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:57057 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993195AbdLRPjXsKXZE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Dec 2017 16:39:23 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 18 Dec 2017 15:38:23 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Mon, 18 Dec 2017 07:38:17 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     Rob Herring <robh@kernel.org>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <Paul.Burton@mips.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Leung <Douglas.Leung@mips.com>,
        "Goran Ferenc" <Goran.Ferenc@mips.com>,
        James Hogan <James.Hogan@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        "Petar Jovanovic" <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>
Subject: RE: [PATCH 1/2] dt-bindings: Document mti,mips-cpc binding
Thread-Topic: [PATCH 1/2] dt-bindings: Document mti,mips-cpc binding
Thread-Index: AQHTdcUog40x7M5wm0mKRD6zzY7yt6NG0WQAgAJtuhs=
Date:   Mon, 18 Dec 2017 15:38:16 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEEC27E53@MIPSMAIL01.mipstec.com>
References: <1513356723-7393-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1513356723-7393-2-git-send-email-aleksandar.markovic@rt-rk.com>,<20171216182638.3vd2rbkyos74e4jo@rob-hp-laptop>
In-Reply-To: <20171216182638.3vd2rbkyos74e4jo@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1513611502-321457-15330-188348-4
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188103
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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

> From: Rob Herring [robh@kernel.org]
> Sent: Saturday, December 16, 2017 7:26 PM
> To: Aleksandar Markovic
> Subject: Re: [PATCH 1/2] dt-bindings: Document mti,mips-cpc binding
>
> On Fri, Dec 15, 2017 at 05:51:59PM +0100, Aleksandar Markovic wrote:
> > From: Paul Burton <paul.burton@mips.com>
> >
> > Document a binding for the MIPS Cluster Power Controller (CPC) which
> > simply allows the device tree to specify where the CPC registers should
> > be mapped.
> >
> > Signed-off-by: Paul Burton <paul.burton@mips.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> > ---
> >  Documentation/devicetree/bindings/misc/mti,mips-cpc.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
> >
...
> > +++ b/Documentation/devicetree/bindings/misc/mti,mips-cpc.txt
> > @@ -0,0 +1,8 @@
> > +Binding for MIPS Cluster Power Controller (CPC).
> > +
> > +This binding allows a system to specify where the CPC registers should be
> > +mapped using device tree.
> 
> Not really where you map registers, but where they are located.
> 

This will be corrected in the next version.

> > +
> > +Required properties:
> > +compatible : Should be "mti,mips-cpc".
> 
> Only one version of the block?
> 

I am not clear what you mean by "version of the block". I you meant
number of allowed values for *compatible* property, yes, we want and
need just one such value (string).

> > +regs: Should describe the address & size of the CPC register region.
> > --
From alexandre.belloni@free-electrons.com Mon Dec 18 17:09:21 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Dec 2017 17:09:28 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:49976 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994630AbdLRQJUSAIPE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Dec 2017 17:09:20 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id B90C8203B5; Mon, 18 Dec 2017 17:09:09 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8A2B72037A;
        Mon, 18 Dec 2017 17:08:59 +0100 (CET)
Date:   Mon, 18 Dec 2017 17:09:00 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Philippe Ombredanne <pombredanne@nexb.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 05/13] pinctrl: Add Microsemi Ocelot SoC driver
Message-ID: <20171218160900.GR7022@piout.net>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-6-alexandre.belloni@free-electrons.com>
 <CACRpkdZ=+pFZYteq=wM=z-CGejY+dX_SqhtDbbGBn+q60arQ4w@mail.gmail.com>
 <CAOFm3uF_OjqK0cQ1A4Xkp8kZab+afqPsnF5rB9=a7Dym9jiU4w@mail.gmail.com>
 <CACRpkdZaaZArEhw3iWaQagrKa__+DcrzSY4i7PWNYwhUiNtm4A@mail.gmail.com>
 <CAOFm3uFsM5Bbb2V-HYKf1kJgHokjUkuRLTht+7gO=-sxJ50faA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uFsM5Bbb2V-HYKf1kJgHokjUkuRLTht+7gO=-sxJ50faA@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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
Content-Length: 1260
Lines: 41

On 15/12/2017 at 08:59:15 +0100, Philippe Ombredanne wrote:
> Alexandre, Linux
> 
> On Fri, Dec 15, 2017 at 12:53 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> > On Wed, Dec 13, 2017 at 10:23 AM, Philippe Ombredanne
> > <pombredanne@nexb.com> wrote:
> >> On Wed, Dec 13, 2017 at 9:15 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> >>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >>>
> >>> Wow never saw that before. OK I guess.
> >>
> >> That's the new thing. Less legalese boilerplate, and more code for the
> >> better IMHO.
> >>
> >> You can check the doc patches from Thomas for details [1]
> >>
> >> [1] https://lkml.org/lkml/2017/12/4/934
> >
> > Yeah I'm aware of this part, but I didn't see that combined license
> > before.
> >
> > What is the reason for not just using GPL 2 here?
> 
> Linus,
> That'a a question for Alexandre that submitted this patch in the first
> place, not me.
> 
> Alexandre?
> 

I'm not the one taking that decision and I don't think this choice has a
particular issue (we use the same one for device trees).

I guess the idea behind it is to be able to reuse the same code in other
non-GPL projects.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
