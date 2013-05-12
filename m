Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 May 2013 18:05:51 +0200 (CEST)
Received: from mail-da0-f41.google.com ([209.85.210.41]:51072 "EHLO
        mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822679Ab3ELQFqffgVB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 May 2013 18:05:46 +0200
Received: by mail-da0-f41.google.com with SMTP id y19so3162634dan.0
        for <multiple recipients>; Sun, 12 May 2013 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=r86Fb2tHfFEX/9bhXzt5A3PYLjcCIrdfX26+XhcNQPw=;
        b=WQFNRkqPB2eHNtoqUX8XM7fQrM7oFw1nlryXNtqDtHOAuZ6XeKbWqaZhcGQFYjICjo
         zn0BDvXt3DMQz2MzCxCs4dZ+qunxOJFhbxfLMgZNPNFOH+A9kdltOd5V1cnKcPQL/7bi
         fuQAH7fuKNvJyfg8bJwbf2jyxT/WmsQkRMqruCCbPQ7ThA12YdnfRn6dItOOMnh+s6N2
         lXYSRyj1PJBNGQxbXacujoU+GnHGCt20sM8Vb77vV3I9Q5VPyw18MZhGYI8FZd8nlDGn
         zZSteXKNGLPp8Rv3pihrghUrhd3sVz/SiMCvKMh0fk8KUD+LCISKW32R7cwTgF+8qfRR
         Sc2g==
X-Received: by 10.68.1.34 with SMTP id 2mr25517108pbj.3.1368374739852;
        Sun, 12 May 2013 09:05:39 -0700 (PDT)
Received: from hades (1-169-142-186.dynamic.hinet.net. [1.169.142.186])
        by mx.google.com with ESMTPSA id bl3sm10578594pbd.12.2013.05.12.09.05.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 09:05:39 -0700 (PDT)
Date:   Mon, 13 May 2013 00:05:34 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH v3 2/2] MIPS: extract schedule_mfi info from __schedule
Message-ID: <20130512160534.GB982@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36387
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

This patch reads the __schedule address by either following
the 'j' call in schedule if KALLSYMS is disabled or by using
kallsyms_lookup_name to lookup __schedule if KALLSYMS is
available, then, extracts schedule_mfi from __schedule frame info.

This patch also fixes the "Can't analyze schedule() prologue"
warning at boot time.

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/kernel/process.c |   34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index d66b04d..b216157 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -223,6 +223,9 @@ struct mips_frame_info {
 	int		pc_offset;
 };
 
+#define J_TARGET(pc,target)	\
+		(((unsigned long)(pc) & 0xf0000000) | ((target) << 2))
+
 static inline int is_ra_save_ins(union mips_instruction *ip)
 {
 	/* sw / sd $ra, offset($sp) */
@@ -294,15 +297,42 @@ err:
 
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
