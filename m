Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2005 22:54:38 +0100 (BST)
Received: from gw.voda.cz ([IPv6:::ffff:212.24.154.90]:4499 "EHLO smtp.voda.cz")
	by linux-mips.org with ESMTP id <S8225764AbVFOVyV>;
	Wed, 15 Jun 2005 22:54:21 +0100
Received: from [10.1.1.77] (unknown [213.151.77.162])
	by smtp.voda.cz (Postfix) with ESMTP id DC11F13C5B
	for <linux-mips@linux-mips.org>; Wed, 15 Jun 2005 23:54:18 +0200 (CEST)
Message-ID: <42B0A38A.6050504@voda.cz>
Date:	Wed, 15 Jun 2005 23:54:18 +0200
From:	=?ISO-8859-2?Q?Tom_Vr=E1na?= <tom@voda.cz>
Organization: VODA IT consulting
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: kernel compilation fails
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tom@voda.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tom@voda.cz
Precedence: bulk
X-list: linux-mips

Hi,

I am desperately trying to compile 2.4.30 mips kernel using uclibc 
buildroot gcc 3.3.4 It fails in the following manner:

mipsel-linux-gcc -D__KERNEL__ 
-I/store/devel/adm/linux-2.4.30-mipscvs-20050614/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -I 
/store/devel/adm/linux-2.4.30-mipscvs-20050614/include/asm/gcc -G 0 
-mno-abicalls -fno-pic -pipe  -finline-limit=100000 -mabi=32 
-march=r4600 -Wa,-32 -Wa,-march=r4600 -Wa,-mips3 -Wa,--trap  -c 
mipsIRQ.S -o mipsIRQ.o
/store/devel/adm/linux-2.4.30-mipscvs-20050614/include/asm/hazards.h: 
Assembler messages:
/store/devel/adm/linux-2.4.30-mipscvs-20050614/include/asm/hazards.h:172: 
Error: unrecognized opcode `__asm__('
/store/devel/adm/linux-2.4.30-mipscvs-20050614/include/asm/hazards.h:173: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.30-mipscvs-20050614/include/asm/hazards.h:174: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.30-mipscvs-20050614/include/asm/hazards.h:175: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.30-mipscvs-20050614/include/asm/hazards.h:176: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.30-mipscvs-20050614/include/asm/hazards.h:177: 
Warning: rest of line ignored; first ignored character is `"'
/store/devel/adm/linux-2.4.30-mipscvs-20050614/include/asm/hazards.h:178: 
Warning: rest of line ignored; first ignored character is `"'

Looks like a stupid typo somewhere, but I lack experience to find. BTW, 
the some code is taken from 2.4.18 kernel...
Can anyone please tell me where to look ?

Thanks, Tom

-- 
 Tomas Vrana  <tom@voda.cz>
 --------------------------
 VODA IT consulting, Borkovany 48, 691 75
 http://www.voda.cz/
 phone: +420 519 419 416 mobile: +420 603 469 305 UIN: 105142752
