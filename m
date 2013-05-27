Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 13:02:54 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43486 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823668Ab3E0LCsLB0w8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 13:02:48 +0200
Received: by mail-pa0-f51.google.com with SMTP id lf10so5722806pab.38
        for <multiple recipients>; Mon, 27 May 2013 04:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Pd/K9jDEwiJoKipJbeShTJkg7xu+JiznfteOh1AAAhc=;
        b=QrH8OiOkNBsT+K+JLf8SnE88xDCUUcawxgJrlRQ5Atb3R2fbodRnDwg9wGx3pc9NVV
         uA34zLEDyqgUaLxaaDdEfrvfKCiwwtQ89esP2kRBAfdYc5EQeMkSqrzbD6fuWBvFozAU
         rSpC3/XQru3eWX4+mSTkPy0AQJ8nnbSwfFL89g8RAlMcsPv6VSV5J3z24yhbuph/CC5E
         6eVs9wQIWQbYIx1Ymd71QUjUA6uKV7SKZ1rXzlr4EWiKNjVHK1dQKG0+1SqzLt5wG4p6
         icVM/5RwHAfCw1oBdQXeBkI5KjAALnlYeqSZ/NJqBN/l3CwbDboI0jGyT7KqbUd1eSi3
         grAA==
X-Received: by 10.68.20.193 with SMTP id p1mr29150936pbe.218.1369652561246;
        Mon, 27 May 2013 04:02:41 -0700 (PDT)
Received: from hades (111-243-158-188.dynamic.hinet.net. [111.243.158.188])
        by mx.google.com with ESMTPSA id ra4sm30219558pab.9.2013.05.27.04.02.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 04:02:40 -0700 (PDT)
Date:   Mon, 27 May 2013 19:02:35 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org, Steven.Hill@imgtec.com, macro@linux-mips.org,
        david.daney@cavium.com, linux-mips@linux-mips.org
Subject: [PATCH v3 3/3] MIPS: microMIPS: Refactor get_frame_info support
Message-ID: <20130527110235.GD31548@hades>
References: <20130527105810.GA31548@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130527105810.GA31548@hades>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36610
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

Current get_frame_info implementation works on word boundary, this
can lead to alignment and endian issues in microMIPS mode,
due to:

1. microMIPS instructions are sequence of halfwords
2. microMIPS instructions can be one or two halfwords
3. microMIPS instructions are placed in 32-bit memory element,
   in endian-dependent order.

Example:
    insn1 = one halfword  => word1, hword[0]
    insn2 = two halfwords => word1, hword[1], word2, hword[0]
    insn3 = one halfword  => word2, hword[1]

       Big Endian
            hword[0]     hword[1]      hword[0]     hword[1]
       +-------------+-------------+-------------+-------------+
       |    insn1    |    insn2    |    insn2'   |    insn3    |
       +-------------+-------------+-------------+-------------+
       31          word1          0 31         word2           0

       Little Endian
            hword[1]     hword[0]      hword[1]     hword[0]
       +-------------+-------------+-------------+-------------+
       |    insn2    |    insn1    |    insn3    |    insn2'   |
       +-------------+-------------+-------------+-------------+
       31          word1          0 31         word2           0

This patch refactors microMIPS get_frame_info by implementing
fetch_instruction() to fetch words on word boundary, and
mmips_fetch_halfword() to assemble one or two halfwords into
microMIPS instructions for further processing.

This patch also fixes sibling call handling and schedule_mfi
initialization for microMIPS.

Signed-off-by: Tony Wu <tung7970@gmail.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/kernel/process.c |  341 +++++++++++++++++++++++++++-----------------
 1 file changed, 211 insertions(+), 130 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index c6a041d..5c1a960 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -211,124 +211,201 @@ struct mips_frame_info {
 	int		pc_offset;
 };
 
-#define J_TARGET(pc,target)	\
-		(((unsigned long)(pc) & 0xf0000000) | ((target) << 2))
-
 static inline int is_ra_save_ins(union mips_instruction *ip)
 {
-#ifdef CONFIG_CPU_MICROMIPS
-	union mips_instruction mmi;
-
-	/*
-	 * swsp ra,offset
-	 * swm16 reglist,offset(sp)
-	 * swm32 reglist,offset(sp)
-	 * sw32 ra,offset(sp)
-	 * jradiussp - NOT SUPPORTED
-	 *
-	 * microMIPS is way more fun...
-	 */
-	if (mm_insn_16bit(ip->halfword[0])) {
-		mmi.word = (ip->halfword[0] << 16);
-		return ((mmi.mm16_r5_format.opcode == mm_swsp16_op &&
-			 mmi.mm16_r5_format.rt == 31) ||
-			(mmi.mm16_m_format.opcode == mm_pool16c_op &&
-			 mmi.mm16_m_format.func == mm_swm16_op));
-	}
-	else {
-		mmi.halfword[0] = ip->halfword[1];
-		mmi.halfword[1] = ip->halfword[0];
-		return ((mmi.mm_m_format.opcode == mm_pool32b_op &&
-			 mmi.mm_m_format.rd > 9 &&
-			 mmi.mm_m_format.base == 29 &&
-			 mmi.mm_m_format.func == mm_swm32_func) ||
-			(mmi.i_format.opcode == mm_sw32_op &&
-			 mmi.i_format.rs == 29 &&
-			 mmi.i_format.rt == 31));
+	if (kernel_uses_mmips) {
+		/*
+		 * swsp ra,offset
+		 * swm16 reglist,offset(sp)
+		 * swm32 reglist,offset(sp)
+		 * sw32 ra,offset(sp)
+		 *
+		 * microMIPS is way more fun...
+		 */
+		return ((ip->mm16_r5_format.opcode == mm_swsp16_op &&
+			 ip->mm16_r5_format.rt == 31) ||
+			(ip->mm16_m_format.opcode == mm_pool16c_op &&
+			 ip->mm16_m_format.func == mm_swm16_op) ||
+			/* two-halfword instructions */
+			(ip->mm_m_format.opcode == mm_pool32b_op &&
+			 ip->mm_m_format.rd >= 16 &&
+			 ip->mm_m_format.base == 29 &&
+			 ip->mm_m_format.func == mm_swm32_func) ||
+			(ip->mm_i_format.opcode == mm_sw32_op &&
+			 ip->mm_i_format.rs == 29 &&
+			 ip->mm_i_format.rt == 31));
+	} else {
+		/* sw / sd $ra, offset($sp) */
+		return (ip->i_format.opcode == sw_op ||
+			ip->i_format.opcode == sd_op) &&
+			ip->i_format.rs == 29 &&
+			ip->i_format.rt == 31;
 	}
-#else
-	/* sw / sd $ra, offset($sp) */
-	return (ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op) &&
-		ip->i_format.rs == 29 &&
-		ip->i_format.rt == 31;
-#endif
 }
 
 static inline int is_jump_ins(union mips_instruction *ip)
 {
-#ifdef CONFIG_CPU_MICROMIPS
-	/*
-	 * jr16,jrc,jalr16,jalr16
-	 * jal
-	 * jalr/jr,jalr.hb/jr.hb,jalrs,jalrs.hb
-	 * jraddiusp - NOT SUPPORTED
-	 *
-	 * microMIPS is kind of more fun...
-	 */
-	union mips_instruction mmi;
-
-	mmi.word = (ip->halfword[0] << 16);
-
-	if ((mmi.mm16_r5_format.opcode == mm_pool16c_op &&
-	    (mmi.mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op) ||
-	    ip->j_format.opcode == mm_jal32_op)
-		return 1;
-	if (ip->r_format.opcode != mm_pool32a_op ||
-			ip->r_format.func != mm_pool32axf_op)
-		return 0;
-	return (((ip->u_format.uimmediate >> 6) & mm_jalr_op) == mm_jalr_op);
-#else
-	if (ip->j_format.opcode == j_op)
-		return 1;
-	if (ip->j_format.opcode == jal_op)
-		return 1;
-	if (ip->r_format.opcode != spec_op)
-		return 0;
-	return ip->r_format.func == jalr_op || ip->r_format.func == jr_op;
-#endif
+	if (kernel_uses_mmips) {
+		/*
+		 * jr16,jrc,jalr16,jalr16
+		 * jal
+		 * jalr/jr,jalr.hb/jr.hb,jalrs,jalrs.hb
+		 * jraddiusp
+		 *
+		 * microMIPS is kind of more fun...
+		 */
+		return ((ip->mm16_r5_format.opcode == mm_pool16c_op &&
+			 ((ip->mm16_r5_format.rt & ~0x3) == mm_jr16_op ||
+			  ip->mm16_r5_format.rt == mm_jraddiusp_op)) ||
+			/* two-halfword instructions */
+			ip->j_format.opcode == mm_jal32_op ||
+			ip->j_format.opcode == mm_jals32_op ||
+			ip->j_format.opcode == mm_j32_op ||
+			(ip->r_format.opcode == mm_pool32a_op &&
+			 ip->r_format.func == mm_pool32axf_op &&
+			 ((ip->u_format.uimmediate >> 6) & ~0x140) ==
+					mm_jalr_op));
+	} else {
+		return (ip->j_format.opcode == j_op ||
+			ip->j_format.opcode == jal_op ||
+			(ip->r_format.opcode == spec_op &&
+			 (ip->r_format.func == jalr_op ||
+			  ip->r_format.func == jr_op)));
+	}
 }
 
 static inline int is_sp_move_ins(union mips_instruction *ip)
 {
-#ifdef CONFIG_CPU_MICROMIPS
-	/*
-	 * addiusp -imm
-	 * addius5 sp,-imm
-	 * addiu32 sp,sp,-imm
-	 * jradiussp - NOT SUPPORTED
-	 *
-	 * microMIPS is not more fun...
-	 */
-	if (mm_insn_16bit(ip->halfword[0])) {
-		union mips_instruction mmi;
-
-		mmi.word = (ip->halfword[0] << 16);
-		return ((mmi.mm16_r3_format.opcode == mm_pool16d_op &&
-			 mmi.mm16_r3_format.simmediate && mm_addiusp_func) ||
-			(mmi.mm16_r5_format.opcode == mm_pool16d_op &&
-			 mmi.mm16_r5_format.rt == 29));
+	if (kernel_uses_mmips) {
+		/*
+		 * addiusp -imm
+		 * addius5 sp,-imm
+		 * addiu32 sp,sp,-imm
+		 *
+		 * microMIPS is not more fun...
+		 */
+		return ((ip->mm16_r5_format.opcode == mm_pool16d_op &&
+			 (ip->mm16_r5_format.simmediate & mm_addiusp_func ||
+			  ip->mm16_r5_format.rt == 29)) ||
+			/* two-halfword instructions */
+			(ip->mm_i_format.opcode == mm_addiu32_op &&
+			 ip->mm_i_format.rt == 29 &&
+			 ip->mm_i_format.rs == 29));
+	} else {
+		/* addiu/daddiu sp,sp,-imm */
+		return (ip->i_format.rs == 29 &&
+			ip->i_format.rt == 29 &&
+			(ip->i_format.opcode == addiu_op ||
+			 ip->i_format.opcode == daddiu_op));
 	}
-	return (ip->mm_i_format.opcode == mm_addiu32_op &&
-		 ip->mm_i_format.rt == 29 && ip->mm_i_format.rs == 29);
-#else
-	/* addiu/daddiu sp,sp,-imm */
-	if (ip->i_format.rs != 29 || ip->i_format.rt != 29)
-		return 0;
-	if (ip->i_format.opcode == addiu_op || ip->i_format.opcode == daddiu_op)
-		return 1;
-#endif
 	return 0;
 }
 
+/*
+ * A few fun facts on microMIPS (MIPS32)
+ *
+ * 1. microMIPS instructions are sequence of halfwords
+ * 2. microMIPS instructions may contain one to two halfwords
+ * 3. microMIPS instructions are placed in 32-bit memory element,
+ *    in endian-dependent order.
+ *
+ * Example:
+ *  insn1 = one halfword  => word1, hword[0]
+ *  insn2 = two halfwords => word1, hword[1], word2, hword[0]
+ *  insn3 = one halfword  => word2, hword[1]
+ *
+ * Big Endian
+ *      hword[0]     hword[1]      hword[0]     hword[1]
+ * +-------------+-------------+-------------+-------------+
+ * |    insn1    |    insn2    |    insn2'   |    insn3    |
+ * +-------------+-------------+-------------+-------------+
+ * 31          word1          0 31         word2           0
+ *
+ * Little Endian
+ *      hword[1]     hword[0]      hword[1]     hword[0]
+ * +-------------+-------------+-------------+-------------+
+ * |    insn2    |    insn1    |    insn3    |    insn2'   |
+ * +-------------+-------------+-------------+-------------+
+ * 31          word1         0 31          word2           0
+ *
+ * mmips_fetch_halfword does the followings:
+ *
+ * 1. fetch word from word-aligned address
+ * 2. access the fetched word using halfword (defeat endian issue)
+ * 3. assemble microMIPS instruction with one or two halfwords
+ */
+static void mmips_fetch_halfword(union mips_instruction **ip,
+				 unsigned short *this_halfword,
+				 unsigned short *prev_halfword)
+{
+	if (*prev_halfword) {
+		*this_halfword = *prev_halfword;
+		*prev_halfword = 0;
+	} else {
+		/* advance pointer to next word */
+		*this_halfword = (*ip)->halfword[0];
+		*prev_halfword = (*ip)->halfword[1];
+		*ip += 1;
+	}
+}
+
+static void fetch_instruction(union mips_instruction **ip,
+			      union mips_instruction *mi,
+			      unsigned short *prev_halfword)
+{
+	if (kernel_uses_mmips) {
+		/* fetch the first microMIPS instruction */
+		mmips_fetch_halfword(ip, &mi->halfword[0], prev_halfword);
+
+		/* fetch the second half if it is a 32bit one */
+		if (mm_insn_16bit(mi->halfword[0]))
+			mi->halfword[1] = 0;
+		else
+			mmips_fetch_halfword(ip, &mi->halfword[1],
+					     prev_halfword);
+	} else {
+		/* do simple assignment for mips32 mode */
+		*mi = **ip;
+		*ip += 1;
+	}
+}
+
+static int get_frame_size(union mips_instruction *ip)
+{
+	unsigned short tmp;
+	int size = 0;
+
+	if (kernel_uses_mmips &&
+	    mm_insn_16bit(ip->halfword[0])) {
+		/*
+		 * addiusp -imm
+		 * addius5 sp,-imm
+		 */
+		if (ip->halfword[0] & mm_addiusp_func) {
+			tmp = (((ip->halfword[0] >> 1) & 0x1ff) << 2);
+			size = -(signed short)(tmp |
+					       ((tmp & 0x100) ? 0xfe00 : 0));
+		} else {
+			tmp = (ip->halfword[0] >> 1);
+			size = -(signed short)(tmp & 0xf);
+		}
+	} else {
+		/*
+		 * addiu32 sp,sp,-imm
+		 * addiu/daddiu sp,sp,-imm
+		 */
+		size = - ip->i_format.simmediate;
+	}
+
+	return size;
+}
+
 static int get_frame_info(struct mips_frame_info *info)
 {
-#ifdef CONFIG_CPU_MICROMIPS
-	union mips_instruction *ip = (void *) (((char *) info->func) - 1);
-#else
 	union mips_instruction *ip = info->func;
-#endif
+	union mips_instruction inst, *max_ip;
 	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
-	unsigned i;
+	unsigned short halfword = 0;
 
 	info->pc_offset = -1;
 	info->frame_size = 0;
@@ -340,37 +417,25 @@ static int get_frame_info(struct mips_frame_info *info)
 		max_insns = 128U;	/* unknown function size */
 	max_insns = min(128U, max_insns);
 
-	for (i = 0; i < max_insns; i++, ip++) {
+	if (kernel_uses_mmips) {
+		/* align start address to word boundary, lose mode bit. */
+		ip = (union mips_instruction *)((unsigned long)ip & ~0x3);
+	}
+	max_ip = ip + max_insns * sizeof(union mips_instruction);
 
-		if (is_jump_ins(ip))
+	while (ip < max_ip) {
+		fetch_instruction(&ip, &inst, &halfword);
+
+		if (is_jump_ins(&inst))
 			break;
 		if (!info->frame_size) {
-			if (is_sp_move_ins(ip))
-			{
-#ifdef CONFIG_CPU_MICROMIPS
-				if (mm_insn_16bit(ip->halfword[0]))
-				{
-					unsigned short tmp;
-
-					if (ip->halfword[0] & mm_addiusp_func)
-					{
-						tmp = (((ip->halfword[0] >> 1) & 0x1ff) << 2);
-						info->frame_size = -(signed short)(tmp | ((tmp & 0x100) ? 0xfe00 : 0));
-					} else {
-						tmp = (ip->halfword[0] >> 1);
-						info->frame_size = -(signed short)(tmp & 0xf);
-					}
-					ip = (void *) &ip->halfword[1];
-					ip--;
-				} else
-#endif
-				info->frame_size = - ip->i_format.simmediate;
-			}
+			if (is_sp_move_ins(&inst))
+				info->frame_size = get_frame_size(&inst);
 			continue;
 		}
-		if (info->pc_offset == -1 && is_ra_save_ins(ip)) {
+		if (info->pc_offset == -1 && is_ra_save_ins(&inst)) {
 			info->pc_offset =
-				ip->i_format.simmediate / sizeof(long);
+				inst.i_format.simmediate / sizeof(long);
 			break;
 		}
 	}
@@ -390,20 +455,36 @@ static unsigned long get___schedule_addr(void)
 {
 	return kallsyms_lookup_name("__schedule");
 }
-#else
+#else /* CONFIG_KALLSYMS */
 static unsigned long get___schedule_addr(void)
 {
 	union mips_instruction *ip = (void *)schedule;
+	union mips_instruction inst;
+	union mips_instruction *max_ip;
 	int max_insns = 8;
-	int i;
+	unsigned short halfword = 0;
 
-	for (i = 0; i < max_insns; i++, ip++) {
-		if (ip->j_format.opcode == j_op)
-			return J_TARGET(ip, ip->j_format.target);
+	if (kernel_uses_mmips) {
+		/* align start address to word boundary, lose mode bit */
+		ip = (union mips_instruction *)((unsigned long)ip & ~0x3);
+	}
+	max_ip = ip + max_insns * sizeof(union mips_instruction);
+
+	while (ip < max_ip) {
+		fetch_instruction(&ip, &inst, &halfword);
+		if (kernel_uses_mmips) {
+			if (inst.j_format.opcode == mm_j32_op)
+				return (((unsigned long)(ip+1) & 0xf8000000) |
+					(inst.j_format.target << 1));
+		} else {
+			if (inst.j_format.opcode == j_op)
+				return (((unsigned long)(ip) & 0xf0000000) |
+					(inst.j_format.target << 2));
+		}
 	}
 	return 0;
 }
-#endif
+#endif /* !CONFIG_KALLSYMS */
 
 static int __init frame_info_init(void)
 {
-- 
1.7.10.2 (Apple Git-33)
