Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 20:00:51 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:5783
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8224992AbVCUUAf>;
	Mon, 21 Mar 2005 20:00:35 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 21 Mar 2005 12:00:32 -0800
  id 0000C3B3.423F27E0.000003EA
Message-ID: <423F27C9.4090909@jg555.com>
Date:	Mon, 21 Mar 2005 12:00:09 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Current Build Warning Message
References: <42375617.3020002@jg555.com> <20050315215538.GJ6025@linux-mips.org> <423EF440.9090902@jg555.com> <423EF764.1070305@jg555.com> <423F25AD.6030705@jg555.com>
In-Reply-To: <423F25AD.6030705@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Here is the output of ksymoops.
ksymoops 2.4.11 on mips 2.6.9-jg-2.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.6.11.5-jg-2/ (specified)
     -m /boot/System-2.6.11.5-jg-2.map (specified)

No modules in ksyms, skipping objects
000002ae 686t
0014ea7f 1370751t
Cpu 0
$ 0   : 00000000 90004400 00000000 10000000
$ 4   : 802b0008 80352164 fffb6cbb 80350000
$ 8   : 10000000 00000008 80350000 00008000
$12   : 7fffffff 00100100 00200200 7fffffff
$16   : 80082958 afff62a8 802b2000 00000001
$20   : 8ffa0000 8ffc0000 8ffc0000 00000000
$24   : 00000000 802b1e23                 
$28   : 802b0000 802b1e78 802b1e78 80081338
Hi    : 000f41fa
Lo    : 2fc92280
epc   : 802849b0 preempt_schedule_irq+0xcc/0xd8     Not tainted
Using defaults from ksymoops -t elf32-tradlittlemips -a mips:8000
Status: 90004402    KERNEL EXL
Cause : 00808024
        80081338 80080470 00000a00 00000001 8ffa0000 8ffc0000 80082e18 
80363274
        00000000 90004400 efffffff 802b0008 802b9430 802b2000 00000000 
0000001d
        802b1f80 81291f30 00008000 00008000 7fffffff 00100100 00200200 
7fffffff
        80082958 afff62a8 00000000 00000001 8ffa0000 8ffc0000 8ffc0000 
00000000
Call Trace:
 [<80080a30>] cobalt_irq+0x170/0x240
 [<80082958>] cpu_idle+0x48/0x50
 [<800ae97c>] irq_exit+0x5c/0x74
 [<80082958>] cpu_idle+0x48/0x50
 [<80081338>] ret_from_fork+0x0/0x8
 [<80080470>] init+0x0/0x270
 [<80082e18>] kernel_thread+0x74/0x8c
 [<80082958>] cpu_idle+0x48/0x50
 [<80082958>] cpu_idle+0x48/0x50
 [<80283dc0>] schedule+0x4c/0xacc
 [<80082958>] cpu_idle+0x48/0x50
 [<8019e514>] idr_cache_ctor+0x0/0xc
 [<8032f764>] start_kernel+0x1b4/0x25c
 [<8032f0fc>] unknown_bootoption+0x0/0x310
Code: 8fb00010  03e00008  27bd0028 <0200000d> 080a1249  8f820010  
27bdffb0  afbe0048  afb00040


 >>$16; 0000000080082958 <cpu_idle+48/50>
 >>$18; 00000000802b2000 <init_task+0/3c8>
 >>$25; 00000000802b1e23 <init_thread_union+1e23/2000>
 >>$28; 00000000802b0000 <init_thread_union+0/2000>
 >>$29; 00000000802b1e78 <init_thread_union+1e78/2000>
 >>$30; 00000000802b1e78 <init_thread_union+1e78/2000>
 >>$31; 0000000080081338 <ret_from_fork+0/8>

 >>PC;  00000000802849b0 <preempt_schedule_irq+cc/d8>   <=====

Trace; 0000000080080a30 <cobalt_irq+170/240>
Trace; 0000000080082958 <cpu_idle+48/50>
Trace; 00000000800ae97c <irq_exit+5c/74>
Trace; 0000000080082958 <cpu_idle+48/50>
Trace; 0000000080081338 <ret_from_fork+0/8>
Trace; 0000000080080470 <init+0/270>
Trace; 0000000080082e18 <kernel_thread+74/8c>
Trace; 0000000080082958 <cpu_idle+48/50>
Trace; 0000000080082958 <cpu_idle+48/50>
Trace; 0000000080283dc0 <schedule+4c/acc>
Trace; 0000000080082958 <cpu_idle+48/50>
Trace; 000000008019e514 <idr_cache_ctor+0/c>
Trace; 000000008032f764 <start_kernel+1b4/25c>
Trace; 000000008032f0fc <unknown_bootoption+0/310>

Code;  00000000802849a4 <preempt_schedule_irq+c0/d8>
00000000 <_PC>:
Code;  00000000802849a4 <preempt_schedule_irq+c0/d8>
   0:   8fb00010  lw      s0,16(sp)
Code;  00000000802849a8 <preempt_schedule_irq+c4/d8>
   4:   03e00008  jr      ra
Code;  00000000802849ac <preempt_schedule_irq+c8/d8>
   8:   27bd0028  addiu   sp,sp,40
Code;  00000000802849b0 <preempt_schedule_irq+cc/d8>   <=====
   c:   0200000d  break   0x200   <=====
Code;  00000000802849b4 <preempt_schedule_irq+d0/d8>
  10:   080a1249  j       284924 <_PC+0x284924>
Code;  00000000802849b8 <preempt_schedule_irq+d4/d8>
  14:   8f820010  lw      v0,16(gp)
Code;  00000000802849bc <wait_for_completion+0/1d4>
  18:   27bdffb0  addiu   sp,sp,-80
Code;  00000000802849c0 <wait_for_completion+4/1d4>
  1c:   afbe0048  sw      s8,72(sp)
Code;  00000000802849c4 <wait_for_completion+8/1d4>
  20:   afb00040  sw      s0,64(sp)

Kernel panic - not syncing: Attempted to kill the idle task!


-- 
----
Jim Gifford
maillist@jg555.com
