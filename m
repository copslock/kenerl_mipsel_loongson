Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 21:35:17 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.189]:36083 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20022194AbXJIUfH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 21:35:07 +0100
Received: by nf-out-0910.google.com with SMTP id c10so1327345nfd
        for <linux-mips@linux-mips.org>; Tue, 09 Oct 2007 13:34:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=IK3KMqki2pK2uKp/1qvU7CvvR5hAco/Ou9PAFH6gX6E=;
        b=QhT1rEvW2I4uDtGJw3yeVMQ8hhVUHw9J7prUv8TKnHg4obuMDN14uDLjGjoCaYN03SlcaY2INIbehyVoE8hpgpF6tyrgwpPzmfswvtKI3KEFX4TZnvttFEsmcmLkUX7226mNgYJVAt2x5SrN377UvDO1XHfZMY4zDV7xUpbT6tE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=dp+aSxgfxZJcvz1A/Krk+gmrCv8boaXKeb8sUdFtnho+QEokeKe2GCH/s70U2cVuQm/tc04bL3jk3sy2PS6u8ZK5O1Pcade8fsXJHzQBiluuhhbgiNJuHBsD+QkBHYxU/2u1vQ1NrmSBYFPl41yFzMuR7getP4234Ler29/mVaU=
Received: by 10.86.70.8 with SMTP id s8mr6302986fga.1191962089502;
        Tue, 09 Oct 2007 13:34:49 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e32sm14347464fke.2007.10.09.13.34.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Oct 2007 13:34:44 -0700 (PDT)
Message-ID: <470BE5D2.50101@gmail.com>
Date:	Tue, 09 Oct 2007 22:34:26 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Franck Bui-Huu <fbuihuu@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: [PATCH 1/6] tlbex.c: Cleanup __init usages.  
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com>
In-Reply-To: <470BE58A.9070709@gmail.com>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/tlbex.c |   96 +++++++++++++++++++++++++-------------------------
 1 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index a61246d..01b0961 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -66,7 +66,7 @@ static inline int __maybe_unused r10000_llsc_war(void)
  * why; it's not an issue caused by the core RTL.
  *
  */
-static __init int __attribute__((unused)) m4kc_tlbp_war(void)
+static int __init m4kc_tlbp_war(void)
 {
 	return (current_cpu_data.processor_id & 0xffff00) ==
 	       (PRID_COMP_MIPS | PRID_IMP_4KC);
@@ -140,7 +140,7 @@ struct insn {
 	 | (e) << RE_SH						\
 	 | (f) << FUNC_SH)
 
-static __initdata struct insn insn_table[] = {
+static struct insn insn_table[] __initdata = {
 	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
 	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
 	{ insn_and, M(spec_op, 0, 0, 0, 0, and_op), RS | RT | RD },
@@ -193,7 +193,7 @@ static __initdata struct insn insn_table[] = {
 
 #undef M
 
-static __init u32 build_rs(u32 arg)
+static u32 __init build_rs(u32 arg)
 {
 	if (arg & ~RS_MASK)
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -201,7 +201,7 @@ static __init u32 build_rs(u32 arg)
 	return (arg & RS_MASK) << RS_SH;
 }
 
-static __init u32 build_rt(u32 arg)
+static u32 __init build_rt(u32 arg)
 {
 	if (arg & ~RT_MASK)
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -209,7 +209,7 @@ static __init u32 build_rt(u32 arg)
 	return (arg & RT_MASK) << RT_SH;
 }
 
-static __init u32 build_rd(u32 arg)
+static u32 __init build_rd(u32 arg)
 {
 	if (arg & ~RD_MASK)
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -217,7 +217,7 @@ static __init u32 build_rd(u32 arg)
 	return (arg & RD_MASK) << RD_SH;
 }
 
-static __init u32 build_re(u32 arg)
+static u32 __init build_re(u32 arg)
 {
 	if (arg & ~RE_MASK)
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -225,7 +225,7 @@ static __init u32 build_re(u32 arg)
 	return (arg & RE_MASK) << RE_SH;
 }
 
-static __init u32 build_simm(s32 arg)
+static u32 __init build_simm(s32 arg)
 {
 	if (arg > 0x7fff || arg < -0x8000)
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -233,7 +233,7 @@ static __init u32 build_simm(s32 arg)
 	return arg & 0xffff;
 }
 
-static __init u32 build_uimm(u32 arg)
+static u32 __init build_uimm(u32 arg)
 {
 	if (arg & ~IMM_MASK)
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -241,7 +241,7 @@ static __init u32 build_uimm(u32 arg)
 	return arg & IMM_MASK;
 }
 
-static __init u32 build_bimm(s32 arg)
+static u32 __init build_bimm(s32 arg)
 {
 	if (arg > 0x1ffff || arg < -0x20000)
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -252,7 +252,7 @@ static __init u32 build_bimm(s32 arg)
 	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
 }
 
-static __init u32 build_jimm(u32 arg)
+static u32 __init build_jimm(u32 arg)
 {
 	if (arg & ~((JIMM_MASK) << 2))
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -260,7 +260,7 @@ static __init u32 build_jimm(u32 arg)
 	return (arg >> 2) & JIMM_MASK;
 }
 
-static __init u32 build_func(u32 arg)
+static u32 __init build_func(u32 arg)
 {
 	if (arg & ~FUNC_MASK)
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -268,7 +268,7 @@ static __init u32 build_func(u32 arg)
 	return arg & FUNC_MASK;
 }
 
-static __init u32 build_set(u32 arg)
+static u32 __init build_set(u32 arg)
 {
 	if (arg & ~SET_MASK)
 		printk(KERN_WARNING "TLB synthesizer field overflow\n");
@@ -315,69 +315,69 @@ static void __init build_insn(u32 **buf, enum opcode opc, ...)
 }
 
 #define I_u1u2u3(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
+	static inline void i##op(u32 **buf, unsigned int a,	\
 	 	unsigned int b, unsigned int c)			\
 	{							\
 		build_insn(buf, insn##op, a, b, c);		\
 	}
 
 #define I_u2u1u3(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
+	static inline void i##op(u32 **buf, unsigned int a,	\
 	 	unsigned int b, unsigned int c)			\
 	{							\
 		build_insn(buf, insn##op, b, a, c);		\
 	}
 
 #define I_u3u1u2(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
+	static inline void i##op(u32 **buf, unsigned int a,	\
 	 	unsigned int b, unsigned int c)			\
 	{							\
 		build_insn(buf, insn##op, b, c, a);		\
 	}
 
 #define I_u1u2s3(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
+	static inline void i##op(u32 **buf, unsigned int a,	\
 	 	unsigned int b, signed int c)			\
 	{							\
 		build_insn(buf, insn##op, a, b, c);		\
 	}
 
 #define I_u2s3u1(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
+	static inline void i##op(u32 **buf, unsigned int a,	\
 	 	signed int b, unsigned int c)			\
 	{							\
 		build_insn(buf, insn##op, c, a, b);		\
 	}
 
 #define I_u2u1s3(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
+	static inline void i##op(u32 **buf, unsigned int a,	\
 	 	unsigned int b, signed int c)			\
 	{							\
 		build_insn(buf, insn##op, b, a, c);		\
 	}
 
 #define I_u1u2(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
+	static inline void i##op(u32 **buf, unsigned int a,	\
 	 	unsigned int b)					\
 	{							\
 		build_insn(buf, insn##op, a, b);		\
 	}
 
 #define I_u1s2(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a,	\
+	static inline void i##op(u32 **buf, unsigned int a,	\
 	 	signed int b)					\
 	{							\
 		build_insn(buf, insn##op, a, b);		\
 	}
 
 #define I_u1(op)						\
-	static inline void __init i##op(u32 **buf, unsigned int a)	\
+	static inline void i##op(u32 **buf, unsigned int a)	\
 	{							\
 		build_insn(buf, insn##op, a);			\
 	}
 
 #define I_0(op)							\
-	static inline void __init i##op(u32 **buf)		\
+	static inline void i##op(u32 **buf)		\
 	{							\
 		build_insn(buf, insn##op);			\
 	}
@@ -457,7 +457,7 @@ struct label {
 	enum label_id lab;
 };
 
-static __init void build_label(struct label **lab, u32 *addr,
+static void __init build_label(struct label **lab, u32 *addr,
 			       enum label_id l)
 {
 	(*lab)->addr = addr;
@@ -526,34 +526,34 @@ L_LA(_r3000_write_probe_fail)
 #define i_ehb(buf) i_sll(buf, 0, 0, 3)
 
 #ifdef CONFIG_64BIT
-static __init int __maybe_unused in_compat_space_p(long addr)
+static int __init __maybe_unused in_compat_space_p(long addr)
 {
 	/* Is this address in 32bit compat space? */
 	return (((addr) & 0xffffffff00000000L) == 0xffffffff00000000L);
 }
 
-static __init int __maybe_unused rel_highest(long val)
+static int __init __maybe_unused rel_highest(long val)
 {
 	return ((((val + 0x800080008000L) >> 48) & 0xffff) ^ 0x8000) - 0x8000;
 }
 
-static __init int __maybe_unused rel_higher(long val)
+static int __init __maybe_unused rel_higher(long val)
 {
 	return ((((val + 0x80008000L) >> 32) & 0xffff) ^ 0x8000) - 0x8000;
 }
 #endif
 
-static __init int rel_hi(long val)
+static int __init rel_hi(long val)
 {
 	return ((((val + 0x8000L) >> 16) & 0xffff) ^ 0x8000) - 0x8000;
 }
 
-static __init int rel_lo(long val)
+static int __init rel_lo(long val)
 {
 	return ((val & 0xffff) ^ 0x8000) - 0x8000;
 }
 
-static __init void i_LA_mostly(u32 **buf, unsigned int rs, long addr)
+static void __init i_LA_mostly(u32 **buf, unsigned int rs, long addr)
 {
 #ifdef CONFIG_64BIT
 	if (!in_compat_space_p(addr)) {
@@ -571,7 +571,7 @@ static __init void i_LA_mostly(u32 **buf, unsigned int rs, long addr)
 		i_lui(buf, rs, rel_hi(addr));
 }
 
-static __init void __maybe_unused i_LA(u32 **buf, unsigned int rs,
+static void __init __maybe_unused i_LA(u32 **buf, unsigned int rs,
 					     long addr)
 {
 	i_LA_mostly(buf, rs, addr);
@@ -589,7 +589,7 @@ struct reloc {
 	enum label_id lab;
 };
 
-static __init void r_mips_pc16(struct reloc **rel, u32 *addr,
+static void __init r_mips_pc16(struct reloc **rel, u32 *addr,
 			       enum label_id l)
 {
 	(*rel)->addr = addr;
@@ -614,7 +614,7 @@ static inline void __resolve_relocs(struct reloc *rel, struct label *lab)
 	}
 }
 
-static __init void resolve_relocs(struct reloc *rel, struct label *lab)
+static void __init resolve_relocs(struct reloc *rel, struct label *lab)
 {
 	struct label *l;
 
@@ -624,7 +624,7 @@ static __init void resolve_relocs(struct reloc *rel, struct label *lab)
 				__resolve_relocs(rel, l);
 }
 
-static __init void move_relocs(struct reloc *rel, u32 *first, u32 *end,
+static void __init move_relocs(struct reloc *rel, u32 *first, u32 *end,
 			       long off)
 {
 	for (; rel->lab != label_invalid; rel++)
@@ -632,7 +632,7 @@ static __init void move_relocs(struct reloc *rel, u32 *first, u32 *end,
 			rel->addr += off;
 }
 
-static __init void move_labels(struct label *lab, u32 *first, u32 *end,
+static void __init move_labels(struct label *lab, u32 *first, u32 *end,
 			       long off)
 {
 	for (; lab->lab != label_invalid; lab++)
@@ -640,7 +640,7 @@ static __init void move_labels(struct label *lab, u32 *first, u32 *end,
 			lab->addr += off;
 }
 
-static __init void copy_handler(struct reloc *rel, struct label *lab,
+static void __init copy_handler(struct reloc *rel, struct label *lab,
 				u32 *first, u32 *end, u32 *target)
 {
 	long off = (long)(target - first);
@@ -651,7 +651,7 @@ static __init void copy_handler(struct reloc *rel, struct label *lab,
 	move_labels(lab, first, end, off);
 }
 
-static __init int __maybe_unused insn_has_bdelay(struct reloc *rel,
+static int __init __maybe_unused insn_has_bdelay(struct reloc *rel,
 						       u32 *addr)
 {
 	for (; rel->lab != label_invalid; rel++) {
@@ -743,11 +743,11 @@ il_bgez(u32 **p, struct reloc **r, unsigned int reg, enum label_id l)
  * We deliberately chose a buffer size of 128, so we won't scribble
  * over anything important on overflow before we panic.
  */
-static __initdata u32 tlb_handler[128];
+static u32 tlb_handler[128] __initdata;
 
 /* simply assume worst case size for labels and relocs */
-static __initdata struct label labels[128];
-static __initdata struct reloc relocs[128];
+static struct label labels[128] __initdata;
+static struct reloc relocs[128] __initdata;
 
 /*
  * The R3000 TLB handler is simple.
@@ -801,7 +801,7 @@ static void __init build_r3000_tlb_refill_handler(void)
  * other one.To keep things simple, we first assume linear space,
  * then we relocate it to the final handler layout as needed.
  */
-static __initdata u32 final_handler[64];
+static u32 final_handler[64] __initdata;
 
 /*
  * Hazards
@@ -825,7 +825,7 @@ static __initdata u32 final_handler[64];
  *
  * As if we MIPS hackers wouldn't know how to nop pipelines happy ...
  */
-static __init void __maybe_unused build_tlb_probe_entry(u32 **p)
+static void __init __maybe_unused build_tlb_probe_entry(u32 **p)
 {
 	switch (current_cpu_type()) {
 	/* Found by experiment: R4600 v2.0 needs this, too.  */
@@ -849,7 +849,7 @@ static __init void __maybe_unused build_tlb_probe_entry(u32 **p)
  */
 enum tlb_write_entry { tlb_random, tlb_indexed };
 
-static __init void build_tlb_write_entry(u32 **p, struct label **l,
+static void __init build_tlb_write_entry(u32 **p, struct label **l,
 					 struct reloc **r,
 					 enum tlb_write_entry wmode)
 {
@@ -993,7 +993,7 @@ static __init void build_tlb_write_entry(u32 **p, struct label **l,
  * TMP and PTR are scratch.
  * TMP will be clobbered, PTR will hold the pmd entry.
  */
-static __init void
+static void __init
 build_get_pmde64(u32 **p, struct label **l, struct reloc **r,
 		 unsigned int tmp, unsigned int ptr)
 {
@@ -1054,7 +1054,7 @@ build_get_pmde64(u32 **p, struct label **l, struct reloc **r,
  * BVADDR is the faulting address, PTR is scratch.
  * PTR will hold the pgd for vmalloc.
  */
-static __init void
+static void __init
 build_get_pgd_vmalloc64(u32 **p, struct label **l, struct reloc **r,
 			unsigned int bvaddr, unsigned int ptr)
 {
@@ -1118,7 +1118,7 @@ build_get_pgd_vmalloc64(u32 **p, struct label **l, struct reloc **r,
  * TMP and PTR are scratch.
  * TMP will be clobbered, PTR will hold the pgd entry.
  */
-static __init void __maybe_unused
+static void __init __maybe_unused
 build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 {
 	long pgdc = (long)pgd_current;
@@ -1153,7 +1153,7 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
 
 #endif /* !CONFIG_64BIT */
 
-static __init void build_adjust_context(u32 **p, unsigned int ctx)
+static void __init build_adjust_context(u32 **p, unsigned int ctx)
 {
 	unsigned int shift = 4 - (PTE_T_LOG2 + 1) + PAGE_SHIFT - 12;
 	unsigned int mask = (PTRS_PER_PTE / 2 - 1) << (PTE_T_LOG2 + 1);
@@ -1179,7 +1179,7 @@ static __init void build_adjust_context(u32 **p, unsigned int ctx)
 	i_andi(p, ctx, ctx, mask);
 }
 
-static __init void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
+static void __init build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 {
 	/*
 	 * Bug workaround for the Nevada. It seems as if under certain
@@ -1204,7 +1204,7 @@ static __init void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
 	i_ADDU(p, ptr, ptr, tmp); /* add in offset */
 }
 
-static __init void build_update_entries(u32 **p, unsigned int tmp,
+static void __init build_update_entries(u32 **p, unsigned int tmp,
 					unsigned int ptep)
 {
 	/*
