Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 May 2012 10:08:57 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:42245 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903550Ab2E3IIv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 May 2012 10:08:51 +0200
Received: by pbbrq13 with SMTP id rq13so7614914pbb.36
        for <multiple recipients>; Wed, 30 May 2012 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=kdCbYpAkvVTRNS4hoVlQyyRSY9PtLkPNWCxSJcXSMTo=;
        b=SS/PBV2yYkmhHdS24RhtM/VQNvFtUGLPtZANa2U8KP8dXkYXMAk6nAaosQxBIfuxVQ
         R+Om2qUPKM82YoHWnREQzGe4eZDhcyiSiVVv9Ig4cOsh2cKVNcmQM5WnL3uhWQLIMB5b
         HfC+2f80WV5wWwjXe/uw2DvEpGAkHeS77iFVje+msRKB+yF2CSbpmINbv4OKm0NXqEKt
         6RLWVnRanC7ERUP4DeJPuFWR+Je+s4rQAex6uic5+ATn60JQxTIMZ6qrAqV3wit5/HaF
         piBm01Fi6neMmyMEy9ex4XMn8KwdaqzGW4ufELN6ZS+qspqsOsF4Cf6pBnuPbGriMZoH
         ICcg==
Received: by 10.68.237.74 with SMTP id va10mr47078326pbc.46.1338365324239;
        Wed, 30 May 2012 01:08:44 -0700 (PDT)
Received: from sdk (UQ1-221-171-23-195.tky.mesh.ad.jp. [221.171.23.195])
        by mx.google.com with ESMTPS id rs3sm25647460pbc.47.2012.05.30.01.08.41
        (version=SSLv3 cipher=OTHER);
        Wed, 30 May 2012 01:08:43 -0700 (PDT)
Date:   Wed, 30 May 2012 17:04:45 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: fix BCMA_DRIVER_PCI_HOSTMODE config dependencies
Message-Id: <20120530170445.6bfff638.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 33479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

warning: (BCM47XX_BCMA) selects BCMA_DRIVER_PCI_HOSTMODE which has unmet direct dependencies (BCMA_POSSIBLE && BCMA && MIPS && BCMA_HOST_PCI)
warning: (BCM47XX_BCMA) selects BCMA_DRIVER_PCI_HOSTMODE which has unmet direct dependencies (BCMA_POSSIBLE && BCMA && MIPS && BCMA_HOST_PCI)

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/bcm47xx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index 6210b8d..b311be4 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -21,6 +21,7 @@ config BCM47XX_BCMA
 	select BCMA
 	select BCMA_HOST_SOC
 	select BCMA_DRIVER_MIPS
+	select BCMA_HOST_PCI if PCI
 	select BCMA_DRIVER_PCI_HOSTMODE if PCI
 	default y
 	help
-- 
1.7.0.4
