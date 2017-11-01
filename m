Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 17:43:21 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:47532 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992974AbdKAQnI1pMcn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2017 17:43:08 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 01 Nov 2017 16:42:55 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Wed, 1 Nov 2017 09:39:48 -0700
Date:   Wed, 1 Nov 2017 09:40:47 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] irqchip: mips-gic: Cleanups, fixes, prep for
 multi-cluster
Message-ID: <20171101164047.4ascutd7tkoaxtjp@pburton-laptop>
References: <867evc5cc9.fsf@arm.com>
 <20171031164151.6357-1-paul.burton@mips.com>
 <86efpi3lgj.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86efpi3lgj.fsf@arm.com>
User-Agent: NeoMutt/20171013
X-BESS-ID: 1509554575-637139-14738-419848-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186483
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
X-archive-position: 60632
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

Hi Marc,

On Wed, Nov 01, 2017 at 12:13:16AM +0000, Marc Zyngier wrote:
> On Tue, Oct 31 2017 at  9:41:43 am GMT, Paul Burton <paul.burton@mips.com> wrote:
> > This series continues cleaning & fixing up the MIPS GIC irqchip driver
> > whilst laying groundwork to support multi-cluster systems.

<SNIP>

> Are those targeting 4.14 or 4.15? It is getting quite late for the
> former, and it doesn't seem to cleanly apply on tip/irq/core (or my
> irqchip-4.15 branch) if that's for the latter (patch 6 shouts at me).

Whichever you're happiest with. If you'd like me to rebase them & resubmit
that's fine.

I see the conflict with patch 6 atop tip/irq/core - it's because tip/irq/core
is based upon v4.14-rc2 which doesn't have commit a08588ea486a
("irqchip/mips-gic: Fix shifts to extract register fields") that went into
v4.14-rc3. The correct resolution is to keep the patches version of things (ie.
delete the block of code).

Thanks,
    Paul
