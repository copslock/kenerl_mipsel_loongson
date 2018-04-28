Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2018 05:23:27 +0200 (CEST)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:33217
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeD1DXUnYxMQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2018 05:23:20 +0200
Received: by mail-pf0-x243.google.com with SMTP id f15so2817165pfn.0;
        Fri, 27 Apr 2018 20:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VviUletBUdNPaRU4C0KizDHhboTXFZepcm4FXe6rc4=;
        b=oq0BwJuM+e5wtmJoGqUF6Og2pXCSpiT1KP5MoO8XhcpvLxv98rfcVix1j5AQ0Ch09z
         Pz80Ftqgjuq0lx3V5PM4fS0DW1vgITlBrADEGd/LXCD4QmOXMeYXBqknu1fSEr0QSfBD
         RxHlgH80XS/wikMVi7KB1i+Y+UYZSFPIefBiyIQNUTqN+pVsFembEvp04Qn2mk6+Tx2L
         +c2ZvvIFkAsAaV0Oe9Bl4aSDnK3Fe3x8Fj8vELmqgga1P1bHyi4zDDiTsrXZW+sQcSMS
         IxzxwehREquQmG76vtxgJoBmpgsNGCdk0K39OGI0WLbqQItvWynOauzPBhPIMRRK7iCV
         /wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8VviUletBUdNPaRU4C0KizDHhboTXFZepcm4FXe6rc4=;
        b=iayEx8D3cWCLzw7ZrAi9JW8tOQG6OdmhUaoE0yD2fyheUuZutWc7jujBo+pheCpLI8
         xi5aoaNwxlvQlxUkmBvOWc8ntBGBqH0njc9JZporVJhtjd2cCHY1bx9CfaCkXeSNgDnC
         mlTp9KDroDmL6fk+wnHeJigHeawlrmsxsF4HFCs/p4cNyyWWNP9ojGJCtDt2KIZ6SbVt
         8Zgt2QpRXkV53/CRje8Ur8H+tkZ+Y9Gof0IPG93cxSIg1aUrDx2TJ+M8i1iKHY6tIGmI
         Norw8znc+O1WkYWzX567lj9IRpss9y0HYIcdzEpVPI96NXJr+dtlRBw7XDk72meDdg5L
         0gkw==
X-Gm-Message-State: ALQs6tB1h3lP3SFPlHYUa6NKFUvuEz9Zl0qvVmXjELWEK0YU8I5cvIj/
        5RvDqYPCUldoPuBMiv1rtpfyzA==
X-Google-Smtp-Source: AB8JxZrgvC6FEbDzh/Kxl9v2tTNDN2rIQqgSjzBJRYltqrS0oZOVQBc6nPazu+wL14buBzqGMUsbhg==
X-Received: by 10.98.229.13 with SMTP id n13mr4384187pff.125.1524885794403;
        Fri, 27 Apr 2018 20:23:14 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g72sm7148114pfg.60.2018.04.27.20.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 20:23:13 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 2 . 6 . 36+" <stable@vger.kernel.org>
Subject: [PATCH V3 07/10] MIPS: Align kernel load address to 64KB
Date:   Sat, 28 Apr 2018 11:21:31 +0800
Message-Id: <1524885694-18132-8-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

KEXEC needs the new kernel's load address to be aligned on a page
boundary (see sanity_check_segment_list()), but on MIPS the default
vmlinuz load address is only explicitly aligned to 16 bytes.

Since the largest PAGE_SIZE supported by MIPS kernels is 64KB, increase
the alignment calculated by calc_vmlinuz_load_addr to 64KB.

Cc: <stable@vger.kernel.org>  # 2.6.36+
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
index 37fe58c..542c3ed 100644
--- a/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
+++ b/arch/mips/boot/compressed/calc_vmlinuz_load_addr.c
@@ -13,6 +13,7 @@
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include "../../../../include/linux/sizes.h"
 
 int main(int argc, char *argv[])
 {
@@ -45,11 +46,11 @@ int main(int argc, char *argv[])
 	vmlinuz_load_addr = vmlinux_load_addr + vmlinux_size;
 
 	/*
-	 * Align with 16 bytes: "greater than that used for any standard data
-	 * types by a MIPS compiler." -- See MIPS Run Linux (Second Edition).
+	 * Align with 64KB: KEXEC needs load sections to be aligned to PAGE_SIZE,
+	 * which may be as large as 64KB depending on the kernel configuration.
 	 */
 
-	vmlinuz_load_addr += (16 - vmlinux_size % 16);
+	vmlinuz_load_addr += (SZ_64K - vmlinux_size % SZ_64K);
 
 	printf("0x%llx\n", vmlinuz_load_addr);
 
-- 
2.7.0
