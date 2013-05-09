Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 16:49:43 +0200 (CEST)
Received: from mail-pa0-f45.google.com ([209.85.220.45]:53736 "EHLO
        mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822996Ab3EIOtl45uCs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 16:49:41 +0200
Received: by mail-pa0-f45.google.com with SMTP id lj1so2167548pab.18
        for <multiple recipients>; Thu, 09 May 2013 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=owZYyZWW2jitAiwzcUYHbvYLikVBgwggO5iRnyb1FDU=;
        b=mqNSqnNUPQB+l5TKXu1Udl8lF2QkEogPk0UFZxZGLpIeGGrZq7OPFGj4DLT3UrIplq
         Zna4SZZCSKXMJ3OlaKOkYneQkLe9uDsHfK9g+OaYxGhGhr9ti0jVPDZ6aRpvB/7qwQWH
         NWiAaS/+KhtPOJ9nF5UQ7aZC6JzxMxq+esQXdMbRQ70dyougZRq6rKEP3+zJiT7H6UJS
         PzkmPWAJXpOAshDzIXn4pjheEIh2hnsjqn9cOXsRDWd0fyYhyRJNxwULn6RwqysLY7aZ
         V9Itf9nH48QLssEoHvVS4Go7H3/WXZhDP6vi1mDloeffBwNili/5lR37qRpq9e/IxVdg
         EdsQ==
X-Received: by 10.68.164.98 with SMTP id yp2mr12629728pbb.214.1368110974549;
        Thu, 09 May 2013 07:49:34 -0700 (PDT)
Received: from hades (114-25-190-57.dynamic.hinet.net. [114.25.190.57])
        by mx.google.com with ESMTPSA id lq5sm3942919pab.19.2013.05.09.07.49.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 May 2013 07:49:33 -0700 (PDT)
Date:   Thu, 9 May 2013 22:49:11 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 2/2] MIPS: get schedule_mfi info from __schedule
Message-ID: <20130509144911.GD3562@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

schedule_mfi is supposed to be extracted from schedule(), and
is used in thread_saved_pc and get_wchan.

But, after optimization, schedule() is reduced to a sibling
call to __schedule(), and no real frame info can be extracted.

One solution is to compile schedule() with -fno-omit-frame-pointer
and -fno-optimize-sibling-calls, but that will incur performance
degradation.

This patch follows the sibling call and extracts the
schedule_mfi from the __schedule with and without KALLSYMS enabled.

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/kernel/process.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index a794eb5..289ea69 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -314,15 +314,39 @@ err:
 
 static struct mips_frame_info schedule_mfi __read_mostly;
 
+static unsigned long get___schedule_addr(void)
+{
+#ifdef CONFIG_KALLSYMS
+	return kallsyms_lookup_name("__schedule");
+#else
+	union mips_instruction *ip = (void *)schedule;
+	int max_insns = 8;
+	int i;
+
+	for (i = 0; i < max_insns; i++, ip++) {
+		if (ip->j_format.opcode == j_op)
+			return J_TARGET(ip, ip->j_format.target);
+	}
+	return 0;
+#endif
+}
+
 static int __init frame_info_init(void)
 {
 	unsigned long size = 0;
 #ifdef CONFIG_KALLSYMS
 	unsigned long ofs;
+#endif
+	unsigned long addr;
+
+	addr = get___schedule_addr();
+	if (!addr)
+		addr = (unsigned long)schedule;
 
-	kallsyms_lookup_size_offset((unsigned long)schedule, &size, &ofs);
+#ifdef CONFIG_KALLSYMS
+	kallsyms_lookup_size_offset(addr, &size, &ofs);
 #endif
-	schedule_mfi.func = schedule;
+	schedule_mfi.func = (void *)addr;
 	schedule_mfi.func_size = size;
 
 	get_frame_info(&schedule_mfi);
-- 
1.7.10.2 (Apple Git-33)
