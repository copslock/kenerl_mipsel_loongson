Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 10:24:02 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49890 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009902AbbCYJYBET3n9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Mar 2015 10:24:01 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2P9NxEH032093;
        Wed, 25 Mar 2015 10:23:59 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2P9NwZx032092;
        Wed, 25 Mar 2015 10:23:58 +0100
Date:   Wed, 25 Mar 2015 10:23:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 15/25] MIPS: BMIPS: Flush the readahead cache after DMA
Message-ID: <20150325092358.GA31933@linux-mips.org>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
 <1419529760-9520-16-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1419529760-9520-16-git-send-email-cernekee@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46517
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

On Thu, Dec 25, 2014 at 09:49:10AM -0800, Kevin Cernekee wrote:

> BMIPS 3300/435x/438x CPUs have a readahead cache that is separate from
> the L1/L2.  During a DMA operation, accesses adjacent to a DMA buffer
> may cause parts of the DMA buffer to be prefetched into the RAC.  To
> avoid possible coherency problems, flush the RAC upon DMA completion.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
>  arch/mips/mm/dma-default.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index af5f046..38ee47a 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -18,6 +18,7 @@
>  #include <linux/highmem.h>
>  #include <linux/dma-contiguous.h>
>  
> +#include <asm/bmips.h>
>  #include <asm/cache.h>
>  #include <asm/cpu-type.h>
>  #include <asm/io.h>

Aside of platform-specific headers having no business of getting
included directly in a generic arch file, this also breaks the build
of many platforms:

  CC      arch/mips/mm/dma-default.o
In file included from arch/mips/mm/dma-default.c:21:0:
./arch/mips/include/asm/bmips.h: In function ‘bmips_read_zscm_reg’:
./arch/mips/include/asm/bmips.h:97:160: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  cache_op(Index_Load_Tag_S, ZSCM_REG_BASE + offset);
                                                                                                                                                                ^
./arch/mips/include/asm/bmips.h: In function ‘bmips_write_zscm_reg’:
./arch/mips/include/asm/bmips.h:118:160: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  cache_op(Index_Store_Tag_S, ZSCM_REG_BASE + offset);

I think the broken platforms are all the 64 bit platforms.

  Ralf
