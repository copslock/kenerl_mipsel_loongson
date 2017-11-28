Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 20:57:36 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:49198 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdK1T53lTDUS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 20:57:29 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 28 Nov 2017 19:57:22 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Tue, 28 Nov 2017 11:49:22 -0800
Date:   Tue, 28 Nov 2017 11:50:02 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     James Hogan <james.hogan@mips.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/13] MIPS: mscc: Add initial support for Microsemi MIPS
 SoCs
Message-ID: <20171128195002.dcq7i2wqmstkn3rr@pburton-laptop>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-10-alexandre.belloni@free-electrons.com>
 <20171128160137.GF27409@jhogan-linux.mipstec.com>
 <20171128165359.GJ21126@piout.net>
 <20171128173151.GD5027@jhogan-linux.mipstec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171128173151.GD5027@jhogan-linux.mipstec.com>
User-Agent: NeoMutt/20171013
X-BESS-ID: 1511898962-637140-23888-52588-8
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187390
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61166
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

Hi James, Alexandre,

On Tue, Nov 28, 2017 at 05:31:51PM +0000, James Hogan wrote:
> On Tue, Nov 28, 2017 at 05:53:59PM +0100, Alexandre Belloni wrote:
> > On 28/11/2017 at 16:01:38 +0000, James Hogan wrote:
> > > On Tue, Nov 28, 2017 at 04:26:39PM +0100, Alexandre Belloni wrote:
> > > > Introduce support for the MIPS based Microsemi Ocelot SoCs.
> > > > As the plan is to have all SoCs supported only using device tree, the
> > > > mach directory is simply called mscc.
> > > 
> > > Nice. Have you considered adding this to the existing multiplatform
> > > "generic" platform? See for example commit b35565bb16a5 ("MIPS: generic:
> > > Add support for MIPSfpga") for the latest platform to be converted.
> > > 
> > 
> > I didn't because we are currently booting using an old redboot with its
> > own boot protocol and at boot, the register read by the sead3 code is
> > completely random (it actually matched once).
> > 
> > Do you consider that mandatory to get the platform upstream?
> 
> No, however if it is practical to do so I think it might be the best way
> forward (even if generic+YAMON support is mutually exclusive of
> generic+redboot, though hopefully there is some way to avoid that).
> 
> Paul on Cc, he may have thoughts on this one.

We could certainly look at tightening the checks in the SEAD-3 code to
avoid the false positive.

Could you share any details of the boot protocol you're using with
redboot? One option might be for the SEAD-3 code to check that the
arguments the bootloader provided look "YAMON-like", so long as the 2
protocols differ sufficiently.

Thanks,
    Paul
