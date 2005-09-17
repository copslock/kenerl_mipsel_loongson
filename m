Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Sep 2005 06:24:26 +0100 (BST)
Received: from bay107-f35.bay107.hotmail.com ([IPv6:::ffff:64.4.51.45]:57182
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224794AbVIQFYC>; Sat, 17 Sep 2005 06:24:02 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Fri, 16 Sep 2005 22:23:57 -0700
Message-ID: <BAY107-F351BA7EDDB556764AF6903C9900@phx.gbl>
Received: from 64.4.51.220 by by107fd.bay107.hotmail.msn.com with HTTP;
	Sat, 17 Sep 2005 05:23:56 GMT
X-Originating-IP: [64.4.51.220]
X-Originating-Email: [michaelanburaj@hotmail.com]
X-Sender: michaelanburaj@hotmail.com
In-Reply-To: <Pine.LNX.4.61L.0507191301220.10363@blysk.ds.pg.gda.pl>
From:	"Michael Anburaj" <michaelanburaj@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: linux 2.6.10 on MIPS Atlas 4Kc -- SAA9730 driver issue
Date:	Fri, 16 Sep 2005 22:23:56 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 17 Sep 2005 05:23:57.0230 (UTC) FILETIME=[009DACE0:01C5BB48]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi All,

Hardware: MIPS Atlas 4Kc
Linux: 2.6.10

I am having an issue with the SAA9730 driver. The kernel works fine other 
than this.

Problem:
I configure the interface & trying pinging outside, the IP packets make it 
to the xmit function in the driver & gets posted to the hardware, but does 
not get transmitted. And when I ping the interface from outside it causes an 
exception (I guess -- It hangs).The control comes to the interrupt handler 
in the driver -- on the way back it hangs.

Please let me know, what possibly could be wrong.

Thanks,
-Mike.

Following is the dump

#ifconfig eth0 192.168.1.105
lan_saa9730_open: IRQ17
lan_saa9730_open: pass
# Reserved instruction in kernel code in arch/mips/kernel/traps.c::do_ri, 
line :Cpu 0
$ 0   : 00000000 1000fc00 00000000 00000000
$ 4   : 80583f30 2ac2e020 00000001 00000000
$ 8   : 1000fc01 1000001e 00000001 804fe000
$12   : 00000000 00000000 80583e94 00000000
$16   : 80583f30 00000001 7fff6b30 00000000
$20   : 10010820 0000005b 10009898 10010000
$24   : 00000000 2ac2e000
$28   : 80582000 80583ee8 00000002 80107a28
Hi    : 12000000
Lo    : 0cf3b100
epc   : 8011a694 do_dsemulret+0x38/0xb4     Not tainted
ra    : 80107a28 do_ade+0x18/0x380
Status: 1000fc03    KERNEL EXL IE
Cause : 30800028
PrId  : 00018001
Modules linked in:
Process sh (pid: 52, threadinfo=80582000, task=8002cbc0)
Stack : 7fff6b30 00000001 10010820 80161c20 80107a28 2ac094d4 80561000 
00001000
        00000000 00001002 00000000 00000000 1000f1a6 00000001 1000f1a6 
00000001
        801017c4 8010a380 10010360 00001002 00000000 1000f318 ffffffff 
00000000
        00000000 1000fc00 00000001 2ac7cef4 00000000 7fff6b30 00000001 
00000000
        00000000 00000000 00000001 804fe000 00000000 00000000 80583e94 
00000000
        ...
Call Trace:
[<80161c20>] sys_read+0x58/0xa0
[<80107a28>] do_ade+0x18/0x380
[<801017c4>] handle_adel_int+0x38/0x54
[<8010a380>] tlb_do_page_fault_1+0x104/0x114


Code: 5440001c  00001021  00401821 <8ca60004> 8ca70008  00621825  14600006  
3c0
Reserved instruction in kernel code in arch/mips/kernel/traps.c::do_ri, line 
63:Cpu 0
$ 0   : 00000000 1000fc01 00000000 8036fbad
$ 4   : 0000003c 00000cf5 80e2fedc 00000000
$ 8   : 00000000 ffffffff 00000001 802e75b4
$12   : 8036eab1 fffffffe 80583c87 ffffffff
$16   : 802e4da0 00001000 7fff6da0 00000000
$20   : 00000002 7fff7ee4 0040672c 00000002
$24   : 00000010 00000007
$28   : 80e2e000 80e2fec0 004069a0 8011f158
Hi    : 12079999
Lo    : a692c28f
epc   : 8011f1f0 do_syslog+0x200/0x510     Not tainted
ra    : 8011f158 do_syslog+0x168/0x510
Status: 1000fc03    KERNEL EXL IE
Cause : 30800028
PrId  : 00018001
Modules linked in:
Process klogd (pid: 54, threadinfo=80e2e000, task=8002c400)
Stack : 00000035 00000006 00000002 801249b8 00000000 8002c400 801376c0 
80e2fedc
        80e2fedc 8013c560 00000000 8002c400 801376c0 80e2fedc 80e2fedc 
801064c8
        7fff6da0 00000035 00000035 00000006 8011f510 00000000 7fff6828 
7fff6844
        7fff685a 7fff6c27 801087e4 80100734 7fff79c0 7fff75c0 1000e018 
7fff71ba
        ffffffff 00000000 00000000 1000fc01 00001007 7fff7da0 00000002 
7fff6da0
        ...
Call Trace:
[<801249b8>] do_softirq+0x5c/0x90
[<801376c0>] autoremove_wake_function+0x0/0x4c
[<8013c560>] irq_exit+0x44/0x50
[<801376c0>] autoremove_wake_function+0x0/0x4c
[<801064c8>] ll_timer_interrupt+0x44/0x58
[<8011f510>] sys_syslog+0x10/0x1c
[<801087e4>] stack_done+0x20/0x3c
[<80100734>] mipsIRQ+0x114/0x160


Code: 40816000  00001021  00403821 <a2440000> 26520001  25080001  40016000  
000
Reserved instruction in kernel code in arch/mips/kernel/traps.c::do_ri, line 
63:Cpu 0
$ 0   : 00000000 1000fc01 00000000 00000000
$ 4   : 00000000 00000013 0000000b 804f7e40
$ 8   : 00000000 ffffffff 00000001 802e75b4
$12   : 8036eab1 fffffffe 80e2fc5f ffffffff
$16   : 8002cbc0 00000000 00000000 7fff7dc8
$20   : 00000000 01000000 00000001 804f5c68
$24   : 00000010 00000007
$28   : 804f8000 804f9e60 00000000 801232e8
Hi    : 1206147a
Lo    : ee3fbf0c
epc   : 80122868 wait_task_zombie+0x2d8/0x568     Not tainted
ra    : 801232e8 do_wait+0x204/0x4dc
Status: 1000fc03    KERNEL EXL IE
Cause : 30800028
PrId  : 00018001
Modules linked in:
Process init (pid: 1, threadinfo=804f8000, task=804f5bc0)
Stack : 804f9e68 803654bc c25bfe80 000f41fd fffffe00 804f5c68 804f5bc0 
00000004
        8002cbc0 8002cc70 804f5bc0 00000004 801232e8 801233ec 8665a700 
000f41fd
        804f9ed8 fffba8a5 00000000 7fff7ba8 00000000 804f5bc0 8011ba68 
804f5cd0
        804f5cd0 802aeb40 00000000 804f5bc0 8011ba68 00000000 00000000 
00200200
        00000000 00000000 0042efb8 7fff7f2c 00430000 0042e3e4 7fff7f24 
00000002
        ...
Call Trace:
[<801232e8>] do_wait+0x204/0x4dc
[<801233ec>] do_wait+0x308/0x4dc
[<8011ba68>] default_wake_function+0x0/0x2c
[<802aeb40>] schedule_timeout+0xb4/0xe4
[<8011ba68>] default_wake_function+0x0/0x2c
[<80123694>] sys_wait4+0x30/0x48
[<801087e4>] stack_done+0x20/0x3c
[<801087e4>] stack_done+0x20/0x3c


Code: 54400004  00408821  02201021 <ae660000> 00408821  1620006f  24020010  
124
Kernel panic - not syncing: Attempted to kill init!
