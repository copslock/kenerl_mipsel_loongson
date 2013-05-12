Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 May 2013 18:04:44 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34874 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822679Ab3ELQEmkeVXk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 May 2013 18:04:42 +0200
Received: by mail-pa0-f47.google.com with SMTP id kl13so4028691pab.20
        for <multiple recipients>; Sun, 12 May 2013 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=On+WnFxDgn79/IeTgSNcAjmHiQXN1R99VixZuV9dNKY=;
        b=Ua2OJ/u4oFmnDo4fk1L6igy5xdmCrr1TKWq9mqG8DYpx6D86XxWbBcvxeqB54Ve65L
         OOFFzoKOio/bQRgILqmgb7Oyr6jQMp77dy/rE3CIA3TVQd9HyTQCU+7XzBIJib978xma
         uEkbZ00D9E2cpe62iwHv0STD2vSZTShHrCmdEP/vfDQcA2iY/ZaCB685+FRs3L6dD0su
         kxS4/02wj+EicLXB94Die9huGydhSii6BWPzjMLQaaWibQ5WiCHlm0tUm+GvhnOSFG2o
         O2oNBeKDbAfmXe+TXvfzS6OCmKaBtY/GL5S1cCiWmXqJaGl/heGPXyfkr05C685lN8zq
         +MxA==
X-Received: by 10.68.172.97 with SMTP id bb1mr25008621pbc.198.1368374675943;
        Sun, 12 May 2013 09:04:35 -0700 (PDT)
Received: from hades (1-169-142-186.dynamic.hinet.net. [1.169.142.186])
        by mx.google.com with ESMTPSA id vv6sm11304580pab.6.2013.05.12.09.04.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 May 2013 09:04:35 -0700 (PDT)
Date:   Mon, 13 May 2013 00:04:29 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH v3 1/2] MIPS: fix sibling call handling in get_frame_info
Message-ID: <20130512160429.GA982@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36386
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
call, example shown as follows.

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
frame info, and eventually returns io_schedule's instead.

This patch adds 'j' to the end search condition to workaround
sibling call cases.

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/kernel/process.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index cfc742d..d66b04d 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -231,8 +231,10 @@ static inline int is_ra_save_ins(union mips_instruction *ip)
 		ip->i_format.rt == 31;
 }
 
-static inline int is_jal_jalr_jr_ins(union mips_instruction *ip)
+static inline int is_jump_ins(union mips_instruction *ip)
 {
+	if (ip->j_format.opcode == j_op)
+		return 1;
 	if (ip->j_format.opcode == jal_op)
 		return 1;
 	if (ip->r_format.opcode != spec_op)
@@ -268,7 +270,7 @@ static int get_frame_info(struct mips_frame_info *info)
 
 	for (i = 0; i < max_insns; i++, ip++) {
 
-		if (is_jal_jalr_jr_ins(ip))
+		if (is_jump_ins(ip))
 			break;
 		if (!info->frame_size) {
 			if (is_sp_move_ins(ip))
-- 
1.7.10.2 (Apple Git-33)
