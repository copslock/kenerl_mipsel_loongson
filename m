Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 03:14:30 +0000 (GMT)
Received: from web40408.mail.yahoo.com ([IPv6:::ffff:66.218.78.105]:6705 "HELO
	web40408.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225234AbTA2DO3>; Wed, 29 Jan 2003 03:14:29 +0000
Message-ID: <20030129031421.89385.qmail@web40408.mail.yahoo.com>
Received: from [157.165.41.125] by web40408.mail.yahoo.com via HTTP; Tue, 28 Jan 2003 19:14:21 PST
Date: Tue, 28 Jan 2003 19:14:21 -0800 (PST)
From: Long Li <long21st@yahoo.com>
Subject: Possible bug in gcc for mips?
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <long21st@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: long21st@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I built a gcc 3.0.4 mips crosscompiler on redhat
7.1(binutils 2.11.2). I embedded some inline assembly
in the C code. This is what I did:

 //get SR Bit from Status Register
 register unsigned int status_reg;
 register unsigned int warm_reset, cold_reset;

 asm volatile ("mfc0 %0,$12" :: "r"(status_reg));

  if ((status_reg >> 20) & 0x1) {
	warm_reset++;
  }
  else {
     cold_reset++;
  }


I compiled and disassembly the output. This is what
shows in the disassembly:

00000000 <init>:
   0:	27bdfff0 	addiu	sp,sp,-16
   4:	afbe0008 	sw	s8,8(sp)
   8:	03a0f025 	move	s8,sp
   c:	8fc20004 	lw	v0,4(s8)
  10:	40026000 	mfc0	v0,t4
  14:	8fc30004 	lw	v1,4(s8)
  18:	00000000 	nop
  1c:	00031502 	srl	v0,v1,0x14
  20:	30420001 	andi	v0,v0,0x1
  24:	10400009 	beqz	v0,4c <init+0x4c>
  28:	00000000 	nop

You can see the condition depends on the value of v1,
which is loaded from the stack, instead of v0, which
is the expected status register.

Is this a possible bug or a feature for gcc 3.0.4?


Thanks a lot!


Long


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
