Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 01:18:31 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:57692
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224936AbUAVBSb>; Thu, 22 Jan 2004 01:18:31 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AjTUJ-0007Ha-00; Thu, 22 Jan 2004 02:18:27 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AjTUJ-0006DX-00; Thu, 22 Jan 2004 02:18:27 +0100
Date: Thu, 22 Jan 2004 02:18:27 +0100
To: Narendra Sankar <narendrasankar@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Error building for rm5231 due to multiple page size support
Message-ID: <20040122011827.GA23173@rembrandt.csv.ica.uni-stuttgart.de>
References: <200401211051.03411.narendrasankar@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401211051.03411.narendrasankar@yahoo.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Narendra Sankar wrote:
> hi
> 
> I am trying to build the 2.4 32-bit (both HEAD and 2_4_23) kernel for the 
> rm5231 cpu - both the cobalt and the ite8172 configurations (just using the 
> default configurations from arch/mips/). I get the 
> following error due to the changes made to support multiple page sizes. 
> Looking at the code, this probably affects all configurations except for the 
> ones that use MIPS32 (it seems that these configurations - for example the 
> malta, actually do not ever use _PTE_T_LOG2) which include tlbex-mips32.S. 
> The code from offset.c 
> seems to generate a offset.h which has _PTE_T_LOG2 defined to be $2. Here is 
> the snippet from the offset.h -
> 
> #define _PGD_T_LOG2    $2
> #define _PMD_T_LOG2    $2
> #define _PTE_T_LOG2    $2
>   
> 
> mipsel-linux-gcc -D__ASSEMBLY__ -D__KERNEL__ 
> -I/home/naren/lnxsrc/linux-2.4.23/linux/include 
> -I /home/naren/lnxsrc/linux-2.4.23/linux/include/asm/gcc -G 0 -mno-abicalls 
> -fno-pic -pipe   -mcpu=r5000 -mips2 -Wa,--trap   -c -o tlbex-r4k.o 
> tlbex-r4k.S
> tlbex-r4k.S: Assembler messages:
> tlbex-r4k.S:178: Error: Instruction srl requires absolute expression
> tlbex-r4k.S:178: Warning: Improper shift amount (4294967295)
> tlbex-r4k.S:206: Error: Instruction srl requires absolute expression
> tlbex-r4k.S:206: Warning: Improper shift amount (4294967295)
> tlbex-r4k.S:242: Error: Instruction srl requires absolute expression
> tlbex-r4k.S:242: Warning: Improper shift amount (4294967295)
> tlbex-r4k.S:274: Error: Instruction srl requires absolute expression
> tlbex-r4k.S:274: Warning: Improper shift amount (4294967295)
> tlbex-r4k.S:465: Error: Instruction srl requires absolute expression
> tlbex-r4k.S:493: Error: Instruction srl requires absolute expression
> tlbex-r4k.S:520: Error: Instruction srl requires absolute expression
> make[2]: *** [tlbex-r4k.o] Error 1
> 
> 
> Is something wrong with the code, or with my configuration?

The new gcc options selection code in arch/mips/Makefile seems to
erraneously filter out -finline-limit=100000, which prevents the
misgeneration of offset.h.


Thiemo
