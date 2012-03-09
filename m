Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2012 17:39:52 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:37041 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903692Ab2CIQjs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2012 17:39:48 +0100
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
        by relay1.mentorg.com with esmtp 
        id 1S62r1-0004Vy-43 from Thomas_Schwinge@mentor.com ; Fri, 09 Mar 2012 08:39:43 -0800
Received: from SVR-ORW-FEM-03.mgc.mentorg.com ([147.34.97.39]) by svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 9 Mar 2012 08:39:42 -0800
Received: from build6-lucid-cs (147.34.91.1) by svr-orw-fem-03.mgc.mentorg.com
 (147.34.97.39) with Microsoft SMTP Server id 14.1.289.1; Fri, 9 Mar 2012
 08:39:42 -0800
Received: by build6-lucid-cs (Postfix, from userid 49978)       id 0F184E6281; Fri,
  9 Mar 2012 08:39:41 -0800 (PST)
From:   Thomas Schwinge <thomas@codesourcery.com>
CC:     Thomas Schwinge <thomas@codesourcery.com>,
        Paul Mundt <lethal@linux-sh.org>, <linux-sh@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 5/7] USB: r8a66597-hcd: restore big-endian operation.
Date:   Fri, 9 Mar 2012 17:38:51 +0100
Message-ID: <1331311133-26937-5-git-send-email-thomas@codesourcery.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
References: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OriginalArrivalTime: 09 Mar 2012 16:39:42.0413 (UTC) FILETIME=[3A605FD0:01CCFE13]
To:     unlisted-recipients:; (no To-header on input)
X-archive-position: 32626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@codesourcery.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On SH, as of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
endianess-agnostic I/O accessor functions.

This driver is also enabled in ARM's viper_defconfig as well as MIPS'
bcm47xx_defconfig and fuloong2e_defconfig -- I suppose none of these are
operating in big-endian mode, or this issue should already have been noticed
before.

The device is now recognized correctly for both litte-endian and big-endian
sh7785lcr, but I have not tested this any further, as the board is situated in
a remote data center.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org
---
 drivers/usb/host/r8a66597.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
index f28782d..c2ea6d1 100644
--- a/drivers/usb/host/r8a66597.h
+++ b/drivers/usb/host/r8a66597.h
@@ -170,7 +170,7 @@ static inline struct urb *r8a66597_get_urb(struct r8a66597 *r8a66597,
 
 static inline u16 r8a66597_read(struct r8a66597 *r8a66597, unsigned long offset)
 {
-	return ioread16(r8a66597->reg + offset);
+	return __raw_readw(r8a66597->reg + offset);
 }
 
 static inline void r8a66597_read_fifo(struct r8a66597 *r8a66597,
@@ -198,7 +198,7 @@ static inline void r8a66597_read_fifo(struct r8a66597 *r8a66597,
 static inline void r8a66597_write(struct r8a66597 *r8a66597, u16 val,
 				  unsigned long offset)
 {
-	iowrite16(val, r8a66597->reg + offset);
+	__raw_writew(val, r8a66597->reg + offset);
 }
 
 static inline void r8a66597_mdfy(struct r8a66597 *r8a66597,
-- 
1.7.4.1
