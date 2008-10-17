Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2008 12:14:04 +0100 (BST)
Received: from cn.fujitsu.com ([222.73.24.84]:18651 "EHLO song.cn.fujitsu.com")
	by ftp.linux-mips.org with ESMTP id S21707404AbYJQLN7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2008 12:13:59 +0100
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 798211700BD;
	Fri, 17 Oct 2008 19:13:47 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id m9HBDjQM016135;
	Fri, 17 Oct 2008 19:13:45 +0800
Received: from [127.0.0.1] (unknown [10.167.141.121])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 03EEBD42AA;
	Fri, 17 Oct 2008 19:19:02 +0800 (CST)
Message-ID: <48F87323.6020303@cn.fujitsu.com>
Date:	Fri, 17 Oct 2008 19:12:35 +0800
From:	Zhaolei <zhaolei@cn.fujitsu.com>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix debugfs_create_*'s error checking method for mips/kernel/
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <zhaolei@cn.fujitsu.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhaolei@cn.fujitsu.com
Precedence: bulk
X-list: linux-mips

Hi, 

debugfs_create_*() returns NULL if an error occurs, returns -ENODEV
when debugfs is not enabled in the kernel.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 arch/mips/kernel/setup.c     |    4 ++--
 arch/mips/kernel/unaligned.c |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 16f8edf..4430a1f 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -601,8 +601,8 @@ static int __init debugfs_mips(void)
 	struct dentry *d;
 
 	d = debugfs_create_dir("mips", NULL);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
+	if (!d)
+		return -ENOMEM;
 	mips_debugfs_dir = d;
 	return 0;
 }
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index c327b21..2070966 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -560,12 +560,12 @@ static int __init debugfs_unaligned(void)
 		return -ENODEV;
 	d = debugfs_create_u32("unaligned_instructions", S_IRUGO,
 			       mips_debugfs_dir, &unaligned_instructions);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
+	if (!d)
+		return -ENOMEM;
 	d = debugfs_create_u32("unaligned_action", S_IRUGO | S_IWUSR,
 			       mips_debugfs_dir, &unaligned_action);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
+	if (!d)
+		return -ENOMEM;
 	return 0;
 }
 __initcall(debugfs_unaligned);
-- 
1.5.5.3
