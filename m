Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 13:09:43 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33397 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008478AbbLGMJlnMCdL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 13:09:41 +0100
Received: by pabfh17 with SMTP id fh17so127756959pab.0;
        Mon, 07 Dec 2015 04:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gbrtOsbRQ9WGQ10ylHggf0Nh1oi1g0DSIPTnbjU2DCQ=;
        b=t266KFvcj74d/t2ZF+oj3OlU84pB4i3kLvPnTf7rFmuGBDfR7quZJGkUdGiu31ZPCs
         yFmPQ7sMc/BvWL+exfhyARUt2/wFHuKNHbyFBWdOtX7bsRCyb6ujOjS/E3m43TlnPSpt
         qbNJvHTjyD20q5ktqH0QVaFm42QDBsxAbC+ZvfrIJ/ZkNKuAl0R2MIBBMjc24D0PuG6l
         w9zvSqDuZD5TBWECV8XrKqViRqvml2WtJaTIRX+ERplBDOCZnM/Cidpx4b3zvytp6XHX
         AjhMnVokksjuNXb88AWJakxuMcVYMYBmpKCHGLwiMWbZSuCmUk0MGcq7vodfVzBPM12K
         KzUQ==
X-Received: by 10.66.234.226 with SMTP id uh2mr41840371pac.6.1449490174686;
        Mon, 07 Dec 2015 04:09:34 -0800 (PST)
Received: from sudip-pc.vectortproxy.org ([122.169.145.251])
        by smtp.gmail.com with ESMTPSA id q129sm34312989pfq.19.2015.12.07.04.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Dec 2015 04:09:34 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Chen Gang <gang.chen.5i5j@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mips: mm: fix build failure
Date:   Mon,  7 Dec 2015 17:39:24 +0530
Message-Id: <1449490164-21029-1-git-send-email-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <sudipm.mukherjee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50356
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

We are having build failure with mips defconfig with the error:
"MADV_FREE" redefined.

commit d53d95838c7d introduced uniform values for all architecture but
missed removing the old value.

Fixes: d53d95838c7d ("arch/*/include/uapi/asm/mman.h: : let MADV_FREE have same value for all architectures")
Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/95309512

 arch/mips/include/uapi/asm/mman.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index b0ebe59..ccdcfcb 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -73,7 +73,6 @@
 #define MADV_SEQUENTIAL 2		/* expect sequential page references */
 #define MADV_WILLNEED	3		/* will need these pages */
 #define MADV_DONTNEED	4		/* don't need these pages */
-#define MADV_FREE	5		/* free pages only if memory pressure */
 
 /* common parameters: try to keep these consistent across architectures */
 #define MADV_FREE	8		/* free pages only if memory pressure */
-- 
1.9.1
