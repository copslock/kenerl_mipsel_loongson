Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 16:50:23 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:60729 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeBRPuO3RjAl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2018 16:50:14 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sun, 18 Feb 2018 15:50:06 +0000
Received: from localhost (10.20.78.38) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Sun, 18 Feb 2018 07:49:39 -0800
Date:   Sun, 18 Feb 2018 07:51:12 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, Hassan Naveed <hassan.naveed@mips.com>,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v5 02/14] net: pch_gbe: Pull PHY GPIO handling out of
 Minnow code
Message-ID: <20180218155045.dbmplf3itouvantp@pburton-laptop>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180217201037.3006-3-paul.burton@mips.com>
 <20180217222933.GB21315@lunn.ch>
 <20180217225022.x45ozstehuuunpp3@pburton-laptop>
 <20180217233442.GA24375@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180217233442.GA24375@lunn.ch>
User-Agent: NeoMutt/20171215
X-BESS-ID: 1518969003-637137-16990-97465-11
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190158
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
X-archive-position: 62611
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

On Sun, Feb 18, 2018 at 12:34:42AM +0100, Andrew Lunn wrote:
> > Even if that is true, rewriting the driver's PHY handling would be a
> > very separate change to the changes this series make which allow this
> > driver to work on a platform besides the Minnowboard. The *only* thing
> > this series does relating to the PHY is allow the reset GPIO to be
> > handled properly - rewriting the existing PHY handling is beyond it's
> > scope.
> 
> Well, you are adding a device tree binding, which needs to be
> supported forever. This is going to make things messy in the future
> when you do such a cleanup that you follow the PHY binding, in that
> you have to handle both what you add here, and the official PHY
> binding.

Thank you - it's useful to know what your concern actually is.

> I would prefer that for the moment, you drop the PHY binding patches
> in this series. That is what i object to the most. Adding an MDIO
> driver and using the standard PHY driver for this PHY is all
> internal. You can change that anytime. But adding a binding means an
> ABI.

The problem is that the device in question doesn't actually work unless
we reset the PHY, so just removing the PHY reset GPIO handling would
break things.

How would you feel if I were to adjust the binding to match the standard
PHY binding, but internally leave the driver's PHY handling as-is for
now? That would:

  1) Allow for the pch_gbe driver to move towards more standard PHY
     handling in the future without DT changes.

  2) Be fairly straightforward to implement in this patchset - the code
     reading the DT would just follow the phandle to the PHY node to
     find the reset GPIO - thereby not holding up the rest of the series.

  3) Still function on our hardware.

Thanks,
    Paul
