Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 19:51:51 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:45718
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8224992AbVCUTvf>;
	Mon, 21 Mar 2005 19:51:35 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 21 Mar 2005 11:51:32 -0800
  id 0000C3B3.423F25C4.00000253
Message-ID: <423F25AD.6030705@jg555.com>
Date:	Mon, 21 Mar 2005 11:51:09 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ralf@linux-mips.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Current Build Warning Message
References: <42375617.3020002@jg555.com> <20050315215538.GJ6025@linux-mips.org> <423EF440.9090902@jg555.com> <423EF764.1070305@jg555.com>
In-Reply-To: <423EF764.1070305@jg555.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

Ralf,
    Here are the warnings with ksym working.

Linux version 2.6.11.5-jg-2 (root@lfs) (gcc version 3.4.3) #1 Mon Mar 21 
11:07:30 PST 2005
CPU revision is: 000028a0
FPU revision is: 000028a0
Cobalt board ID: 6
Determined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: root=/dev/hda2 console=ttyS0,115200 ide1=noprobe
ide_setup: ide1=noprobe
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
Synthesized TLB refill handler (21 instructions).
Synthesized TLB load handler fastpath (34 instructions).
Synthesized TLB store handler fastpath (34 instructions).
Synthesized TLB modify handler fastpath (33 instructions).
PID hash table entries: 2048 (order: 11, 32768 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 256000k/262144k available (2079k kernel code, 5940k reserved, 
664k data, 112k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Checking for 'wait' instruction...  available.
Break instruction in kernel code in arch/mips/kernel/traps.c::do_bp, 
line 560[#1]:
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
ra    : 80081338 ret_from_fork+0x0/0x8
Status: 90004402    KERNEL EXL
Cause : 00808024
PrId  : 000028a0
Modules linked in:
Process swapper (pid: 0, threadinfo=802b0000, task=802b2000)
Stack : 8ffa0000 80080a30 80082958 800ae97c 80082958 afff62a8 00000000 
802b1f50
        80081338 80080470 00000a00 00000001 8ffa0000 8ffc0000 80082e18 
80363274
        00000000 90004400 efffffff 802b0008 802b9430 802b2000 00000000 
0000001d
        802b1f80 81291f30 00008000 00008000 7fffffff 00100100 00200200 
7fffffff
        80082958 afff62a8 00000000 00000001 8ffa0000 8ffc0000 8ffc0000 
00000000
        ...
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
Kernel panic - not syncing: Attempted to kill the idle task

-- 
----
Jim Gifford
maillist@jg555.com
