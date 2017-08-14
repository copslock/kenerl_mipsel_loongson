Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2017 20:22:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34806 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993947AbdHNSUyOYPXp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2017 20:20:54 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 3A5AE9BD297C7;
        Mon, 14 Aug 2017 19:20:43 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 14 Aug 2017 19:20:46
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 7/8] MIPS: generic: Don't explicitly disable CONFIG_USB_SUPPORT
Date:   Mon, 14 Aug 2017 11:18:18 -0700
Message-ID: <20170814181819.7376-8-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170814181819.7376-1-paul.burton@imgtec.com>
References: <20170814181819.7376-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Leave CONFIG_USB_SUPPORT at its default, allowing board config fragments
to make use of USB drivers without needing to override it & trigger
warnings from merge_config.sh.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

Changes in v2: None

 arch/mips/configs/generic_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index 91aacf2ef26d..a638028b1425 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -61,7 +61,6 @@ CONFIG_HID_KENSINGTON=y
 CONFIG_HID_LOGITECH=y
 CONFIG_HID_MICROSOFT=y
 CONFIG_HID_MONTEREY=y
-# CONFIG_USB_SUPPORT is not set
 # CONFIG_MIPS_PLATFORM_DEVICES is not set
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT4_FS=y
-- 
2.14.0
