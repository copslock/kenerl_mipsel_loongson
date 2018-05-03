Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 May 2018 13:45:25 +0200 (CEST)
Received: from mga03.intel.com ([134.134.136.65]:47647 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991485AbeECLpSkOgoE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 May 2018 13:45:18 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2018 04:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400"; 
   d="scan'208";a="38126224"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 03 May 2018 04:45:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4888CF1; Thu,  3 May 2018 14:45:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MIPS: Re-use kstrtobool_from_user()
Date:   Thu,  3 May 2018 14:45:11 +0300
Message-Id: <20180503114511.29969-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Return-Path: <andriy.shevchenko@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andriy.shevchenko@linux.intel.com
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

Re-use kstrtobool_from_user() instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/mips/mm/sc-debugfs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/mips/mm/sc-debugfs.c b/arch/mips/mm/sc-debugfs.c
index 2e2132d3f5c7..2a116084216f 100644
--- a/arch/mips/mm/sc-debugfs.c
+++ b/arch/mips/mm/sc-debugfs.c
@@ -31,17 +31,10 @@ static ssize_t sc_prefetch_write(struct file *file,
 				 const char __user *user_buf,
 				 size_t count, loff_t *ppos)
 {
-	char buf[32];
-	ssize_t buf_size;
 	bool enabled;
 	int err;
 
-	buf_size = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] = '\0';
-	err = strtobool(buf, &enabled);
+	err = kstrtobool_from_user(user_buf, count, &enabled);
 	if (err)
 		return err;
 
-- 
2.17.0
