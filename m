Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Aug 2013 19:34:52 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:15553 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6828773Ab3HTRetXmJgg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Aug 2013 19:34:49 +0200
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRU00DQRBHQD2S0@mailout3.samsung.com>; Wed,
 21 Aug 2013 02:34:40 +0900 (KST)
X-AuditID: cbfee61b-b7efe6d000007b11-86-5213a8af00cd
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm2.samsung.com (EPCPMTA)
 with SMTP id A5.78.31505.FA8A3125; Wed, 21 Aug 2013 02:34:39 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MRU005WMBHD9970@mmp2.samsung.com>; Wed,
 21 Aug 2013 02:34:39 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, robherring2@gmail.com,
        grant.likely@linaro.org, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        shawn.guo@linaro.org, sebastian.hesselbarth@gmail.com,
        LW@KARO-electronics.de, t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 0/4] clk: clock deregistration support
Date:   Tue, 20 Aug 2013 19:34:19 +0200
Message-id: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsVy+t9jQd31K4SDDC5usLKY+vAJm8X7jfOY
        LA782cFo0fOn0uJs0xt2i86JS9gtNj2+xmpxedccNosJUyexW8z5M4XZ4vZlXosDT5azWTyd
        cJHN4tIeFYvv376xWRx+085q8f6no8XTdUuYLdbPeM1isbDhC7vFzQk/mB1EPVqae9g8Vk73
        9rj8/Q2zx85Zd9k9PnyM85jdMZPVY/70R8wem1Z1snncubaHzePoyrVMHpuX1Hvs/trE6NG3
        ZRWjx+dNcgF8UVw2Kak5mWWpRfp2CVwZ3VcusxW0cVU8ueTVwHibvYuRk0NCwETi7v/1TBC2
        mMSFe+vZuhi5OIQEpjNKTD8yjRHC6WCSaJj6lBGkik3AUKL3aB+YLSKgITGl6zE7SBGzwGIW
        iW2bFzGDJIQFLCX+HL0NVsQioCrx/f8bNhCbV8BN4sfyr0A2B9A6BYk5k2wmMHIvYGRYxSia
        WpBcUJyUnmukV5yYW1yal66XnJ+7iREc/M+kdzCuarA4xCjAwajEw7uhUDhIiDWxrLgy9xCj
        BAezkgjvtgygEG9KYmVValF+fFFpTmrxIUZpDhYlcd6DrdaBQgLpiSWp2ampBalFMFkmDk6p
        BkbzKT1b1s4x+X95uYzM/LpZjTHhmzftvF6ReLArKDvEpWdKwY7fn3ic1lzveXrAwUnV2+Gj
        WNQ1x+h2qx7jBVesNh8LFL1p/9z68LpZZl4HtRNM8w0TZ+nO8XFIWx4488hH6+srUitnapT8
        NDy1M5Gx/Oi7jtrJys4lSYLqXNMXvZvx2mPZMVclluKMREMt5qLiRADT1IRdegIAAA==
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37594
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

This series combines my previous ones ([1], [2]) adding clk_unregister()
function's implementation and fixing a race condition in the device tree
related part of clk_get().

There are couple changes since the RFC v1:
 - moved of_clk_{lock, unlock}, __of_clk_get_from_provider() function
   declaractions to a local header,
 - renamed clk_dummy_* to clk_nodrv_*.

[1] https://lkml.org/lkml/2013/8/6/306
[2] http://www.spinics.net/lists/arm-kernel/msg265989.html

Sylwester Nawrocki (4):
  clk: add common __clk_get(), __clk_put() implementations
  clk: implement clk_unregister
  clk: Provide not locked variant of of_clk_get_from_provider()
  clkdev: Fix race condition in clock lookup from device tree

 arch/arm/include/asm/clkdev.h      |    2 +
 arch/blackfin/include/asm/clkdev.h |    2 +
 arch/mips/include/asm/clkdev.h     |    2 +
 arch/sh/include/asm/clkdev.h       |    2 +
 drivers/clk/clk.c                  |  185 +++++++++++++++++++++++++++++++++---
 drivers/clk/clk.h                  |   16 ++++
 drivers/clk/clkdev.c               |   12 ++-
 include/linux/clk-private.h        |    5 +
 include/linux/clkdev.h             |    5 +
 9 files changed, 218 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/clk.h

--
1.7.9.5
