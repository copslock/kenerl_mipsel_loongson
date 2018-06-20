Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 19:14:35 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:50884 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994674AbeFTROYqFRCS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2018 19:14:24 +0200
Received: from mipsdag03.mipstec.com (mail3.mips.com [12.201.5.33]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 20 Jun 2018 17:14:19 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag03.mipstec.com
 (10.20.40.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 20
 Jun 2018 10:14:18 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Wed, 20 Jun
 2018 10:14:18 -0700
Date:   Wed, 20 Jun 2018 10:14:18 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Rob Herring <robh@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/5] MIPS: Clean-up DT bus probing
Message-ID: <20180620171418.43yveoh3md4kqzvw@pburton-laptop>
References: <20180619214710.22066-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180619214710.22066-1-robh@kernel.org>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529514859-637139-29444-50583-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194226
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: robh@kernel.org,ralf@linux-mips.org,jhogan@kernel.org,linux-kernel@vger.kernel.org,linux-mips@linux-mips.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64398
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

Hi Rob,

On Tue, Jun 19, 2018 at 03:47:05PM -0600, Rob Herring wrote:
> This is a series of clean-ups of DT bus probing calls. Generally, the 
> DT core code takes care of the default case and arches/platforms only 
> need to do their own call if they have non-default matching 
> requirements.
> 
> Rob
> 
> Rob Herring (5):
>   MIPS: octeon: use of_platform_populate to probe devices
>   MIPS: netlogic: remove unnecessary of_platform_bus_probe call
>   MIPS: bmips: remove unnecessary call to register "simple-bus"
>   MIPS: generic: remove unnecessary of_platform_populate call
>   MIPS: lantiq: remove unnecessary of_platform_default_populate call
> 
>  arch/mips/bmips/setup.c                   |  7 -------
>  arch/mips/cavium-octeon/octeon-platform.c |  2 +-
>  arch/mips/generic/init.c                  | 13 -------------
>  arch/mips/lantiq/prom.c                   |  8 --------
>  arch/mips/netlogic/xlp/dt.c               | 14 --------------
>  5 files changed, 1 insertion(+), 43 deletions(-)

Thanks - series applied to mips-next for 4.19.

Paul
