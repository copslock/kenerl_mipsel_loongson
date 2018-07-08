Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Jul 2018 17:07:26 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:55818 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992747AbeGHPHTLZ8E- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Jul 2018 17:07:19 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] MIPS: jz4740: Bump zload address
Date:   Sun,  8 Jul 2018 17:07:12 +0200
Message-Id: <20180708150712.7404-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531062437; bh=xg289lwT5JS32ZGyJVoi4pZrUBN6AiXrsLJepzYH4w4=; h=From:To:Cc:Subject:Date:Message-Id; b=FchTZBdZAoMGuroL57MBahfcWeaQ7gyHos2vZUplGnf5m2TNijX9dlyqmAM69atZ7TZ6I9rR03F+iSvcqHu2qc1yzZaOv1QyK1renZlwQBMtgyWVtW36eXyKCS5oADIq7IK7RD9BtA94Sk2Af6TwU/bbHJJqKu+o3cLd1bYTtXE=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Having the zload address at 0x8060.0000 means the size of the
uncompressed kernel cannot be bigger than around 6 MiB, as it is
deflated at address 0x8001.0000.

This limit is too small; a kernel with some built-in drivers and things
like debugfs enabled will already be over 6 MiB in size, and so will
fail to extract properly.

To fix this, we bump the zload address from 0x8060.0000 to 0x8100.0000.

This is fine, as all the boards featuring Ingenic JZ SoCs have at least
32 MiB of RAM, and use u-boot or compatible bootloaders which won't
hardcode the load address but read it from the uImage's header.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/jz4740/Platform | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/Platform b/arch/mips/jz4740/Platform
index 28448d358c10..a2a5a85ea1f9 100644
--- a/arch/mips/jz4740/Platform
+++ b/arch/mips/jz4740/Platform
@@ -1,4 +1,4 @@
 platform-$(CONFIG_MACH_INGENIC)	+= jz4740/
 cflags-$(CONFIG_MACH_INGENIC)	+= -I$(srctree)/arch/mips/include/asm/mach-jz4740
 load-$(CONFIG_MACH_INGENIC)	+= 0xffffffff80010000
-zload-$(CONFIG_MACH_INGENIC)	+= 0xffffffff80600000
+zload-$(CONFIG_MACH_INGENIC)	+= 0xffffffff81000000
-- 
2.18.0
