Received:  by oss.sgi.com id <S553695AbQLMP7d>;
	Wed, 13 Dec 2000 07:59:33 -0800
Received: from mx.mips.com ([206.31.31.226]:45499 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553663AbQLMP7W>;
	Wed, 13 Dec 2000 07:59:22 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA03827
	for <linux-mips@oss.sgi.com>; Wed, 13 Dec 2000 07:59:19 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA02263
	for <linux-mips@oss.sgi.com>; Wed, 13 Dec 2000 07:59:16 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id QAA18353
	for <linux-mips@oss.sgi.com>; Wed, 13 Dec 2000 16:58:52 +0100 (MET)
Message-ID: <3A379CBC.ED1D9F@mips.com>
Date:   Wed, 13 Dec 2000 16:58:52 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: 64 bit build fails
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I'm trying to build a 64bit kernel, but it fails with following message:

mips64-linux-gcc -D__KERNEL__
-I/home/soc/proj/work/carstenl/sw/linux-2.4.0/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r8000 -mips4
-Wa,-32   -c head.S -o head.o
head.S: Assembler messages:
head.S:69: Error: Missing ')' assumed
head.S:69: Error: Missing ')' assumed
head.S:69: Error: Missing ')' assumed
head.S:69: Error: Missing ')' assumed
head.S:69: Error: Missing ')' assumed
head.S:69: Error: Missing ')' assumed
head.S:69: Error: illegal operands `dli'
head.S:107: Error: Missing ')' assumed
head.S:107: Error: Missing ')' assumed
head.S:107: Error: Missing ')' assumed
head.S:107: Error: Missing ')' assumed
head.S:107: Error: Missing ')' assumed
head.S:107: Error: Missing ')' assumed
head.S:107: Error: illegal operands `dli'
head.S:109: Error: Instruction dsll requires absolute expression
head.S:109: Error: Instruction dsll requires absolute expression
make[1]: *** [head.o] Error 1
make[1]: Leaving directory
`/home/soc/proj/work/carstenl/sw/linux-2.4.0/arch/mips64/kernel'
make: *** [_dir_arch/mips64/kernel] Error 2



What are this macro doing ?

.macro GET_NASID_ASM
 dli t1, LOCAL_HUB_ADDR(NI_STATUS_REV_ID)
 ld t1, (t1)
 and t1, NSRI_NODEID_MASK
 dsrl t1, NSRI_NODEID_SHFT
 .endm


/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
