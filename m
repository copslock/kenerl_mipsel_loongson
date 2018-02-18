Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 23:07:53 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:46279 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeBRWHqa8g4n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2018 23:07:46 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sun, 18 Feb 2018 22:07:30 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Sun, 18 Feb 2018 14:07:29 -0800
Date:   Sun, 18 Feb 2018 14:09:01 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <hassan.naveed@mips.com>, <matt.redfearn@mips.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v5 00/14] net: pch_gbe: Fixes & MIPS support
Message-ID: <20180218220901.lyer5ovlbid6ew6p@pburton-laptop>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180218.103112.1461192916516173265.davem@davemloft.net>
 <20180218170310.lpwjtnxe6awrhgen@pburton-laptop>
 <20180218175607.GB31083@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180218175607.GB31083@lunn.ch>
User-Agent: NeoMutt/20171215
X-BESS-ID: 1518991650-452060-19051-159380-1
X-BESS-VER: 2018.2.1-r1802152107
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190168
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 INFO_TLD               URI: Contains an URL in 
        the INFO top-level domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=INFO_TLD, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62616
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

On Sun, Feb 18, 2018 at 06:56:07PM +0100, Andrew Lunn wrote:
> On Sun, Feb 18, 2018 at 09:03:10AM -0800, Paul Burton wrote:
> > Hi David,
> > 
> > On Sun, Feb 18, 2018 at 10:31:12AM -0500, David Miller wrote:
> > > Nobody is going to see and apply these patches if you don't CC: the
> > > Linux networking development list, netdev@vger.kernel.org
> > 
> > You're replying to mail that was "To: netdev@vger.kernel.org" and I see
> > the whole series in the archives[1] so it definitely reached the list.
> > 
> > I'm not sure I see the problem?
> 
> Hi Paul
> 
> I'm guess that David is wondering about version 1-4 of this patchset?
> As far as i can see, they were sent to the mips list, not the netdev
> list.

It has been quite a while since v4, but it and earlier revisions were
submitted to the netdev list too:

v4: https://www.spinics.net/lists/netdev/msg438550.html
v3: https://www.spinics.net/lists/netdev/msg438313.html
v2: https://marc.info/?l=linux-netdev&m=145450117711515&w=2

v1 was part of a larger series, but netdev was also copied on the
relevant patches starting here & the patches following it:

v1: https://marc.info/?l=linux-netdev&m=144890083511222&w=2

Thanks,
    Paul
