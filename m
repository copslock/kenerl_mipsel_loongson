Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 16:54:06 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:44918 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824784Ab3H3Oxns47kj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Aug 2013 16:53:43 +0200
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MSC002T3MP1N5M0@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Fri, 30 Aug 2013 23:53:34 +0900 (KST)
X-AuditID: cbfee61b-b7f776d0000016c8-e8-5220b1ee2af2
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm2.samsung.com (EPCPMTA) with SMTP id 2E.E9.05832.EE1B0225; Fri,
 30 Aug 2013 23:53:34 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MSC00KB2MP05U90@mmp1.samsung.com>; Fri,
 30 Aug 2013 23:53:34 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, t.figa@samsung.com,
        g.liakhovetski@gmx.de, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v6 0/5] clk: clock deregistration support
Date:   Fri, 30 Aug 2013 16:53:17 +0200
Message-id: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t9jAd13GxWCDPauUrJ4v3Eek0XPn0qL
        s01v2C06Jy5ht9j0+BqrxeVdc9gsJkydxG4x588UZovbl3ktnk64yGZxu3EFm8XhN+2sFutn
        vGZx4PVoae5h8/jwMc5jdsdMVo871/aweRxduZbJY/OSeo/dX5sYPfq2rGL0+LxJLoAzissm
        JTUnsyy1SN8ugSuj9cwlpoL/vBVXZr5kaWB8wNXFyMkhIWAi8f/FdHYIW0ziwr31bF2MXBxC
        AosYJXonrWGEcDqYJN72TmQDqWITMJToPdrHCGKLCGhITOl6zA5SxCxwmUli05cusFHCApYS
        ZzdtYAGxWQRUJfacbwFr4BVwlfi8ah9TFyMH0DoFiTmTbCYwci9gZFjFKJpakFxQnJSea6RX
        nJhbXJqXrpecn7uJERyCz6R3MK5qsDjEKMDBqMTDu3O5QpAQa2JZcWXuIUYJDmYlEd6Pi4FC
        vCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ+2WgcKCaQnlqRmp6YWpBbBZJk4OKUaGGMNts4pUVqw
        7/FXg8ykzD/l309Iqc2tkb/2KbKq03ZRRsn9RU731oRueWSxTLioY1bFXMHj6fsFr6hlzSir
        fRYS3C/Kv5Lznkd5UeCyupKw7AQ2tkNTbxXM3jKj9bHcMSHXJJe9T059nqgiyvnh8Mq4Sf8j
        1K+tdT6qJGLVvXVnqHTnsnyhtUosxRmJhlrMRcWJAN6W2tg9AgAA
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37713
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
framework. Comparing to v5 it only includes further corrections of NULL
clock handling.

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
  clk: Provide not locked variant of of_clk_get_from_provider()
  clkdev: Fix race condition in clock lookup from device tree
  clk: Add common __clk_get(), __clk_put() implementations
  clk: Assign module owner of a clock being registered
  clk: Implement clk_unregister

 arch/arm/include/asm/clkdev.h      |    2 +
 arch/blackfin/include/asm/clkdev.h |    2 +
 arch/mips/include/asm/clkdev.h     |    2 +
 arch/sh/include/asm/clkdev.h       |    2 +
 drivers/clk/clk.c                  |  188 +++++++++++++++++++++++++++++++++---
 drivers/clk/clk.h                  |   16 +++
 drivers/clk/clkdev.c               |   12 ++-
 include/linux/clk-private.h        |    5 +
 include/linux/clkdev.h             |    5 +
 9 files changed, 221 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/clk.h

--
1.7.9.5
