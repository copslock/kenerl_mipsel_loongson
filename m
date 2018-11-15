Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 08:58:23 +0100 (CET)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:43251
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992494AbeKOH5YOC1m4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 08:57:24 +0100
Received: by mail-pf1-x444.google.com with SMTP id g7-v6so9282854pfo.10;
        Wed, 14 Nov 2018 23:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VviUletBUdNPaRU4C0KizDHhboTXFZepcm4FXe6rc4=;
        b=FrAGRQbPiVDd8kajBlMHPqWYcrF+oDw1FCuDKO5Brevbqb2I68YLUQskbhfzG00n0W
         vfgzYkSXUcXF/cRHbagU/zBasi7niqzR3RKFG8JlbBtreUsoTbiWkb/H2aZ8oHkyagkd
         d5ACaEf+SqP9estcYlzesfDkYIa17QSJWrUsULgAdgzMgdMIQXK7gj6NxdaCJlyZE+3j
         umbSRuwfMgaeSHTd+e+O7TJrnMAg/Sj3Dws4Opeq56PfJZ/gPMP4GmyO1Kz2/2IVcid2
         /ILIUhBxgZZMRnxRLb6V1uZxccxovJWV6/9N1iLFKXmjgWc1vuCkFo9mFHf/L9A4CT64
         Xv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8VviUletBUdNPaRU4C0KizDHhboTXFZepcm4FXe6rc4=;
        b=TR4kcHVhkoHNr+ykZAWKTv9c1Xfdo9I0LfSlSuDoBk5JftElqsH4ztEPWPiCTDJDuP
         dTrNEaoIixSCly09oKkzYUuIrc5zZ+UskIg/gPyb8C1S/lsUg8E32e1ZjSN2RPESQDS0
         AeYQqfcYASI6L28TMZM9rhlEaMz9eTRozO2/7dKvoV/nvV37EsuwSF2PEvHVHXyWqaX+
         KkZdreYkurHa6slyTMuXOA344Tp0jx4rNyqN7RpDN7ZSFhDcgYIwtGQ9migcImg1JGtR
         SvF9gdLJpevbVNjuV0lxv3VbFxWUYEHPnv//EtU1vM7hM5361uWUDH299rEecm5emK0x
         I0/Q==
X-Gm-Message-State: AGRZ1gKPdUqXz5HME9GsXU8oM5iCbQo2j8PM/QrvjjKEkBV9WZPfHo7M
        702TC/3Y5aDBOtjMuLOzsAQxxvlXhCU=
X-Google-Smtp-Source: AJdET5fTBgJ+MiRHDBU4TyJm2VZXlh2xnrjtOVZUxzUvwXhn0qWqWutHnE0Hl31wp6tffEFLFN2O4w==
X-Received: by 2002:a62:888c:: with SMTP id l134-v6mr5399763pfd.198.1542268642068;
        Wed, 14 Nov 2018 23:57:22 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id k24sm10366286pfj.13.2018.11.14.23.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 23:57:21 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 2 . 6 . 36+" <stable@vger.kernel.org>
Subject: [PATCH V5 5/8] MIPS: Align kernel load address to 64KB
Date:   Thu, 15 Nov 2018 15:53:56 +0800
Message-Id: <1542268439-4146-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
References: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67310
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
