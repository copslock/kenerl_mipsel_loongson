Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2013 20:51:45 +0100 (CET)
Received: from mailout4.samsung.com ([203.254.224.34]:59368 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817537Ab3J2TvmWSw9x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Oct 2013 20:51:42 +0100
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MVG00CPC4HV5X00@mailout4.samsung.com> for
 linux-mips@linux-mips.org; Wed, 30 Oct 2013 04:51:31 +0900 (KST)
X-AuditID: cbfee61b-b7fd56d000001fc6-ad-527011c3d33e
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm2.samsung.com (EPCPMTA) with SMTP id 1B.34.08134.3C110725; Wed,
 30 Oct 2013 04:51:31 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MVG00CM84HJ3H10@mmp1.samsung.com>; Wed,
 30 Oct 2013 04:51:30 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, mturquette@linaro.org
Cc:     linux@arm.linux.org.uk, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v7 0/5] clk: clock deregistration support
Date:   Tue, 29 Oct 2013 20:51:03 +0100
Message-id: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsVy+t9jAd3DggVBBvf2sFv0/Km0ONv0ht2i
        c+ISdotNj6+xWlzeNYfNYsLUSewWc/5MYba4fZnX4umEi2wWh9+0s1osbPjC7sDt0dLcw+ax
        crq3x+yOmawed67tYfM4unItk8fmJfUeu782MXr0bVnF6PF5k1wAZxSXTUpqTmZZapG+XQJX
        xuT/S5gKbvBX/J46hb2B8T93FyMnh4SAicTXyZ/YIWwxiQv31rN1MXJxCAksYpTYMf0JM0hC
        SKCDSWLOzHQQm03AUKL3aB8jiC0iYC/xY8JLFpAGZoF5QDUfDrCBJIQFLCWWtj1g6mLk4GAR
        UJXoeuUFEuYVcJVYPmUiWFhCQEFiziSbCYzcCxgZVjGKphYkFxQnpeca6RUn5haX5qXrJefn
        bmIEh9oz6R2MqxosDjEKcDAq8fAaPMgPEmJNLCuuzD3EKMHBrCTCO/04UIg3JbGyKrUoP76o
        NCe1+BCjNAeLkjjvwVbrQCGB9MSS1OzU1ILUIpgsEwenVANjsmCr9tZYWYcjFe+9xKPOzjG8
        KSVc/Fs8IaijR1WCX1jo3HuDZc5e36TTsm6rqidH64eUzOy7nHUq0eISt5Cs/DeBNZPPOgkI
        Lp5g2/KtyWz/RPZVpVPbjyXNtr6wb29E9o2ZJmIP1Ds7QjNObztfJH/6uu+O5KVHDnklm0gz
        6s86sPW7D4MSS3FGoqEWc1FxIgCsB1PXMQIAAA==
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: s.nawrocki@samsung.com
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

This patch series implements clock deregistration in the common clock
framework. Detailed changes are listed at each patch. I have included
an additional patch in this series for the omap3isp driver, required 
to avoid regressions.

Changes since v5:
 - fixed NULL clock handling in __clk_get(), __clk_put (patch 5/5).

Changes since v4:
 - removed stray struct module forward declaration in patch 3/5.

Changes since v3:
 - replaced WARN_ON() with WARN_ON_ONCE() in clk_nodrv_disable_unprepare()
   callback.

Changes since v2:
 - reordered the patches so the race condition is fixed before it can
   actually cause any issues,
 - fixed handling of NULL clock pointers in __clk_get(), __clk_put(),
 - added patch adding actual asignment of clk->owner; more details are
   discussed in that specific patch.

Changes since v1:
 - moved of_clk_{lock, unlock}, __of_clk_get_from_provider() function
   declaractions to a local header,
 - renamed clk_dummy_* to clk_nodrv_*.

Sylwester Nawrocki (5):
  omap3isp: Modify clocks registration to avoid circular references
  clk: Provide not locked variant of of_clk_get_from_provider()
  clkdev: Fix race condition in clock lookup from device tree
  clk: Add common __clk_get(), __clk_put() implementations
  clk: Implement clk_unregister()

 arch/arm/include/asm/clkdev.h         |    2 +
 arch/blackfin/include/asm/clkdev.h    |    2 +
 arch/mips/include/asm/clkdev.h        |    2 +
 arch/sh/include/asm/clkdev.h          |    2 +
 drivers/clk/clk.c                     |  185 +++++++++++++++++++++++++++++++--
 drivers/clk/clk.h                     |   16 +++
 drivers/clk/clkdev.c                  |   12 ++-
 drivers/media/platform/omap3isp/isp.c |   22 ++--
 drivers/media/platform/omap3isp/isp.h |    1 +
 include/linux/clk-private.h           |    5 +
 include/linux/clkdev.h                |    5 +
 11 files changed, 235 insertions(+), 19 deletions(-)
 create mode 100644 drivers/clk/clk.h

-- 
1.7.9.5
