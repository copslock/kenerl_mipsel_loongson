Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jan 2005 18:42:37 +0000 (GMT)
Received: from gw.voda.cz ([IPv6:::ffff:212.24.154.90]:21182 "EHLO
	kojot.voda.cz") by linux-mips.org with ESMTP id <S8224839AbVAOSm3>;
	Sat, 15 Jan 2005 18:42:29 +0000
Received: from localhost (localhost [127.0.0.1])
	by kojot.voda.cz (Postfix) with ESMTP id 382B74C8E2
	for <linux-mips@ftp.linux-mips.org>; Sat, 15 Jan 2005 19:42:28 +0100 (CET)
Received: from kojot.voda.cz ([127.0.0.1])
 by localhost (kojot [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08440-10 for <linux-mips@ftp.linux-mips.org>;
 Sat, 15 Jan 2005 19:42:26 +0100 (CET)
Received: from [10.1.1.77] (unknown [10.1.1.77])
	by kojot.voda.cz (Postfix) with ESMTP id EDD594B973
	for <linux-mips@ftp.linux-mips.org>; Sat, 15 Jan 2005 19:42:25 +0100 (CET)
Message-ID: <41E96411.90305@voda.cz>
Date: Sat, 15 Jan 2005 19:42:25 +0100
From: =?ISO-8859-2?Q?Tom_Vr=E1na?= <tom@voda.cz>
Organization: VODA IT consulting
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@ftp.linux-mips.org
Subject: crosscompiling and 
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at voda.cz
Return-Path: <tom@voda.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 6923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tom@voda.cz
Precedence: bulk
X-list: linux-mips

Hi,

I'm just hopelesly stuck, trying to make a kernel 2.4.27 for mips SoC 
ADM5120 (MIPS 4Kc). I have the code in a 2.4.18 kernel that I'm able to 
compile. With the code merged in 2.4.27 most of the stuff works, but I 
get the following assembler errors. Like if it doesn't recognize what's 
C and what assembler code ? I am using gcc3.3 toolchain built with 
uclibc with 2.4.27 kernel headers. and I do appreciate any help....
   
          Tom


mipsel-linux-uclibc-gcc  -D__KERNEL__ 
-I/store/devel/adm/linux-2.4.27-mipscvs-20050114/include  -c -o 
mipsIRQ.o mipsIRQ.S
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h: 
Assembler messages:
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:875: 
Error: unrecognized opcode `static inline void tlb_probe(void)'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:876: 
Warning: rest of line ignored; first ignored character is `{'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:877: 
Error: unrecognized opcode `do {}while(0)'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:878: 
Error: unrecognized opcode `__asm__ __volatile__('
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:879: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:880: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:881: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:882: 
Error: unrecognized opcode `do {}while(0)'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:883: 
Warning: rest of line ignored; first ignored character is `}'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:885: 
Error: unrecognized opcode `static inline void tlb_read(void)'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:886: 
Warning: rest of line ignored; first ignored character is `{'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:887: 
Error: unrecognized opcode `do {}while(0)'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:888: 
Error: unrecognized opcode `__asm__ __volatile__('
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:889: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:890: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.27-mipscvs-20050114/include/asm/mipsregs.h:891: 
Warning: rest of line ignored; first ignored character is `"'
---- SNIP ---- (few hundred more complaints from other included header 
files)

-- 
 Tomas Vrana  <tom@voda.cz>
 --------------------------
 VODA IT consulting, Borkovany 48, 691 75
 http://www.voda.cz/
 phone: +420 519 419 416 mobile: +420 603 469 305 UIN: 105142752
