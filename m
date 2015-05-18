Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2015 01:21:28 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36108 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012124AbbERXV1Oknd4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2015 01:21:27 +0200
Received: by pabts4 with SMTP id ts4so171061755pab.3;
        Mon, 18 May 2015 16:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iPGSwIAeP5Cn9OsZAwO2o/0pPJI5hDziOJ1P66Mnv0Q=;
        b=lgmqIQw48220fZMAYtwH8aaOxHDNBfOTY/nphWudYS5shFCEkhroVTbUrvB4ub/+Ii
         KYWa8QPSn4AelzVI1IIB77eztJfC1qF3RUJsq8UuMGcwzaqDvSjuBeNaT7qiwTxoqCiX
         KyaZzgmvhB2OknwGE7HrFIoi3aaqFQcZ8hF5qBnTmtkAcdV657KZT3fL7YLarF1WXGTP
         0q8qI5aKA28vLFf7flsF9yh65EJEzhJaRKSdeunqMh++DvRayBO17jVJbTshWvT3wFH1
         bsJMbP+MN9056leMqdQbQb+28vdVe5rXfinJg1E1Uy0glNn0jP7n0wV+RcbsQ5F2uk5L
         xaLg==
X-Received: by 10.66.232.104 with SMTP id tn8mr47769462pac.73.1431991282901;
        Mon, 18 May 2015 16:21:22 -0700 (PDT)
Received: from ld-irv-0074.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id oj10sm11102211pdb.38.2015.05.18.16.21.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 16:21:22 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: netlogic: remove unnecessary MTD partition probe specification
Date:   Mon, 18 May 2015 16:21:12 -0700
Message-Id: <1431991272-22200-1-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

The cmdlinepart parser is already supported in the default probe.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 arch/mips/netlogic/xlr/platform-flash.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/netlogic/xlr/platform-flash.c b/arch/mips/netlogic/xlr/platform-flash.c
index 6d3c727e0ef8..f03131fec41d 100644
--- a/arch/mips/netlogic/xlr/platform-flash.c
+++ b/arch/mips/netlogic/xlr/platform-flash.c
@@ -78,8 +78,6 @@ static struct platform_device xlr_nor_dev = {
 	.resource	= xlr_nor_res,
 };
 
-const char *xlr_part_probes[] = { "cmdlinepart", NULL };
-
 /*
  * Use "gen_nand" driver for NAND flash
  *
@@ -111,7 +109,6 @@ struct platform_nand_data xlr_nand_data = {
 		.nr_partitions	= ARRAY_SIZE(xlr_nand_parts),
 		.chip_delay	= 50,
 		.partitions	= xlr_nand_parts,
-		.part_probe_types = xlr_part_probes,
 	},
 	.ctrl = {
 		.cmd_ctrl	= xlr_nand_ctrl,
-- 
1.9.1
