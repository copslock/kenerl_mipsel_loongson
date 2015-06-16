Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jun 2015 20:50:11 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:52009 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008828AbbFPSuJ7Ducl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jun 2015 20:50:09 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t5GIo2Wc020611
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 16 Jun 2015 11:50:02 -0700 (PDT)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.224.2; Tue, 16 Jun 2015 11:50:02 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH v2] MIPS: don't use module_init in non-modular cobalt/mtd.c file
Date:   Tue, 16 Jun 2015 14:49:46 -0400
Message-ID: <1434480586-18799-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1434406281-32168-1-git-send-email-paul.gortmaker@windriver.com>
References: <1434406281-32168-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

As of commit 34b1252bd91851f77f89fbb6829a04efad900f41 ("MIPS:
Cobalt: Do not build MTD platform device registration code as module.")
this file became built-in instead of modular.  So we should also
stop using module_init as an alias for __initcall as that can be
rather misleading.

Fix this up now, so that we can relocate module_init from
init.h into module.h in the future.  If we don't do this, we'd
have to add module.h to obviously non-modular code, and that
would be a worse thing.

Direct use of __initcall is discouraged, vs prioritized ones.
Use of device_initcall is consistent with what __initcall
maps onto, and hence does not change the init order, making the
impact of this change zero.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[
 v2: rebase from rc6 to rc8 so 34b1252 is present, and that changes
 the patch from being an implicit module.h user to a misleading
 module_init() user.

 To be appended to the branch content originally sent as:
 "Replace module_init with device_initcall in non modules"
 https://lkml.kernel.org/r/1432860493-23831-1-git-send-email-paul.gortmaker@windriver.com
]

 arch/mips/cobalt/mtd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/cobalt/mtd.c b/arch/mips/cobalt/mtd.c
index 8db7b5d81560..83e1b1093d5f 100644
--- a/arch/mips/cobalt/mtd.c
+++ b/arch/mips/cobalt/mtd.c
@@ -57,5 +57,4 @@ static int __init cobalt_mtd_init(void)
 
 	return 0;
 }
-
-module_init(cobalt_mtd_init);
+device_initcall(cobalt_mtd_init);
-- 
2.2.1
