Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA70761 for <linux-archive@neteng.engr.sgi.com>; Tue, 13 Oct 1998 15:34:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA62272
	for linux-list;
	Tue, 13 Oct 1998 15:33:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA87289
	for <linux@engr.sgi.com>;
	Tue, 13 Oct 1998 15:33:06 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07745
	for <linux@engr.sgi.com>; Tue, 13 Oct 1998 15:33:04 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-03.uni-koblenz.de [141.26.249.3])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA16297
	for <linux@engr.sgi.com>; Wed, 14 Oct 1998 00:32:57 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id VAA02698;
	Tue, 13 Oct 1998 21:59:27 +0200
Message-ID: <19981013215927.A2692@uni-koblenz.de>
Date: Tue, 13 Oct 1998 21:59:27 +0200
From: ralf@uni-koblenz.de
To: Vladimir Roganov <roganov@niisi.msk.ru>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu,
        linux-kernel@vger.rutgers.edu
Subject: get_mmu_context()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ok, here is a draft version of an agressively optimized version of
get_mmu_context().  I just didn't like the idea of referencing
global variables in get_mmu_context() if avoidable.  The code below
will work on both R3000 and R4000 with no performance penalty for
being generic.  The trick is to patch the operands of two machine
instructions at runtime, shoot me.

The code below should be integrated into <asm/mmu_context.h>.  The
CPU specific code in arch/mips/mm/... will then just have to include
that header file and call r3000_asid_setup rsp. r4xx0_asid_setup.

Have fun,

  Ralf

#define ASID_VERSION_SHIFT 16
#define ASID_VERSION_MASK  ((~0UL) << ASID_VERSION_SHIFT)
#define ASID_FIRST_VERSION (1UL << ASID_VERSION_SHIFT)

unsigned long asid_cache = ASID_FIRST_VERSION;

/* The next two macros know that they will only be assembled once
   per kernel.  */
#define ASID_VERSION_INC					\
 ({ unsigned long __asid_inc;					\
   __asm__(".globl\tasid_inc\n"					\
           "asid_inc:\n\t"					\
           "li\t%0,0\t\t\t#patched\n\t"				\
           :"=r" (__asid_inc));					\
   __asid_inc; })

#define ASID_OVERFLOW(asid)					\
 ({ unsigned long __res;					\
   __asm__(".global\tasid_overflow\n"				\
           "asid_overflow:\n\t"					\
           "sltu\t%0,%1,0\t\t\t#patched\n\t"			\
           :"=r" (__res)					\
           :"r" (asid));					\
   __res; })

extern inline void get_new_mmu_context(struct mm_struct *mm, unsigned long asid)
{
	/* check if it's legal.. */
	if (ASID_OVERFLOW(asid & ~ASID_VERSION_MASK)) {
		/* start a new version, invalidate all old asid's */
		flush_tlb_all();
		asid = (asid & ASID_VERSION_MASK) + ASID_FIRST_VERSION;
		if (!asid)
			asid = ASID_FIRST_VERSION;
	}
	asid_cache = asid + ASID_VERSION_INC;
	mm->context = asid;			 /* full version + asid */
}

extern void get_mmu_context(struct task_struct *p)
{
	struct mm_struct *mm = p->mm;

	if (mm) {
		unsigned long asid = asid_cache;
		/* Check if our ASID is of an older version and thus invalid */
		if ((mm->context ^ asid) & ASID_VERSION_MASK)
			get_new_mmu_context(mm, asid);
	}
}

extern inline void __asid_setup(unsigned long asid_inc, unsigned long asid_cmp)
{
	extern u32 asid_inc;
	extern u32 asid_overflow;

	asid_inc = (asid_inc & 0xffff0000) | asid_inc;
	flush_icache_range(&asid_inc, 4);
	asid_overflow = (asid_overflow & 0xffff0000) | asid_cmp;
	flush_icache_range(&asid_overflow, 4);
}

extern inline void r3000_asid_setup(void)
{
	__asid_setup(0x40, 0xfc1);
}

extern inline void r4xx0_asid_setup(void)
{
	__asid_setup(1, 0x100);
}
