Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 20:40:27 +0100 (BST)
Received: from mx03.cybersurf.com ([IPv6:::ffff:209.197.145.106]:55199 "EHLO
	mx03.cybersurf.com") by linux-mips.org with ESMTP
	id <S8225877AbUE1TkL>; Fri, 28 May 2004 20:40:11 +0100
Received: from mail.cyberus.ca ([209.197.145.21])
	by mx03.cybersurf.com with esmtp (Exim 4.20)
	id 1BTnCB-0002MD-Vr
	for linux-mips@linux-mips.org; Fri, 28 May 2004 15:39:11 -0400
Received: from [216.209.86.2] (helo=[10.0.0.21])
	by mail.cyberus.ca with esmtp (Exim 4.20)
	id 1BTn9w-0003J4-8k; Fri, 28 May 2004 15:36:52 -0400
Subject: weird sb1250 behavior
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: linux-mips@linux-mips.org
Cc: sibyte-users@bitmover.com
Content-Type: multipart/mixed; boundary="=-yRcc9hJc2nJX+maAD6p5"
Organization: jamalopolis
Message-Id: <1085773008.1029.59.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 May 2004 15:36:48 -0400
Return-Path: <hadi@cyberus.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hadi@cyberus.ca
Precedence: bulk
X-list: linux-mips


--=-yRcc9hJc2nJX+maAD6p5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


found some very strange behavior with sb1250.
Gcc 3.2.3 with sibyte mods. Running Linux 2.4.21 with whatever
mods off sibyte.

Testcase:
sending a large amount of traffic 
-->eth0-->someprocessing-->eth1

given the nature of processing, say i was getting 100Kpps throughput.
Now i fire a very basic program that has just loops and forever
sums up two numbers.

---
      1 #include <stdlib.h>
      2 
      3 int main ()
      4 {
      5         int a = 1;
      6         int b = 2;
      7         int c = 0; 
      8         // int c;
      9         while (1) {
     10                 c = a + b;
     11         }
     12 }
--------

I see very little drop in throughput - probably around 0.01%.

Now comment line 7 then uncomment line 8. Hallelujah.
Perfomance drops to about 100pps. Thats about a factor of 1000 down!

Interesting thing is if you add a nop (__asm__ __volatile__("nop");)
in the second version just before the while loop, we get back the same
performance as in the earlier version.
Apologies in advance for attaching objdumps (since there maybe folks who
dont have access to the sibyte tools)
1) while-init-dis is for case 1 where c is initialized
2) while-noinit-dis is for case 2 where c is not initialize
3) while-nop-dis is for case 3 when you have nop thrown in.


cheers,
jamal


--=-yRcc9hJc2nJX+maAD6p5
Content-Disposition: attachment; filename=while-init-dis
Content-Type: text/plain; name=while-init-dis; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


while-init:     file format elf32-tradbigmips

Disassembly of section .init:

004003f0 <_init>:
  4003f0:	3c1c0fc0 	lui	gp,0xfc0
  4003f4:	279c7c40 	addiu	gp,gp,31808
  4003f8:	0399e021 	addu	gp,gp,t9
  4003fc:	27bdffe0 	addiu	sp,sp,-32
  400400:	afbc0010 	sw	gp,16(sp)
  400404:	afbf001c 	sw	ra,28(sp)
  400408:	afbc0018 	sw	gp,24(sp)
  40040c:	8f998018 	lw	t9,-32744(gp)
  400410:	00000000 	nop
  400414:	27390500 	addiu	t9,t9,1280
	...
  400420:	0320f809 	jalr	t9
  400424:	00000000 	nop
  400428:	8fbc0010 	lw	gp,16(sp)
  40042c:	00000000 	nop
  400430:	8f998018 	lw	t9,-32744(gp)
  400434:	00000000 	nop
  400438:	2739063c 	addiu	t9,t9,1596
  40043c:	00000000 	nop
  400440:	0320f809 	jalr	t9
  400444:	00000000 	nop
  400448:	8fbc0010 	lw	gp,16(sp)
  40044c:	00000000 	nop
  400450:	8f998018 	lw	t9,-32744(gp)
  400454:	00000000 	nop
  400458:	27390720 	addiu	t9,t9,1824
  40045c:	00000000 	nop
  400460:	0320f809 	jalr	t9
  400464:	00000000 	nop
  400468:	8fbc0010 	lw	gp,16(sp)
  40046c:	00000000 	nop
  400470:	8fbf001c 	lw	ra,28(sp)
  400474:	00000000 	nop
  400478:	03e00008 	jr	ra
  40047c:	27bd0020 	addiu	sp,sp,32
Disassembly of section .text:

00400480 <__start>:
  400480:	04100001 	bltzal	zero,400488 <__start+0x8>
  400484:	00000000 	nop
  400488:	3c1c0fc0 	lui	gp,0xfc0
  40048c:	279c7ba8 	addiu	gp,gp,31656
  400490:	039fe021 	addu	gp,gp,ra
  400494:	0000f821 	move	ra,zero
  400498:	8f84803c 	lw	a0,-32708(gp)
  40049c:	8fa50000 	lw	a1,0(sp)
  4004a0:	27a60004 	addiu	a2,sp,4
  4004a4:	3c01ffff 	lui	at,0xffff
  4004a8:	3421fff8 	ori	at,at,0xfff8
  4004ac:	03a1e824 	and	sp,sp,at
  4004b0:	27bdffe0 	addiu	sp,sp,-32
  4004b4:	8f878040 	lw	a3,-32704(gp)
  4004b8:	8f888034 	lw	t0,-32716(gp)
  4004bc:	00000000 	nop
  4004c0:	afa80010 	sw	t0,16(sp)
  4004c4:	afa20014 	sw	v0,20(sp)
  4004c8:	afbd0018 	sw	sp,24(sp)
  4004cc:	8f998038 	lw	t9,-32712(gp)
  4004d0:	00000000 	nop
  4004d4:	0320f809 	jalr	t9
  4004d8:	00000000 	nop

004004dc <hlt>:
  4004dc:	1000ffff 	b	4004dc <hlt>
  4004e0:	00000000 	nop
	...

00400500 <call_gmon_start>:
  400500:	3c1c0fc0 	lui	gp,0xfc0
  400504:	279c7b30 	addiu	gp,gp,31536
  400508:	0399e021 	addu	gp,gp,t9
  40050c:	27bdffe0 	addiu	sp,sp,-32
  400510:	afbc0010 	sw	gp,16(sp)
  400514:	afbf001c 	sw	ra,28(sp)
  400518:	8f82802c 	lw	v0,-32724(gp)
  40051c:	00000000 	nop
  400520:	10400006 	beqz	v0,40053c <call_gmon_start+0x3c>
  400524:	afbc0018 	sw	gp,24(sp)
  400528:	0040c821 	move	t9,v0
  40052c:	00000000 	nop
  400530:	0320f809 	jalr	t9
  400534:	00000000 	nop
  400538:	8fbc0010 	lw	gp,16(sp)
  40053c:	8fbf001c 	lw	ra,28(sp)
	...
  400548:	03e00008 	jr	ra
  40054c:	27bd0020 	addiu	sp,sp,32

00400550 <__do_global_dtors_aux>:
  400550:	3c1c0fc0 	lui	gp,0xfc0
  400554:	279c7ae0 	addiu	gp,gp,31456
  400558:	0399e021 	addu	gp,gp,t9
  40055c:	27bdffe0 	addiu	sp,sp,-32
  400560:	afbc0010 	sw	gp,16(sp)
  400564:	8f82801c 	lw	v0,-32740(gp)
  400568:	00000000 	nop
  40056c:	24420080 	addiu	v0,v0,128
  400570:	90420000 	lbu	v0,0(v0)
  400574:	afbf001c 	sw	ra,28(sp)
  400578:	14400021 	bnez	v0,400600 <__do_global_dtors_aux+0xb0>
  40057c:	afbc0018 	sw	gp,24(sp)
  400580:	8f82801c 	lw	v0,-32740(gp)
  400584:	00000000 	nop
  400588:	24420014 	addiu	v0,v0,20
  40058c:	8c420000 	lw	v0,0(v0)
  400590:	00000000 	nop
  400594:	8c430000 	lw	v1,0(v0)
  400598:	00000000 	nop
  40059c:	10600013 	beqz	v1,4005ec <__do_global_dtors_aux+0x9c>
  4005a0:	24420004 	addiu	v0,v0,4
  4005a4:	8f81801c 	lw	at,-32740(gp)
  4005a8:	00000000 	nop
  4005ac:	24210014 	addiu	at,at,20
  4005b0:	ac220000 	sw	v0,0(at)
  4005b4:	0060c821 	move	t9,v1
  4005b8:	0320f809 	jalr	t9
  4005bc:	00000000 	nop
  4005c0:	8fbc0010 	lw	gp,16(sp)
  4005c4:	00000000 	nop
  4005c8:	8f82801c 	lw	v0,-32740(gp)
  4005cc:	00000000 	nop
  4005d0:	24420014 	addiu	v0,v0,20
  4005d4:	8c420000 	lw	v0,0(v0)
  4005d8:	00000000 	nop
  4005dc:	8c430000 	lw	v1,0(v0)
  4005e0:	00000000 	nop
  4005e4:	1460ffef 	bnez	v1,4005a4 <__do_global_dtors_aux+0x54>
  4005e8:	24420004 	addiu	v0,v0,4
  4005ec:	24020001 	li	v0,1
  4005f0:	8f81801c 	lw	at,-32740(gp)
  4005f4:	00000000 	nop
  4005f8:	24210080 	addiu	at,at,128
  4005fc:	a0220000 	sb	v0,0(at)
  400600:	8fbf001c 	lw	ra,28(sp)
  400604:	00000000 	nop
  400608:	03e00008 	jr	ra
  40060c:	27bd0020 	addiu	sp,sp,32

00400610 <call___do_global_dtors_aux>:
  400610:	3c1c0fc0 	lui	gp,0xfc0
  400614:	279c7a20 	addiu	gp,gp,31264
  400618:	0399e021 	addu	gp,gp,t9
  40061c:	27bdffe0 	addiu	sp,sp,-32
  400620:	afbc0010 	sw	gp,16(sp)
  400624:	afbf001c 	sw	ra,28(sp)
  400628:	afbc0018 	sw	gp,24(sp)
  40062c:	8fbf001c 	lw	ra,28(sp)
  400630:	00000000 	nop
  400634:	03e00008 	jr	ra
  400638:	27bd0020 	addiu	sp,sp,32

0040063c <frame_dummy>:
  40063c:	3c1c0fc0 	lui	gp,0xfc0
  400640:	279c79f4 	addiu	gp,gp,31220
  400644:	0399e021 	addu	gp,gp,t9
  400648:	27bdffe0 	addiu	sp,sp,-32
  40064c:	afbc0010 	sw	gp,16(sp)
  400650:	afbf001c 	sw	ra,28(sp)
  400654:	8f84801c 	lw	a0,-32740(gp)
  400658:	00000000 	nop
  40065c:	24840038 	addiu	a0,a0,56
  400660:	8f838030 	lw	v1,-32720(gp)
  400664:	afbc0018 	sw	gp,24(sp)
  400668:	8c820000 	lw	v0,0(a0)
  40066c:	00000000 	nop
  400670:	10400007 	beqz	v0,400690 <frame_dummy+0x54>
  400674:	00000000 	nop
  400678:	10600005 	beqz	v1,400690 <frame_dummy+0x54>
  40067c:	00000000 	nop
  400680:	0060c821 	move	t9,v1
  400684:	0320f809 	jalr	t9
  400688:	00000000 	nop
  40068c:	8fbc0010 	lw	gp,16(sp)
  400690:	8fbf001c 	lw	ra,28(sp)
  400694:	00000000 	nop
  400698:	03e00008 	jr	ra
  40069c:	27bd0020 	addiu	sp,sp,32

004006a0 <call_frame_dummy>:
  4006a0:	3c1c0fc0 	lui	gp,0xfc0
  4006a4:	279c7990 	addiu	gp,gp,31120
  4006a8:	0399e021 	addu	gp,gp,t9
  4006ac:	27bdffe0 	addiu	sp,sp,-32
  4006b0:	afbc0010 	sw	gp,16(sp)
  4006b4:	afbf001c 	sw	ra,28(sp)
  4006b8:	afbc0018 	sw	gp,24(sp)
  4006bc:	8fbf001c 	lw	ra,28(sp)
  4006c0:	00000000 	nop
  4006c4:	03e00008 	jr	ra
  4006c8:	27bd0020 	addiu	sp,sp,32
  4006cc:	00000000 	nop

004006d0 <main>:
  4006d0:	3c1c0fc0 	lui	gp,0xfc0
  4006d4:	279c7960 	addiu	gp,gp,31072
  4006d8:	0399e021 	addu	gp,gp,t9
  4006dc:	27bdffe0 	addiu	sp,sp,-32
  4006e0:	afbc0000 	sw	gp,0(sp)
  4006e4:	afbe001c 	sw	s8,28(sp)
  4006e8:	afbc0018 	sw	gp,24(sp)
  4006ec:	03a0f021 	move	s8,sp
  4006f0:	24020001 	li	v0,1
  4006f4:	afc20008 	sw	v0,8(s8)
  4006f8:	24020002 	li	v0,2
  4006fc:	afc2000c 	sw	v0,12(s8)
  400700:	afc00010 	sw	zero,16(s8)
  400704:	8fc20008 	lw	v0,8(s8)
  400708:	8fc3000c 	lw	v1,12(s8)
  40070c:	00000000 	nop
  400710:	00431021 	addu	v0,v0,v1
  400714:	1000fffb 	b	400704 <main+0x34>
  400718:	afc20010 	sw	v0,16(s8)
  40071c:	00000000 	nop

00400720 <__do_global_ctors_aux>:
  400720:	3c1c0fc0 	lui	gp,0xfc0
  400724:	279c7910 	addiu	gp,gp,30992
  400728:	0399e021 	addu	gp,gp,t9
  40072c:	27bdffd8 	addiu	sp,sp,-40
  400730:	afbc0010 	sw	gp,16(sp)
  400734:	afb00018 	sw	s0,24(sp)
  400738:	8f82801c 	lw	v0,-32740(gp)
  40073c:	00000000 	nop
  400740:	2442002c 	addiu	v0,v0,44
  400744:	2403ffff 	li	v1,-1
  400748:	afbf0024 	sw	ra,36(sp)
  40074c:	afbc0020 	sw	gp,32(sp)
  400750:	afb1001c 	sw	s1,28(sp)
  400754:	8c44fffc 	lw	a0,-4(v0)
  400758:	00000000 	nop
  40075c:	1083000f 	beq	a0,v1,40079c <__do_global_ctors_aux+0x7c>
  400760:	2450fffc 	addiu	s0,v0,-4
  400764:	8f83801c 	lw	v1,-32740(gp)
  400768:	00000000 	nop
  40076c:	2463002c 	addiu	v1,v1,44
  400770:	8c63fffc 	lw	v1,-4(v1)
  400774:	2411ffff 	li	s1,-1
  400778:	2610fffc 	addiu	s0,s0,-4
  40077c:	0060c821 	move	t9,v1
  400780:	0320f809 	jalr	t9
  400784:	00000000 	nop
  400788:	8fbc0010 	lw	gp,16(sp)
  40078c:	8e020000 	lw	v0,0(s0)
  400790:	00000000 	nop
  400794:	1451fff8 	bne	v0,s1,400778 <__do_global_ctors_aux+0x58>
  400798:	00401821 	move	v1,v0
  40079c:	8fbf0024 	lw	ra,36(sp)
  4007a0:	8fb1001c 	lw	s1,28(sp)
  4007a4:	8fb00018 	lw	s0,24(sp)
  4007a8:	03e00008 	jr	ra
  4007ac:	27bd0028 	addiu	sp,sp,40

004007b0 <call___do_global_ctors_aux>:
  4007b0:	3c1c0fc0 	lui	gp,0xfc0
  4007b4:	279c7880 	addiu	gp,gp,30848
  4007b8:	0399e021 	addu	gp,gp,t9
  4007bc:	27bdffe0 	addiu	sp,sp,-32
  4007c0:	afbc0010 	sw	gp,16(sp)
  4007c4:	afbf001c 	sw	ra,28(sp)
  4007c8:	afbc0018 	sw	gp,24(sp)
  4007cc:	8fbf001c 	lw	ra,28(sp)
  4007d0:	00000000 	nop
  4007d4:	03e00008 	jr	ra
  4007d8:	27bd0020 	addiu	sp,sp,32
  4007dc:	00000000 	nop
Disassembly of section .fini:

004007e0 <_fini>:
  4007e0:	3c1c0fc0 	lui	gp,0xfc0
  4007e4:	279c7850 	addiu	gp,gp,30800
  4007e8:	0399e021 	addu	gp,gp,t9
  4007ec:	27bdffe0 	addiu	sp,sp,-32
  4007f0:	afbc0010 	sw	gp,16(sp)
  4007f4:	afbf001c 	sw	ra,28(sp)
  4007f8:	afbc0018 	sw	gp,24(sp)
  4007fc:	00000000 	nop
  400800:	8f998018 	lw	t9,-32744(gp)
  400804:	00000000 	nop
  400808:	27390550 	addiu	t9,t9,1360
  40080c:	00000000 	nop
  400810:	0320f809 	jalr	t9
  400814:	00000000 	nop
  400818:	8fbc0010 	lw	gp,16(sp)
  40081c:	00000000 	nop
  400820:	8fbf001c 	lw	ra,28(sp)
  400824:	00000000 	nop
  400828:	03e00008 	jr	ra
  40082c:	27bd0020 	addiu	sp,sp,32

--=-yRcc9hJc2nJX+maAD6p5
Content-Disposition: attachment; filename=while-noinit-dis
Content-Type: text/plain; name=while-noinit-dis; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


while-noinit:     file format elf32-tradbigmips

Disassembly of section .init:

004003f0 <_init>:
  4003f0:	3c1c0fc0 	lui	gp,0xfc0
  4003f4:	279c7c40 	addiu	gp,gp,31808
  4003f8:	0399e021 	addu	gp,gp,t9
  4003fc:	27bdffe0 	addiu	sp,sp,-32
  400400:	afbc0010 	sw	gp,16(sp)
  400404:	afbf001c 	sw	ra,28(sp)
  400408:	afbc0018 	sw	gp,24(sp)
  40040c:	8f998018 	lw	t9,-32744(gp)
  400410:	00000000 	nop
  400414:	27390500 	addiu	t9,t9,1280
	...
  400420:	0320f809 	jalr	t9
  400424:	00000000 	nop
  400428:	8fbc0010 	lw	gp,16(sp)
  40042c:	00000000 	nop
  400430:	8f998018 	lw	t9,-32744(gp)
  400434:	00000000 	nop
  400438:	2739063c 	addiu	t9,t9,1596
  40043c:	00000000 	nop
  400440:	0320f809 	jalr	t9
  400444:	00000000 	nop
  400448:	8fbc0010 	lw	gp,16(sp)
  40044c:	00000000 	nop
  400450:	8f998018 	lw	t9,-32744(gp)
  400454:	00000000 	nop
  400458:	27390720 	addiu	t9,t9,1824
  40045c:	00000000 	nop
  400460:	0320f809 	jalr	t9
  400464:	00000000 	nop
  400468:	8fbc0010 	lw	gp,16(sp)
  40046c:	00000000 	nop
  400470:	8fbf001c 	lw	ra,28(sp)
  400474:	00000000 	nop
  400478:	03e00008 	jr	ra
  40047c:	27bd0020 	addiu	sp,sp,32
Disassembly of section .text:

00400480 <__start>:
  400480:	04100001 	bltzal	zero,400488 <__start+0x8>
  400484:	00000000 	nop
  400488:	3c1c0fc0 	lui	gp,0xfc0
  40048c:	279c7ba8 	addiu	gp,gp,31656
  400490:	039fe021 	addu	gp,gp,ra
  400494:	0000f821 	move	ra,zero
  400498:	8f84803c 	lw	a0,-32708(gp)
  40049c:	8fa50000 	lw	a1,0(sp)
  4004a0:	27a60004 	addiu	a2,sp,4
  4004a4:	3c01ffff 	lui	at,0xffff
  4004a8:	3421fff8 	ori	at,at,0xfff8
  4004ac:	03a1e824 	and	sp,sp,at
  4004b0:	27bdffe0 	addiu	sp,sp,-32
  4004b4:	8f878040 	lw	a3,-32704(gp)
  4004b8:	8f888034 	lw	t0,-32716(gp)
  4004bc:	00000000 	nop
  4004c0:	afa80010 	sw	t0,16(sp)
  4004c4:	afa20014 	sw	v0,20(sp)
  4004c8:	afbd0018 	sw	sp,24(sp)
  4004cc:	8f998038 	lw	t9,-32712(gp)
  4004d0:	00000000 	nop
  4004d4:	0320f809 	jalr	t9
  4004d8:	00000000 	nop

004004dc <hlt>:
  4004dc:	1000ffff 	b	4004dc <hlt>
  4004e0:	00000000 	nop
	...

00400500 <call_gmon_start>:
  400500:	3c1c0fc0 	lui	gp,0xfc0
  400504:	279c7b30 	addiu	gp,gp,31536
  400508:	0399e021 	addu	gp,gp,t9
  40050c:	27bdffe0 	addiu	sp,sp,-32
  400510:	afbc0010 	sw	gp,16(sp)
  400514:	afbf001c 	sw	ra,28(sp)
  400518:	8f82802c 	lw	v0,-32724(gp)
  40051c:	00000000 	nop
  400520:	10400006 	beqz	v0,40053c <call_gmon_start+0x3c>
  400524:	afbc0018 	sw	gp,24(sp)
  400528:	0040c821 	move	t9,v0
  40052c:	00000000 	nop
  400530:	0320f809 	jalr	t9
  400534:	00000000 	nop
  400538:	8fbc0010 	lw	gp,16(sp)
  40053c:	8fbf001c 	lw	ra,28(sp)
	...
  400548:	03e00008 	jr	ra
  40054c:	27bd0020 	addiu	sp,sp,32

00400550 <__do_global_dtors_aux>:
  400550:	3c1c0fc0 	lui	gp,0xfc0
  400554:	279c7ae0 	addiu	gp,gp,31456
  400558:	0399e021 	addu	gp,gp,t9
  40055c:	27bdffe0 	addiu	sp,sp,-32
  400560:	afbc0010 	sw	gp,16(sp)
  400564:	8f82801c 	lw	v0,-32740(gp)
  400568:	00000000 	nop
  40056c:	24420080 	addiu	v0,v0,128
  400570:	90420000 	lbu	v0,0(v0)
  400574:	afbf001c 	sw	ra,28(sp)
  400578:	14400021 	bnez	v0,400600 <__do_global_dtors_aux+0xb0>
  40057c:	afbc0018 	sw	gp,24(sp)
  400580:	8f82801c 	lw	v0,-32740(gp)
  400584:	00000000 	nop
  400588:	24420014 	addiu	v0,v0,20
  40058c:	8c420000 	lw	v0,0(v0)
  400590:	00000000 	nop
  400594:	8c430000 	lw	v1,0(v0)
  400598:	00000000 	nop
  40059c:	10600013 	beqz	v1,4005ec <__do_global_dtors_aux+0x9c>
  4005a0:	24420004 	addiu	v0,v0,4
  4005a4:	8f81801c 	lw	at,-32740(gp)
  4005a8:	00000000 	nop
  4005ac:	24210014 	addiu	at,at,20
  4005b0:	ac220000 	sw	v0,0(at)
  4005b4:	0060c821 	move	t9,v1
  4005b8:	0320f809 	jalr	t9
  4005bc:	00000000 	nop
  4005c0:	8fbc0010 	lw	gp,16(sp)
  4005c4:	00000000 	nop
  4005c8:	8f82801c 	lw	v0,-32740(gp)
  4005cc:	00000000 	nop
  4005d0:	24420014 	addiu	v0,v0,20
  4005d4:	8c420000 	lw	v0,0(v0)
  4005d8:	00000000 	nop
  4005dc:	8c430000 	lw	v1,0(v0)
  4005e0:	00000000 	nop
  4005e4:	1460ffef 	bnez	v1,4005a4 <__do_global_dtors_aux+0x54>
  4005e8:	24420004 	addiu	v0,v0,4
  4005ec:	24020001 	li	v0,1
  4005f0:	8f81801c 	lw	at,-32740(gp)
  4005f4:	00000000 	nop
  4005f8:	24210080 	addiu	at,at,128
  4005fc:	a0220000 	sb	v0,0(at)
  400600:	8fbf001c 	lw	ra,28(sp)
  400604:	00000000 	nop
  400608:	03e00008 	jr	ra
  40060c:	27bd0020 	addiu	sp,sp,32

00400610 <call___do_global_dtors_aux>:
  400610:	3c1c0fc0 	lui	gp,0xfc0
  400614:	279c7a20 	addiu	gp,gp,31264
  400618:	0399e021 	addu	gp,gp,t9
  40061c:	27bdffe0 	addiu	sp,sp,-32
  400620:	afbc0010 	sw	gp,16(sp)
  400624:	afbf001c 	sw	ra,28(sp)
  400628:	afbc0018 	sw	gp,24(sp)
  40062c:	8fbf001c 	lw	ra,28(sp)
  400630:	00000000 	nop
  400634:	03e00008 	jr	ra
  400638:	27bd0020 	addiu	sp,sp,32

0040063c <frame_dummy>:
  40063c:	3c1c0fc0 	lui	gp,0xfc0
  400640:	279c79f4 	addiu	gp,gp,31220
  400644:	0399e021 	addu	gp,gp,t9
  400648:	27bdffe0 	addiu	sp,sp,-32
  40064c:	afbc0010 	sw	gp,16(sp)
  400650:	afbf001c 	sw	ra,28(sp)
  400654:	8f84801c 	lw	a0,-32740(gp)
  400658:	00000000 	nop
  40065c:	24840038 	addiu	a0,a0,56
  400660:	8f838030 	lw	v1,-32720(gp)
  400664:	afbc0018 	sw	gp,24(sp)
  400668:	8c820000 	lw	v0,0(a0)
  40066c:	00000000 	nop
  400670:	10400007 	beqz	v0,400690 <frame_dummy+0x54>
  400674:	00000000 	nop
  400678:	10600005 	beqz	v1,400690 <frame_dummy+0x54>
  40067c:	00000000 	nop
  400680:	0060c821 	move	t9,v1
  400684:	0320f809 	jalr	t9
  400688:	00000000 	nop
  40068c:	8fbc0010 	lw	gp,16(sp)
  400690:	8fbf001c 	lw	ra,28(sp)
  400694:	00000000 	nop
  400698:	03e00008 	jr	ra
  40069c:	27bd0020 	addiu	sp,sp,32

004006a0 <call_frame_dummy>:
  4006a0:	3c1c0fc0 	lui	gp,0xfc0
  4006a4:	279c7990 	addiu	gp,gp,31120
  4006a8:	0399e021 	addu	gp,gp,t9
  4006ac:	27bdffe0 	addiu	sp,sp,-32
  4006b0:	afbc0010 	sw	gp,16(sp)
  4006b4:	afbf001c 	sw	ra,28(sp)
  4006b8:	afbc0018 	sw	gp,24(sp)
  4006bc:	8fbf001c 	lw	ra,28(sp)
  4006c0:	00000000 	nop
  4006c4:	03e00008 	jr	ra
  4006c8:	27bd0020 	addiu	sp,sp,32
  4006cc:	00000000 	nop

004006d0 <main>:
  4006d0:	3c1c0fc0 	lui	gp,0xfc0
  4006d4:	279c7960 	addiu	gp,gp,31072
  4006d8:	0399e021 	addu	gp,gp,t9
  4006dc:	27bdffe0 	addiu	sp,sp,-32
  4006e0:	afbc0000 	sw	gp,0(sp)
  4006e4:	afbe001c 	sw	s8,28(sp)
  4006e8:	afbc0018 	sw	gp,24(sp)
  4006ec:	03a0f021 	move	s8,sp
  4006f0:	24020001 	li	v0,1
  4006f4:	afc20008 	sw	v0,8(s8)
  4006f8:	24020002 	li	v0,2
  4006fc:	afc2000c 	sw	v0,12(s8)
  400700:	8fc20008 	lw	v0,8(s8)
  400704:	8fc3000c 	lw	v1,12(s8)
  400708:	00000000 	nop
  40070c:	00431021 	addu	v0,v0,v1
  400710:	1000fffb 	b	400700 <main+0x30>
  400714:	afc20010 	sw	v0,16(s8)
	...

00400720 <__do_global_ctors_aux>:
  400720:	3c1c0fc0 	lui	gp,0xfc0
  400724:	279c7910 	addiu	gp,gp,30992
  400728:	0399e021 	addu	gp,gp,t9
  40072c:	27bdffd8 	addiu	sp,sp,-40
  400730:	afbc0010 	sw	gp,16(sp)
  400734:	afb00018 	sw	s0,24(sp)
  400738:	8f82801c 	lw	v0,-32740(gp)
  40073c:	00000000 	nop
  400740:	2442002c 	addiu	v0,v0,44
  400744:	2403ffff 	li	v1,-1
  400748:	afbf0024 	sw	ra,36(sp)
  40074c:	afbc0020 	sw	gp,32(sp)
  400750:	afb1001c 	sw	s1,28(sp)
  400754:	8c44fffc 	lw	a0,-4(v0)
  400758:	00000000 	nop
  40075c:	1083000f 	beq	a0,v1,40079c <__do_global_ctors_aux+0x7c>
  400760:	2450fffc 	addiu	s0,v0,-4
  400764:	8f83801c 	lw	v1,-32740(gp)
  400768:	00000000 	nop
  40076c:	2463002c 	addiu	v1,v1,44
  400770:	8c63fffc 	lw	v1,-4(v1)
  400774:	2411ffff 	li	s1,-1
  400778:	2610fffc 	addiu	s0,s0,-4
  40077c:	0060c821 	move	t9,v1
  400780:	0320f809 	jalr	t9
  400784:	00000000 	nop
  400788:	8fbc0010 	lw	gp,16(sp)
  40078c:	8e020000 	lw	v0,0(s0)
  400790:	00000000 	nop
  400794:	1451fff8 	bne	v0,s1,400778 <__do_global_ctors_aux+0x58>
  400798:	00401821 	move	v1,v0
  40079c:	8fbf0024 	lw	ra,36(sp)
  4007a0:	8fb1001c 	lw	s1,28(sp)
  4007a4:	8fb00018 	lw	s0,24(sp)
  4007a8:	03e00008 	jr	ra
  4007ac:	27bd0028 	addiu	sp,sp,40

004007b0 <call___do_global_ctors_aux>:
  4007b0:	3c1c0fc0 	lui	gp,0xfc0
  4007b4:	279c7880 	addiu	gp,gp,30848
  4007b8:	0399e021 	addu	gp,gp,t9
  4007bc:	27bdffe0 	addiu	sp,sp,-32
  4007c0:	afbc0010 	sw	gp,16(sp)
  4007c4:	afbf001c 	sw	ra,28(sp)
  4007c8:	afbc0018 	sw	gp,24(sp)
  4007cc:	8fbf001c 	lw	ra,28(sp)
  4007d0:	00000000 	nop
  4007d4:	03e00008 	jr	ra
  4007d8:	27bd0020 	addiu	sp,sp,32
  4007dc:	00000000 	nop
Disassembly of section .fini:

004007e0 <_fini>:
  4007e0:	3c1c0fc0 	lui	gp,0xfc0
  4007e4:	279c7850 	addiu	gp,gp,30800
  4007e8:	0399e021 	addu	gp,gp,t9
  4007ec:	27bdffe0 	addiu	sp,sp,-32
  4007f0:	afbc0010 	sw	gp,16(sp)
  4007f4:	afbf001c 	sw	ra,28(sp)
  4007f8:	afbc0018 	sw	gp,24(sp)
  4007fc:	00000000 	nop
  400800:	8f998018 	lw	t9,-32744(gp)
  400804:	00000000 	nop
  400808:	27390550 	addiu	t9,t9,1360
  40080c:	00000000 	nop
  400810:	0320f809 	jalr	t9
  400814:	00000000 	nop
  400818:	8fbc0010 	lw	gp,16(sp)
  40081c:	00000000 	nop
  400820:	8fbf001c 	lw	ra,28(sp)
  400824:	00000000 	nop
  400828:	03e00008 	jr	ra
  40082c:	27bd0020 	addiu	sp,sp,32

--=-yRcc9hJc2nJX+maAD6p5
Content-Disposition: attachment; filename=while-nop-dis
Content-Type: text/plain; name=while-nop-dis; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


while-nop:     file format elf32-tradbigmips

Disassembly of section .init:

004003f0 <_init>:
  4003f0:	3c1c0fc0 	lui	gp,0xfc0
  4003f4:	279c7c40 	addiu	gp,gp,31808
  4003f8:	0399e021 	addu	gp,gp,t9
  4003fc:	27bdffe0 	addiu	sp,sp,-32
  400400:	afbc0010 	sw	gp,16(sp)
  400404:	afbf001c 	sw	ra,28(sp)
  400408:	afbc0018 	sw	gp,24(sp)
  40040c:	8f998018 	lw	t9,-32744(gp)
  400410:	00000000 	nop
  400414:	27390500 	addiu	t9,t9,1280
	...
  400420:	0320f809 	jalr	t9
  400424:	00000000 	nop
  400428:	8fbc0010 	lw	gp,16(sp)
  40042c:	00000000 	nop
  400430:	8f998018 	lw	t9,-32744(gp)
  400434:	00000000 	nop
  400438:	2739063c 	addiu	t9,t9,1596
  40043c:	00000000 	nop
  400440:	0320f809 	jalr	t9
  400444:	00000000 	nop
  400448:	8fbc0010 	lw	gp,16(sp)
  40044c:	00000000 	nop
  400450:	8f998018 	lw	t9,-32744(gp)
  400454:	00000000 	nop
  400458:	27390720 	addiu	t9,t9,1824
  40045c:	00000000 	nop
  400460:	0320f809 	jalr	t9
  400464:	00000000 	nop
  400468:	8fbc0010 	lw	gp,16(sp)
  40046c:	00000000 	nop
  400470:	8fbf001c 	lw	ra,28(sp)
  400474:	00000000 	nop
  400478:	03e00008 	jr	ra
  40047c:	27bd0020 	addiu	sp,sp,32
Disassembly of section .text:

00400480 <__start>:
  400480:	04100001 	bltzal	zero,400488 <__start+0x8>
  400484:	00000000 	nop
  400488:	3c1c0fc0 	lui	gp,0xfc0
  40048c:	279c7ba8 	addiu	gp,gp,31656
  400490:	039fe021 	addu	gp,gp,ra
  400494:	0000f821 	move	ra,zero
  400498:	8f84803c 	lw	a0,-32708(gp)
  40049c:	8fa50000 	lw	a1,0(sp)
  4004a0:	27a60004 	addiu	a2,sp,4
  4004a4:	3c01ffff 	lui	at,0xffff
  4004a8:	3421fff8 	ori	at,at,0xfff8
  4004ac:	03a1e824 	and	sp,sp,at
  4004b0:	27bdffe0 	addiu	sp,sp,-32
  4004b4:	8f878040 	lw	a3,-32704(gp)
  4004b8:	8f888034 	lw	t0,-32716(gp)
  4004bc:	00000000 	nop
  4004c0:	afa80010 	sw	t0,16(sp)
  4004c4:	afa20014 	sw	v0,20(sp)
  4004c8:	afbd0018 	sw	sp,24(sp)
  4004cc:	8f998038 	lw	t9,-32712(gp)
  4004d0:	00000000 	nop
  4004d4:	0320f809 	jalr	t9
  4004d8:	00000000 	nop

004004dc <hlt>:
  4004dc:	1000ffff 	b	4004dc <hlt>
  4004e0:	00000000 	nop
	...

00400500 <call_gmon_start>:
  400500:	3c1c0fc0 	lui	gp,0xfc0
  400504:	279c7b30 	addiu	gp,gp,31536
  400508:	0399e021 	addu	gp,gp,t9
  40050c:	27bdffe0 	addiu	sp,sp,-32
  400510:	afbc0010 	sw	gp,16(sp)
  400514:	afbf001c 	sw	ra,28(sp)
  400518:	8f82802c 	lw	v0,-32724(gp)
  40051c:	00000000 	nop
  400520:	10400006 	beqz	v0,40053c <call_gmon_start+0x3c>
  400524:	afbc0018 	sw	gp,24(sp)
  400528:	0040c821 	move	t9,v0
  40052c:	00000000 	nop
  400530:	0320f809 	jalr	t9
  400534:	00000000 	nop
  400538:	8fbc0010 	lw	gp,16(sp)
  40053c:	8fbf001c 	lw	ra,28(sp)
	...
  400548:	03e00008 	jr	ra
  40054c:	27bd0020 	addiu	sp,sp,32

00400550 <__do_global_dtors_aux>:
  400550:	3c1c0fc0 	lui	gp,0xfc0
  400554:	279c7ae0 	addiu	gp,gp,31456
  400558:	0399e021 	addu	gp,gp,t9
  40055c:	27bdffe0 	addiu	sp,sp,-32
  400560:	afbc0010 	sw	gp,16(sp)
  400564:	8f82801c 	lw	v0,-32740(gp)
  400568:	00000000 	nop
  40056c:	24420080 	addiu	v0,v0,128
  400570:	90420000 	lbu	v0,0(v0)
  400574:	afbf001c 	sw	ra,28(sp)
  400578:	14400021 	bnez	v0,400600 <__do_global_dtors_aux+0xb0>
  40057c:	afbc0018 	sw	gp,24(sp)
  400580:	8f82801c 	lw	v0,-32740(gp)
  400584:	00000000 	nop
  400588:	24420014 	addiu	v0,v0,20
  40058c:	8c420000 	lw	v0,0(v0)
  400590:	00000000 	nop
  400594:	8c430000 	lw	v1,0(v0)
  400598:	00000000 	nop
  40059c:	10600013 	beqz	v1,4005ec <__do_global_dtors_aux+0x9c>
  4005a0:	24420004 	addiu	v0,v0,4
  4005a4:	8f81801c 	lw	at,-32740(gp)
  4005a8:	00000000 	nop
  4005ac:	24210014 	addiu	at,at,20
  4005b0:	ac220000 	sw	v0,0(at)
  4005b4:	0060c821 	move	t9,v1
  4005b8:	0320f809 	jalr	t9
  4005bc:	00000000 	nop
  4005c0:	8fbc0010 	lw	gp,16(sp)
  4005c4:	00000000 	nop
  4005c8:	8f82801c 	lw	v0,-32740(gp)
  4005cc:	00000000 	nop
  4005d0:	24420014 	addiu	v0,v0,20
  4005d4:	8c420000 	lw	v0,0(v0)
  4005d8:	00000000 	nop
  4005dc:	8c430000 	lw	v1,0(v0)
  4005e0:	00000000 	nop
  4005e4:	1460ffef 	bnez	v1,4005a4 <__do_global_dtors_aux+0x54>
  4005e8:	24420004 	addiu	v0,v0,4
  4005ec:	24020001 	li	v0,1
  4005f0:	8f81801c 	lw	at,-32740(gp)
  4005f4:	00000000 	nop
  4005f8:	24210080 	addiu	at,at,128
  4005fc:	a0220000 	sb	v0,0(at)
  400600:	8fbf001c 	lw	ra,28(sp)
  400604:	00000000 	nop
  400608:	03e00008 	jr	ra
  40060c:	27bd0020 	addiu	sp,sp,32

00400610 <call___do_global_dtors_aux>:
  400610:	3c1c0fc0 	lui	gp,0xfc0
  400614:	279c7a20 	addiu	gp,gp,31264
  400618:	0399e021 	addu	gp,gp,t9
  40061c:	27bdffe0 	addiu	sp,sp,-32
  400620:	afbc0010 	sw	gp,16(sp)
  400624:	afbf001c 	sw	ra,28(sp)
  400628:	afbc0018 	sw	gp,24(sp)
  40062c:	8fbf001c 	lw	ra,28(sp)
  400630:	00000000 	nop
  400634:	03e00008 	jr	ra
  400638:	27bd0020 	addiu	sp,sp,32

0040063c <frame_dummy>:
  40063c:	3c1c0fc0 	lui	gp,0xfc0
  400640:	279c79f4 	addiu	gp,gp,31220
  400644:	0399e021 	addu	gp,gp,t9
  400648:	27bdffe0 	addiu	sp,sp,-32
  40064c:	afbc0010 	sw	gp,16(sp)
  400650:	afbf001c 	sw	ra,28(sp)
  400654:	8f84801c 	lw	a0,-32740(gp)
  400658:	00000000 	nop
  40065c:	24840038 	addiu	a0,a0,56
  400660:	8f838030 	lw	v1,-32720(gp)
  400664:	afbc0018 	sw	gp,24(sp)
  400668:	8c820000 	lw	v0,0(a0)
  40066c:	00000000 	nop
  400670:	10400007 	beqz	v0,400690 <frame_dummy+0x54>
  400674:	00000000 	nop
  400678:	10600005 	beqz	v1,400690 <frame_dummy+0x54>
  40067c:	00000000 	nop
  400680:	0060c821 	move	t9,v1
  400684:	0320f809 	jalr	t9
  400688:	00000000 	nop
  40068c:	8fbc0010 	lw	gp,16(sp)
  400690:	8fbf001c 	lw	ra,28(sp)
  400694:	00000000 	nop
  400698:	03e00008 	jr	ra
  40069c:	27bd0020 	addiu	sp,sp,32

004006a0 <call_frame_dummy>:
  4006a0:	3c1c0fc0 	lui	gp,0xfc0
  4006a4:	279c7990 	addiu	gp,gp,31120
  4006a8:	0399e021 	addu	gp,gp,t9
  4006ac:	27bdffe0 	addiu	sp,sp,-32
  4006b0:	afbc0010 	sw	gp,16(sp)
  4006b4:	afbf001c 	sw	ra,28(sp)
  4006b8:	afbc0018 	sw	gp,24(sp)
  4006bc:	8fbf001c 	lw	ra,28(sp)
  4006c0:	00000000 	nop
  4006c4:	03e00008 	jr	ra
  4006c8:	27bd0020 	addiu	sp,sp,32
  4006cc:	00000000 	nop

004006d0 <main>:
  4006d0:	3c1c0fc0 	lui	gp,0xfc0
  4006d4:	279c7960 	addiu	gp,gp,31072
  4006d8:	0399e021 	addu	gp,gp,t9
  4006dc:	27bdffe0 	addiu	sp,sp,-32
  4006e0:	afbc0000 	sw	gp,0(sp)
  4006e4:	afbe001c 	sw	s8,28(sp)
  4006e8:	afbc0018 	sw	gp,24(sp)
  4006ec:	03a0f021 	move	s8,sp
  4006f0:	24020001 	li	v0,1
  4006f4:	afc20008 	sw	v0,8(s8)
  4006f8:	24020002 	li	v0,2
  4006fc:	afc2000c 	sw	v0,12(s8)
  400700:	00000000 	nop
  400704:	8fc20008 	lw	v0,8(s8)
  400708:	8fc3000c 	lw	v1,12(s8)
  40070c:	00000000 	nop
  400710:	00431021 	addu	v0,v0,v1
  400714:	1000fffb 	b	400704 <main+0x34>
  400718:	afc20010 	sw	v0,16(s8)
  40071c:	00000000 	nop

00400720 <__do_global_ctors_aux>:
  400720:	3c1c0fc0 	lui	gp,0xfc0
  400724:	279c7910 	addiu	gp,gp,30992
  400728:	0399e021 	addu	gp,gp,t9
  40072c:	27bdffd8 	addiu	sp,sp,-40
  400730:	afbc0010 	sw	gp,16(sp)
  400734:	afb00018 	sw	s0,24(sp)
  400738:	8f82801c 	lw	v0,-32740(gp)
  40073c:	00000000 	nop
  400740:	2442002c 	addiu	v0,v0,44
  400744:	2403ffff 	li	v1,-1
  400748:	afbf0024 	sw	ra,36(sp)
  40074c:	afbc0020 	sw	gp,32(sp)
  400750:	afb1001c 	sw	s1,28(sp)
  400754:	8c44fffc 	lw	a0,-4(v0)
  400758:	00000000 	nop
  40075c:	1083000f 	beq	a0,v1,40079c <__do_global_ctors_aux+0x7c>
  400760:	2450fffc 	addiu	s0,v0,-4
  400764:	8f83801c 	lw	v1,-32740(gp)
  400768:	00000000 	nop
  40076c:	2463002c 	addiu	v1,v1,44
  400770:	8c63fffc 	lw	v1,-4(v1)
  400774:	2411ffff 	li	s1,-1
  400778:	2610fffc 	addiu	s0,s0,-4
  40077c:	0060c821 	move	t9,v1
  400780:	0320f809 	jalr	t9
  400784:	00000000 	nop
  400788:	8fbc0010 	lw	gp,16(sp)
  40078c:	8e020000 	lw	v0,0(s0)
  400790:	00000000 	nop
  400794:	1451fff8 	bne	v0,s1,400778 <__do_global_ctors_aux+0x58>
  400798:	00401821 	move	v1,v0
  40079c:	8fbf0024 	lw	ra,36(sp)
  4007a0:	8fb1001c 	lw	s1,28(sp)
  4007a4:	8fb00018 	lw	s0,24(sp)
  4007a8:	03e00008 	jr	ra
  4007ac:	27bd0028 	addiu	sp,sp,40

004007b0 <call___do_global_ctors_aux>:
  4007b0:	3c1c0fc0 	lui	gp,0xfc0
  4007b4:	279c7880 	addiu	gp,gp,30848
  4007b8:	0399e021 	addu	gp,gp,t9
  4007bc:	27bdffe0 	addiu	sp,sp,-32
  4007c0:	afbc0010 	sw	gp,16(sp)
  4007c4:	afbf001c 	sw	ra,28(sp)
  4007c8:	afbc0018 	sw	gp,24(sp)
  4007cc:	8fbf001c 	lw	ra,28(sp)
  4007d0:	00000000 	nop
  4007d4:	03e00008 	jr	ra
  4007d8:	27bd0020 	addiu	sp,sp,32
  4007dc:	00000000 	nop
Disassembly of section .fini:

004007e0 <_fini>:
  4007e0:	3c1c0fc0 	lui	gp,0xfc0
  4007e4:	279c7850 	addiu	gp,gp,30800
  4007e8:	0399e021 	addu	gp,gp,t9
  4007ec:	27bdffe0 	addiu	sp,sp,-32
  4007f0:	afbc0010 	sw	gp,16(sp)
  4007f4:	afbf001c 	sw	ra,28(sp)
  4007f8:	afbc0018 	sw	gp,24(sp)
  4007fc:	00000000 	nop
  400800:	8f998018 	lw	t9,-32744(gp)
  400804:	00000000 	nop
  400808:	27390550 	addiu	t9,t9,1360
  40080c:	00000000 	nop
  400810:	0320f809 	jalr	t9
  400814:	00000000 	nop
  400818:	8fbc0010 	lw	gp,16(sp)
  40081c:	00000000 	nop
  400820:	8fbf001c 	lw	ra,28(sp)
  400824:	00000000 	nop
  400828:	03e00008 	jr	ra
  40082c:	27bd0020 	addiu	sp,sp,32

--=-yRcc9hJc2nJX+maAD6p5--
