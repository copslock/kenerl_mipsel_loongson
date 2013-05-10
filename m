Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 May 2013 13:15:10 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:50664 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816354Ab3EJLLiFGogf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 May 2013 13:11:38 +0200
Received: by mail-pd0-f174.google.com with SMTP id u10so2702325pdi.5
        for <multiple recipients>; Fri, 10 May 2013 04:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=utaJ8+PGiD6g+f6LF4yLuqqkdHXujMsR+q9a6PDYg4k=;
        b=zYTQOBorKXg+1Km4lSkEaow0bewCLBpAxkTdeJtoh0RdZMY/wKfMsF411tofQzh4Bb
         OcSQmxv0Mv4+q3mAghnLC35haCBdRkFqjcFWBZym/GATSaCYs2mj86bC64gFwH5Rs1cp
         aT/pxtL5FTs3sCYpUWKMfJhikYU9cFzK67CFDxgab1jVgAo/fguT9M6/GbmfguXNn1b8
         qqsawt+sonXoivPLC2Kpq4uXzJRE10pIa0vcQanp5T+XHYXwlr0M5wzDqAHY7hcWTH0n
         H/OzFxVVOdym/JgjK0cBbvRlfto3q44fbKDmZqXAAWbxjLl9hUnN77v6yPqjK/HpFKro
         684g==
X-Received: by 10.68.36.197 with SMTP id s5mr16934683pbj.23.1368184161164;
        Fri, 10 May 2013 04:09:21 -0700 (PDT)
Received: from hades (1-169-131-150.dynamic.hinet.net. [1.169.131.150])
        by mx.google.com with ESMTPSA id do4sm2338612pbc.8.2013.05.10.04.09.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 04:09:20 -0700 (PDT)
Date:   Fri, 10 May 2013 19:09:15 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH v2 2/2] MIPS: get schedule_mfi info from __schedule
Message-ID: <20130510110915.GB7499@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36378
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

Another solution is to extract info from the real scheduler,
__schedule, and this is the approache adopted here.

This patch follows the sibling call and extracts the schedule_mfi
from the __schedule with and without KALLSYMS enabled. It also fixes
the "Can't analyze schedule() prologue" warning at boot time.

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/kernel/process.c |   31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index a794eb5..a01b523 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -314,15 +314,42 @@ err:
 
 static struct mips_frame_info schedule_mfi __read_mostly;
 
+#ifdef CONFIG_KALLSYMS
+static unsigned long get___schedule_addr(void)
+{
+	return kallsyms_lookup_name("__schedule");
+}
+#else
+static unsigned long get___schedule_addr(void)
+{
+	union mips_instruction *ip = (void *)schedule;
+	int max_insns = 8;
+	int i;
+
+	for (i = 0; i < max_insns; i++, ip++) {
+		if (ip->j_format.opcode == j_op)
+			return J_TARGET(ip, ip->j_format.target);
+	}
+	return 0;
+}
+#endif
+
 static int __init frame_info_init(void)
 {
 	unsigned long size = 0;
 #ifdef CONFIG_KALLSYMS
 	unsigned long ofs;
+#endif
+	unsigned long addr;
 
-	kallsyms_lookup_size_offset((unsigned long)schedule, &size, &ofs);
+	addr = get___schedule_addr();
+	if (!addr)
+		addr = (unsigned long)schedule;
+
+#ifdef CONFIG_KALLSYMS
+	kallsyms_lookup_size_offset(addr, &size, &ofs);
 #endif
-	schedule_mfi.func = schedule;
+	schedule_mfi.func = (void *)addr;
 	schedule_mfi.func_size = size;
 
 	get_frame_info(&schedule_mfi);
-- 
1.7.10.2 (Apple Git-33)
