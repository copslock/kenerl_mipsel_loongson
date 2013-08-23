Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 17:04:20 +0200 (CEST)
Received: from mailout4.samsung.com ([203.254.224.34]:50991 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6827305Ab3HWPERNN4Zp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Aug 2013 17:04:17 +0200
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MRZ00CZYOIV3ZV0@mailout4.samsung.com>; Sat,
 24 Aug 2013 00:04:07 +0900 (KST)
X-AuditID: cbfee61b-b7f776d0000016c8-66-521779e70d5a
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm2.samsung.com (EPCPMTA) with SMTP id 0C.0C.05832.7E977125; Sat,
 24 Aug 2013 00:04:07 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MRZ00M18OIHS210@mmp1.samsung.com>; Sat,
 24 Aug 2013 00:04:06 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, shawn.guo@linaro.org,
        sebastian.hesselbarth@gmail.com, LW@KARO-electronics.de,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 0/5] clk: clock deregistration support
Date:   Fri, 23 Aug 2013 17:03:42 +0200
Message-id: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsVy+t9jAd3nleJBBnunClpMffiEzeL9xnlM
        Fj1/Ki3ONr1ht+icuITdYtPja6wWl3fNYbOYMHUSu8WcP1OYLW5f5rU48GQ5m8XTCRfZLG43
        rmCzuLRHxeLwm3ZWi/c/HS2erlvCbLF+xmsWi4UNX9gtbk74wewg4tHS3MPmsXK6t8fl72+Y
        PXbOusvu8eFjnMfsjpmsHvOnP2L22LSqk83jzrU9bB5HV65l8ti8pN5j99cmRo++LasYPT5v
        kgvgi+KySUnNySxLLdK3S+DKWLNiJVPBZ56Kp/MfMjcwvuHsYuTkkBAwkfgx4wM7hC0mceHe
        erYuRi4OIYFFjBKXHvexQDgdTBKfGnqZQKrYBAwleo/2MYLYIgIaElO6HrODFDEL9LJITJl8
        kwUkISxgKfH04QYwm0VAVeJVwzLWLkYODl4BV4lti3RATAkBBYk5k2wmMHIvYGRYxSiaWpBc
        UJyUnmukV5yYW1yal66XnJ+7iREc8s+kdzCuarA4xCjAwajEwzvBWSxIiDWxrLgy9xCjBAez
        kgjvzjzxICHelMTKqtSi/Pii0pzU4kOM0hwsSuK8B1utA4UE0hNLUrNTUwtSi2CyTBycUg2M
        0z9JKVxoOjjj4skCzlVcd2OsS30Cp2cGTdK8srTq91vFdqPG3MjPkyz3z//0qUQsNfbLVtPj
        Zenm+aw3DO/wLFI2dp9Vojb1D1fnzvrafWx3lzHVqW0Q/POh/9MPlpVV6hcLOVtVd3ntfOOy
        r17UZHF0lL+yruPcr7yvGU5tFqlOlK9heZOpxFKckWioxVxUnAgAtnhGzHUCAAA=
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37659
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

This patch set is intended to add clock deregistration support to
the common clock framework, required for clock suppliers as loadable
modules.  Previous version of this series can be found at [1].

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


[1] http://www.spinics.net/lists/linux-sh/msg22948.html

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
 drivers/clk/clk.c                  |  189 +++++++++++++++++++++++++++++++++---
 drivers/clk/clk.h                  |   16 +++
 drivers/clk/clkdev.c               |   12 ++-
 include/linux/clk-private.h        |    5 +
 include/linux/clk-provider.h       |    2 +
 include/linux/clkdev.h             |    5 +
 10 files changed, 224 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/clk.h

--
1.7.9.5
