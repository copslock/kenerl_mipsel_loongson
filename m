Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Oct 2004 07:10:27 +0100 (BST)
Received: from imfep06.dion.ne.jp ([IPv6:::ffff:210.174.120.157]:19221 "EHLO
	imfep06.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8224913AbUJ1GKW>; Thu, 28 Oct 2004 07:10:22 +0100
Received: from webmail.dion.ne.jp ([210.196.2.172]) by imfep06.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with SMTP
          id <20041028061017.CMDT23095.imfep06.dion.ne.jp@webmail.dion.ne.jp>;
          Thu, 28 Oct 2004 15:10:17 +0900
From: ichinoh@mb.neweb.ne.jp
To: linux-mips@linux-mips.org
Date: Thu, 28 Oct 2004 15:10:17 +0900
Message-Id: <1098943817.20703@157.120.127.3.DIONWebMail>
Subject: Link error gcc3.3.1
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
X-Mailer: DION Web mail version 1.03
X-Originating-IP: 157.120.127.3(*)
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Hello,

I have a question about gcc3.3.1.

Compiling source codes when using gcc3.3.1, I encounter the link error.

<<< error messages >>>
make[1]: Leaving directory `/home/mvista/u-boot-1.1.1-mips1022/post/cpu'
mips_fp_le-gcc -Wa,-gstabs -D__ASSEMBLY__ -g -DDEBUG -Os   -D__KERNEL__ 
-DTEXT_BASE=0xbfc00000 -I/home/mvista/u-boot-1.1.1-mips1022/include -fno-builtin 
-ffreestanding -nostdinc -isystem /usr/lib/gcc-lib/i386-redhat-linux/3.2.2/include -pipe 
-DCONFIG_MIPS -D__MIPS__  -march=4kc -mabicalls -c -o cpu/mips/start.o 
/home/mvista/u-boot-1.1.1-mips1022/cpu/mips/start.S
/home/mvista/u-boot-1.1.1-mips1022/cpu/mips/start.S: Assembler messages:
/home/mvista/u-boot-1.1.1-mips1022/cpu/mips/start.S:247: Error: Cannot branch to undefined symbol.
/home/mvista/u-boot-1.1.1-mips1022/cpu/mips/start.S:252: Error: Cannot branch to undefined symbol.
/home/mvista/u-boot-1.1.1-mips1022/cpu/mips/start.S:264: Error: Cannot branch to undefined symbol.
make: *** [cpu/mips/start.o] Error 1


However, ".globl memsetup" is defined by the source code of (*2).
Did anyone encounter the same error ?
In addition, this error is not generated in gcc3.2.3.


(*1):u-boot-1.1.1/cpu/mips/start.S
	/* Initialize any external memory.
	 */
	bal	memsetup  /* <<< error occured */
	nop

(*2):u-boot-1.1.1/board/dbau1x00/memsetup.S

	.text
	.set noreorder
	.set mips32

	.globl	memsetup
memsetup:
	/*
	 * Step 1) Establish CPU endian mode.
	 * Db1500-specific:
	 * Switch S1.1 Off(bit7 reads 1) is Little Endian
	 * Switch S1.1 On (bit7 reads 0) is Big Endian
	 */
	li	t0, MEM_STCFG1

Best regards,
Nyauyama.
