Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2008 12:14:24 +0100 (BST)
Received: from cn.fujitsu.com ([222.73.24.84]:4589 "EHLO song.cn.fujitsu.com")
	by ftp.linux-mips.org with ESMTP id S21707405AbYJQLN7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2008 12:13:59 +0100
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id EB7E117008D;
	Fri, 17 Oct 2008 19:13:44 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id m9HBDgVW016132;
	Fri, 17 Oct 2008 19:13:42 +0800
Received: from [127.0.0.1] (unknown [10.167.141.121])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 35D05D42B9;
	Fri, 17 Oct 2008 19:18:59 +0800 (CST)
Message-ID: <48F8731E.40100@cn.fujitsu.com>
Date:	Fri, 17 Oct 2008 19:12:30 +0800
From:	Zhaolei <zhaolei@cn.fujitsu.com>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	linux-mips@linux-mips.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix debugfs_create_*'s error checking method for mips/math-emu/
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-Path: <zhaolei@cn.fujitsu.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20779
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
 arch/mips/math-emu/cp1emu.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index b08fc65..7ec0b21 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1299,12 +1299,12 @@ static int __init debugfs_fpuemu(void)
 	if (!mips_debugfs_dir)
 		return -ENODEV;
 	dir = debugfs_create_dir("fpuemustats", mips_debugfs_dir);
-	if (IS_ERR(dir))
-		return PTR_ERR(dir);
+	if (!dir)
+		return -ENOMEM;
 	for (i = 0; i < ARRAY_SIZE(vars); i++) {
 		d = debugfs_create_u32(vars[i].name, S_IRUGO, dir, vars[i].v);
-		if (IS_ERR(d))
-			return PTR_ERR(d);
+		if (!d)
+			return -ENOMEM;
 	}
 	return 0;
 }
-- 
1.5.5.3
