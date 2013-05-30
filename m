Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 May 2013 19:59:42 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:10674 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823064Ab3E3R7hEnPVq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 30 May 2013 19:59:37 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 30 May 2013 10:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,772,1363158000"; 
   d="scan'208";a="345797016"
Received: from vkoul-udesk3.iind.intel.com ([10.223.84.41])
  by fmsmga002.fm.intel.com with ESMTP; 30 May 2013 10:59:16 -0700
Received: from vkoul-udesk3.iind.intel.com (localhost [127.0.0.1])
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r4UHLN4E012679;
        Thu, 30 May 2013 22:51:26 +0530
Received: (from vkoul@localhost)
        by vkoul-udesk3.iind.intel.com (8.14.3/8.14.3/Submit) id r4UHKoY9012655;
        Thu, 30 May 2013 22:50:50 +0530
X-Authentication-Warning: vkoul-udesk3.iind.intel.com: vkoul set sender to vinod.koul@intel.com using -f
Date:   Thu, 30 May 2013 22:50:50 +0530
From:   Vinod Koul <vinod.koul@intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 6/6] MIPS: jz4740: Remove custom DMA API
Message-ID: <20130530172050.GB3767@intel.com>
References: <1369931105-28065-1-git-send-email-lars@metafoo.de>
 <1369931105-28065-7-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369931105-28065-7-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <vinod.koul@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36649
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

On Thu, May 30, 2013 at 06:25:05PM +0200, Lars-Peter Clausen wrote:
> Now that all users of the custom jz4740 DMA API have been converted to use
> the dmaengine API instead we can remove the custom API and move all the code
> talking to the hardware to the dmaengine driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> ---
> No changes since v1
> ---
>  arch/mips/include/asm/mach-jz4740/dma.h |  56 ------
>  arch/mips/jz4740/Makefile               |   2 +-
>  arch/mips/jz4740/dma.c                  | 307 --------------------------------
>  drivers/dma/dma-jz4740.c                | 258 +++++++++++++++++++++++----
>  4 files changed, 222 insertions(+), 401 deletions(-)
>  delete mode 100644 arch/mips/jz4740/dma.c
only dma.c, you should remove the dma.h or relocate it to linux/


rest of the series looks fine, and once we have acks from repsective subsystem
mainatiners, we should be good to merge

--
~Vinod
