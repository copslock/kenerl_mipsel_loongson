Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:35:15 +0200 (CEST)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:37147
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeIEJfJb0mCC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:35:09 +0200
Received: by mail-pg1-x542.google.com with SMTP id 2-v6so3160294pgo.4;
        Wed, 05 Sep 2018 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VviUletBUdNPaRU4C0KizDHhboTXFZepcm4FXe6rc4=;
        b=A6MpbfvsC8keRv5k1hYwggP/rerkBaUEwJ9Y0oqBEg2pRBeIIDLZOUSoethmUw3t0/
         lS8eEumqlfOwNUWtEub3exSbGgUgcONj5R4+8OSj6O2IovByCQ5w+ZEM5iVxe27Ozs3j
         HTFObKeskcw/hTyLBTN3C37eMRX33obrFZ5VuLRMhWJwVZAW3gUdyL8Nd25rkc/74QKD
         WT4EFq34kzVwy8A5j5nvm7O3riKYjj+bgQbxnW/GUotTdz8YYmSEgslr7quDnoiqP1fM
         R8Y+pv6qjEzuRT/aTeeaOG+n0iZHhXz5Z/aUVTZu+5YaF5lvJd4KU0/HudnbNL2NfIZv
         3BBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8VviUletBUdNPaRU4C0KizDHhboTXFZepcm4FXe6rc4=;
        b=fh+hGxL0JUz8zN6TLcFgv1VNk4VFs0ngF/mkyOGYEjCq75rPdZDexvuiZR0zlKMbAw
         7JZbJBrSXh0e4523z4bIT6TVjgjIoS7GtC1wRgRW0CSBIUuPkifXK3CKyYbzVVUnOBYA
         IGTPe3wzL0Z9n25+9xuEAVL7tE3iFV3NXaC2kRCqNLPTFN+IDNzf9RRthZvf4d5g3Fjo
         YI/409Cu7VUPWh3FF7BChhglf6Zp6aLSmfcPykRElQ6BsrlUt/skHq6ikvVleeDQSem/
         yspQvzPZKsKo9a2rdABWU6ohvNREx5UuRBE2FsEBJYUj9gFaOymMsCOpnPoAIXVw9zyV
         Grnw==
X-Gm-Message-State: APzg51CWFf9lyHUf21E6LrzkZYNAeHWaqmO21DyYK77Uw6uPmjuLBjoy
        HfH7s92UqnQToK5cQCVZqB9ST+s6rDc=
X-Google-Smtp-Source: ANB0VdbaObdHG10bn7+rTeCH2RkxEj0sDp9mjU8m8fFueuPjDKFxine1GFcC9O9Jb8WqOrkEMgH1Hw==
X-Received: by 2002:a63:e0e:: with SMTP id d14-v6mr20936566pgl.38.1536140103366;
        Wed, 05 Sep 2018 02:35:03 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2008744pfm.137.2018.09.05.02.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 02:35:02 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 2 . 6 . 36+" <stable@vger.kernel.org>
Subject: [PATCH V4 05/10] MIPS: Align kernel load address to 64KB
Date:   Wed,  5 Sep 2018 17:33:05 +0800
Message-Id: <1536139990-11665-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65943
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
