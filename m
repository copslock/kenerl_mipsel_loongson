Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 15:25:42 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:52152 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeC2NZcfvTsM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 15:25:32 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 29 Mar 2018 13:25:12 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 29 Mar 2018 03:41:32 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] Add notrace to lib/ucmpdi2.c
Date:   Thu, 29 Mar 2018 11:41:21 +0100
Message-ID: <1522320083-27818-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522329910-452059-22112-59221-6
X-BESS-VER: 2018.4.1-r1803282120
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191513
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

From: Palmer Dabbelt <palmer@sifive.com>

As part of the MIPS conversion to use the generic GCC library routines,
Matt Redfearn discovered that I'd missed a notrace on __ucmpdi2().  This
patch rectifies the problem.

CC: Matt Redfearn <matt.redfearn@mips.com>
CC: Antony Pavlov <antonynpavlov@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
  add notrace to lib/ucmpdi2.c

 lib/ucmpdi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ucmpdi2.c b/lib/ucmpdi2.c
index 25ca2d4c1e19..597998169a96 100644
--- a/lib/ucmpdi2.c
+++ b/lib/ucmpdi2.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/libgcc.h>
 
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
+word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
 {
 	const DWunion au = {.ll = a};
 	const DWunion bu = {.ll = b};
-- 
2.7.4
