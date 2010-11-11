Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Nov 2010 19:09:48 +0100 (CET)
Received: from smtp-out-138.synserver.de ([212.40.180.138]:1043 "HELO
        smtp-out-138.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492004Ab0KKSJX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Nov 2010 19:09:23 +0100
Received: (qmail 27606 invoked by uid 0); 11 Nov 2010 18:09:13 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 27496
Received: from d124041.adsl.hansenet.de (HELO localhost.localdomain) [80.171.124.41]
  by 217.119.54.81 with SMTP; 11 Nov 2010 18:09:13 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MIPS: JZ4740: Set nand ecc offsets for the qi_lb60 board
Date:   Thu, 11 Nov 2010 19:08:53 +0100
Message-Id: <1289498933-12836-2-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1289498933-12836-1-git-send-email-lars@metafoo.de>
References: <1289498933-12836-1-git-send-email-lars@metafoo.de>
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Now that the mtd core supports more then 64 ecc bytes we can use it instead of
some a custom hack in the jz4740 nand driver.
This patches sets the ecc pos fields of the ecc_layout of the qi_lb60 board.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/board-qi_lb60.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
---
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 05297ef..3a41014 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -50,14 +50,14 @@ static bool is_avt2;
 
 /* NAND */
 static struct nand_ecclayout qi_lb60_ecclayout_1gb = {
-/*	.eccbytes = 36,
+	.eccbytes = 36,
 	.eccpos = {
 		6,  7,  8,  9,  10, 11, 12, 13,
 		14, 15, 16, 17, 18, 19, 20, 21,
 		22, 23, 24, 25, 26, 27, 28, 29,
 		30, 31, 32, 33, 34, 35, 36, 37,
 		38, 39, 40, 41
-	},*/
+	},
 	.oobfree = {
 		{ .offset = 2, .length = 4 },
 		{ .offset = 42, .length = 22 }
@@ -86,7 +86,7 @@ static struct mtd_partition qi_lb60_partitions_1gb[] = {
 };
 
 static struct nand_ecclayout qi_lb60_ecclayout_2gb = {
-/*	.eccbytes = 72,
+	.eccbytes = 72,
 	.eccpos = {
 		12, 13, 14, 15, 16, 17, 18, 19,
 		20, 21, 22, 23, 24, 25, 26, 27,
@@ -97,7 +97,7 @@ static struct nand_ecclayout qi_lb60_ecclayout_2gb = {
 		60, 61, 62, 63, 64, 65, 66, 67,
 		68, 69, 70, 71, 72, 73, 74, 75,
 		76, 77, 78, 79, 80, 81, 82, 83
-	},*/
+	},
 	.oobfree = {
 		{ .offset = 2, .length = 10 },
 		{ .offset = 84, .length = 44 },
-- 
1.5.6.5
