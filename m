Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 18:04:10 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:47881 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225375AbULBSEE>;
	Thu, 2 Dec 2004 18:04:04 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CZvQV-00088z-00; Thu, 02 Dec 2004 18:11:35 +0000
Received: from perivale.mips.com ([192.168.192.200])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CZvIl-0001qz-00; Thu, 02 Dec 2004 18:03:35 +0000
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1CZvIl-0004c2-00; Thu, 02 Dec 2004 18:03:35 +0000
Date: Thu, 2 Dec 2004 18:03:35 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH] Label misplacement on an XTLB refill handler split
Message-ID: <Pine.LNX.4.61.0412021746590.15065@perivale.mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-3.277, required 4, AWL,
	BAYES_00, SPAMMYSPELL)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

Thiemo,

 The XTLB refill handler splitter misplaces labels associated with an
instruction that gets placed in the branch delay slot of the splitting 
branch.  Here's an example:

tlb-handler.img:     file format binary

Disassembly of section .data:

0000000000000000 <.data>:
   0:	001bd83c 	dsll32	k1,k1,0x0
   4:	035bd02f 	dsubu	k0,k0,k1
   8:	3c1b803a 	lui	k1,0x803a
   c:	10000026 	b	0xa8
  10:	677b4000 	daddiu	k1,k1,16384
	...
  80:	403a4000 	dmfc0	k0,c0_badvaddr
  84:	403b5000 	dmfc0	k1,c0_entryhi
  88:	035bd026 	xor	k0,k0,k1
  8c:	001ad37a 	dsrl	k0,k0,0xd
  90:	17400018 	bnez	k0,0xf4
  94:	403a4000 	dmfc0	k0,c0_badvaddr
  98:	07400018 	bltz	k0,0xfc
  9c:	403b2000 	dmfc0	k1,c0_context
  a0:	001bddfb 	dsra	k1,k1,0x17
  a4:	df7b0000 	ld	k1,0(k1)
  a8:	001ad73a 	dsrl	k0,k0,0x1c
  ac:	335a1ff8 	andi	k0,k0,0x1ff8
  b0:	037ad82d 	daddu	k1,k1,k0
  b4:	403a4000 	dmfc0	k0,c0_badvaddr
  b8:	df7b0000 	ld	k1,0(k1)
  bc:	001ad4ba 	dsrl	k0,k0,0x12
  c0:	335a0ff8 	andi	k0,k0,0xff8
  c4:	037ad82d 	daddu	k1,k1,k0
  c8:	403aa000 	dmfc0	k0,c0_xcontext
  cc:	df7b0000 	ld	k1,0(k1)
  d0:	335a0ff0 	andi	k0,k0,0xff0
  d4:	037ad82d 	daddu	k1,k1,k0
  d8:	df7a0000 	ld	k0,0(k1)
  dc:	df7b0008 	ld	k1,8(k1)
  e0:	001ad1ba 	dsrl	k0,k0,0x6
  e4:	409a1000 	mtc0	k0,c0_entrylo0
  e8:	001bd9ba 	dsrl	k1,k1,0x6
  ec:	409b1800 	mtc0	k1,c0_entrylo1
  f0:	42000006 	tlbwr
  f4:	42000018 	eret
  f8:	1000ffc1 	b	0x0
  fc:	3c1bc000 	lui	k1,0xc000

I've fixed it by separating the label mover (and the reloc mover, for 
consistency) and using it to fix up relevant labels.  I'll apply it if 
it's OK with you.

  Maciej

patch-mips-2.6.10-rc2-20041124-mips-tlb-label-0
diff -up --recursive --new-file linux-mips-2.6.10-rc2-20041124.macro/arch/mips/mm/tlbex.c linux-mips-2.6.10-rc2-20041124/arch/mips/mm/tlbex.c
--- linux-mips-2.6.10-rc2-20041124.macro/arch/mips/mm/tlbex.c	2004-11-24 21:37:38.000000000 +0000
+++ linux-mips-2.6.10-rc2-20041124/arch/mips/mm/tlbex.c	2004-12-02 17:41:11.000000000 +0000
@@ -550,22 +550,33 @@ static __init void resolve_relocs(struct
 				__resolve_relocs(rel, l);
 }
 
-static __init void copy_handler(struct reloc *rel, struct label *lab,
-				u32 *first, u32 *end, u32* target)
+static __init void move_relocs(struct reloc *rel, u32 *first, u32 *end,
+			       long off)
 {
-	long off = (long)(target - first);
-
-	memcpy(target, first, (end - first) * sizeof(u32));
-
 	for (; rel->lab != label_invalid; rel++)
 		if (rel->addr >= first && rel->addr < end)
 			rel->addr += off;
+}
 
+static __init void move_labels(struct label *lab, u32 *first, u32 *end,
+			       long off)
+{
 	for (; lab->lab != label_invalid; lab++)
 		if (lab->addr >= first && lab->addr < end)
 			lab->addr += off;
 }
 
+static __init void copy_handler(struct reloc *rel, struct label *lab,
+				u32 *first, u32 *end, u32 *target)
+{
+	long off = (long)(target - first);
+
+	memcpy(target, first, (end - first) * sizeof(u32));
+
+	move_relocs(rel, first, end, off);
+	move_labels(lab, first, end, off);
+}
+
 static __init int __attribute__((unused)) insn_has_bdelay(struct reloc *rel,
 							  u32 *addr)
 {
@@ -1110,6 +1121,7 @@ static void __init build_r4000_tlb_refil
 			i_nop(&f);
 		else {
 			copy_handler(relocs, labels, split, split + 1, f);
+			move_labels(labels, f, f + 1, -1);
 			f++;
 			split++;
 		}
