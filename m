Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jan 2005 19:21:29 +0000 (GMT)
Received: from gw.voda.cz ([IPv6:::ffff:212.24.154.90]:28350 "EHLO
	kojot.voda.cz") by linux-mips.org with ESMTP id <S8224842AbVAOTVZ>;
	Sat, 15 Jan 2005 19:21:25 +0000
Received: from localhost (localhost [127.0.0.1])
	by kojot.voda.cz (Postfix) with ESMTP id 5413A4C8E8
	for <linux-mips@ftp.linux-mips.org>; Sat, 15 Jan 2005 20:21:24 +0100 (CET)
Received: from kojot.voda.cz ([127.0.0.1])
 by localhost (kojot [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17598-05 for <linux-mips@ftp.linux-mips.org>;
 Sat, 15 Jan 2005 20:21:22 +0100 (CET)
Received: from [10.1.1.77] (unknown [10.1.1.77])
	by kojot.voda.cz (Postfix) with ESMTP id 47E674B446
	for <linux-mips@ftp.linux-mips.org>; Sat, 15 Jan 2005 20:21:22 +0100 (CET)
Message-ID: <41E96D32.4020400@voda.cz>
Date: Sat, 15 Jan 2005 20:21:22 +0100
From: =?ISO-8859-1?Q?Tom_Vr=E1na?= <tom@voda.cz>
Organization: VODA IT consulting
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@ftp.linux-mips.org
Subject: Re: crosscompiling and ...
References: <41E96411.90305@voda.cz> <20050115185509.GO31149@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20050115185509.GO31149@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new at voda.cz
Return-Path: <tom@voda.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@ftp.linux-mips.org
Original-Recipient: rfc822;linux-mips@ftp.linux-mips.org
X-archive-position: 6925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tom@voda.cz
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:

>Tom Vrána wrote:
>  
>
>>Hi,
>>
>>I'm just hopelesly stuck, trying to make a kernel 2.4.27 for mips SoC 
>>ADM5120 (MIPS 4Kc). I have the code in a 2.4.18 kernel that I'm able to 
>>compile. With the code merged in 2.4.27 most of the stuff works, but I 
>>get the following assembler errors. Like if it doesn't recognize what's 
>>C and what assembler code ? I am using gcc3.3 toolchain built with 
>>uclibc with 2.4.27 kernel headers. and I do appreciate any help....
>>  
>>         Tom
>>
>>
>>mipsel-linux-uclibc-gcc  -D__KERNEL__ 
>>-I/store/devel/adm/linux-2.4.27-mipscvs-20050114/include  -c -o 
>>mipsIRQ.o mipsIRQ.S
>>    
>>
>
>It fails to add -D__ASSEMBLY__ for some reason. I guess the cause is
>some broken Makefile in your tree.
>
>
>Thiemo
>  
>
Thanks, your guess is right ;-) I got that one one fixed. What I got now 
is a complaint:

mipsIRQ.S: Assembler messages:
mipsIRQ.S:116: Error: absolute expression required `li'
mipsIRQ.S:120: Error: absolute expression required `and'
mipsIRQ.S:127: Error: absolute expression required `and'

the trouble causing code is this (STATUS_IE) :

LEAF(mips_int_lock)
        .set noreorder
        mfc0    v0, CP0_STATUS
        li              v1, ~STATUS_IE
        and             v1, v1, v0
        mtc0    v1, CP0_STATUS
        j               ra
        and             v0, v0, STATUS_IE
        .set reorder
END(mips_int_lock)


LEAF(mips_int_unlock)
        mfc0    v0, CP0_STATUS
        and             a0, a0, STATUS_IE
        or              v0, v0, a0
        mtc0    v0, CP0_STATUS
        j               ra
        nop
END(mips_int_unlock)

Any hints here ?


-- 
 Tomas Vrana  <tom@voda.cz>
 --------------------------
 VODA IT consulting, Borkovany 48, 691 75
 http://www.voda.cz/
 phone: +420 519 419 416 mobile: +420 603 469 305 UIN: 105142752
