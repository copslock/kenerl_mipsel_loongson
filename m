Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jun 2013 16:53:21 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:39548 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823009Ab3FUOxR1qksU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Jun 2013 16:53:17 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 21 Jun 2013 07:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,913,1363158000"; 
   d="scan'208";a="333394996"
Received: from vkoul-udesk3.iind.intel.com ([10.223.84.41])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2013 07:53:07 -0700
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r5LEDcmB002881;
        Fri, 21 Jun 2013 19:43:38 +0530
Received: (from vkoul@localhost)
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r5LEDUYM002879;
        Fri, 21 Jun 2013 19:43:30 +0530
X-Authentication-Warning: vkoul-udesk3.iind.intel.com: vkoul set sender to vinod.koul@intel.com using -f
Date:   Fri, 21 Jun 2013 19:43:30 +0530
From:   Vinod Koul <vinod.koul@intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/6] Convert JZ4740 to dmaengine
Message-ID: <20130621141330.GK23141@intel.com>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369931105-28065-1-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <vinod.koul@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vinod.koul@intel.com
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

On Thu, May 30, 2013 at 06:24:59PM +0200, Lars-Peter Clausen wrote:
> Hi,
> 
> This series replaces the custom JZ4740 DMA API with a dmaengine driver. This is
> done in 3 steps:
> 	1) Add a dmaengine driver which wraps the custom JZ4740 DMA API
> 	2) Update all users of the JZ4740 DMA API to use dmaengine instead
> 	3) Remove the custom API and move all direct hardware access to the
> 	   dmaengine driver.
> 
> The first two patches in the series also make sure that the clock of the DMA
> core is enabled.
> 
> Since the patches in this series depend on each other I'd prefer if they could
> all go through the DMA tree.
> 
> There are a few minor changes to the patch 3 in v2 of this series, all other
> patches are identical to v1.

Applied all expect the "ASoC: jz4740: Use the generic dmaengine PCM driver". Can
you rebase that on slave dma-next and resend

Fixed up struct alignment manually in 4th one

--
~Vinod
> 
> - Lars
> 
> Lars-Peter Clausen (4):
>   dma: Add a jz4740 dmaengine driver
>   MIPS: jz4740: Register jz4740 DMA device
>   ASoC: jz4740: Use the generic dmaengine PCM driver
>   MIPS: jz4740: Remove custom DMA API
> 
> Maarten ter Huurne (2):
>   MIPS: jz4740: Correct clock gate bit for DMA controller
>   MIPS: jz4740: Acquire and enable DMA controller clock
> 
>  arch/mips/include/asm/mach-jz4740/dma.h      |  56 ---
>  arch/mips/include/asm/mach-jz4740/platform.h |   1 +
>  arch/mips/jz4740/Makefile                    |   2 +-
>  arch/mips/jz4740/board-qi_lb60.c             |   1 +
>  arch/mips/jz4740/clock.c                     |   2 +-
>  arch/mips/jz4740/dma.c                       | 287 -------------
>  arch/mips/jz4740/platform.c                  |  21 +
>  drivers/dma/Kconfig                          |   6 +
>  drivers/dma/Makefile                         |   1 +
>  drivers/dma/dma-jz4740.c                     | 617 +++++++++++++++++++++++++++
>  sound/soc/jz4740/Kconfig                     |   1 +
>  sound/soc/jz4740/jz4740-i2s.c                |  48 +--
>  sound/soc/jz4740/jz4740-pcm.c                | 310 +-------------
>  sound/soc/jz4740/jz4740-pcm.h                |  20 -
>  14 files changed, 676 insertions(+), 697 deletions(-)
>  delete mode 100644 arch/mips/jz4740/dma.c
>  create mode 100644 drivers/dma/dma-jz4740.c
>  delete mode 100644 sound/soc/jz4740/jz4740-pcm.h
> 
> -- 
> 1.8.2.1
> 

-- 
