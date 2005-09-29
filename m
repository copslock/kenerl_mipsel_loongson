Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2005 07:21:34 +0100 (BST)
Received: from mailhub.cs.uoguelph.ca ([131.104.96.75]:60804 "EHLO
	mailhub.cs.uoguelph.ca") by ftp.linux-mips.org with ESMTP
	id S8133627AbVI2GVO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Sep 2005 07:21:14 +0100
Received: from batman.cs.uoguelph.ca (batman.cs.uoguelph.ca [131.104.93.48])
	by mailhub.cs.uoguelph.ca (8.13.1/8.13.1) with ESMTP id j8T6L39j013960;
	Thu, 29 Sep 2005 02:21:03 -0400
Received: from beddie.cis.uoguelph.ca (marvin.cis.uoguelph.ca [131.104.48.131])
	by batman.cs.uoguelph.ca (8.13.4/8.13.4) with ESMTP id j8T6L105020718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Sep 2005 02:21:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by beddie.cis.uoguelph.ca (Postfix) with ESMTP id C26BD42404;
	Thu, 29 Sep 2005 02:20:54 -0400 (EDT)
Received: from beddie.cis.uoguelph.ca ([127.0.0.1])
	by localhost (beddie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 03755-10; Thu, 29 Sep 2005 02:20:53 -0400 (EDT)
Received: from [192.168.0.103] (CPE001217cc2ab6-CM001371143eca.cpe.net.cable.rogers.com [70.30.137.118])
	by beddie.cis.uoguelph.ca (Postfix) with ESMTP id A2327423EE;
	Thu, 29 Sep 2005 02:20:53 -0400 (EDT)
Message-ID: <433B87CE.1060509@uoguelph.ca>
Date:	Thu, 29 Sep 2005 02:21:02 -0400
From:	Brett Foster <fosterb@uoguelph.ca>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Yoann Allain <yallain@avilinks.com>
CC:	linux-mips@linux-mips.org
Subject: Re: =?ISO-8859-1?Q?R=E9f=2E_=3A_Compiling_a_2=2E6_kern?=
 =?ISO-8859-1?Q?el_for_Mips?=
References: <OF6AB06D9F.A4F86C60-ONC125708A.003730C5-C125708A.00479A09@sagem.com> <433A9CD9.6040906@avilinks.com>
In-Reply-To: <433A9CD9.6040906@avilinks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cs-club.org
X-Scanned-By: MIMEDefang 2.52 on 131.104.96.75
X-Scanned-By: MIMEDefang 2.52 on 131.104.93.48
Return-Path: <fosterb@uoguelph.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fosterb@uoguelph.ca
Precedence: bulk
X-list: linux-mips

Yoann Allain wrote:

> Here is the function putPromChar in which I have the problem:
>
> 80101e70 <putPromChar>:
> 80101e70:       3c028039        lui     $v0,0x8039
> 80101e74:       244519f0        addiu   $a1,$v0,6640
> 80101e78:       8ca30014        lw      $v1,20($a1)
> 80101e7c:       00042600        sll     $a0,$a0,24
> 80101e80:       27bdfff0        addiu   $sp,$sp,-16
> 80101e84:       00043603        sra     $a2,$a0,24
> 80101e88:       10600012        beqz    $v1,80101ed4 <putPromChar+0x64>
> 80101e8c:       00001025        move    $v0,$zero
> 80101e90:       8ca20004        lw      $v0,4($a1)
> 80101e94:       3c038036        lui     $v1,0x8036
> 80101e98:       8c64c9a0        lw      $a0,-13920($v1)
> 80101e9c:       2442001c        addiu   $v0,$v0,28
> 80101ea0:       00822021        addu    $a0,$a0,$v0
> 80101ea4:       00000000        nop
> 80101ea8:       8c820000        lw      $v0,0($a0)
> 80101eac:       30420020        andi    $v0,$v0,0x20
> 80101eb0:       1040fffd        beqz    $v0,80101ea8 <putPromChar+0x38>
> 80101eb4:       3c028039        lui     $v0,0x8039
> 80101eb8:       8c4319f4        lw      $v1,6644($v0)
> 80101ebc:       3c048036        lui     $a0,0x8036
> 80101ec0:       8c82c9a0        lw      $v0,-13920($a0)
> 80101ec4:       24630004        addiu   $v1,$v1,4
> 80101ec8:       00431021        addu    $v0,$v0,$v1
> 80101ecc:       ac460000        sw      $a2,0($v0)
> 80101ed0:       24020001        li      $v0,1
> 80101ed4:       03e00008        jr      $ra
> 80101ed8:       27bd0010        addiu   $sp,$sp,16
> 80101edc:       00000000        nop
>
> with WinMon (bootloader) I get this (this is perhaps more readable...):
>
> [80101e70] 3c028039 lui         r2,0x8039        putPromChar
> [80101e74] 244519f0 addiu       r5,r2,0x19f0
> [80101e78] 8ca30014 lw          r3,0x0014(r5)
> [80101e7c] 00042600 sll         r4,r4,24
> [80101e80] 27bdfff0 addiu       r29,r29,0xfff0
> [80101e84] 00043603 sra         r6,r4,24
> [80101e88] 10600012 beq         r3,r0,0x0012
> [80101e90] 8ca20004 lw          r2,0x0004(r5)           --> in 2.6 it 
> reads 0 at address r5 + 0x4  [80101e94] 3c038036 lui         r3,0x8036
> [80101e98] 8c64c9a0 lw          r4,0xc9a0(r3)        --> in 2.6 it 
> reads 0 at adress r3 + 0xc9a0
> [80101e9c] 2442001c addiu       r2,r2,0x001c
> [80101ea0] 00822021 addu        r4,r4,r2        ==> in 2.4 it returns 
> bf010f1c in r4
> [80101ea8] 8c820000 lw          r2,0x0000(r4)
>
> * Exception 0x02 (user) : TLB (load or instruction fetch) *
> * in address: 80101ea8
> ClockDiv2+0xe38:
> [80101ea8] 8c820000 lw          r2,0x0000(r4)
>
>
> r0(zero): 00000000 r1(AT)  : 1000fc00 r2(v0)  : 0000001c r3(v1)  : 
> 80360000
> r4(a0)  : 0000001c r5(a1)  : 803919f0 r6(a2)  : 0000000d r7(a3)  : 
> 8038df8c
>
> I hope this will help and many thanks for your help!
>
> Yoann

I traced through some of put character function this morning... I didn't 
finish, but I thought it looked like some data structure wasn't 
initialized. Perhaps you can figure out exactly what line the bad load 
belongs to in the C source, and see what structure that is. -- If there 
is a data structure -- I could just be crazy. ;)

Brett
