Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2018 17:41:14 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:37098 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbeBSQlHAeYUn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Feb 2018 17:41:07 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 19 Feb 2018 16:40:49 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Mon, 19 Feb 2018 08:40:49 -0800
Date:   Mon, 19 Feb 2018 08:42:23 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Hassan Naveed <hassan.naveed@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH v5 07/14] net: pch_gbe: Fix handling of TX padding
Message-ID: <20180219164223.plclfvimcyiqzh4h@pburton-laptop>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180217201037.3006-8-paul.burton@mips.com>
 <33d3777368d244a79c6287b2e955853f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <33d3777368d244a79c6287b2e955853f@AcuMS.aculab.com>
User-Agent: NeoMutt/20171215
X-BESS-ID: 1519058449-321458-23600-5067-1
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190190
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62621
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

Hi David,

On Mon, Feb 19, 2018 at 02:01:25PM +0000, David Laight wrote:
> From: Paul Burton
> > Sent: 17 February 2018 20:11
> > 
> > The ethernet controller found in the Intel EG20T Platform Controller
> > Hub requires that we place 2 bytes of padding between the ethernet
> > header & the packet payload. Our pch_gbe driver handles this by copying
> > packets to be transmitted to a temporary struct skb with the padding
> > bytes inserted
> ...
> 
> Uggg WFT is the driver doing that for?
> 
> I'd guess that the two byte pad is there so that a 4 byte aligned
> frame is still 4 byte aligned when the 14 byte ethernet header is added.
> So instead of copying the entire frame the MAC header should be built
> (or rebuilt?) two bytes further from the actual data.

I agree - the pch_gbe driver is pretty bad and does a lot of things
wrong. Frankly I'm amazed it's in tree, but it is & one patch series
isn't going to fix all of its shortcomings.

So whilst I totally agree that copying around the whole frame is awful,
it's a separate problem to the length used for DMA mapping being
incorrect which is what this patch addresses & I'd rather not start
adding more & more fixes or cleanups into this initial series before the
driver is even functional on my hardware.

Thanks,
    Paul
