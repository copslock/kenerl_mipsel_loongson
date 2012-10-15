Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2012 11:04:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35375 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823031Ab2JOJEkpOfWj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Oct 2012 11:04:40 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q9F94dvl018472
        for <linux-mips@linux-mips.org>; Mon, 15 Oct 2012 11:04:39 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q9F94d6i018471
        for linux-mips@linux-mips.org; Mon, 15 Oct 2012 11:04:39 +0200
Date:   Mon, 15 Oct 2012 11:04:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] tlbex: Deal with re-definition of label
Message-ID: <20121015090439.GB15338@linux-mips.org>
References: <20121013204457.GA5340@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121013204457.GA5340@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Oct 13, 2012 at 10:44:57PM +0200, Ralf Baechle wrote:

Just to illustrate how curious the effects of this bug were, see the
disassembly below.  Affected are all the bgezl instructions immediately
preceeding TLBWR or TLBWI instructions and in all cases the branch should
be pointing to the address immediately following the TLBWI, iow, it should
be a "bgezl $0, . + 8".

  Ralf

/*
 * Bit definitions used
 */
#define _PAGE_PRESENT_SHIFT 0
#define _PAGE_READ_SHIFT 1
#define _PAGE_WRITE_SHIFT 2
#define _PAGE_ACCESSED_SHIFT 3
#define _PAGE_MODIFIED_SHIFT 4
#define _PAGE_HUGE_SHIFT 5
#define _PAGE_SPLITTING_SHIFT 6
#define _PAGE_GLOBAL_SHIFT 7
#define _PAGE_VALID_SHIFT 8
#define _PAGE_DIRTY_SHIFT 9
#define _PFN_SHIFT 13

00000000 <r4000_tlb_load>:
   0:	3c1a8063 	lui	k0,0x8063
   4:	275a4668 	addiu	k0,k0,18024
   8:	ff410000 	sd	at,0(k0)
   c:	ff420008 	sd	v0,8(k0)
  10:	403b4000 	dmfc0	k1,c0_badvaddr
  14:	07600029 	bltz	k1,bc <r4000_tlb_load+0xbc>
  18:	3c018063 	lui	at,0x8063
  1c:	dc212000 	ld	at,8192(at)			# root pointer
  20:	001bdefa 	dsrl	k1,k1,0x1b
  24:	337b1ff8 	andi	k1,k1,0x1ff8
  28:	003b082d 	daddu	at,at,k1
  2c:	403b4000 	dmfc0	k1,c0_badvaddr
  30:	dc210000 	ld	at,0(at)			# load pge/pud
  34:	001bdcba 	dsrl	k1,k1,0x12
  38:	337b0ff8 	andi	k1,k1,0xff8
  3c:	003b082d 	daddu	at,at,k1
  40:	dc3b0000 	ld	k1,0(at)			# load pmd
  44:	337b0020 	andi	k1,k1,0x20			# Huge page?
  48:	1760001e 	bnez	k1,c4 <r4000_tlb_load+0xc4>	# yes
  4c:	403b4000 	dmfc0	k1,c0_badvaddr
  50:	dc210000 	ld	at,0(at)
  54:	001bda7a 	dsrl	k1,k1,0x9
  58:	337b0ff8 	andi	k1,k1,0xff8
  5c:	003b082d 	daddu	at,at,k1
  60:	dc3b0000 	ld	k1,0(at)
  64:	00000000 	nop
  68:	42000008 	tlbp
  6c:	33620003 	andi	v0,k1,0x3
  70:	38420003 	xori	v0,v0,0x3
  74:	14400028 	bnez	v0,118 <r4000_tlb_load+0x118>
  78:	377b0108 	ori	k1,k1,0x108
  7c:	fc3b0000 	sd	k1,0(at)
  80:	34210008 	ori	at,at,0x8
  84:	38210008 	xori	at,at,0x8
  88:	dc3b0000 	ld	k1,0(at)
  8c:	dc210008 	ld	at,8(at)
  90:	001bd9fa 	dsrl	k1,k1,0x7
  94:	40bb1000 	dmtc0	k1,c0_entrylo0
  98:	000109fa 	dsrl	at,at,0x7
  9c:	40a11800 	dmtc0	at,c0_entrylo1
	...
  a8:	04030019 	bgezl	zero,110 <r4000_tlb_load+0x110>	# should 0xb0
  ac:	42000002 	tlbwi
  b0:	df410000 	ld	at,0(k0)
  b4:	df420008 	ld	v0,8(k0)
  b8:	42000018 	eret
  bc:	1000ffd8 	b	20 <r4000_tlb_load+0x20>
  c0:	3c018063 	lui	at,0x8063


/*
 * Huge page load code starts here
 */
  c4:	dc3b0000 	ld	k1,0(at)
  c8:	33620003 	andi	v0,k1,0x3
  cc:	38420003 	xori	v0,v0,0x3
  d0:	14400011 	bnez	v0,118 <r4000_tlb_load+0x118>
  d4:	00000000 	nop
  d8:	42000008 	tlbp
  dc:	377b0108 	ori	k1,k1,0x108
  e0:	fc3b0000 	sd	k1,0(at)
  e4:	001bd9fa 	dsrl	k1,k1,0x7
  e8:	40bb1000 	dmtc0	k1,c0_entrylo0
  ec:	677b4000 	daddiu	k1,k1,16384
  f0:	40bb1800 	dmtc0	k1,c0_entrylo1
  f4:	3c1b001f 	lui	k1,0x1f
  f8:	377be000 	ori	k1,k1,0xe000
  fc:	409b2800 	mtc0	k1,c0_pagemask
	...
 108:	0403ffe9 	bgezl	zero,b0 <r4000_tlb_load+0xb0>	# should 0x110
 10c:	42000002 	tlbwi
 110:	1000ffe7 	b	b0 <r4000_tlb_load+0xb0>
 114:	40802800 	mtc0	zero,c0_pagemask
 118:	df410000 	ld	at,0(k0)
 11c:	df420008 	ld	v0,8(k0)
 120:	08045650 	j	115940 <r4000_tlb_refill+0x115340>
 124:	00000000 	nop
	...

00000200 <r4000_tlb_store>:
 200:	3c1a8063 	lui	k0,0x8063
 204:	275a4668 	addiu	k0,k0,18024
 208:	ff410000 	sd	at,0(k0)
 20c:	ff420008 	sd	v0,8(k0)
 210:	403b4000 	dmfc0	k1,c0_badvaddr
 214:	0760002a 	bltz	k1,2c0 <r4000_tlb_store+0xc0>
 218:	3c018063 	lui	at,0x8063
 21c:	dc212000 	ld	at,8192(at)
 220:	001bdefa 	dsrl	k1,k1,0x1b
 224:	337b1ff8 	andi	k1,k1,0x1ff8
 228:	003b082d 	daddu	at,at,k1
 22c:	403b4000 	dmfc0	k1,c0_badvaddr
 230:	dc210000 	ld	at,0(at)
 234:	001bdcba 	dsrl	k1,k1,0x12
 238:	337b0ff8 	andi	k1,k1,0xff8
 23c:	003b082d 	daddu	at,at,k1
 240:	dc3b0000 	ld	k1,0(at)
 244:	337b0020 	andi	k1,k1,0x20			# huge page
 248:	1760001f 	bnez	k1,2c8 <r4000_tlb_store+0xc8>
 24c:	403b4000 	dmfc0	k1,c0_badvaddr
 250:	dc210000 	ld	at,0(at)
 254:	001bda7a 	dsrl	k1,k1,0x9
 258:	337b0ff8 	andi	k1,k1,0xff8
 25c:	003b082d 	daddu	at,at,k1
 260:	dc3b0000 	ld	k1,0(at)
 264:	00000000 	nop
 268:	42000008 	tlbp
 26c:	33620005 	andi	v0,k1,0x5
 270:	38420005 	xori	v0,v0,0x5
 274:	1440002a 	bnez	v0,320 <r4000_tlb_store+0x120>
 278:	00000000 	nop
 27c:	377b0318 	ori	k1,k1,0x318
 280:	fc3b0000 	sd	k1,0(at)
 284:	34210008 	ori	at,at,0x8
 288:	38210008 	xori	at,at,0x8
 28c:	dc3b0000 	ld	k1,0(at)
 290:	dc210008 	ld	at,8(at)
 294:	001bd9fa 	dsrl	k1,k1,0x7
 298:	40bb1000 	dmtc0	k1,c0_entrylo0
 29c:	000109fa 	dsrl	at,at,0x7
 2a0:	40a11800 	dmtc0	at,c0_entrylo1
	...
 2ac:	0403001b 	bgezl	zero,31c <r4000_tlb_store+0x11c> # should 0x2b4
 2b0:	42000002 	tlbwi
 2b4:	df410000 	ld	at,0(k0)
 2b8:	df420008 	ld	v0,8(k0)
 2bc:	42000018 	eret
 2c0:	1000ffd7 	b	220 <r4000_tlb_store+0x20>
 2c4:	3c018063 	lui	at,0x8063
 2c8:	dc3b0000 	ld	k1,0(at)			# huge page
 2cc:	33620005 	andi	v0,k1,0x5
 2d0:	38420005 	xori	v0,v0,0x5
 2d4:	14400012 	bnez	v0,320 <r4000_tlb_store+0x120>
 2d8:	00000000 	nop
 2dc:	00000000 	nop
 2e0:	42000008 	tlbp
 2e4:	377b0318 	ori	k1,k1,0x318
 2e8:	fc3b0000 	sd	k1,0(at)
 2ec:	001bd9fa 	dsrl	k1,k1,0x7
 2f0:	40bb1000 	dmtc0	k1,c0_entrylo0
 2f4:	677b4000 	daddiu	k1,k1,16384
 2f8:	40bb1800 	dmtc0	k1,c0_entrylo1
 2fc:	3c1b001f 	lui	k1,0x1f
 300:	377be000 	ori	k1,k1,0xe000
 304:	409b2800 	mtc0	k1,c0_pagemask
	...
 310:	0403ffe9 	bgezl	zero,2b8 <r4000_tlb_store+0xb8> # should 0x318
 314:	42000002 	tlbwi
 318:	1000ffe6 	b	2b4 <r4000_tlb_store+0xb4>
 31c:	40802800 	mtc0	zero,c0_pagemask
 320:	df410000 	ld	at,0(k0)
 324:	df420008 	ld	v0,8(k0)
 328:	08045693 	j	115a4c <r4000_tlb_refill+0x11544c>
 32c:	00000000 	nop
	...

00000400 <r4000_tlb_modify>:
 400:	3c1a8063 	lui	k0,0x8063
 404:	275a4668 	addiu	k0,k0,18024
 408:	ff410000 	sd	at,0(k0)
 40c:	ff420008 	sd	v0,8(k0)
 410:	403b4000 	dmfc0	k1,c0_badvaddr
 414:	07600028 	bltz	k1,4b8 <r4000_tlb_modify+0xb8>
 418:	3c018063 	lui	at,0x8063
 41c:	dc212000 	ld	at,8192(at)
 420:	001bdefa 	dsrl	k1,k1,0x1b
 424:	337b1ff8 	andi	k1,k1,0x1ff8
 428:	003b082d 	daddu	at,at,k1
 42c:	403b4000 	dmfc0	k1,c0_badvaddr
 430:	dc210000 	ld	at,0(at)
 434:	001bdcba 	dsrl	k1,k1,0x12
 438:	337b0ff8 	andi	k1,k1,0xff8
 43c:	003b082d 	daddu	at,at,k1
 440:	dc3b0000 	ld	k1,0(at)
 444:	337b0020 	andi	k1,k1,0x20			# huge page
 448:	1760001d 	bnez	k1,4c0 <r4000_tlb_modify+0xc0>
 44c:	403b4000 	dmfc0	k1,c0_badvaddr
 450:	dc210000 	ld	at,0(at)
 454:	001bda7a 	dsrl	k1,k1,0x9
 458:	337b0ff8 	andi	k1,k1,0xff8
 45c:	003b082d 	daddu	at,at,k1
 460:	dc3b0000 	ld	k1,0(at)
 464:	00000000 	nop
 468:	42000008 	tlbp
 46c:	33620004 	andi	v0,k1,0x4
 470:	10400027 	beqz	v0,510 <r4000_tlb_modify+0x110>
 474:	377b0318 	ori	k1,k1,0x318
 478:	fc3b0000 	sd	k1,0(at)
 47c:	34210008 	ori	at,at,0x8
 480:	38210008 	xori	at,at,0x8
 484:	dc3b0000 	ld	k1,0(at)
 488:	dc210008 	ld	at,8(at)
 48c:	001bd9fa 	dsrl	k1,k1,0x7
 490:	40bb1000 	dmtc0	k1,c0_entrylo0
 494:	000109fa 	dsrl	at,at,0x7
 498:	40a11800 	dmtc0	at,c0_entrylo1
	...
 4a4:	04030019 	bgezl	zero,50c <r4000_tlb_modify+0x10c> # should 0x4ac
 4a8:	42000002 	tlbwi
 4ac:	df410000 	ld	at,0(k0)
 4b0:	df420008 	ld	v0,8(k0)
 4b4:	42000018 	eret
 4b8:	1000ffd9 	b	420 <r4000_tlb_modify+0x20>
 4bc:	3c018063 	lui	at,0x8063
 4c0:	dc3b0000 	ld	k1,0(at)
 4c4:	33620004 	andi	v0,k1,0x4
 4c8:	10400011 	beqz	v0,510 <r4000_tlb_modify+0x110>
 4cc:	00000000 	nop
 4d0:	42000008 	tlbp
 4d4:	377b0318 	ori	k1,k1,0x318
 4d8:	fc3b0000 	sd	k1,0(at)
 4dc:	001bd9fa 	dsrl	k1,k1,0x7
 4e0:	40bb1000 	dmtc0	k1,c0_entrylo0
 4e4:	677b4000 	daddiu	k1,k1,16384
 4e8:	40bb1800 	dmtc0	k1,c0_entrylo1
 4ec:	3c1b001f 	lui	k1,0x1f
 4f0:	377be000 	ori	k1,k1,0xe000
 4f4:	409b2800 	mtc0	k1,c0_pagemask
	...
 500:	0403ffeb 	bgezl	zero,4b0 <r4000_tlb_modify+0xb0> # should 0x508
 504:	42000002 	tlbwi
 508:	1000ffe8 	b	4ac <r4000_tlb_modify+0xac>
 50c:	40802800 	mtc0	zero,c0_pagemask
 510:	df410000 	ld	at,0(k0)
 514:	df420008 	ld	v0,8(k0)
 518:	08045693 	j	115a4c <r4000_tlb_refill+0x11544c>
 51c:	00000000 	nop
	...

00000600 <r4000_tlb_refill>:					# huge page
 600:	001ad1fa 	dsrl	k0,k0,0x7
 604:	40ba1000 	dmtc0	k0,c0_entrylo0
 608:	675a4000 	daddiu	k0,k0,16384
 60c:	40ba1800 	dmtc0	k0,c0_entrylo1
 610:	3c1a001f 	lui	k0,0x1f
 614:	375ae000 	ori	k0,k0,0xe000
 618:	409a2800 	mtc0	k0,c0_pagemask
	...
 624:	04030033 	bgezl	zero,6f4 <r4000_tlb_refill+0xf4> # should 0x62c
 628:	42000006 	tlbwr
 62c:	10000031 	b	6f4 <r4000_tlb_refill+0xf4>
 630:	40802800 	mtc0	zero,c0_pagemask
 634:	10000016 	b	690 <r4000_tlb_refill+0x90>
 638:	3c1b8063 	lui	k1,0x8063
	...
 680:	403a4000 	dmfc0	k0,c0_badvaddr
 684:	0740ffeb 	bltz	k0,634 <r4000_tlb_refill+0x34>
 688:	3c1b8063 	lui	k1,0x8063
 68c:	df7b2000 	ld	k1,8192(k1)
 690:	001ad6fa 	dsrl	k0,k0,0x1b
 694:	335a1ff8 	andi	k0,k0,0x1ff8
 698:	037ad82d 	daddu	k1,k1,k0
 69c:	403a4000 	dmfc0	k0,c0_badvaddr
 6a0:	df7b0000 	ld	k1,0(k1)
 6a4:	001ad4ba 	dsrl	k0,k0,0x12
 6a8:	335a0ff8 	andi	k0,k0,0xff8
 6ac:	037ad82d 	daddu	k1,k1,k0
 6b0:	df7a0000 	ld	k0,0(k1)
 6b4:	335a0020 	andi	k0,k0,0x20			# huge page?
 6b8:	1740ffd1 	bnez	k0,600 <r4000_tlb_refill>
 6bc:	df7b0000 	ld	k1,0(k1)
 6c0:	403aa000 	dmfc0	k0,c0_xcontext
 6c4:	335a0ff0 	andi	k0,k0,0xff0
 6c8:	037ad82d 	daddu	k1,k1,k0
 6cc:	df7a0000 	ld	k0,0(k1)
 6d0:	df7b0008 	ld	k1,8(k1)
 6d4:	001ad1fa 	dsrl	k0,k0,0x7
 6d8:	40ba1000 	dmtc0	k0,c0_entrylo0
 6dc:	001bd9fa 	dsrl	k1,k1,0x7
 6e0:	40bb1800 	dmtc0	k1,c0_entrylo1
	...
 6ec:	0403ffcf 	bgezl	zero,62c <r4000_tlb_refill+0x2c> # should 0x6f4
 6f0:	42000006 	tlbwr
 6f4:	42000018 	eret
	...
