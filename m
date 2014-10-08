Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2014 03:18:16 +0200 (CEST)
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:57424 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010187AbaJHBSO40T1z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Oct 2014 03:18:14 +0200
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-03v.sys.comcast.net with comcast
        id 0RHf1p0052EPM3101RJ61L; Wed, 08 Oct 2014 01:18:06 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-ch2-07v.sys.comcast.net with comcast
        id 0RHu1p00A3aNLgd01RHuhZ; Wed, 08 Oct 2014 01:18:05 +0000
Message-ID: <543490B9.7070302@gentoo.org>
Date:   Tue, 07 Oct 2014 21:17:45 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: R14000: Add missing CPU_R14000 reference in cpu_needs_post_dma_flush()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1412731086;
        bh=089n+M4+jzVVczd1N6swJ7QTiY/9y+y+1RYqGWmSkjI=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=L2Xh+wCPJHARDiGlzkxH5TWl5A0bEWNXn0bogiP/d5OqZTb1AgVn0ttCvklxdA4i9
         +qdZ2pzjbq4CMH6nd4/dM3crdbZej3xUQ1+IiREhIHXCJAK+ZgOLEGUfWdgPYlePAx
         DzUmSCYr2lotbhn/HvvkbI1D+6X32ZSkNFFGdVC5NqIadQ7P8sExkLlqor6cZmZDrx
         UJuKXHd1gbvynaQBifqbkOVD9KMSU1N3ZCvQZWoWcSbzgyOGzUHsblSgawkEfrnE90
         5DpzFO5fC68KCQhT/ht3OTshw2KJ/1uXVh/MyZrfWJkyqPyOXbijRxOuFEILF6L9xE
         MtfZOQn5aJWew==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

cpu_needs_post_dma_flush() in arch/mips/mm/dma-default.c is missing a check for
CPU_R14000, where it already has checks for CPU_R10000 and CPU_R12000.  This
patch adds the missing CPU_R14000 check.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/mm/dma-default.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 44b6dff..3693c91 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -66,6 +66,7 @@ static inline int cpu_needs_post_dma_flush(struct device *dev)
 	return !plat_device_is_coherent(dev) &&
 	       (boot_cpu_type() == CPU_R10000 ||
 		boot_cpu_type() == CPU_R12000 ||
+		boot_cpu_type() == CPU_R14000 ||
 		boot_cpu_type() == CPU_BMIPS5000);
 }
