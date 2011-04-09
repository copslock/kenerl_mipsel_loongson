Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Apr 2011 19:43:32 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:54343 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490988Ab1DIRnO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Apr 2011 19:43:14 +0200
Received: by iwn36 with SMTP id 36so5093538iwn.36
        for <multiple recipients>; Sat, 09 Apr 2011 10:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=K2SxquBAsrGztBy/4Ma46A+ekqzD7WXU+7KMCA045Vg=;
        b=mer9g6K+4ncCEwXGeVe3hgGYvnYOdxk8l+NoOzKlJKsBs03Lr0BUuDLr2Vb1Uuznd4
         4k3O8KMDxZezB7e2SiBLOvRyZouDw3m22iAAtzRQ/3bzJOV0XYekYSJSI81gizfhRTSI
         0/a4JmrOpBdG9mr/ZRrzMQ1/Q/BtCp6woXWiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DH1auiinRCx5nKIcc9NvTSUf0aXSXEcW0BL/n/XnW/bN27Gdgl6A23nJ57c6nFslrG
         DzW7olj0WBk44AKVd23pV4eM89ikxdU4OUNl+YL34Pl+1Jq6kQnyJ26vPio9wLgiRXjx
         u2N7uRM+AbNPe5IeSD2aGtMwkC9bdiIh0Qtww=
Received: by 10.42.142.9 with SMTP id q9mr4933596icu.413.1302370986451;
        Sat, 09 Apr 2011 10:43:06 -0700 (PDT)
Received: from localhost.localdomain ([182.32.130.75])
        by mx.google.com with ESMTPS id e9sm2782765ibb.15.2011.04.09.10.42.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 10:43:05 -0700 (PDT)
From:   wanlong.gao@gmail.com
To:     ralf@linux-mips.org, david.woodhouse@intel.com,
        akpm@linux-foundation.org, mingo@elte.hu
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH] MIPS:fix the build warning
Date:   Sun, 10 Apr 2011 01:42:17 +0800
Message-Id: <1302370937-832-1-git-send-email-wanlong.gao@gmail.com>
X-Mailer: git-send-email 1.7.3
Return-Path: <wanlong.gao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wanlong.gao@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wanlong Gao <wanlong.gao@gmail.com>

LEDS_CLASS is a bool config .
Value 'm' is invalid for LEDS_CLASS.

Signed-off-by: Wanlong Gao <wanlong.gao@gmail.com>
---
 arch/mips/configs/lemote2f_defconfig |    2 +-
 arch/mips/configs/malta_defconfig    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 167c1d0..cb2c5ea 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -329,7 +329,7 @@ CONFIG_USB_LED=m
 CONFIG_USB_GADGET=m
 CONFIG_USB_GADGET_M66592=y
 CONFIG_MMC=m
-CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_CLASS=y
 CONFIG_STAGING=y
 # CONFIG_STAGING_EXCLUDE_BUILD is not set
 CONFIG_FB_SM7XX=y
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 7270f31..5527abb 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -374,7 +374,7 @@ CONFIG_FB_CIRRUS=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_HID=m
-CONFIG_LEDS_CLASS=m
+CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_TRIGGER_TIMER=m
 CONFIG_LEDS_TRIGGER_IDE_DISK=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=m
-- 
1.7.3
