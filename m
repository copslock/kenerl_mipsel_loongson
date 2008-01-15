Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 20:06:04 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:17837 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S20038554AbYAOUFz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2008 20:05:55 +0000
Received: from [192.168.32.206] ([192.168.32.206]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 15 Jan 2008 15:05:49 -0500
Message-ID: <478D121C.4020701@raritan.com>
Date:	Tue, 15 Jan 2008 15:05:48 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
References: <477E7DAE.2080005@raritan.com> <20080106.000725.75184768.anemo@mba.ocn.ne.jp> <4787AC3D.2020604@raritan.com> <20080112.211749.25909440.anemo@mba.ocn.ne.jp> <478CD639.3040307@raritan.com> <20080115161457.GB31107@networkno.de>
In-Reply-To: <20080115161457.GB31107@networkno.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2008 20:05:49.0526 (UTC) FILETIME=[05ECCF60:01C857B2]
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Gregor Waltz wrote:
>   
>> Atsushi Nemoto wrote:
>>     
>>> On Fri, 11 Jan 2008 12:49:49 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
>>>   
>>>       
>>>> I built linux-2.6.23.9 with the above, but the results are still the  
>>>> same and the EPC is not in System.map.
>>>>     
>>>>         
>>> Are you searching the exact EPC value in System.map?
>>> Usually you should find a function symbol which contains the EPC value in it.
>>>
>>> Or you can do "mipsel-linux-objdump -d vmlinux" and search the EPC value.
>>>   
>>>       
>> The current error is:
>> Exception! EPC=80026290 CAUSE=00000020(Sys)
>> 80026290 0000000c syscall
>>
>> 80026290 is not in System.map, however, the objdump is much more  
>> informative and does contain that value. That particular syscall is in:
>>
>> 8002628c <kernel_execve>:
>> 8002628c:       24020fab        li      v0,4011
>> 80026290:       0000000c        syscall
>> 80026294:       00401821        move    v1,v0
>> 80026298:       14e00003        bnez    a3,800262a8 <kernel_execve+0x1c>
>> 8002629c:       00000000        nop
>> 800262a0:       03e00008        jr      ra
>> 800262a4:       00601021        move    v0,v1
>> 800262a8:       03e00008        jr      ra
>> 800262ac:       00031023        negu    v0,v1
>>
>> Does that provide any clues?
>>     
>
> The kernel failed to set up the general exception handler correctly.
> It should have done that before attempting to start the first kernel
> thread.
>
>
> Thiemo
>   

 From where in the kernel image should execution begin?

Presuming that the output of "objdump -d" reflects the disassembled 
binary from the beginning in order, it looks like my 2.6 kernel is 
running straight into run_init_process as the first real code executed. 
 From what I have seen in the kernel code, run_init_process should be 
jumped to far later in the boot process. If what I am thinking is 
correct, then it also explains why the failure happens in kernel_execve.

I have also included the start of my working kernel, which has _ftext 
with non-zero data as its first entry. Is the _ftext the ELF header or 
some other info for the boot loader?

Thanks


linux-2.6.23.9/vmlinux:     file format elf32-tradlittlemips

Disassembly of section .text:

80020000 <run_init_process-0x400>:
        ...

80020400 <run_init_process>:
80020400:       3c028033        lui     v0,0x8033
80020404:       3c068033        lui     a2,0x8033
80020408:       244594dc        addiu   a1,v0,-27428
8002040c:       24c69450        addiu   a2,a2,-27568
80020410:       080098a3        j       8002628c <kernel_execve> // 
Should this be happening already?
80020414:       ac4494dc        sw      a0,-27428(v0)

80020418 <init_post>:

run_init_process is from linux-2.6.23.9/init/main.c



Our working kernel starts differently:

linux-2.4.12/vmlinux:     file format elf32-tradlittlemips

Disassembly of section .text:

80020000 <_ftext>:
80020000:       26 80 01 3c 14 42 3d ac 02 80 08 3c 80 04 08 25     
&..<.B=....<...%
80020010:       08 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00     
................
        ...

80020298 <except_vec2_generic>:
80020298:       401a8000        mfc0    k0,$16
8002029c:       241bfff8        li      k1,-8
800202a0:       035bd024        and     k0,k0,k1
800202a4:       375a0002        ori     k0,k0,0x2
800202a8:       409a8000        mtc0    k0,$16
        ...
800202b8:       0800b248        j       8002c920 <cache_parity_error>
800202bc:       00000000        nop

800202c0 <except_vec4>:
