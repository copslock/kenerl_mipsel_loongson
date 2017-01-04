Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2017 19:05:21 +0100 (CET)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33277 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbdADSFNnl1sB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jan 2017 19:05:13 +0100
Received: by mail-wm0-f68.google.com with SMTP id u144so92702845wmu.0;
        Wed, 04 Jan 2017 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eqS2fyBAWSebsEpHn/l1gAuYA5JWieTew9DyeWbgVwM=;
        b=Bnslp/x4mUU26MG4hHgWSVgwmvgbInD+o2o7kQbqwcdZHqA1SX+k+Efv7uVIUyWJVl
         InpdvHFPZYPLT9ljkp8ePdsQ2H3dRq3g+wSLCuD3TVLS1EmGoNec6x3oIIKWnw15fSRp
         lLVTJTSu7QML0m8RcexcvgFooLBibNdqk1MzdakdIytF3f/lgym3rav2LtdaOka2jrD4
         agdxsaZxnib21ejeHjO5wm0y1vs2XnsFuf7/2E6Cb/l6LDKIloRemiNcmToSG128JBxs
         6elbb64OUUys6w6iBxZR/PVAa8d5J3f51RZ7ay+CbVwg1zdPX+SYhV9xhtWtwwYC7+ty
         YVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eqS2fyBAWSebsEpHn/l1gAuYA5JWieTew9DyeWbgVwM=;
        b=Eshmd6dievlM4RbuRO7T5yn/QIPrhysgmFSKErlaz5gvVfRfUeY4v2qVlzjkluwchI
         6GTFykkds76Epe8XCQXxEi1zBKrYtK7aHDIhWN8L/fFiejgmdhBU98fvWUv6bF4graSd
         pwSAXQY/WUFsNms9YXss0rK7yQOkKDy9Wc3YUuMaB1ImlWkOZ4lQyqjwtxj5n8e74W2u
         QJbof+vkPWkhhn/TEFsA/qVlznunhnqLITxm5f3AzpaUReuUclwERcC6US/q3deE9JNS
         kHvRU3hdvE4REDzm7aadPECYS45afFCuHzzAhbt63JrYRsHgbkG9nU421r5AcjzDag8m
         CUOA==
X-Gm-Message-State: AIkVDXI+W+4gViuHFnfWdzo/1DfkBMh/mX7ObYnyCNqPXGtGCavcIbz5MoWhN1Px1cbxbg==
X-Received: by 10.28.60.5 with SMTP id j5mr64210724wma.119.1483553103427;
        Wed, 04 Jan 2017 10:05:03 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id g73sm96254294wme.16.2017.01.04.10.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 10:05:02 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] MIPS: zboot: fix build failure
Date:   Wed,  4 Jan 2017 18:04:58 +0000
Message-Id: <1483553098-5013-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sudipm.mukherjee@gmail.com
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

The build of mips ar7_defconfig was failing with the error:
arch/mips/boot/compressed/Makefile:21:
  *** insufficient number of arguments (1) to function `filter-out'.
	Stop.

A ',' was missing while adding filter-out.

Fixes: afca036d463c ("MIPS: zboot: Consolidate compiler flag filtering.")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/188737021

 arch/mips/boot/compressed/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 608389a..c675eec 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -18,7 +18,7 @@ include $(srctree)/arch/mips/Kbuild.platforms
 BOOT_HEAP_SIZE := 0x400000
 
 # Disable Function Tracer
-KBUILD_CFLAGS := $(filter-out -pg $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out -pg, $(KBUILD_CFLAGS))
 
 KBUILD_CFLAGS := $(filter-out -fstack-protector, $(KBUILD_CFLAGS))
 
-- 
1.9.1
