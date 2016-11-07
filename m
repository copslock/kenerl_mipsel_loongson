Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 20:41:41 +0100 (CET)
Received: from smtp.duncanthrax.net ([89.31.1.170]:35607 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991978AbcKGTlakie08 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 20:41:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From; bh=dHMb1PbJQazIi620JCEA/2vpWkPEG5UyL/O0j4vzLG0=; b=oqqa7vqbrrOWGm
        ErSaBW2vHCbneL7tvQ7lKpdbFuQM5HiBUNuTMcLi1tSAhQWeiRJAe+hjZW+/bSkohdc/95ZzeMBsB
        0y/gT2J15Ava8ypVIp6bkgSfnXBG7cKwstLWx+qFIp5UwhBdQ33blwYm4rqBdio3Uqgtzl1PVMu3a
        7aI=;
Received: from hsi-kbw-109-193-239-081.hsi7.kabel-badenwuerttemberg.de ([109.193.239.81] helo=macbook.stackframe.org)
        by smtp.eurescom.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <svens@stackframe.org>)
        id 1c3pnO-0003rp-7X; Mon, 07 Nov 2016 20:41:30 +0100
From:   Sven Schnelle <svens@stackframe.org>
To:     linux-mips@linux-mips.org
Cc:     svens@stackframe.org
Subject: [PATCH] MIPS: MIPS74K needs post dma flush
Date:   Mon,  7 Nov 2016 20:41:28 +0100
Message-Id: <20161107194128.25086-2-svens@stackframe.org>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107194128.25086-1-svens@stackframe.org>
References: <20161107194128.25086-1-svens@stackframe.org>
Return-Path: <svens@stackframe.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svens@stackframe.org
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

The manual states "A 74K processor contains no direct hardware
support for managing coherency with respect to its caches, so
it must be handled via the system design or software"

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 arch/mips/mm/dma-default.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 46d5696..575b7b8 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -73,7 +73,8 @@ static inline int cpu_needs_post_dma_flush(struct device *dev)
 	return !plat_device_is_coherent(dev) &&
 	       (boot_cpu_type() == CPU_R10000 ||
 		boot_cpu_type() == CPU_R12000 ||
-		boot_cpu_type() == CPU_BMIPS5000);
+		boot_cpu_type() == CPU_BMIPS5000 ||
+		boot_cpu_type() == CPU_74K);
 }
 
 static gfp_t massage_gfp_flags(const struct device *dev, gfp_t gfp)
-- 
2.10.2
