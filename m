Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 02:32:36 +0100 (CET)
Received: from mail-ob0-f202.google.com ([209.85.214.202]:36222 "EHLO
        mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007078AbbBXBb7HGCuz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 02:31:59 +0100
Received: by mail-ob0-f202.google.com with SMTP id nt9so10060750obb.1
        for <linux-mips@linux-mips.org>; Mon, 23 Feb 2015 17:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zOvmofLK+BVe0xCmR/eNr6eLGBtcaWF+w44b7xX1II4=;
        b=bXWZBkLSuOFmicjX/YRnXWv7IgEY0onDWUMuQbog8aeUTlayiM9usOW6adaK8fTT2j
         hcVd6gJQyLxuDdxGhhMcVGCWgRNTTjgajm245Ykn+KPyTCQXwn+n244pNYWmca1alm8B
         Ba7XMTHLqFcp3UujUgYLC4JrBdbXp6CIrIxmF0StJ2q0ohj8mNoZ49t0ZcvbvfQcQvwK
         ZKcrW2wMunfIWFE9KWeIC00PLOvms1B7fM5KL9o+dD2It9OhzuSGoOry6KB4eFkPoymb
         cJ7w8tQ5E4xBIHBqSB+M05Aqjr1V2nucmiAYQVft/XWgOflI6JgC1pOg2E2h6Q3l8j7t
         Isrg==
X-Gm-Message-State: ALoCoQlH2anrUTQ+izXXuub4lCkVPvV4HmRaUXUI/bRibeWZ3IaBGIq/ho7XY/AbACrtX8PoqYW1
X-Received: by 10.182.126.12 with SMTP id mu12mr1650316obb.13.1424741513612;
        Mon, 23 Feb 2015 17:31:53 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id ba9si6331789qcb.0.2015.02.23.17.31.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2015 17:31:53 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id o5n28JLR.1; Mon, 23 Feb 2015 17:31:53 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 67428220AFE; Mon, 23 Feb 2015 17:31:52 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] MIPS: Allow platforms to specify the decompressor load address
Date:   Mon, 23 Feb 2015 17:31:44 -0800
Message-Id: <1424741507-8882-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1424741507-8882-1-git-send-email-abrestic@chromium.org>
References: <1424741507-8882-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45906
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
