Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2003 18:23:02 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:14844 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225201AbTGRRW7>;
	Fri, 18 Jul 2003 18:22:59 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h6IHMu332075;
	Fri, 18 Jul 2003 10:22:56 -0700
Date: Fri, 18 Jul 2003 10:22:56 -0700
From: Jun Sun <jsun@mvista.com>
To: Jack Miller <jack.miller@pioneer-pdt.com>
Cc: Linux-Mips <linux-mips@linux-mips.org>, jsun@mvista.com
Subject: Re: kernel BUG at sched.c:784!
Message-ID: <20030718102256.D31523@mvista.com>
References: <JCELLCFDJLFKPOBFKGFNGEKJCFAA.jack.miller@pioneer-pdt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <JCELLCFDJLFKPOBFKGFNGEKJCFAA.jack.miller@pioneer-pdt.com>; from jack.miller@pioneer-pdt.com on Fri, Jul 18, 2003 at 09:57:01AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Your kernel looks old, and probably don't have the CPU bug workaround
code at the beginning of vec3 exception handler.

NESTED(except_vec3_generic, 0, sp)
#if R5432_CP0_INTERRUPT_WAR
                mfc0    k0, CP0_INDEX
#endif

Try this.

Jun

On Fri, Jul 18, 2003 at 09:57:01AM -0700, Jack Miller wrote:
>   We are developing a system based around a NEC VR5432 CPU and Broadcom
> BCM703X System Controller. When the system is running with the intended
> application and drivers we intermittently experience a kernel OOPS in the
> scheduler.  Would someone please provide some insight to the following OOPS
> ?  It appears (with my limited understanding of the scheduler) that the
> scheduler is trying to schedule the 'idle' task.  What condition prevails to
> cause this to happen ?
> 
>   Using a J-TAG Debugger, I "walked" the task list (in both directions) and
> everthing appears to be in order.
> 
>   Thanks in advance for your help.
> 
>   Regards,
>     Jack
> 
> 
> Linux version 2.4.17 (jack@saturn) (gcc version 3.2.2 20030322 (Pioneer
> Voyager)) #1 Fri May 30 14:55:32 PDT 2003
> ksymoops 2.4.6 on mips 2.4.17.  Options used
>      -v vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.17/ (default)
>      -m System.map (specified)
>      -T 32
> 
> root@stb2073:~# kernel BUG at sched.c:784!
> Unable to handle kernel paging request at virtual address 00000000, epc ==
> 8001524c, ra == 8001524c
> $0 : 00000000 b001f800 0000001b 00000000 ffffff9d 80008000 0000001f 828f4a20
> $8 : 00000001 ffffd890 00001890 801cb119 00000000 00000000 fffffff9 ffffffff
> $16: 00000000 00000000 809ae000 828f4a20 80008000 00000000 80008000 1001ccf8
> $24: 0000000a 00000002                   809ae000 809afe90 809afe90 8001524c
> epc  : 8001524c    Tainted: P
> Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
> Status: b001f803
> Cause : 8000c40c
> Process pvrd (pid: 331, stackpage=809ae000)
> Stack: 8016eda8 8016edc0 00000310 fffffc18 00138f80 00000002 809afed8
> 00000070
>        00000000 1001cd00 1001ccfc 809afec8 80014e74 80014e6c 00000400
> 00000200
>        c008422b 80bd4160 00000000 00000000 00138f80 809ae000 80014dd4
> 2aac2000
>        00000000 809aff18 00001807 7edffa50 8002242c 00000070 00000000
> 8016c290
>        00000000 00000000 00000000 00989680 7edffa40 00000000 8000f7c4
> 8000f7c4
>        00000000 ...
> Call Trace: [<8016eda8>] [<8016edc0>] [<80014e74>] [<80014e6c>] [<c008422b>]
> [<80014dd4>]
>  [<8002242c>] [<8016c290>] [<8000f7c4>] [<8000f7c4>]
> Code: 24a5edc0  0c0062f7  24060310 <08005485> ae200000  40016000  00000000
> 3421001f  3821001e
> 
> 
> >>RA;  8001524c <schedule+33c/47c>
> >>$1; b001f800 <_end+2fe2aea0/3fe2a6a0>
> >>$5; 80008000 <init_task_union+0/0>
> >>$7; 828f4a20 <_end+27000c0/3fe2a6a0>
> >>$11; 801cb119 <printk_buf.4+19/400>
> >>$18; 809ae000 <_end+7b96a0/3fe2a6a0>
> >>$19; 828f4a20 <_end+27000c0/3fe2a6a0>
> >>$20; 80008000 <init_task_union+0/0>
> >>$22; 80008000 <init_task_union+0/0>
> >>$23; 1001ccf8 <_binary_ramdisk_gz_size+1001a6da/7fffe9e2>
> >>$28; 809ae000 <_end+7b96a0/3fe2a6a0>
> >>$29; 809afe90 <_end+7bb530/3fe2a6a0>
> >>$30; 809afe90 <_end+7bb530/3fe2a6a0>
> >>$31; 8001524c <schedule+33c/47c>
> 
> >>PC;  8001524c <schedule+33c/47c>   <=====
> 
> Trace; 8016eda8 <mips_io_port_base+d08/1c30>
> Trace; 8016edc0 <mips_io_port_base+d20/1c30>
> Trace; 80014e74 <schedule_timeout+74/e4>
> Trace; 80014e6c <schedule_timeout+6c/e4>
> Trace; c008422b <[bcm7030]scard_interrupt+f/340>
> Trace; 80014dd4 <process_timeout+0/2c>
> Trace; 8002242c <sys_nanosleep+170/1fc>
> Trace; 8016c290 <mips_hwi4_dispatch+70/78>
> Trace; 8000f7c4 <stack_done+1c/38>
> Trace; 8000f7c4 <stack_done+1c/38>
> 
> Code;  80015240 <schedule+330/47c>
> 00000000 <_PC>:
> Code;  80015240 <schedule+330/47c>
>    0:   24a5edc0  addiu   a1,a1,-4672
> Code;  80015244 <schedule+334/47c>
>    4:   0c0062f7  jal     18bdc <_PC+0x18bdc> 8002de1c
> <generic_file_direct_IO+294/2d8>
> Code;  80015248 <schedule+338/47c>
>    8:   24060310  li      a2,784
> Code;  8001524c <schedule+33c/47c>   <=====
>    c:   08005485  j       15214 <_PC+0x15214> 8002a454 <__vma_link+9c/e0>
> <=====
> Code;  80015250 <schedule+340/47c>
>   10:   ae200000  sw      zero,0(s1)
> Code;  80015254 <schedule+344/47c>
>   14:   40016000  mfc0    at,$12
> Code;  80015258 <schedule+348/47c>
>   18:   00000000  nop
> Code;  8001525c <schedule+34c/47c>
>   1c:   3421001f  ori     at,at,0x1f
> Code;  80015260 <schedule+350/47c>
>   20:   3821001e  xori    at,at,0x1e
> 
> 
> Jack Miller <jack.miller@pioneer-pdt.com>
> Pioneer Digital Technologies, Inc.
> 6170 Cornerstone Court East
> Suite 330
> San Diego, CA 92121-3767
> vox: (858)824-0790 x356
> fax: (858)824-0796
> 
> 
