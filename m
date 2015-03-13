Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 23:54:54 +0100 (CET)
Received: from mail-pa0-f73.google.com ([209.85.220.73]:32820 "EHLO
        mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013730AbbCMWyTElmda (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 23:54:19 +0100
Received: by pablj1 with SMTP id lj1so7742416pab.0
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 15:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0lpB78RG40KwzpTs8C+z/hvZxe30ign8vOp0sxUSJrM=;
        b=TwTlFxE6ZedKqhlyQnFSrURRWDDFDHp1crMgxk43GVbYIqdTIg3nVHzJuaNW9l6ujM
         O+jBLS4sP0vt5McHDPNX2Uth1g/x36qLRFIXqVzqA2CH94sZGTlsQQM1CUgVfhSS5pjC
         dP+EXsBMiwth+7odq1uAkQdqEJo+b8jByoeDdtV5ld1ZlfxBhD6ohPERPd0dVR7YoI6K
         jVpa6DeaEfEoN4kFkyMDKWgYPPpkm7EIBcjnwkWR6AQp+n7Zhm/Nvni9xic0aexKxao0
         ON7yeqVLd/Gdp+c8dt0hD7x330w7nffpAhRrJqPHQzSiCpI6Amnfsa/0wQM9XBhxCdKY
         oYUQ==
X-Gm-Message-State: ALoCoQmZnEtZa98J4n67mGS3U10QHS3M4IpF4YnkROsiPmSgQ1d3mBKUbxTei7BrZ7rBXTwwWiUD
X-Received: by 10.66.151.101 with SMTP id up5mr50508812pab.10.1426287253382;
        Fri, 13 Mar 2015 15:54:13 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id 40si187534yho.6.2015.03.13.15.54.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2015 15:54:13 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 2dE2lyIw.1; Fri, 13 Mar 2015 15:54:13 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 4C87122038B; Fri, 13 Mar 2015 15:54:12 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH V2 2/5] MIPS: Allow platforms to specify the decompressor load address
Date:   Fri, 13 Mar 2015 15:54:06 -0700
Message-Id: <1426287249-27185-3-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1426287249-27185-1-git-send-email-abrestic@chromium.org>
References: <1426287249-27185-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46381
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
No changes from v1.
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
