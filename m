Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15Ew6c12453
	for linux-mips-outgoing; Tue, 5 Feb 2002 06:58:06 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15EvfA12401
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 06:57:41 -0800
Message-Id: <200202051457.g15EvfA12401@oss.sgi.com>
Received: (qmail 28346 invoked from network); 5 Feb 2002 14:58:14 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 5 Feb 2002 14:58:14 -0000
Date: Tue, 5 Feb 2002 22:54:42 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: another gcc optimization bug?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
    It seems gcc with optimization > -O2 will produce incorrect code for fp code:
I find this example when tracking down the libm-test failures.
  ( expf(NaN) == NaN will report an extra "invalid operation" exception )
The faulting code snippet is:
	float __my_expf(float x)		/* wrapper expf */
{
	float z;
	unsigned int hx;
	z = __ieee754_expf(x);
	if(_LIB_VERSION == _IEEE_) return z;
	if(__finitef(x)) {
	    if(x>o_threshold)
		return 1.0;
	    else if(x<u_threshold)
		return 2.0;
            printf("haha\n");
	} 
	return z;
}

with -O2(or higher),some statements inside "if (__finitef(x))" are put before
testing the return value of __finitef(x),one of which is a c.lt.s that cause
the extra "invalid operation" exception being raised.

the obj codes is listed below:
1.  without -O
0000000000401290 <__my_expf>:
  401290:	3c1c0fc0 	lui	gp,0xfc0
  401294:	279c6dd0 	addiu	gp,gp,28112
  401298:	0399e021 	addu	gp,gp,t9
  40129c:	27bdffd0 	addiu	sp,sp,-48
  4012a0:	afbc0010 	sw	gp,16(sp)
  4012a4:	afbf0028 	sw	ra,40(sp)
  4012a8:	afbe0024 	sw	s8,36(sp)
  4012ac:	afbc0020 	sw	gp,32(sp)
  4012b0:	03a0f021 	move	s8,sp
  4012b4:	e7cc0030 	swc1	$f12,48(s8)
  4012b8:	c7cc0030 	lwc1	$f12,48(s8)
  4012bc:	8f998088 	lw	t9,-32632(gp)
  4012c0:	00000000 	nop
  4012c4:	0320f809 	jalr	t9
  4012c8:	00000000 	nop
  4012cc:	8fdc0010 	lw	gp,16(s8)
  4012d0:	e7c00018 	swc1	$f0,24(s8)
  4012d4:	8f8380ac 	lw	v1,-32596(gp)
  4012d8:	00000000 	nop
  4012dc:	8c630000 	lw	v1,0(v1)
  4012e0:	2402ffff 	li	v0,-1
  4012e4:	14620004 	bne	v1,v0,4012f8 <__my_expf+0x68>
  4012e8:	00000000 	nop
  4012ec:	c7c00018 	lwc1	$f0,24(s8)
  4012f0:	10000032 	b	4013bc <__my_expf+0x12c>
  4012f4:	00000000 	nop
  4012f8:	c7cc0030 	lwc1	$f12,48(s8)
  4012fc:	8f998090 	lw	t9,-32624(gp)
  401300:	00000000 	nop
  401304:	0320f809 	jalr	t9
  401308:	00000000 	nop
  40130c:	8fdc0010 	lw	gp,16(s8)
  401310:	10400029 	beqz	v0,4013b8 <__my_expf+0x128>
  401314:	00000000 	nop
  401318:	c7c20030 	lwc1	$f2,48(s8)
  40131c:	8f818018 	lw	at,-32744(gp)
  401320:	00000000 	nop
  401324:	242142a0 	addiu	at,at,17056
  401328:	c4200000 	lwc1	$f0,0(at)
  40132c:	00000000 	nop
  401330:	4602003c 	c.lt.s	$f0,$f2
  401334:	00000000 	nop
  401338:	45010003 	bc1t	401348 <__my_expf+0xb8>
  40133c:	00000000 	nop
  401340:	10000005 	b	401358 <__my_expf+0xc8>
  401344:	00000000 	nop
  401348:	3c013f80 	lui	at,0x3f80
  40134c:	44810000 	mtc1	at,$f0
  401350:	1000001a 	b	4013bc <__my_expf+0x12c>
  401354:	00000000 	nop
  401358:	c7c20030 	lwc1	$f2,48(s8)
  40135c:	8f818018 	lw	at,-32744(gp)
  401360:	00000000 	nop
  401364:	242142a4 	addiu	at,at,17060
  401368:	c4200000 	lwc1	$f0,0(at)
  40136c:	00000000 	nop
  401370:	4600103c 	c.lt.s	$f2,$f0
  401374:	00000000 	nop
  401378:	45010003 	bc1t	401388 <__my_expf+0xf8>
  40137c:	00000000 	nop
  401380:	10000005 	b	401398 <__my_expf+0x108>
  401384:	00000000 	nop
  401388:	3c014000 	lui	at,0x4000
  40138c:	44810000 	mtc1	at,$f0
  401390:	1000000a 	b	4013bc <__my_expf+0x12c>
  401394:	00000000 	nop
  401398:	8f848018 	lw	a0,-32744(gp)
  40139c:	00000000 	nop
  4013a0:	248442a8 	addiu	a0,a0,17064
  4013a4:	8f998058 	lw	t9,-32680(gp)
  4013a8:	00000000 	nop
  4013ac:	0320f809 	jalr	t9
  4013b0:	00000000 	nop
  4013b4:	8fdc0010 	lw	gp,16(s8)
  4013b8:	c7c00018 	lwc1	$f0,24(s8)
  4013bc:	03c0e821 	move	sp,s8
  4013c0:	8fbf0028 	lw	ra,40(sp)
  4013c4:	8fbe0024 	lw	s8,36(sp)
  4013c8:	03e00008 	jr	ra
  4013cc:	27bd0030 	addiu	sp,sp,48

2. with -O
 000000000400fc0 <__my_expf>:
  400fc0:	3c1c0fc0 	lui	gp,0xfc0
  400fc4:	279c70a0 	addiu	gp,gp,28832
  400fc8:	0399e021 	addu	gp,gp,t9
  400fcc:	27bdffd0 	addiu	sp,sp,-48
  400fd0:	afbc0010 	sw	gp,16(sp)
  400fd4:	e7b60028 	swc1	$f22,40(sp)
  400fd8:	e7b7002c 	swc1	$f23,44(sp)
  400fdc:	e7b40020 	swc1	$f20,32(sp)
  400fe0:	e7b50024 	swc1	$f21,36(sp)
  400fe4:	afbf001c 	sw	ra,28(sp)
  400fe8:	46006506 	mov.s	$f20,$f12
  400fec:	afbc0018 	sw	gp,24(sp)
  400ff0:	8f998088 	lw	t9,-32632(gp)
  400ff4:	00000000 	nop
  400ff8:	0320f809 	jalr	t9
  400ffc:	00000000 	nop
  401000:	8fbc0010 	lw	gp,16(sp)
  401004:	00000000 	nop
  401008:	8f8380ac 	lw	v1,-32596(gp)
  40100c:	00000000 	nop
  401010:	8c630000 	lw	v1,0(v1)
  401014:	2402ffff 	li	v0,-1
  401018:	46000586 	mov.s	$f22,$f0
  40101c:	1062000a 	beq	v1,v0,401048 <__my_expf+0x88>
  401020:	4600a306 	mov.s	$f12,$f20
  401024:	8f998090 	lw	t9,-32624(gp)
  401028:	00000000 	nop
  40102c:	0320f809 	jalr	t9
  401030:	00000000 	nop
  401034:	8fbc0010 	lw	gp,16(sp)
  401038:	44800000 	mtc1	zero,$f0
  40103c:	14400002 	bnez	v0,401048 <__my_expf+0x88>
  401040:	00000000 	nop
  401044:	4600b006 	mov.s	$f0,$f22
  401048:	8fbf001c 	lw	ra,28(sp)
  40104c:	c7b60028 	lwc1	$f22,40(sp)
  401050:	c7b7002c 	lwc1	$f23,44(sp)
  401054:	c7b40020 	lwc1	$f20,32(sp)
  401058:	c7b50024 	lwc1	$f21,36(sp)
  40105c:	03e00008 	jr	ra
  401060:	27bd0030 	addiu	sp,sp,48

3. with -O2
   0000000000400fc0 <__my_expf>:
  400fc0:	3c1c0fc0 	lui	gp,0xfc0
  400fc4:	279c70a0 	addiu	gp,gp,28832
  400fc8:	0399e021 	addu	gp,gp,t9
  400fcc:	27bdffd0 	addiu	sp,sp,-48
  400fd0:	afbc0010 	sw	gp,16(sp)
  400fd4:	e7b60028 	swc1	$f22,40(sp)
  400fd8:	e7b7002c 	swc1	$f23,44(sp)
  400fdc:	e7b40020 	swc1	$f20,32(sp)
  400fe0:	e7b50024 	swc1	$f21,36(sp)
  400fe4:	afbf001c 	sw	ra,28(sp)
  400fe8:	46006506 	mov.s	$f20,$f12
  400fec:	afbc0018 	sw	gp,24(sp)
  400ff0:	8f998088 	lw	t9,-32632(gp)
  400ff4:	00000000 	nop
  400ff8:	0320f809 	jalr	t9
  400ffc:	00000000 	nop
  401000:	8fbc0010 	lw	gp,16(sp)
  401004:	00000000 	nop
  401008:	8f8380ac 	lw	v1,-32596(gp)
  40100c:	00000000 	nop
  401010:	8c630000 	lw	v1,0(v1)
  401014:	2402ffff 	li	v0,-1
  401018:	46000586 	mov.s	$f22,$f0
  40101c:	10620021 	beq	v1,v0,4010a4 <__my_expf+0xe4>
  401020:	4600a306 	mov.s	$f12,$f20
  401024:	8f998090 	lw	t9,-32624(gp)
  401028:	00000000 	nop
  40102c:	0320f809 	jalr	t9
  401030:	00000000 	nop
  401034:	8fbc0010 	lw	gp,16(sp)
  401038:	3c0142b1 	lui	at,0x42b1
  40103c:	34217180 	ori	at,at,0x7180
  401040:	44811000 	mtc1	at,$f2
  401044:	3c013f80 	lui	at,0x3f80
  401048:	44810000 	mtc1	at,$f0
  40104c:	4614103c 	c.lt.s	$f2,$f20  // this is wrongly put ahead ?
  401050:	10400013 	beqz	v0,4010a0 <__my_expf+0xe0>
  401054:	00000000 	nop
  401058:	45010012 	bc1t	4010a4 <__my_expf+0xe4>
  40105c:	00000000 	nop
  401060:	3c01c2cf 	lui	at,0xc2cf
  401064:	3421f1b5 	ori	at,at,0xf1b5
  401068:	44810000 	mtc1	at,$f0
  40106c:	8f848018 	lw	a0,-32744(gp)
  401070:	00000000 	nop
  401074:	24843fa8 	addiu	a0,a0,16296
  401078:	4600a03c 	c.lt.s	$f20,$f0
  40107c:	3c014000 	lui	at,0x4000
  401080:	44810000 	mtc1	at,$f0
  401084:	45010007 	bc1t	4010a4 <__my_expf+0xe4>
  401088:	00000000 	nop
  40108c:	8f998058 	lw	t9,-32680(gp)
  401090:	00000000 	nop
  401094:	0320f809 	jalr	t9
  401098:	00000000 	nop
  40109c:	8fbc0010 	lw	gp,16(sp)
  4010a0:	4600b006 	mov.s	$f0,$f22
  4010a4:	8fbf001c 	lw	ra,28(sp)
  4010a8:	c7b60028 	lwc1	$f22,40(sp)
  4010ac:	c7b7002c 	lwc1	$f23,44(sp)
  4010b0:	c7b40020 	lwc1	$f20,32(sp)
  4010b4:	c7b50024 	lwc1	$f21,36(sp)
  4010b8:	03e00008 	jr	ra
  4010bc:	27bd0030 	addiu	sp,sp,48

 
 
  
Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
