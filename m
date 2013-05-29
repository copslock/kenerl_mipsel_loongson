Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 May 2013 11:31:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57481 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823086Ab3E2JbrclnPy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 May 2013 11:31:47 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r4T9VO79006973;
        Wed, 29 May 2013 11:31:24 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r4T9V4T5006932;
        Wed, 29 May 2013 11:31:04 +0200
Date:   Wed, 29 May 2013 11:31:03 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Vinod Koul <vinod.koul@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/6] Convert JZ4740 to dmaengine
Message-ID: <20130529093103.GA6426@linux-mips.org>
References: <1369341387-19147-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369341387-19147-1-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, May 23, 2013 at 10:36:21PM +0200, Lars-Peter Clausen wrote:

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

No problem - though my experience is that code for MIPS systems, including
drivers receives most testing if it lives in the MIPS git tree, less in
linux-next and barely any in in other subsystem-specific trees.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
