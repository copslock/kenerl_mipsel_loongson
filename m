Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 01:35:30 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:19474 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133748AbWBXBfV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2006 01:35:21 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id E026A64D3D; Fri, 24 Feb 2006 01:42:36 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 2FA4C8DC5; Fri, 24 Feb 2006 01:42:27 +0000 (GMT)
Date:	Fri, 24 Feb 2006 01:42:27 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: [RFC] SMP initialization order fixes.
Message-ID: <20060224014226.GA26064@deprecation.cyrius.com>
References: <20060222190940.GA29967@linux-mips.org> <Pine.LNX.4.64.0602221636300.5110@trantor.stuart.netsweng.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.64.0602221636300.5110@trantor.stuart.netsweng.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Stuart Anderson <anderson@netsweng.com> [2006-02-22 16:41]:
> >RM9000 & BCM1250 users for testing.  This really needs to be fixed for
> >2.6.16.
> I'm not sure if this is the specific fix or not, but I can report that git
> as of today (approx 2pm est) is working better than is has since 2.6.14 for
> me on a bcm1480.

Strange, I get the following oops during boot with latest git:


CFE> ifconfig eth0 -auto; boot -elf 192.168.1.1:/srv/tftp/mips/bigsur
Device eth0:  hwaddr 00-02-4C-F5-2C-3C, ipaddr 192.168.1.146, mask 255.255.255.0
        gateway 192.168.1.1, nameserver 131.111.8.42, domain cyrius.com
Loader:elf Filesys:tftp Dev:eth0 File:192.168.1.1:/srv/tftp/mips/bigsur Options:(null)
Loading: 0xffffffff80100000/3248680 eth0: Link speed: 100BaseT FDX[J
0xffffffff80419228/286248 Entry at 0x803e9000
Closing network.
Starting program at 0x803e9000
[RUN!]
Broadcom SiByte BCM1480 A3 (pass1) @ 700 MHz (SB-1A rev 0)
Board type: SiByte BCM91x80A/B (BigSur)
[CPU1]
[cpu1]
[CPU2]
[cpu2]
[CPU3]
[cpu3]
Linux version 2.6.16-rc4-Helix64-smp (tbm@deprecation) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #2 SMP Fri Feb 24 01:36:35 GMT 2006
CPU revision is: 01041100
FPU revision is: 000f0103
swarm setup: M41T81 RTC detected.
This kernel optimized for board runs with CFE
Determined physical RAM map:
 memory: 000000000fe7ae00 @ 0000000000000000 (usable)
 memory: 000000001ffffe00 @ 0000000080000000 (usable)
 memory: 000000000ffffe00 @ 00000000c0000000 (usable)
 memory: 000000003ffffe00 @ 0000000140000000 (usable)
Detected 3 available secondary CPU(s)
Built 1 zonelists
Kernel command line: root=/dev/hda2
Primary instruction cache 32kB, 4-way, linesize 32 bytes.
Primary data cache 32kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (35 instructions).
Synthesized TLB load handler fastpath (49 instructions).
Synthesized TLB store handler fastpath (49 instructions).
Synthesized TLB modify handler fastpath (48 instructions).
PID hash table entries: 4096 (order: 12, 131072 bytes)
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 1991780k/2095580k available (2437k kernel code, 103096k reserved, 539k data, 196k init, 0k highmem)
Mount-cache hash table entries: 256
Checking for 'wait' instruction...  unavailable.
Checking for the multiply/shift bug... no.
Checking for the daddi bug... no.
Checking for the daddiu bug... no.
CPU revision is: 03041100
FPU revision is: 000f0103
CPU 0 Unable to handle kernel paging request at virtual address 0000008b3cb03e00, epc == ffffffff8010b37c, ra == ffffffff8010b2fc
Primary instruction cache 32kB, 4-way, linesize 32 bytes.
Primary data cache 32kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (35 instructions).
Oops[#1]:
Cpu 0
$ 0   : 0000000000000000 0000000000000001 0000000003333333 0000008b3cb03e00
$ 4   : ffffffff8041be00 0000000000000001 0000000000000000 ffffffff8041c588
$ 8   : 0000000014001fe1 ffffffff8fefcae0 ffffffff803e9108 0000000000000000
$12   : ffffffffffffffff ffffffff8026f7e8 ffffffff80420000 ffffffff80420000
$16   : 0000000000000001 0000000000000001 0000000000000001 ffffffff8041c5c0
$20   : ffffffff80430000 0000000000000000 0000000000000000 0000000000000000
$24   : ffffffff80430000 ffffffff8fe7dfd4                                  
$28   : ffffffff9fff8000 a80000009fffbf30 0000000000000000 ffffffff8010b2fc
Hi    : 0000000000000000
Lo    : 0000000000000024
epc   : ffffffff8010b37c __cpu_up+0xb4/0x168     Not tainted
ra    : ffffffff8010b2fc __cpu_up+0x34/0x168
Status: 14001fe3    KX SX UX KERNEL EXL IE 
Cause : 00808008
BadVA : 0000008b3cb03e00
PrId  : 01041100
Process swapper (pid: 1, threadinfo=a80000009fff8000, task=a80000000fe79848)
Stack : 0000000000000001 0000000000000001 ffffffff8015eccc ffffffff8015ecb8
        0000000000000001 ffffffff80420000 ffffffff80420000 ffffffff803a0000
        0000000000000000 ffffffff80100e78 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 ffffffff80104c80
        0000000000000000 ffffffff80104c70 0000000000000000 0000000000000000
        0000000000000000 0000000000000000
Call Trace:
 [<ffffffff8015eccc>] cpu_up+0xfc/0x190
 [<ffffffff8015ecb8>] cpu_up+0xe8/0x190
 [<ffffffff80100e78>] init+0x9c8/0x9f0
 [<ffffffff80104c80>] kernel_thread_helper+0x10/0x18
 [<ffffffff80104c70>] kernel_thread_helper+0x0/0x18


Code: 0062182d  3c020333  34423333 <dc640000> 000214b8  3442cccd  00021478  6446995c  00c4001d 
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 5 seconds..261.63 BogoMIPS (lpj=130816)
Passing control back to CFE...

-- 
Martin Michlmayr
http://www.cyrius.com/
