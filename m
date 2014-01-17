Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2014 17:34:59 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:35616 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817237AbaAQQe5ZRwdJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jan 2014 17:34:57 +0100
Date:   Fri, 17 Jan 2014 16:34:50 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <blogic@openwrt.org>
Subject: Re: [PATCH 0/3] MIPS: CMP: Add CPU hotplug support for CMP platforms.
Message-ID: <20140117163450.GM970@pburton-linux.le.imgtec.org>
References: <1389975535-62279-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1389975535-62279-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Originating-IP: [192.168.154.79]
X-SEF-Processed: 7_3_0_01192__2014_01_17_16_34_51
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Fri, Jan 17, 2014 at 10:18:52AM -0600, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@imgtec.com>
> 
> Add CPU hotplug support for cores with a CM.
> 
> Steven J. Hill (3):
>   MIPS: CMP: Add support for CPU hotplugging.
>   MIPS: CMP: Malta: Add support for CPU hotplugging.
>   MIPS: CMP: Malta: Enable CPU hotplug.
> 
>  arch/mips/Kconfig                |    1 +
>  arch/mips/include/asm/amon.h     |    1 +
>  arch/mips/include/asm/gcmpregs.h |    2 +
>  arch/mips/kernel/irq-gic.c       |    6 +-
>  arch/mips/kernel/smp-cmp.c       |  167 +++++++++++++++++++++++++++-----------
>  arch/mips/mti-malta/malta-amon.c |  107 ++++++++++++++++++++----
>  arch/mips/mti-malta/malta-int.c  |    2 +-
>  7 files changed, 216 insertions(+), 70 deletions(-)
> 
> -- 
> 1.7.10.4
> 
> 

No. As I've said internally a few times this is *not* what hotplug is
meant to be. This doesn't actually make use of the CM/CPC to power down
a core (and can't via the CMP framework/AMON interface). It is
ultimately pointless and in my opinion should be replaced by proper
hotplug (that actually powers down cores) built atop the CONFIG_MIPS_CPS
implementation (that already moves the BEV) which I submitted a few days
ago.

Paul
