Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 May 2013 16:48:23 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39202 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824769Ab3EIOsOXL6wS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 May 2013 16:48:14 +0200
Received: by mail-pa0-f50.google.com with SMTP id fb10so2145888pad.23
        for <multiple recipients>; Thu, 09 May 2013 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=4wocrIPDSxNbfSIDpjqo1TpUfg5qobs+70dXgUdqTlI=;
        b=mi+BsVjpsHlfaUuOtbA6CEkEcdFv+a6LVuW91MulrmtHut5QSnkViUmxFYkQVZOvEU
         ffC6TpbhUJQhvLfEa8Ocmh2E5FtEyD5lcZj2ct9EubL1ygbow5sqQXxZ7f6RgxItvMTs
         xaaq4LuX9zUbY7u+zWNAKdfNhDnBfer8mKyG4nQiJzp7mRAPk0YQBlAYcWpj5uIzU9wt
         3q1sQJCOi3iF24cOst2MBnmgdPmmMOrG0f6u9D4FNPR4xwKbrwWAOxm+150TS1yaugYV
         2Ni96Z8j9OWdGy6qvZWuAj8DtRgsvaLyi4pMYbX65Rz/sXfjXAQlh4pYcrrjulYgZjui
         IkIg==
X-Received: by 10.66.122.163 with SMTP id lt3mr3788018pab.219.1368110887601;
        Thu, 09 May 2013 07:48:07 -0700 (PDT)
Received: from hades (114-25-190-57.dynamic.hinet.net. [114.25.190.57])
        by mx.google.com with ESMTPSA id uv1sm3348755pbc.16.2013.05.09.07.48.02
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 May 2013 07:48:06 -0700 (PDT)
Date:   Thu, 9 May 2013 22:47:53 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: detect sibling call in get_frame_info
Message-ID: <20130509144753.GC3562@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36365
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

Given a function, get_frame_info() analyzes its instructions
to figure out frame size and return address. get_frame_info()
works as follows:

1. analyze up to 128 instructions if the function size is unknown
2. search for 'addiu/daddiu sp,sp,-immed' for frame size
3. search for 'sw ra,offset(sp)' for return address
4. end search when it sees jr/jal/jalr

This leads to an issue when the given function is a sibling
call, example given as follows.

801ca110 <schedule>:
801ca110:       8f820000        lw      v0,0(gp)
801ca114:       8c420000        lw      v0,0(v0)
801ca118:       080726f0        j       801c9bc0 <__schedule>
801ca11c:       00000000        nop

801ca120 <io_schedule>:
801ca120:       27bdffe8        addiu   sp,sp,-24
801ca124:       3c028022        lui     v0,0x8022
801ca128:       afbf0014        sw      ra,20(sp)

In this case, get_frame_info() cannot properly detect schedule's
frame info, and eventually returns io_schedule's info instead.

This patch adds sibling call check by detecting out of range jump.

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/kernel/process.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index cfc742d..a794eb5 100644
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
@@ -250,11 +253,25 @@ static inline int is_sp_move_ins(union mips_instruction *ip)
 	return 0;
 }
 
+static inline int is_sibling_j_ins(union mips_instruction *ip,
+				   unsigned long func_begin, unsigned long func_end)
+{
+	if (ip->j_format.opcode == j_op) {
+		unsigned long addr;
+
+		addr = J_TARGET(ip, ip->j_format.target);
+		if (addr < func_begin || addr > func_end)
+			return 1;
+	}
+	return 0;
+}
+
 static int get_frame_info(struct mips_frame_info *info)
 {
 	union mips_instruction *ip = info->func;
 	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
 	unsigned i;
+	unsigned long func_begin, func_end;
 
 	info->pc_offset = -1;
 	info->frame_size = 0;
@@ -266,10 +283,15 @@ static int get_frame_info(struct mips_frame_info *info)
 		max_insns = 128U;	/* unknown function size */
 	max_insns = min(128U, max_insns);
 
+	func_begin = (unsigned long) info->func;
+	func_end = func_begin + max_insns * sizeof(union mips_instruction);
+
 	for (i = 0; i < max_insns; i++, ip++) {
 
 		if (is_jal_jalr_jr_ins(ip))
 			break;
+		if (is_sibling_j_ins(ip, func_begin, func_end))
+			break;
 		if (!info->frame_size) {
 			if (is_sp_move_ins(ip))
 				info->frame_size = - ip->i_format.simmediate;
-- 
1.7.10.2 (Apple Git-33)
