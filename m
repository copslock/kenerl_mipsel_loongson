Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 01:08:48 +0000 (GMT)
Received: from smtp015.mail.yahoo.com ([IPv6:::ffff:216.136.173.59]:23981 "HELO
	smtp015.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224936AbUAVBGv>; Thu, 22 Jan 2004 01:06:51 +0000
Received: from unknown (HELO 192.168.0.100) (narendrasankar@67.119.11.4 with plain)
  by smtp015.mail.yahoo.com with SMTP; 22 Jan 2004 01:06:49 -0000
From: Narendra Sankar <narendrasankar@yahoo.com>
Reply-To: narendrasankar@yahoo.com
To: linux-mips@linux-mips.org
Subject: Error building for rm5231 due to multiple page size support
Date: Wed, 21 Jan 2004 16:14:13 -0800
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200401211051.03411.narendrasankar@yahoo.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <narendrasankar@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4092
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: narendrasankar@yahoo.com
Precedence: bulk
X-list: linux-mips

hi

I am trying to build the 2.4 32-bit (both HEAD and 2_4_23) kernel for the 
rm5231 cpu - both the cobalt and the ite8172 configurations (just using the 
default configurations from arch/mips/). I get the 
following error due to the changes made to support multiple page sizes. 
Looking at the code, this probably affects all configurations except for the 
ones that use MIPS32 (it seems that these configurations - for example the 
malta, actually do not ever use _PTE_T_LOG2) which include tlbex-mips32.S. 
The code from offset.c 
seems to generate a offset.h which has _PTE_T_LOG2 defined to be $2. Here is 
the snippet from the offset.h -

#define _PGD_T_LOG2    $2
#define _PMD_T_LOG2    $2
#define _PTE_T_LOG2    $2
  

mipsel-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ 
-I/home/naren/lnxsrc/linux-2.4.23/linux/include 
-I /home/naren/lnxsrc/linux-2.4.23/linux/include/asm/gcc -G 0 -mno-abicalls 
-fno-pic -pipe   -mcpu=r5000 -mips2 -Wa,--trap   -c -o tlbex-r4k.o 
tlbex-r4k.S
tlbex-r4k.S: Assembler messages:
tlbex-r4k.S:178: Error: Instruction srl requires absolute expression
tlbex-r4k.S:178: Warning: Improper shift amount (4294967295)
tlbex-r4k.S:206: Error: Instruction srl requires absolute expression
tlbex-r4k.S:206: Warning: Improper shift amount (4294967295)
tlbex-r4k.S:242: Error: Instruction srl requires absolute expression
tlbex-r4k.S:242: Warning: Improper shift amount (4294967295)
tlbex-r4k.S:274: Error: Instruction srl requires absolute expression
tlbex-r4k.S:274: Warning: Improper shift amount (4294967295)
tlbex-r4k.S:465: Error: Instruction srl requires absolute expression
tlbex-r4k.S:493: Error: Instruction srl requires absolute expression
tlbex-r4k.S:520: Error: Instruction srl requires absolute expression
make[2]: *** [tlbex-r4k.o] Error 1


Is something wrong with the code, or with my configuration?

Thanks
Naren Sankar
