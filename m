Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2004 17:20:03 +0100 (BST)
Received: from web50803.mail.yahoo.com ([IPv6:::ffff:206.190.38.112]:61083
	"HELO web50803.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224907AbUHCQT4>; Tue, 3 Aug 2004 17:19:56 +0100
Message-ID: <20040803161949.89148.qmail@web50803.mail.yahoo.com>
Received: from [65.204.143.11] by web50803.mail.yahoo.com via HTTP; Tue, 03 Aug 2004 09:19:49 PDT
Date: Tue, 3 Aug 2004 09:19:49 -0700 (PDT)
From: G H <giles67@yahoo.com>
Subject: do_ri failure in cache flushing routines
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1918942025-1091549989=:87300"
Return-Path: <giles67@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giles67@yahoo.com
Precedence: bulk
X-list: linux-mips

--0-1918942025-1091549989=:87300
Content-Type: text/plain; charset=us-ascii

While testing out an amd au1500 based board I have been getting " do_ri " exceptions that always occur in the cache flushing routines. More often than not in blast_icache_32().
 
So far this has mainly happened after running the board for days on end while running multiple telnet sessions to it. It has sometimes ( quite rarely ) happened after a few hours to a day of multiple telnet session use.
 
If left to run for days on end the the do_ri always occurs in a lcd daemon we have for updating a simple 40 row by 2 column I2c dispay and the oops trace is :
 
Reading Oops report from the terminal
$0 : 00000000 1000fc01 7fff76e0 ffffffe0 7fff76e0 8034880c ffffffff 00000000
$8 : ffffffff ffffffff 00000000 00000002 80313ae4 0005800b 00000340 849dbe20
$16: 7fff76d8 7fff7ea4 00416050 0000000e 8437ff30 00000000 8436da5c 8437e3d0
$24: 00000000 2afb0900                   8437e000 8437fe30 8437ff08 80105510
Hi : 00000000
Lo : 00000001
epc   : 8010cd50    Not tainted
Using defaults from ksymoops -t elf32-tradlittlemips -a mips:3000
Status: 1000fc03
Cause : 00800028
Process lcd (pid: 106, stackpage=8437e000)
Stack:    1000fc01 00000001 00000000 00000001 0000000e 00000080 00000000
 00000000 00000000 00000003 00000000 0000000a 00000001 802feda0 8437e000
 802fe920 84cec000 00000000 802fe920 803487e0 00000000 2ab34390 00000010
 80156614 8437e000 8437feb8 8437feb8 80104a98 1000fc03 b3b77d7a 000006c5
 00000021 00801000 8010f690 ffffffff 10015d08 7fff76e8 7fff76f0 1000fc01
 00000000 ...
Call Trace:   [<80156614>] [<80104a98>] [<8010f690>] [<80104aa4>] [<801097a0>]
 [<80162038>]
 Code: bc550000  00031823  00832024 <bc900000> 03e00008  00000000  3c028035  8c42881c  27bdffe8

>>$5; 8034880c <cpu_data+2c/80>
>>$12; 80313ae4 <contig_page_data+0/3ac>
>>$31; 80105510 <do_signal+2a8/df8>
>>PC;  8010cd50 <r4k_flush_cache_sigtramp+24/30>   <=====
Trace; 80156614 <iput+128/2b4>
Trace; 80104a98 <_sys_rt_sigsuspend+164/180>
Trace; 8010f690 <schedule+2d8/4fc>
Trace; 80104aa4 <_sys_rt_sigsuspend+170/180>
Trace; 801097a0 <stack_done+1c/38>
Trace; 80162038 <create_proc_entry+58/d0>
Code;  8010cd44 <r4k_flush_cache_sigtramp+18/30>
00000000 <_PC>:
Code;  8010cd44 <r4k_flush_cache_sigtramp+18/30>
   0:   bc550000  0xbc550000
Code;  8010cd48 <r4k_flush_cache_sigtramp+1c/30>
   4:   00031823  negu    v1,v1
Code;  8010cd4c <r4k_flush_cache_sigtramp+20/30>
   8:   00832024  and     a0,a0,v1
Code;  8010cd50 <r4k_flush_cache_sigtramp+24/30>   <=====
   c:   bc900000  0xbc900000   <=====
Code;  8010cd54 <r4k_flush_cache_sigtramp+28/30>
  10:   03e00008  jr      ra
Code;  8010cd58 <r4k_flush_cache_sigtramp+2c/30>
  14:   00000000  nop
Code;  8010cd5c <r4k_flush_icache_all+0/3c>
  18:   3c028035  lui     v0,0x8035
Code;  8010cd60 <r4k_flush_icache_all+4/3c>
  1c:   8c42881c  lw      v0,-30692(v0)
Code;  8010cd64 <r4k_flush_icache_all+8/3c>
  20:   27bdffe8  addiu   sp,sp,-24
 
But on the times it has happened after a few hours / a day or so it has happened due to activity on the serial console when running general linux commands the oops traces are at the end of this email.
 
I am using a 2.4.24 kernel from linux-mips cvs. 
 
Does anyone have any idea what could be causing this ? And possible ways to fix it ?
 
Can someone explain to me why the cache flushing routines are triggering a "reserved instruction" at random like this when up to the point of failure the same code must have been executed millions of times without triggering the exception ?
 
Any help in debugging this is greatly appreciated.
 
 
Failure in sshd :
 
Reserved instruction in kernel code in traps.c::do_ri, line 663:
 $0 : 00000000 80000000 80001c00 80001000 80000c00 00001000 00000001 00004000
 $8 : 00001000 00000000 820700f0 00000000 2afaee50 2afaee9c fffffff8 fffffffa
 $16: 810517c8 823acf60 0041ee48 820700f0 0041ee48 00000000 802feda0 00000000
 $24: fffffffe 0041ee48                   81dd4000 81dd5d98 00000004 8010cabc
 Hi : ffffa71d
 Lo : 00001da1
 epc   : 8010d66c    Not tainted
Using defaults from ksymoops -t elf32-tradlittlemips -a mips:3000
 Status: 1000fc03
 Cause : 00800028
 Process sshd (pid: 631, stackpage=81dd4000)
 Stack:    0041ee48 820700f0 0041ee48 00000000 810517c8 823acf60 0041ee48
  80125138 74737271 78777675 000000d8 0015a298 100151fc 0007831e 000000d8
  0015a298 00000000 00000000 000000d8 0015a298 000007de 0007831e 802feda0
  00000000 0041ee48 823acf60 81dd5f30 00000000 802fedbc 00000001 80125460
  801253f4 826d5cf0 82030a20 81dd5ed0 81dd5ed0 820700f0 0007831a 7fff78b0
  00000005 ...
 Call Trace:   [<80125138>] [<80125460>] [<801253f4>] [<80133d74>] [<8010c1d8>]
  [<8023112c>] [<80231510>] [<80126d88>] [<80125a0c>] [<8010e8bc>]
 Code: bc400260  bc400280  bc4002a0 <bc4002c0> bc4002e0  bc400300  bc400320  bc400340  bc400360

>>$22; 802feda0 <pci_socket_init+20/58>
>>$31; 8010cabc <r4k_flush_icache_page+138/218>
>>PC;  8010d66c <blast_icache32+a0/f0>   <=====
Trace; 80125138 <do_no_page+144/3b8>
Trace; 80125460 <handle_mm_fault+b4/278>
Trace; 801253f4 <handle_mm_fault+48/278>
Trace; 80133d74 <free_pages+48/50>
Trace; 8010c1d8 <do_page_fault+160/3c8>
Trace; 8023112c <sock_recvmsg+48/104>
Trace; 80231510 <sock_poll+28/34>
Trace; 80126d88 <do_brk+16c/23c>
Trace; 80125a0c <sys_brk+c8/140>
Trace; 8010e8bc <nopage_tlbl+f0/114>
Code;  8010d660 <blast_icache32+94/f0>
00000000 <_PC>:
Code;  8010d660 <blast_icache32+94/f0>
   0:   bc400260  0xbc400260
Code;  8010d664 <blast_icache32+98/f0>
   4:   bc400280  0xbc400280
Code;  8010d668 <blast_icache32+9c/f0>
   8:   bc4002a0  0xbc4002a0
Code;  8010d66c <blast_icache32+a0/f0>   <=====
   c:   bc4002c0  0xbc4002c0   <=====
Code;  8010d670 <blast_icache32+a4/f0>
  10:   bc4002e0  0xbc4002e0
Code;  8010d674 <blast_icache32+a8/f0>
  14:   bc400300  0xbc400300
Code;  8010d678 <blast_icache32+ac/f0>
  18:   bc400320  0xbc400320
Code;  8010d67c <blast_icache32+b0/f0>
  1c:   bc400340  0xbc400340
Code;  8010d680 <blast_icache32+b4/f0>
  20:   bc400360  0xbc400360

Failure in ls :
 

Reading Oops report from the terminal
Reserved instruction in kernel code in traps.c::do_ri, line 663:
$0 : 00000000 80000000 80002000 80001000 80000000 00002000 000079d8 00004000
$8 : 00000001 00000000 8349a0e8 00000b3b 7f1c0300 00000001 65726168 00000115
$16: 810e7d2c 834cb740 0041da54 8349a0e8 0041da54 00000000 83a96460 00000000
$24: 00000000 2abede20                   8010f58b 83481d98 00000000 8010cabc
Hi : ffff031c
Lo : 0000544c
epc   : 8010d634    Not tainted
Using defaults from ksymoops -t elf32-tradlittlemips -a mips:3000
Status: 1000fc03
Cause : 00800028
Process ls (pid: 1335, stackpage=83480000)
Stack:    0041da54 8349a0e8 0041da54 00000000 810e7d2c 834cb740 0041da54
 80125138 4c4b4a49 504f4e4d 000000d8 0010b2d8 62615a59 66656463 000000d8
 0010b2d8 00000000 00000000 000000d8 0010b2d8 48474645 4c4b4a49 83a96460
 00000000 0041da54 834cb740 83481f30 00000000 83a9647c 00000000 80125460
 801253f4 44434241 48474645 7fff7ce0 00000000 8349a0e8 83481eb8 80312cd0
 2ad2d520 ...
Call Trace:   [<80125138>] [<80125460>] [<801253f4>] [<801198e8>] [<8010c1d8>]
 [<801bf480>] [<80125b4c>] [<80126e08>] [<801ae43c>] [<8014de3c>] [<80125a0c>]
 [<8010e8bc>]
Code: bc4000a0  bc4000c0  bc4000e0 <bc400100> bc400120  bc400140  bc400160  bc400180  bc4001a0

>>$28; 8010f58b <schedule+1d3/4fc>
>>$31; 8010cabc <r4k_flush_icache_page+138/218>
>>PC;  8010d634 <blast_icache32+68/f0>   <=====
Trace; 80125138 <do_no_page+144/3b8>
Trace; 80125460 <handle_mm_fault+b4/278>
Trace; 801253f4 <handle_mm_fault+48/278>
Trace; 801198e8 <parse_table+16c/174>
Trace; 8010c1d8 <do_page_fault+160/3c8>
Trace; 801bf480 <ltxser_interrupt+204/32c>
Trace; 80125b4c <__vma_link+44/dc>
Trace; 80126e08 <do_brk+1ec/23c>
Trace; 801ae43c <tty_ioctl+15c/51c>
Trace; 8014de3c <sys_ioctl+a0/2e4>
Trace; 80125a0c <sys_brk+c8/140>
Trace; 8010e8bc <nopage_tlbl+f0/114>
Code;  8010d628 <blast_icache32+5c/f0>
00000000 <_PC>:
Code;  8010d628 <blast_icache32+5c/f0>
   0:   bc4000a0  0xbc4000a0
Code;  8010d62c <blast_icache32+60/f0>
   4:   bc4000c0  0xbc4000c0
Code;  8010d630 <blast_icache32+64/f0>
   8:   bc4000e0  0xbc4000e0
Code;  8010d634 <blast_icache32+68/f0>   <=====
   c:   bc400100  0xbc400100   <=====
Code;  8010d638 <blast_icache32+6c/f0>
  10:   bc400120  0xbc400120
Code;  8010d63c <blast_icache32+70/f0>
  14:   bc400140  0xbc400140
Code;  8010d640 <blast_icache32+74/f0>
  18:   bc400160  0xbc400160
Code;  8010d644 <blast_icache32+78/f0>
  1c:   bc400180  0xbc400180
Code;  8010d648 <blast_icache32+7c/f0>
  20:   bc4001a0  0xbc4001a0

Failure in stat:
 
Reserved instruction in kernel code in traps.c::do_ri, line 663:
$0 : 00000000 80000000 80002400 80001000 80000400 00002000 000079d8 00004000
$8 : 00000001 00000000 82ea8828 6ffffeff 6fffff72 00000063 40f2d4f7 00000000
$16: 810eeb84 834cb920 2ab051ac 82ea8828 2ab051ac 00000000 83a96460 00000000
$24: 00000000 2aabcd10                   8010f58b 82eb5d98 7fff7678 8010cabc
Hi : fffefb96
Lo : 000056ce
epc   : 8010d650    Not tainted
Using defaults from ksymoops -t elf32-tradlittlemips -a mips:3000
Status: 1000fc03
Cause : 00800028
Process stat (pid: 1376, stackpage=82eb4000)
Stack:    2ab051ac 82ea8828 2ab051ac 00000000 810eeb84 834cb920 2ab051ac
 80125138 00000000 856ff768 000000d8 0015b458 000005dc 000baa5c 000000d8
 0015b458 00000000 00000000 000000d8 0015b458 000000d8 000baa58 83a96460
 00000000 2ab051ac 834cb920 82eb5f30 00000000 83a9647c 00000001 80125460
 801253f4 834cb938 834cb920 834cbbc0 834cbbc0 82ea8828 0015bb1a 801267c8
 8010e8bc ...
Call Trace:   [<80125138>] [<80125460>] [<801253f4>] [<801267c8>] [<8010e8bc>]
 [<8010c1d8>] [<80126068>] [<8012d008>] [<801a074c>] [<80108034>] [<8010e8bc>]
Code: bc400180  bc4001a0  bc4001c0 <bc4001e0> bc400200  bc400220  bc400240  bc400260  bc400280

>>$28; 8010f58b <schedule+1d3/4fc>
>>$31; 8010cabc <r4k_flush_icache_page+138/218>
>>PC;  8010d650 <blast_icache32+84/f0>   <=====
Trace; 80125138 <do_no_page+144/3b8>
Trace; 80125460 <handle_mm_fault+b4/278>
Trace; 801253f4 <handle_mm_fault+48/278>
Trace; 801267c8 <unmap_fixup+1e4/1fc>
Trace; 8010e8bc <nopage_tlbl+f0/114>
Trace; 8010c1d8 <do_page_fault+160/3c8>
Trace; 80126068 <do_mmap_pgoff+350/5b0>
Trace; 8012d008 <mprotect_fixup+1f0/534>
Trace; 801a074c <fpu_emulator_cop1Handler+198/1bc>
Trace; 80108034 <do_cpu+2e0/334>
Trace; 8010e8bc <nopage_tlbl+f0/114>
Code;  8010d644 <blast_icache32+78/f0>
00000000 <_PC>:
Code;  8010d644 <blast_icache32+78/f0>
   0:   bc400180  0xbc400180
Code;  8010d648 <blast_icache32+7c/f0>
   4:   bc4001a0  0xbc4001a0
Code;  8010d64c <blast_icache32+80/f0>
   8:   bc4001c0  0xbc4001c0
Code;  8010d650 <blast_icache32+84/f0>   <=====
   c:   bc4001e0  0xbc4001e0   <=====
Code;  8010d654 <blast_icache32+88/f0>
  10:   bc400200  0xbc400200
Code;  8010d658 <blast_icache32+8c/f0>
  14:   bc400220  0xbc400220
Code;  8010d65c <blast_icache32+90/f0>
  18:   bc400240  0xbc400240
Code;  8010d660 <blast_icache32+94/f0>
  1c:   bc400260  0xbc400260
Code;  8010d664 <blast_icache32+98/f0>
  20:   bc400280  0xbc400280

  

		
---------------------------------
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
--0-1918942025-1091549989=:87300
Content-Type: text/html; charset=us-ascii

<DIV>While testing out an amd au1500 based board I have been getting " do_ri "&nbsp;exceptions that always occur in the cache flushing routines. More often than not in blast_icache_32().</DIV>
<DIV>&nbsp;</DIV>
<DIV>So far this has mainly happened after&nbsp;running the board for days on end while running multiple telnet sessions to it. It has sometimes ( quite rarely ) happened after a few hours to a day of multiple telnet session use.</DIV>
<DIV>&nbsp;</DIV>
<DIV>If left to run for days on end the the do_ri always occurs in a lcd daemon we have for updating a simple 40 row by 2 column I2c dispay and the oops trace is :</DIV>
<DIV>&nbsp;</DIV>
<DIV>Reading Oops report from the terminal<BR>$0 : 00000000 1000fc01 7fff76e0 ffffffe0 7fff76e0 8034880c ffffffff 00000000<BR>$8 : ffffffff ffffffff 00000000 00000002 80313ae4 0005800b 00000340 849dbe20<BR>$16: 7fff76d8 7fff7ea4 00416050 0000000e 8437ff30 00000000 8436da5c 8437e3d0<BR>$24: 00000000 2afb0900&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8437e000 8437fe30 8437ff08 80105510<BR>Hi : 00000000<BR>Lo : 00000001<BR>epc&nbsp;&nbsp; : 8010cd50&nbsp;&nbsp;&nbsp; Not tainted<BR>Using defaults from ksymoops -t elf32-tradlittlemips -a mips:3000<BR>Status: 1000fc03<BR>Cause : 00800028<BR>Process lcd (pid: 106, stackpage=8437e000)<BR>Stack:&nbsp;&nbsp;&nbsp; 1000fc01 00000001 00000000 00000001 0000000e 00000080 00000000<BR>&nbsp;00000000 00000000 00000003 00000000 0000000a 00000001 802feda0 8437e000<BR>&nbsp;802fe920 84cec000 00000000 802fe920 803487e0 00000000 2ab34390 00000010<BR>&nbsp;80156614 8437e000 8437feb8
 8437feb8 80104a98 1000fc03 b3b77d7a 000006c5<BR>&nbsp;00000021 00801000 8010f690 ffffffff 10015d08 7fff76e8 7fff76f0 1000fc01<BR>&nbsp;00000000 ...<BR>Call Trace:&nbsp;&nbsp; [&lt;80156614&gt;] [&lt;80104a98&gt;] [&lt;8010f690&gt;] [&lt;80104aa4&gt;] [&lt;801097a0&gt;]<BR>&nbsp;[&lt;80162038&gt;]<BR>&nbsp;Code: bc550000&nbsp; 00031823&nbsp; 00832024 &lt;bc900000&gt; 03e00008&nbsp; 00000000&nbsp; 3c028035&nbsp; 8c42881c&nbsp; 27bdffe8</DIV>
<DIV><BR>&gt;&gt;$5; 8034880c &lt;cpu_data+2c/80&gt;<BR>&gt;&gt;$12; 80313ae4 &lt;contig_page_data+0/3ac&gt;<BR>&gt;&gt;$31; 80105510 &lt;do_signal+2a8/df8&gt;</DIV>
<DIV>&gt;&gt;PC;&nbsp; 8010cd50 &lt;r4k_flush_cache_sigtramp+24/30&gt;&nbsp;&nbsp; &lt;=====</DIV>
<DIV>Trace; 80156614 &lt;iput+128/2b4&gt;<BR>Trace; 80104a98 &lt;_sys_rt_sigsuspend+164/180&gt;<BR>Trace; 8010f690 &lt;schedule+2d8/4fc&gt;<BR>Trace; 80104aa4 &lt;_sys_rt_sigsuspend+170/180&gt;<BR>Trace; 801097a0 &lt;stack_done+1c/38&gt;<BR>Trace; 80162038 &lt;create_proc_entry+58/d0&gt;</DIV>
<DIV>Code;&nbsp; 8010cd44 &lt;r4k_flush_cache_sigtramp+18/30&gt;<BR>00000000 &lt;_PC&gt;:<BR>Code;&nbsp; 8010cd44 &lt;r4k_flush_cache_sigtramp+18/30&gt;<BR>&nbsp;&nbsp; 0:&nbsp;&nbsp; bc550000&nbsp; 0xbc550000<BR>Code;&nbsp; 8010cd48 &lt;r4k_flush_cache_sigtramp+1c/30&gt;<BR>&nbsp;&nbsp; 4:&nbsp;&nbsp; 00031823&nbsp; negu&nbsp;&nbsp;&nbsp; v1,v1<BR>Code;&nbsp; 8010cd4c &lt;r4k_flush_cache_sigtramp+20/30&gt;<BR>&nbsp;&nbsp; 8:&nbsp;&nbsp; 00832024&nbsp; and&nbsp;&nbsp;&nbsp;&nbsp; a0,a0,v1<BR>Code;&nbsp; 8010cd50 &lt;r4k_flush_cache_sigtramp+24/30&gt;&nbsp;&nbsp; &lt;=====<BR>&nbsp;&nbsp; c:&nbsp;&nbsp; bc900000&nbsp; 0xbc900000&nbsp;&nbsp; &lt;=====<BR>Code;&nbsp; 8010cd54 &lt;r4k_flush_cache_sigtramp+28/30&gt;<BR>&nbsp; 10:&nbsp;&nbsp; 03e00008&nbsp; jr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ra<BR>Code;&nbsp; 8010cd58 &lt;r4k_flush_cache_sigtramp+2c/30&gt;<BR>&nbsp; 14:&nbsp;&nbsp; 00000000&nbsp; nop<BR>Code;&nbsp; 8010cd5c &lt;r4k_flush_icache_all+0/3c&gt;<BR>&nbsp; 18:&nbsp;&nbsp;
 3c028035&nbsp; lui&nbsp;&nbsp;&nbsp;&nbsp; v0,0x8035<BR>Code;&nbsp; 8010cd60 &lt;r4k_flush_icache_all+4/3c&gt;<BR>&nbsp; 1c:&nbsp;&nbsp; 8c42881c&nbsp; lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; v0,-30692(v0)<BR>Code;&nbsp; 8010cd64 &lt;r4k_flush_icache_all+8/3c&gt;<BR>&nbsp; 20:&nbsp;&nbsp; 27bdffe8&nbsp; addiu&nbsp;&nbsp; sp,sp,-24</DIV>
<DIV>&nbsp;</DIV>
<DIV>But on the times it has happened after a few hours / a day or so it has happened due to activity on the serial console when running general linux commands the oops&nbsp;traces are at the end of this email.</DIV>
<DIV>&nbsp;</DIV>
<DIV>I am using a 2.4.24 kernel from linux-mips cvs. </DIV>
<DIV>&nbsp;</DIV>
<DIV>Does anyone have any idea what could be causing this ? And possible ways to fix it ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Can someone explain to me why the cache flushing routines are triggering a "reserved instruction" at random like this when up to the point of failure the same code must have been executed millions of times without triggering the exception ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>Any help in debugging this is greatly appreciated.</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Failure in sshd :</DIV>
<DIV>&nbsp;</DIV>
<DIV>Reserved instruction in kernel code in traps.c::do_ri, line 663:<BR>&nbsp;$0 : 00000000 80000000 80001c00 80001000 80000c00 00001000 00000001 00004000<BR>&nbsp;$8 : 00001000 00000000 820700f0 00000000 2afaee50 2afaee9c fffffff8 fffffffa<BR>&nbsp;$16: 810517c8 823acf60 0041ee48 820700f0 0041ee48 00000000 802feda0 00000000<BR>&nbsp;$24: fffffffe 0041ee48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 81dd4000 81dd5d98 00000004 8010cabc<BR>&nbsp;Hi : ffffa71d<BR>&nbsp;Lo : 00001da1<BR>&nbsp;epc&nbsp;&nbsp; : 8010d66c&nbsp;&nbsp;&nbsp; Not tainted<BR>Using defaults from ksymoops -t elf32-tradlittlemips -a mips:3000<BR>&nbsp;Status: 1000fc03<BR>&nbsp;Cause : 00800028<BR>&nbsp;Process sshd (pid: 631, stackpage=81dd4000)<BR>&nbsp;Stack:&nbsp;&nbsp;&nbsp; 0041ee48 820700f0 0041ee48 00000000 810517c8 823acf60 0041ee48<BR>&nbsp; 80125138 74737271 78777675 000000d8 0015a298 100151fc 0007831e 000000d8<BR>&nbsp; 0015a298 00000000
 00000000 000000d8 0015a298 000007de 0007831e 802feda0<BR>&nbsp; 00000000 0041ee48 823acf60 81dd5f30 00000000 802fedbc 00000001 80125460<BR>&nbsp; 801253f4 826d5cf0 82030a20 81dd5ed0 81dd5ed0 820700f0 0007831a 7fff78b0<BR>&nbsp; 00000005 ...<BR>&nbsp;Call Trace:&nbsp;&nbsp; [&lt;80125138&gt;] [&lt;80125460&gt;] [&lt;801253f4&gt;] [&lt;80133d74&gt;] [&lt;8010c1d8&gt;]<BR>&nbsp; [&lt;8023112c&gt;] [&lt;80231510&gt;] [&lt;80126d88&gt;] [&lt;80125a0c&gt;] [&lt;8010e8bc&gt;]<BR>&nbsp;Code: bc400260&nbsp; bc400280&nbsp; bc4002a0 &lt;bc4002c0&gt; bc4002e0&nbsp; bc400300&nbsp; bc400320&nbsp; bc400340&nbsp; bc400360</DIV>
<DIV><BR>&gt;&gt;$22; 802feda0 &lt;pci_socket_init+20/58&gt;<BR>&gt;&gt;$31; 8010cabc &lt;r4k_flush_icache_page+138/218&gt;</DIV>
<DIV>&gt;&gt;PC;&nbsp; 8010d66c &lt;blast_icache32+a0/f0&gt;&nbsp;&nbsp; &lt;=====</DIV>
<DIV>Trace; 80125138 &lt;do_no_page+144/3b8&gt;<BR>Trace; 80125460 &lt;handle_mm_fault+b4/278&gt;<BR>Trace; 801253f4 &lt;handle_mm_fault+48/278&gt;<BR>Trace; 80133d74 &lt;free_pages+48/50&gt;<BR>Trace; 8010c1d8 &lt;do_page_fault+160/3c8&gt;<BR>Trace; 8023112c &lt;sock_recvmsg+48/104&gt;<BR>Trace; 80231510 &lt;sock_poll+28/34&gt;<BR>Trace; 80126d88 &lt;do_brk+16c/23c&gt;<BR>Trace; 80125a0c &lt;sys_brk+c8/140&gt;<BR>Trace; 8010e8bc &lt;nopage_tlbl+f0/114&gt;</DIV>
<DIV>Code;&nbsp; 8010d660 &lt;blast_icache32+94/f0&gt;<BR>00000000 &lt;_PC&gt;:<BR>Code;&nbsp; 8010d660 &lt;blast_icache32+94/f0&gt;<BR>&nbsp;&nbsp; 0:&nbsp;&nbsp; bc400260&nbsp; 0xbc400260<BR>Code;&nbsp; 8010d664 &lt;blast_icache32+98/f0&gt;<BR>&nbsp;&nbsp; 4:&nbsp;&nbsp; bc400280&nbsp; 0xbc400280<BR>Code;&nbsp; 8010d668 &lt;blast_icache32+9c/f0&gt;<BR>&nbsp;&nbsp; 8:&nbsp;&nbsp; bc4002a0&nbsp; 0xbc4002a0<BR>Code;&nbsp; 8010d66c &lt;blast_icache32+a0/f0&gt;&nbsp;&nbsp; &lt;=====<BR>&nbsp;&nbsp; c:&nbsp;&nbsp; bc4002c0&nbsp; 0xbc4002c0&nbsp;&nbsp; &lt;=====<BR>Code;&nbsp; 8010d670 &lt;blast_icache32+a4/f0&gt;<BR>&nbsp; 10:&nbsp;&nbsp; bc4002e0&nbsp; 0xbc4002e0<BR>Code;&nbsp; 8010d674 &lt;blast_icache32+a8/f0&gt;<BR>&nbsp; 14:&nbsp;&nbsp; bc400300&nbsp; 0xbc400300<BR>Code;&nbsp; 8010d678 &lt;blast_icache32+ac/f0&gt;<BR>&nbsp; 18:&nbsp;&nbsp; bc400320&nbsp; 0xbc400320<BR>Code;&nbsp; 8010d67c &lt;blast_icache32+b0/f0&gt;<BR>&nbsp; 1c:&nbsp;&nbsp; bc400340&nbsp; 0xbc400340<BR>Code;&nbsp;
 8010d680 &lt;blast_icache32+b4/f0&gt;<BR>&nbsp; 20:&nbsp;&nbsp; bc400360&nbsp; 0xbc400360<BR></DIV>
<DIV>
<DIV>Failure in&nbsp;ls :</DIV>
<DIV>&nbsp;</DIV></DIV>
<DIV>Reading Oops report from the terminal<BR>Reserved instruction in kernel code in traps.c::do_ri, line 663:<BR>$0 : 00000000 80000000 80002000 80001000 80000000 00002000 000079d8 00004000<BR>$8 : 00000001 00000000 8349a0e8 00000b3b 7f1c0300 00000001 65726168 00000115<BR>$16: 810e7d2c 834cb740 0041da54 8349a0e8 0041da54 00000000 83a96460 00000000<BR>$24: 00000000 2abede20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8010f58b 83481d98 00000000 8010cabc<BR>Hi : ffff031c<BR>Lo : 0000544c<BR>epc&nbsp;&nbsp; : 8010d634&nbsp;&nbsp;&nbsp; Not tainted<BR>Using defaults from ksymoops -t elf32-tradlittlemips -a mips:3000<BR>Status: 1000fc03<BR>Cause : 00800028<BR>Process ls (pid: 1335, stackpage=83480000)<BR>Stack:&nbsp;&nbsp;&nbsp; 0041da54 8349a0e8 0041da54 00000000 810e7d2c 834cb740 0041da54<BR>&nbsp;80125138 4c4b4a49 504f4e4d 000000d8 0010b2d8 62615a59 66656463 000000d8<BR>&nbsp;0010b2d8 00000000 00000000 000000d8 0010b2d8
 48474645 4c4b4a49 83a96460<BR>&nbsp;00000000 0041da54 834cb740 83481f30 00000000 83a9647c 00000000 80125460<BR>&nbsp;801253f4 44434241 48474645 7fff7ce0 00000000 8349a0e8 83481eb8 80312cd0<BR>&nbsp;2ad2d520 ...<BR>Call Trace:&nbsp;&nbsp; [&lt;80125138&gt;] [&lt;80125460&gt;] [&lt;801253f4&gt;] [&lt;801198e8&gt;] [&lt;8010c1d8&gt;]<BR>&nbsp;[&lt;801bf480&gt;] [&lt;80125b4c&gt;] [&lt;80126e08&gt;] [&lt;801ae43c&gt;] [&lt;8014de3c&gt;] [&lt;80125a0c&gt;]<BR>&nbsp;[&lt;8010e8bc&gt;]<BR>Code: bc4000a0&nbsp; bc4000c0&nbsp; bc4000e0 &lt;bc400100&gt; bc400120&nbsp; bc400140&nbsp; bc400160&nbsp; bc400180&nbsp; bc4001a0</DIV>
<DIV><BR>&gt;&gt;$28; 8010f58b &lt;schedule+1d3/4fc&gt;<BR>&gt;&gt;$31; 8010cabc &lt;r4k_flush_icache_page+138/218&gt;</DIV>
<DIV>&gt;&gt;PC;&nbsp; 8010d634 &lt;blast_icache32+68/f0&gt;&nbsp;&nbsp; &lt;=====</DIV>
<DIV>Trace; 80125138 &lt;do_no_page+144/3b8&gt;<BR>Trace; 80125460 &lt;handle_mm_fault+b4/278&gt;<BR>Trace; 801253f4 &lt;handle_mm_fault+48/278&gt;<BR>Trace; 801198e8 &lt;parse_table+16c/174&gt;<BR>Trace; 8010c1d8 &lt;do_page_fault+160/3c8&gt;<BR>Trace; 801bf480 &lt;ltxser_interrupt+204/32c&gt;<BR>Trace; 80125b4c &lt;__vma_link+44/dc&gt;<BR>Trace; 80126e08 &lt;do_brk+1ec/23c&gt;<BR>Trace; 801ae43c &lt;tty_ioctl+15c/51c&gt;<BR>Trace; 8014de3c &lt;sys_ioctl+a0/2e4&gt;<BR>Trace; 80125a0c &lt;sys_brk+c8/140&gt;<BR>Trace; 8010e8bc &lt;nopage_tlbl+f0/114&gt;</DIV>
<DIV>Code;&nbsp; 8010d628 &lt;blast_icache32+5c/f0&gt;<BR>00000000 &lt;_PC&gt;:<BR>Code;&nbsp; 8010d628 &lt;blast_icache32+5c/f0&gt;<BR>&nbsp;&nbsp; 0:&nbsp;&nbsp; bc4000a0&nbsp; 0xbc4000a0<BR>Code;&nbsp; 8010d62c &lt;blast_icache32+60/f0&gt;<BR>&nbsp;&nbsp; 4:&nbsp;&nbsp; bc4000c0&nbsp; 0xbc4000c0<BR>Code;&nbsp; 8010d630 &lt;blast_icache32+64/f0&gt;<BR>&nbsp;&nbsp; 8:&nbsp;&nbsp; bc4000e0&nbsp; 0xbc4000e0<BR>Code;&nbsp; 8010d634 &lt;blast_icache32+68/f0&gt;&nbsp;&nbsp; &lt;=====<BR>&nbsp;&nbsp; c:&nbsp;&nbsp; bc400100&nbsp; 0xbc400100&nbsp;&nbsp; &lt;=====<BR>Code;&nbsp; 8010d638 &lt;blast_icache32+6c/f0&gt;<BR>&nbsp; 10:&nbsp;&nbsp; bc400120&nbsp; 0xbc400120<BR>Code;&nbsp; 8010d63c &lt;blast_icache32+70/f0&gt;<BR>&nbsp; 14:&nbsp;&nbsp; bc400140&nbsp; 0xbc400140<BR>Code;&nbsp; 8010d640 &lt;blast_icache32+74/f0&gt;<BR>&nbsp; 18:&nbsp;&nbsp; bc400160&nbsp; 0xbc400160<BR>Code;&nbsp; 8010d644 &lt;blast_icache32+78/f0&gt;<BR>&nbsp; 1c:&nbsp;&nbsp; bc400180&nbsp; 0xbc400180<BR>Code;&nbsp;
 8010d648 &lt;blast_icache32+7c/f0&gt;<BR>&nbsp; 20:&nbsp;&nbsp; bc4001a0&nbsp; 0xbc4001a0<BR></DIV>
<DIV>Failure in stat:</DIV>
<DIV>&nbsp;</DIV>
<DIV>Reserved instruction in kernel code in traps.c::do_ri, line 663:<BR>$0 : 00000000 80000000 80002400 80001000 80000400 00002000 000079d8 00004000<BR>$8 : 00000001 00000000 82ea8828 6ffffeff 6fffff72 00000063 40f2d4f7 00000000<BR>$16: 810eeb84 834cb920 2ab051ac 82ea8828 2ab051ac 00000000 83a96460 00000000<BR>$24: 00000000 2aabcd10&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8010f58b 82eb5d98 7fff7678 8010cabc<BR>Hi : fffefb96<BR>Lo : 000056ce<BR>epc&nbsp;&nbsp; : 8010d650&nbsp;&nbsp;&nbsp; Not tainted<BR>Using defaults from ksymoops -t elf32-tradlittlemips -a mips:3000<BR>Status: 1000fc03<BR>Cause : 00800028<BR>Process stat (pid: 1376, stackpage=82eb4000)<BR>Stack:&nbsp;&nbsp;&nbsp; 2ab051ac 82ea8828 2ab051ac 00000000 810eeb84 834cb920 2ab051ac<BR>&nbsp;80125138 00000000 856ff768 000000d8 0015b458 000005dc 000baa5c 000000d8<BR>&nbsp;0015b458 00000000 00000000 000000d8 0015b458 000000d8 000baa58
 83a96460<BR>&nbsp;00000000 2ab051ac 834cb920 82eb5f30 00000000 83a9647c 00000001 80125460<BR>&nbsp;801253f4 834cb938 834cb920 834cbbc0 834cbbc0 82ea8828 0015bb1a 801267c8<BR>&nbsp;8010e8bc ...<BR>Call Trace:&nbsp;&nbsp; [&lt;80125138&gt;] [&lt;80125460&gt;] [&lt;801253f4&gt;] [&lt;801267c8&gt;] [&lt;8010e8bc&gt;]<BR>&nbsp;[&lt;8010c1d8&gt;] [&lt;80126068&gt;] [&lt;8012d008&gt;] [&lt;801a074c&gt;] [&lt;80108034&gt;] [&lt;8010e8bc&gt;]<BR>Code: bc400180&nbsp; bc4001a0&nbsp; bc4001c0 &lt;bc4001e0&gt; bc400200&nbsp; bc400220&nbsp; bc400240&nbsp; bc400260&nbsp; bc400280</DIV>
<DIV><BR>&gt;&gt;$28; 8010f58b &lt;schedule+1d3/4fc&gt;<BR>&gt;&gt;$31; 8010cabc &lt;r4k_flush_icache_page+138/218&gt;</DIV>
<DIV>&gt;&gt;PC;&nbsp; 8010d650 &lt;blast_icache32+84/f0&gt;&nbsp;&nbsp; &lt;=====</DIV>
<DIV>Trace; 80125138 &lt;do_no_page+144/3b8&gt;<BR>Trace; 80125460 &lt;handle_mm_fault+b4/278&gt;<BR>Trace; 801253f4 &lt;handle_mm_fault+48/278&gt;<BR>Trace; 801267c8 &lt;unmap_fixup+1e4/1fc&gt;<BR>Trace; 8010e8bc &lt;nopage_tlbl+f0/114&gt;<BR>Trace; 8010c1d8 &lt;do_page_fault+160/3c8&gt;<BR>Trace; 80126068 &lt;do_mmap_pgoff+350/5b0&gt;<BR>Trace; 8012d008 &lt;mprotect_fixup+1f0/534&gt;<BR>Trace; 801a074c &lt;fpu_emulator_cop1Handler+198/1bc&gt;<BR>Trace; 80108034 &lt;do_cpu+2e0/334&gt;<BR>Trace; 8010e8bc &lt;nopage_tlbl+f0/114&gt;</DIV>
<DIV>Code;&nbsp; 8010d644 &lt;blast_icache32+78/f0&gt;<BR>00000000 &lt;_PC&gt;:<BR>Code;&nbsp; 8010d644 &lt;blast_icache32+78/f0&gt;<BR>&nbsp;&nbsp; 0:&nbsp;&nbsp; bc400180&nbsp; 0xbc400180<BR>Code;&nbsp; 8010d648 &lt;blast_icache32+7c/f0&gt;<BR>&nbsp;&nbsp; 4:&nbsp;&nbsp; bc4001a0&nbsp; 0xbc4001a0<BR>Code;&nbsp; 8010d64c &lt;blast_icache32+80/f0&gt;<BR>&nbsp;&nbsp; 8:&nbsp;&nbsp; bc4001c0&nbsp; 0xbc4001c0<BR>Code;&nbsp; 8010d650 &lt;blast_icache32+84/f0&gt;&nbsp;&nbsp; &lt;=====<BR>&nbsp;&nbsp; c:&nbsp;&nbsp; bc4001e0&nbsp; 0xbc4001e0&nbsp;&nbsp; &lt;=====<BR>Code;&nbsp; 8010d654 &lt;blast_icache32+88/f0&gt;<BR>&nbsp; 10:&nbsp;&nbsp; bc400200&nbsp; 0xbc400200<BR>Code;&nbsp; 8010d658 &lt;blast_icache32+8c/f0&gt;<BR>&nbsp; 14:&nbsp;&nbsp; bc400220&nbsp; 0xbc400220<BR>Code;&nbsp; 8010d65c &lt;blast_icache32+90/f0&gt;<BR>&nbsp; 18:&nbsp;&nbsp; bc400240&nbsp; 0xbc400240<BR>Code;&nbsp; 8010d660 &lt;blast_icache32+94/f0&gt;<BR>&nbsp; 1c:&nbsp;&nbsp; bc400260&nbsp; 0xbc400260<BR>Code;&nbsp;
 8010d664 &lt;blast_icache32+98/f0&gt;<BR>&nbsp; 20:&nbsp;&nbsp; bc400280&nbsp; 0xbc400280<BR></DIV>
<DIV>&nbsp; </DIV><p>
		<hr size=1>Do you Yahoo!?<br>
<a href="http://us.rd.yahoo.com/mail_us/taglines/aac/*http://promotions.yahoo.com/new_mail/static/ease.html">Yahoo! Mail Address AutoComplete</a> - You start. We finish.
--0-1918942025-1091549989=:87300--
