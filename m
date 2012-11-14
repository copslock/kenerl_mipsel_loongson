Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2012 01:54:03 +0100 (CET)
Received: from wolverine02.qualcomm.com ([199.106.114.251]:37701 "EHLO
        wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823117Ab2KNAyCPd18l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Nov 2012 01:54:02 +0100
X-IronPort-AV: E=McAfee;i="5400,1158,6895"; a="6551360"
Received: from pdmz-ns-snip_115_219.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.219])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Nov 2012 16:53:45 -0800
Received: from codeaurora.org (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
        by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E434010004C8;
        Tue, 13 Nov 2012 16:53:43 -0800 (PST)
Date:   Tue, 13 Nov 2012 18:53:41 -0600
From:   Richard Kuo <rkuo@codeaurora.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mike Frysinger <vapier@gentoo.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/1] arch Kconfig: remove references to IRQ_PER_CPU
Message-ID: <20121114005341.GA6917@codeaurora.org>
References: <1352807948-26920-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1352807948-26920-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 34993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkuo@codeaurora.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Nov 13, 2012 at 11:59:08AM +0000, James Hogan wrote:
> The IRQ_PER_CPU Kconfig symbol was removed in the following commit:
> 
> Commit 6a58fb3bad099076f36f0f30f44507bc3275cdb6 ("genirq: Remove
> CONFIG_IRQ_PER_CPU") merged in v2.6.39-rc1.
> 
> But IRQ_PER_CPU wasn't removed from any of the architecture Kconfig
> files where it was defined or selected. It's completely unused so remove
> the remaining references.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> ---
> Based on v3.7-rc5.
> 
> Compile tested defconfigs for bfin, ia64, mips, parisc, powerpc, sh, but
> not hexagon.
> 
> Grepped entire tree to check no references to CONFIG_IRQ_PER_CPU, and
> grepped arch/ for Kconfig files referencing IRQ_PER_CPU.
> 
>  arch/blackfin/Kconfig |    1 -
>  arch/hexagon/Kconfig  |    1 -
>  arch/ia64/Kconfig     |    1 -
>  arch/mips/Kconfig     |    1 -
>  arch/parisc/Kconfig   |    1 -
>  arch/powerpc/Kconfig  |    1 -
>  arch/sh/Kconfig       |    3 ---
>  7 files changed, 0 insertions(+), 9 deletions(-)
> 

Hexagon's was commented out anyways, but thanks for pointing it out.

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
