Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 15:14:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41853 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006621AbbEUNOaKj1yj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 May 2015 15:14:30 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4LDEWlO008220;
        Thu, 21 May 2015 15:14:32 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4LDETEC008219;
        Thu, 21 May 2015 15:14:29 +0200
Date:   Thu, 21 May 2015 15:14:29 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH] mips: irq: Use DECLARE_BITMAP
Message-ID: <20150521131429.GA8177@linux-mips.org>
References: <1432125894.2870.284.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432125894.2870.284.camel@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47513
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

On Wed, May 20, 2015 at 05:44:54AM -0700, Joe Perches wrote:

> Use the generic mechanism to declare a bitmap instead of unsigned long.
> 
> This could fix an overwrite defect of whatever follows irq_map.
> 
> Not all "#define NR_IRQS <value>" are a multiple of BITS_PER_LONG so
> using DECLARE_BITMAP allocates the proper number of longs required
> for the possible bits.
> 
> For instance:
> 
> arch/mips/include/asm/mach-ath79/irq.h:#define NR_IRQS                  51
> arch/mips/include/asm/mach-db1x00/irq.h:#define NR_IRQS 152
> arch/mips/include/asm/mach-lantiq/falcon/irq.h:#define NR_IRQS 328

This only matters to user of the allocate_irqno() API and there is only
on such platform, the IP27 which fortunately uses a NR_IRQS value that
is a multiple of 64, so no impact.

Thanks anyway!

  Ralf
