Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 17:40:44 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45812 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491927Ab1F0PiF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jun 2011 17:38:05 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p5RFc4Fm019420;
        Mon, 27 Jun 2011 16:38:04 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p5RFc4TK019418;
        Mon, 27 Jun 2011 16:38:04 +0100
Message-Id: <1868ba261f47136619ef71c85ff1ef56b085fbe2.1309182743.git.ralf@linux-mips.org>
In-Reply-To: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
References: <17dd5038b15d7135791aadbe80464a13c80758d3.1309182742.git.ralf@linux-mips.org>
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Date:   Mon, 27 Jun 2011 14:40:35 +0100
Subject: [PATCH 12/12] DRM: Radeon: Fix section mismatch.
X-archive-position: 30527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21984

WARNING: drivers/gpu/drm/radeon/radeon.o(.text+0x5d1fc): Section mismatch in reference from the function radeon_get_clock_info() to the function .devinit.text:radeon_read_clocks_OF()
The function radeon_get_clock_info() references
the function __devinit radeon_read_clocks_OF().
This is often because radeon_get_clock_info lacks a __devinit
annotation or the annotation of radeon_read_clocks_OF is wrong.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
To: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/gpu/drm/radeon/radeon_clocks.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_clocks.c b/drivers/gpu/drm/radeon/radeon_clocks.c
index 2d48e7a..dcd0863e 100644
--- a/drivers/gpu/drm/radeon/radeon_clocks.c
+++ b/drivers/gpu/drm/radeon/radeon_clocks.c
@@ -96,7 +96,7 @@ uint32_t radeon_legacy_get_memory_clock(struct radeon_device *rdev)
  * Read XTAL (ref clock), SCLK and MCLK from Open Firmware device
  * tree. Hopefully, ATI OF driver is kind enough to fill these
  */
-static bool __devinit radeon_read_clocks_OF(struct drm_device *dev)
+static bool radeon_read_clocks_OF(struct drm_device *dev)
 {
 	struct radeon_device *rdev = dev->dev_private;
 	struct device_node *dp = rdev->pdev->dev.of_node;
@@ -166,7 +166,7 @@ static bool __devinit radeon_read_clocks_OF(struct drm_device *dev)
 	return true;
 }
 #else
-static bool __devinit radeon_read_clocks_OF(struct drm_device *dev)
+static bool radeon_read_clocks_OF(struct drm_device *dev)
 {
 	return false;
 }
-- 
1.7.4.4
