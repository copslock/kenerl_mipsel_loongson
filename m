Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 23:53:55 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:32988 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992923AbeBQWxs25fRS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 23:53:48 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sat, 17 Feb 2018 22:53:18 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Sat, 17 Feb 2018 14:48:50 -0800
Date:   Sat, 17 Feb 2018 14:50:22 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, Hassan Naveed <hassan.naveed@mips.com>,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v5 02/14] net: pch_gbe: Pull PHY GPIO handling out of
 Minnow code
Message-ID: <20180217225022.x45ozstehuuunpp3@pburton-laptop>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180217201037.3006-3-paul.burton@mips.com>
 <20180217222933.GB21315@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180217222933.GB21315@lunn.ch>
User-Agent: NeoMutt/20171215
X-BESS-ID: 1518907997-637140-2698-63404-6
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190138
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
X-archive-position: 62602
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

Hi Andrew,

On Sat, Feb 17, 2018 at 11:29:33PM +0100, Andrew Lunn wrote:
> On Sat, Feb 17, 2018 at 12:10:25PM -0800, Paul Burton wrote:
> > The MIPS Boston development board uses the Intel EG20T Platform
> > Controller Hub, including its gigabit ethernet controller, and requires
> > that its RTL8211E PHY be reset much like the Minnow platform. Pull the
> > PHY reset GPIO handling out of Minnow-specific code such that it can be
> > shared by later patches.
> 
> Hi Paul
> 
> I'm i right in saying the driver currently supports the Atheros AT8031
> PHY? The same phy which is supported in drivers/net/phy/at803x.c?

It looks like the driver does contain some code relating to that PHY,
but it's not the one I'm using with the MIPS Boston board - there we
have a Realtek RTL8211E (as mentioned in the commit message) which is
working fine alongside this pch_gbe driver too.

> If so, i think you are doing this all wrong.

Note that this is a driver which is already in mainline, and I didn't
write it. Claiming that *I* am doing this all wrong is a bit of a
stretch - all this patch does is make small changes to some existing
code, which only tangentially relates to a PHY driver, such that it
ceases to be specific to a single platform.

> You would be much better off throwing away pch_gbe_phy.c and write a
> proper MDIO driver. You then get the PHY driver for free, and the MDIO
> code could will handle your GPIO for you, in the standardised way.

Even if that is true, rewriting the driver's PHY handling would be a
very separate change to the changes this series make which allow this
driver to work on a platform besides the Minnowboard. The *only* thing
this series does relating to the PHY is allow the reset GPIO to be
handled properly - rewriting the existing PHY handling is beyond it's
scope.

Note that I do have various cleanups to the driver beyond this series
which I intend to submit after it is functional for my system[1], so I
am not saying that I don't care about improving the driver. But please,
let's do one thing at a time.

Thanks,
    Paul

[1] https://git.linux-mips.org/cgit/paul/linux.git/log/?h=up417-boston-eth-cleanup
