Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 14:41:04 +0100 (BST)
Received: from paris5.amen.fr ([62.193.203.10]:53765 "EHLO paris5.amen.fr")
	by ftp.linux-mips.org with ESMTP id S8133585AbVI1Nks (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2005 14:40:48 +0100
Received: from firewall (46.237.98-84.rev.gaoland.net [84.98.237.46])
	by paris5.amen.fr (8.10.2/8.10.2) with ESMTP id j8SDekv20844;
	Wed, 28 Sep 2005 15:40:46 +0200
Message-ID: <433A9CD9.6040906@avilinks.com>
Date:	Wed, 28 Sep 2005 15:38:33 +0200
From:	Yoann Allain <yallain@avilinks.com>
Organization: Avilinks
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To:	Florian DELIZY <florian.delizy@sagem.com>
CC:	linux-mips@linux-mips.org
Subject: Re: =?ISO-8859-1?Q?R=E9f=2E_=3A_Compiling_a_2=2E6_kern?=
 =?ISO-8859-1?Q?el_for_Mips?=
References: <OF6AB06D9F.A4F86C60-ONC125708A.003730C5-C125708A.00479A09@sagem.com>
In-Reply-To: <OF6AB06D9F.A4F86C60-ONC125708A.003730C5-C125708A.00479A09@sagem.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <yallain@avilinks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yallain@avilinks.com
Precedence: bulk
X-list: linux-mips

Here is the function putPromChar in which I have the problem:

80101e70 <putPromChar>:
80101e70:       3c028039        lui     $v0,0x8039
80101e74:       244519f0        addiu   $a1,$v0,6640
80101e78:       8ca30014        lw      $v1,20($a1)
80101e7c:       00042600        sll     $a0,$a0,24
80101e80:       27bdfff0        addiu   $sp,$sp,-16
80101e84:       00043603        sra     $a2,$a0,24
80101e88:       10600012        beqz    $v1,80101ed4 <putPromChar+0x64>
80101e8c:       00001025        move    $v0,$zero
80101e90:       8ca20004        lw      $v0,4($a1)
80101e94:       3c038036        lui     $v1,0x8036
80101e98:       8c64c9a0        lw      $a0,-13920($v1)
80101e9c:       2442001c        addiu   $v0,$v0,28
80101ea0:       00822021        addu    $a0,$a0,$v0
80101ea4:       00000000        nop
80101ea8:       8c820000        lw      $v0,0($a0)
80101eac:       30420020        andi    $v0,$v0,0x20
80101eb0:       1040fffd        beqz    $v0,80101ea8 <putPromChar+0x38>
80101eb4:       3c028039        lui     $v0,0x8039
80101eb8:       8c4319f4        lw      $v1,6644($v0)
80101ebc:       3c048036        lui     $a0,0x8036
80101ec0:       8c82c9a0        lw      $v0,-13920($a0)
80101ec4:       24630004        addiu   $v1,$v1,4
80101ec8:       00431021        addu    $v0,$v0,$v1
80101ecc:       ac460000        sw      $a2,0($v0)
80101ed0:       24020001        li      $v0,1
80101ed4:       03e00008        jr      $ra
80101ed8:       27bd0010        addiu   $sp,$sp,16
80101edc:       00000000        nop

with WinMon (bootloader) I get this (this is perhaps more readable...):

[80101e70] 3c028039 lui         r2,0x8039		putPromChar
[80101e74] 244519f0 addiu       r5,r2,0x19f0
[80101e78] 8ca30014 lw          r3,0x0014(r5)
[80101e7c] 00042600 sll         r4,r4,24
[80101e80] 27bdfff0 addiu       r29,r29,0xfff0
[80101e84] 00043603 sra         r6,r4,24
[80101e88] 10600012 beq         r3,r0,0x0012
[80101e90] 8ca20004 lw          r2,0x0004(r5)           --> in 2.6 it reads 0 at address r5 + 0x4  
[80101e94] 3c038036 lui         r3,0x8036
[80101e98] 8c64c9a0 lw          r4,0xc9a0(r3)		--> in 2.6 it reads 0 at adress r3 + 0xc9a0
[80101e9c] 2442001c addiu       r2,r2,0x001c
[80101ea0] 00822021 addu        r4,r4,r2		==> in 2.4 it returns bf010f1c in r4
[80101ea8] 8c820000 lw          r2,0x0000(r4)

* Exception 0x02 (user) : TLB (load or instruction fetch) *
* in address: 80101ea8
ClockDiv2+0xe38:
[80101ea8] 8c820000 lw          r2,0x0000(r4)


r0(zero): 00000000 r1(AT)  : 1000fc00 r2(v0)  : 0000001c r3(v1)  : 80360000
r4(a0)  : 0000001c r5(a1)  : 803919f0 r6(a2)  : 0000000d r7(a3)  : 8038df8c

I hope this will help and many thanks for your help!

Yoann



Florian DELIZY wrote:

>
>
>
>
> > Hi,
>
> > I am no more a newbie but I still need some help to build kernels :
> > I am working on the Wintegra Evaluation Board (WEB777) and I used the
> > 2.4 kernel Wintegra gave me with the patch for that board.
> > I tried to adapt the patch for the 2.6 kernel but it doesn't work. I
> > traced the kernel to find it crashed very early before displaying 
> anything.
> > In fact the host processor makes an address and tries to read it but
> > this makes an exception :
>
> > * Exception 0x02 (user) : TLB (load or instruction fetch) *
> > * in address: 80101ea8
> > ClockDiv2+0xe38:
> > [80101ea8] 8c820000 lw          r2,0x0000(r4)
>
>
> > r0(zero): 00000000 r1(AT)  : 1000fc00 r2(v0)  : 0000001c r3(v1)  : 
> 80360000
> > r4(a0)  : 0000001c r5(a1)  : 803919f0 r6(a2)  : 0000000d r7(a3)  : 
> 8038df8c
>
> That would help a lot if you could objdump your kernel and give us 10 
> instructions before (at least)
> and 10 instructions after it, you could try an :
>
> mips-linux-objdump -DSz vmlinux | grep -U 20 '^\[80101ea8\]'
>
> and send the output (that should ouput around 20 lines (which will 
> hopefully contain some C code also,
> assuùing that you compiled the code with debug informations. Moreover 
> you can also tell us in which
> symbol (function) is located the address 0x80101ea8.
>
>
> > I think this is a problem of host processor misconfiguration, but don't
> > find out exactly what it is... To make the address in R4, the processor
> > reads some zeroes where in 2.4 kernel, it doesn't and the address read
> > in 2.4 is something like 0xbf010f1c.
> > I don't know if this can help but here are the few functions before 
> crash:
>
> > kernel_entry
> >    J start_kernel
> >             cpu_probe() (WEB777 patch)
> >             prom_init() (WEB777 patch)
> >                   setup_prom_printf() (WEB777 patch)
> >                   wds_prom_printf() (WEB777 patch)
> >                            putPromChar() (WEB777 patch)
> >                            --> CRASH
>
> You should also start to figure out which variable/pointer anything is 
> consulted to get this adress (0x0000001c)
> which might then help to understand you're problem.
>
> Regards
>
> Florian Delizy
>
