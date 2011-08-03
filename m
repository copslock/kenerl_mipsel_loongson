Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2011 18:25:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33521 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S2100412Ab1HCQZm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Aug 2011 18:25:42 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p73GHm9u017140;
        Wed, 3 Aug 2011 17:17:48 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p73GHjV5017133;
        Wed, 3 Aug 2011 17:17:45 +0100
Date:   Wed, 3 Aug 2011 17:17:45 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, schwidefsky@de.ibm.com,
        liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@redhat.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 19/23] mips: Use HAVE_MEMBLOCK_NODE_MAP
Message-ID: <20110803161745.GA13266@linux-mips.org>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
 <1311694534-5161-20-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1311694534-5161-20-git-send-email-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2487

On Tue, Jul 26, 2011 at 05:35:30PM +0200, Tejun Heo wrote:

> mips used early_node_map[] just to prime free_area_init_nodes().  Now
> memblock can be used for the same purpose and early_node_map[] is
> scheduled to be dropped.  Use memblock instead.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Yinghai Lu <yinghai@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
> Only compile tested.  Thanks.
> 
>  arch/mips/Kconfig                |    3 +++
>  arch/mips/kernel/setup.c         |    3 ++-
>  arch/mips/sgi-ip27/ip27-memory.c |    5 +++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 653da62..368b2ec 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -24,6 +24,9 @@ config MIPS
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  	select HAVE_ARCH_JUMP_LABEL
> +	select HAVE_MEMBLOCK

This means <linux/memblock.h> will include <asm/memblock.h> which does
not exist for MIPS.  Did you accidentally not post this new file?

  Ralf
