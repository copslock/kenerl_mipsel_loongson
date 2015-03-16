Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 22:43:22 +0100 (CET)
Received: from mail-ie0-f202.google.com ([209.85.223.202]:34672 "EHLO
        mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008511AbbCPVnUxPccP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 22:43:20 +0100
Received: by iebtr6 with SMTP id tr6so11501799ieb.1
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 14:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YkDbjsoS5lrKlh/u7QCcRMpA4OgbubmipUEYfaiaPCc=;
        b=S0iUdakJMPsKPD7evEXSUt14ThxQG+V8kF6WWPfk2Mre5q1MFuDpwlWMGrGIEWmvGP
         QY2gOglSWuvq/U53GvV03MdQIJXFqPSBss42dntIL/OQp3AEHHMOW8UfftNsOSzvbwgM
         ziOCtP6RLaOrJ+bEluNa4Si/W88ZV5MT/e/ti7C1UC7U257vjdy+hGlJxUtHRY6Mh9Gc
         7DEvkaH90CwzD8Mu4qKzP7q6CPZt6NzdC26yaPf38Oeavk3tsqY7BbNdJLicwLk5RL2r
         zHEqxfyuhGmGKIAfR2XpCsH/XW1k0NdOzQJJpZ5wVgepBYNZDt9IzG/CRSxNuqMZfsIx
         JMCQ==
X-Gm-Message-State: ALoCoQk9Lqd7sBQvvSfSwx2v/1kr/carDlDKcrN+Bw+9pvJBNkX8uuP3wiphnDtO9mYr2lGh24o/
X-Received: by 10.42.83.209 with SMTP id i17mr57860897icl.32.1426542195306;
        Mon, 16 Mar 2015 14:43:15 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id l2si591398yhg.7.2015.03.16.14.43.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Mar 2015 14:43:15 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id cg9mftII.1; Mon, 16 Mar 2015 14:43:15 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 3E1A6220A5E; Mon, 16 Mar 2015 14:43:14 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH V3 2/5] MIPS: Allow platforms to specify the decompressor load address
Date:   Mon, 16 Mar 2015 14:43:08 -0700
Message-Id: <1426542191-6883-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1426542191-6883-1-git-send-email-abrestic@chromium.org>
References: <1426542191-6883-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Platforms which use raw zboot images may need to link the image at
a fixed address if there is no other way to communicate the load
address to the bootloader.  Allow the per-platform Kbuild files
to specify an optional zboot image load address (zload-y) and fall
back to calc_vmlinuz_load_addr if unset.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
No changes from v1/v2.
---
 arch/mips/boot/compressed/Makefile | 6 ++++--
 arch/mips/jz4740/Platform          | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 61af6b6..82d0b13 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -12,6 +12,8 @@
 # Author: Wu Zhangjin <wuzhangjin@gmail.com>
 #
 
+include $(srctree)/arch/mips/Kbuild.platforms
+
 # set the default size of the mallocing area for decompressing
 BOOT_HEAP_SIZE := 0x400000
 
@@ -66,8 +68,8 @@ $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
 # Calculate the load address of the compressed kernel image
 hostprogs-y := calc_vmlinuz_load_addr
 
-ifeq ($(CONFIG_MACH_JZ4740),y)
-VMLINUZ_LOAD_ADDRESS := 0x80600000
+ifneq ($(zload-y),)
+VMLINUZ_LOAD_ADDRESS := $(zload-y)
 else
 VMLINUZ_LOAD_ADDRESS = $(shell $(obj)/calc_vmlinuz_load_addr \
 		$(obj)/vmlinux.bin $(VMLINUX_LOAD_ADDRESS))
diff --git a/arch/mips/jz4740/Platform b/arch/mips/jz4740/Platform
index ba91be9..c41d300 100644
--- a/arch/mips/jz4740/Platform
+++ b/arch/mips/jz4740/Platform
@@ -1,3 +1,4 @@
 platform-$(CONFIG_MACH_JZ4740)	+= jz4740/
 cflags-$(CONFIG_MACH_JZ4740)	+= -I$(srctree)/arch/mips/include/asm/mach-jz4740
 load-$(CONFIG_MACH_JZ4740)	+= 0xffffffff80010000
+zload-$(CONFIG_MACH_JZ4740)	+= 0xffffffff80600000
-- 
2.2.0.rc0.207.ga3a616c
