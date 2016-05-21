Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 13:59:43 +0200 (CEST)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:33985 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032398AbcEUL7lpeJhI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 13:59:41 +0200
Received: by mail-lb0-f194.google.com with SMTP id t6so59275lbv.1;
        Sat, 21 May 2016 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=307QqjCXZeBTB3d83Y7O8BSO8OpUPXorCWJZJHADFfs=;
        b=ZKPQaihLieeepVMDH1VXLVcLGsPQPGGKncdOKLTLUn/JVTsDaWJd5AdbRlFEwddqKC
         06/hSErIkhBfk6aytv9qOT3ICUxCXRP81M5ms69LMqfM4B6ub3DXkf/yHxNrarIgPqWg
         WK3pnMeKYf1+10a1963Ab+bpO/eeB8G2UzWWTcTx1Zoxo7RCytkVv19rzv6ufbHpKkFv
         epoP5Aj0oEw3i++Fu64NEjtlKpdGCXP+KGfuCY0k8IZGvEPOpszbHisCPaNtNWZ2QLvU
         5SF88lwUrSKKwDarmBulQVl5pPYhG2/MjF86tVT77F39kQjW8jF0atM0P/dm9I/rMe2b
         Rqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=307QqjCXZeBTB3d83Y7O8BSO8OpUPXorCWJZJHADFfs=;
        b=QpMDudMqWmOy0Y6zKmQkg8bqDaEIWfXQkWgVbuPlCqVcOWcwy7yNa3gHOzRbbUtc4u
         33fpG/TitzPu80wjf6bpnkoEYt7I2MSCe4jDCaxgCzSKjsKs99K8qCUfHZYwjYZYqBy6
         PEqi/Gvv/nzoJDfvKG5JrXUBb4S4+q7mJCUWcGZbYnxDlCYgKSz7z8Xk+tnmDJGFMuqY
         bJM3gC6lTx0P6iDxL3gBurttrkuW7iBK1649MvswnXLd3wN6KVU4TD/2/K5yWsl3JkvA
         05YgpALnljylyLjVTaD/VnKyr81nscKcWX9et1mjCg1XW/p1qioQrMVZSpReN0Tl9L5s
         I7cw==
X-Gm-Message-State: AOPr4FVn8a9qN4owB9mM/keZ4R6ZKIdkC2T85cUoWDTs9/hJDA+jD6m0BkBrFvQQsL1R/A==
X-Received: by 10.112.170.106 with SMTP id al10mr2755157lbc.12.1463831976406;
        Sat, 21 May 2016 04:59:36 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id oq7sm4101585lbb.47.2016.05.21.04.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 04:59:35 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 0179/1529] Fix typo
Date:   Sat, 21 May 2016 13:59:32 +0200
Message-Id: <20160521115932.9141-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
index 504ed61..b65a6c1 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-bootmem.c
@@ -668,7 +668,7 @@ int64_t cvmx_bootmem_phy_named_block_alloc(uint64_t size, uint64_t min_addr,
 	/*
 	 * Round size up to mult of minimum alignment bytes We need
 	 * the actual size allocated to allow for blocks to be
-	 * coallesced when they are freed.  The alloc routine does the
+	 * coalesced when they are freed. The alloc routine does the
 	 * same rounding up on all allocations.
 	 */
 	size = ALIGN(size, CVMX_BOOTMEM_ALIGNMENT_SIZE);
-- 
2.8.2.534.g1f66975
