Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2003 16:13:34 +0100 (BST)
Received: from mail.convergence.de ([IPv6:::ffff:212.84.236.4]:2711 "EHLO
	mail.convergence.de") by linux-mips.org with ESMTP
	id <S8225480AbTJXPNa>; Fri, 24 Oct 2003 16:13:30 +0100
Received: from [10.1.1.146] (helo=heck)
	by mail.convergence.de with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.14)
	id 1AD3aq-0006gz-Cp
	for linux-mips@linux-mips.org; Fri, 24 Oct 2003 17:11:12 +0200
Received: from js by heck with local (Exim 3.35 #1 (Debian))
	id 1AD3d0-0006bZ-00
	for <linux-mips@linux-mips.org>; Fri, 24 Oct 2003 17:13:26 +0200
Date: Fri, 24 Oct 2003 17:13:25 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: random kernel panics with 2.4.22 running on VR4120A
Message-ID: <20031024151325.GB22979@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

Hi,

we've been using a 2.4.21 snapshot from linux-mips.org CVS for
about two months on a set-top-box chip with VR4120A core. This kernel
was rock solid.

After the 2.4.22 merge in linux-mips.org CVS I updated our kernel,
from 2.4.21-2003-07-08 to 2.4.22-2003-09-24, and now we are getting
occational kernel panics at random places, either one of:

  Unhandled kernel unaligned access in unaligned.c::emulate_load_store_insn, line 481:
  Kernel unaligned instruction access in unaligned.c::do_ade, line 550:

It happens about once per day on a box wich continously runs
a test suite, and rather seldom on other boxes.

I searched through the diff from 2.4.21-2003-07-08 to 2.4.22-2003-09-24, but did
not find something obvious (to me, at least ;).
I also checked the post-2003-09-24 CVS logs for possible bug fixes, but there's
no log message that clearly addresses such a problem.
I haven't yet tried to update to a newer kernel, but can do so.

Below is a (slightly censored) example Oops, but the actual place where it
crashes seems random.
I would greatly appreciate any hints. Are other VR41xx users seeing similar problems?

Our kernel is tainted due to proprietary modules being loaded, but the
same modules worked with 2.4.21-2003-07-08.


Unhandled kernel unaligned access in unaligned.c::emulate_load_store_insn, line 481:
$0 : 00000000 80a20000 00000000 0000001b 00005000 809ec000 80a197f4 00000000
$8 : 3d75d353 00000000 10008400 00000000 80a41b16 fffffff8 837f7c92 0000000a
$16: 00000001 00000001 00000000 80a18960 80a09080 fffffffe 00000006 00000001
$24: ffffffff 00000002                   837f6000 837f6160 810b5ec0 8081ca68
epc  : 8081c9a0    Tainted: P
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
Status: 10008403
Cause : 00000010
Process  (pid: 8, stackpage=837f6000)
Stack:    837f6000 00000001 00000000 8081c8b8 80a34468 80a34468 837f6170
 837f6170 80a18980 80818a38 837f6228 00000007 80a18980 8081cfb4 80818850
 003b1174 003b1174 003b1174 7c354722 80808ad4 00000001 80a090a0 fffffffe
 10008400 80a18960 80a090a0 8081827c 837f6228 80a18964 808010a0 0d5e4000
 00014400 80a080e0 00000007 80a15b80 fffffffb 837f6228 837f7eb8 808013c4
 80801374 ...
Call Trace:   [<8081c8b8>] [<80818a38>] [<8081cfb4>] [<80818850>] [<80808ad4>]
 [<8081827c>] [<808010a0>] [<808013c4>] [<80801374>] [<c01d0340>] [<c01d0340>]
 [<c01cd874>] [<809b980c>] [<80812870>] [<c01cce54>] [<809deca5>] [<c01d0340>]
 [<c01d0340>] [<c01cd874>] [<c01cffc3>] [<c01cc090>] [<c01cc0e0>] [<c01cffc0>]
 [<c01cffc4>] [<c01d0340>] [<c01cc2b8>] [<c01cfffc>] [<c01d0018>] [<c01cd874>]
 [<c01d0340>] [<c01ccc70>] [<c01cffc3>] [<c01d0340>] [<c01cce70>] [<c01cc0e0>]
 [<c01d0340>] [<c01cc114>] [<c01cffc0>] [<c01cffc4>] [<c01d0340>] ...
Warning (Oops_trace_line): garbage '...' at end of trace line ignored
Code: 1062000d  00002021  00402821 <8c620000> 50400006  24840800  8c620000  30420002  50400003


>>$1; 80a20000 <urandom_fops+38/48>
>>$5; 809ec000 <init_task_union+0/2000>
>>$6; 80a197f4 <xtime+4/8>
>>$12; 80a41b16 <printk_buf.916+26/400>
>>$14; 837f7c92 <_end+2d952a2/3f658670>
>>$19; 80a18960 <irq_stat+0/20>
>>$20; 80a09080 <tasklet_hi_vec+0/20>
>>$28; 837f6000 <_end+2d93610/3f658670>
>>$29; 837f6160 <_end+2d93770/3f658670>
>>$30; 810b5ec0 <_end+6534d0/3f658670>
>>$31; 8081ca68 <timer_bh+94/53c>

>>PC;  8081c9a0 <count_active_tasks+1c/50>   <=====

Trace; 8081c8b8 <update_process_times+38/104>
Trace; 80818a38 <bh_action+34/c8>
Trace; 8081cfb4 <do_timer+a4/134>
Trace; 80818850 <tasklet_hi_action+110/190>
Trace; 80808ad4 <timer_interrupt+74/208>
Trace; 8081827c <do_softirq+bc/184>
Trace; 808010a0 <handle_IRQ_event+84/f8>
Trace; 808013c4 <do_IRQ+f4/118>
Trace; 80801374 <do_IRQ+a4/118>
Trace; 809b980c <vr4120_handle_irq+12c/220>
Trace; 80812870 <_call_console_drivers+6c/7c>
[snip]

Code;  8081c994 <count_active_tasks+10/50>
00000000 <_PC>:
Code;  8081c994 <count_active_tasks+10/50>
   0:   1062000d  beq     v1,v0,38 <_PC+0x38>
Code;  8081c998 <count_active_tasks+14/50>
   4:   00002021  move    a0,zero
Code;  8081c99c <count_active_tasks+18/50>
   8:   00402821  move    a1,v0
Code;  8081c9a0 <count_active_tasks+1c/50>   <=====
   c:   8c620000  lw      v0,0(v1)   <=====
Code;  8081c9a4 <count_active_tasks+20/50>
  10:   50400006  0x50400006
Code;  8081c9a8 <count_active_tasks+24/50>
  14:   24840800  addiu   a0,a0,2048
Code;  8081c9ac <count_active_tasks+28/50>
  18:   8c620000  lw      v0,0(v1)
Code;  8081c9b0 <count_active_tasks+2c/50>
  1c:   30420002  andi    v0,v0,0x2
Code;  8081c9b4 <count_active_tasks+30/50>
  20:   50400003  0x50400003

Kernel panic: Aiee, killing interrupt handler!


Regards,
Johannes
