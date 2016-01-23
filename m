Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2016 10:33:53 +0100 (CET)
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35833 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007043AbcAWJdwS5uKW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jan 2016 10:33:52 +0100
Received: by mail-wm0-f52.google.com with SMTP id r129so11331707wmr.0;
        Sat, 23 Jan 2016 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HbAK0BqnV+TNTGkDPC3KsHiOJtIV94yPEQ6R8VrBjwU=;
        b=eQR9DDmGMWkEyfmSy+we7sEFtoHRfBjwIh0Yer19B/Luc4kDhB1TnDhIIIZFc66pVF
         5Eu5Ow6gIkAt+QY+QoIFJtoiTOcR4bLuVNH97dOTWk6sQA4L5GVHOmCCG2WiV5sMwS4v
         vFlr9LJIN+pAl8twwqtn7qptsf3cvm0w1Ec1fVUvBeY3wq6vBapXxaBC+6Lw4gPwZwgM
         a9AfivzdFN25vE5vDqfoMUblBMzgIM1pSgjy/xbG9Pz9Pfl0Snjg0cvZgM8GJJKYZULY
         1syeRX9AL8BmfGmlT+mbQan+rVofA1s7Ik2pbZkrgiQHaVrJvyU4movgnnUOs+YfqGfJ
         jDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HbAK0BqnV+TNTGkDPC3KsHiOJtIV94yPEQ6R8VrBjwU=;
        b=GbFkPrswWocaYJnz3pc/w22OqtDSPq5IAafJvmQiBqBngpDctLhiDeF1anE9GIfkx4
         iqdJoCO/ZKT52X526Kak4jE+/9EPYBV+57+hmgsuVI8Tisldl0T/DchenKfYC91Xdb5P
         Ut9h9XaA5A796OpFlGO63KnFVZ8uLg2+MAnOH3CpM5yI7mKYPSSP7xZEGRzYTPNKC4sX
         WI8kfsaCZUnMNiN9HwZNF1nfO8j4W6isMcX5j5pa5Q1Nf1uOVIy8Jjm58bnaOQXLmXQ+
         P4KxjxXsYc96yWA6SAXdSV55pRgiW90/AMpz8MdQ8PP2Z3krtSh4yOA06NotorJtYKbh
         EARg==
X-Gm-Message-State: AG10YOS/nmwkIx9kA+Yv2P5VYu5eI9UBAE0HCoL8SljFFk7JF/JsPF/GJJFDp89OHY/ZJg==
X-Received: by 10.28.212.85 with SMTP id l82mr7554979wmg.11.1453541627144;
        Sat, 23 Jan 2016 01:33:47 -0800 (PST)
Received: from dargo.Speedport_W_724V_Typ_A_05011603_00_007 (p200300874C20A67936E6D7FFFE14BFA6.dip0.t-ipconnect.de. [2003:87:4c20:a679:36e6:d7ff:fe14:bfa6])
        by smtp.gmail.com with ESMTPSA id x2sm717101wjf.13.2016.01.23.01.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 23 Jan 2016 01:33:45 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Chen Gang <gang.chen.5i5j@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: fix double definition of MADV_FREE
Date:   Sat, 23 Jan 2016 10:33:43 +0100
Message-Id: <1453541623-710122-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Commit ef58978f1eaab140081ec1808d96ee06e933e760
("mm: define MADV_FREE for some arches") introduced MADV_FREE to MIPS,
commit 21f55b018ba57897f4d3590ecbe11516bdc540af
("arch/*/include/uapi/asm/mman.h: : let MADV_FREE have same value for all architectures")
added another instance, which resulted in this build error:

In file included from include/uapi/linux/mman.h:4:0,
                 from include/linux/mman.h:8,
                 from kernel/fork.c:28:
arch/mips/include/uapi/asm/mman.h:79:0: warning: "MADV_FREE" redefined
 #define MADV_FREE 8  /* free pages only if memory pressure */
 ^
arch/mips/include/uapi/asm/mman.h:76:0: note: this is the location of the previous definition
 #define MADV_FREE 5  /* free pages only if memory pressure */


This patch removes the "MADV_FREE 5" introduced by the first commit
("mm: define MADV_FREE for some arches").

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
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
2.7.0
