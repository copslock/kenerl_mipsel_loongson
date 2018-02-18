Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 18:01:54 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:33626 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeBRRBqtkdf0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2018 18:01:46 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Sun, 18 Feb 2018 17:01:38 +0000
Received: from localhost (10.20.79.96) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Sun, 18 Feb 2018 09:01:36 -0800
Date:   Sun, 18 Feb 2018 09:03:10 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <hassan.naveed@mips.com>,
        <matt.redfearn@mips.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v5 00/14] net: pch_gbe: Fixes & MIPS support
Message-ID: <20180218170310.lpwjtnxe6awrhgen@pburton-laptop>
References: <20180217201037.3006-1-paul.burton@mips.com>
 <20180218.103112.1461192916516173265.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180218.103112.1461192916516173265.davem@davemloft.net>
User-Agent: NeoMutt/20171215
X-BESS-ID: 1518973297-321458-32720-28671-1
X-BESS-VER: 2018.2-r1802152108
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190159
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
X-archive-position: 62614
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

On Sun, Feb 18, 2018 at 10:31:12AM -0500, David Miller wrote:
> Nobody is going to see and apply these patches if you don't CC: the
> Linux networking development list, netdev@vger.kernel.org

You're replying to mail that was "To: netdev@vger.kernel.org" and I see
the whole series in the archives[1] so it definitely reached the list.

I'm not sure I see the problem?

Thanks,
    Paul

[1] https://www.spinics.net/lists/netdev/msg484102.html
