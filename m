Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2005 20:38:43 +0100 (BST)
Received: from static-151-204-232-50.bos.east.verizon.net ([IPv6:::ffff:151.204.232.50]:35754
	"EHLO mail2.sicortex.com") by linux-mips.org with ESMTP
	id <S8226059AbVHQTi1>; Wed, 17 Aug 2005 20:38:27 +0100
Received: from gs104.sicortex.com (gs104.sicortex.com [10.0.1.104])
	by mail2.sicortex.com (Postfix) with ESMTP id E8A6B1BF33F;
	Wed, 17 Aug 2005 15:43:09 -0400 (EDT)
From:	Joshua Wise <Joshua.Wise@sicortex.com>
Organization: SiCortex
To:	linux-mips@linux-mips.org
Subject: synchronize_rcu() hangs in simulated mips environment
Date:	Wed, 17 Aug 2005 15:43:09 -0400
User-Agent: KMail/1.8.1
Cc:	Aaron Brooks <aaron.brooks@sicortex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508171543.09295.Joshua.Wise@sicortex.com>
Return-Path: <Joshua.Wise@sicortex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joshua.Wise@sicortex.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm again bringing up the network on my simulator, and I've found that if I 
run with more than one CPU in my simulation (if I have CONFIG_SMP enabled), 
synchronize_rcu() just hangs, as I never get a cpu_quiet() call.

I've attached boot log chunks from various parts of boot time to the bottom of 
this mail. I'm curious as to whether the fault is in my emulator, or in the 
kernel, or in my additions to the kernel... On IRC, Ralf initially suggested 
that it could be an emulator fault, but I'm not sure where such a fault would 
be.

Thanks,
joshua

Here is how a good boot looks:
lan-lan.c 0.01: Joshua Wise <Joshua.Wise@SiCortex.com>
emu0: lan-lan found at 0xef0000000.
emu0: loaded successfully
NET: Registered protocol family 2
Sock_register done
Base protocols done
Socketside stuff done
inet_register_protosw(80343aa0)
spinlock: inetsw lock
got it
list done
spin unlock
synchronize net
net synch:
Synchronizing RCU...
Calling...
Waiting...
CPU quiet: 0
Awake
Done!
net synch done
ok
inet_register_protosw(80343ad0)
spinlock: inetsw lock
got it
list done

However, a failing boot looks like this:
Starting CPU #1...
CPU revision is: 00018101
FPU revision is: 00038110
Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
Primary data cache 32kB, 2-way, linesize 32 bytes.
Synthesized TLB refill handler (36 instructions).
CPU frequency 8.00 MHz
CPU #1 init complete.
Brought up 2 CPUs
checking if image is initramfs...it isn't (bad gzip magic numbers); looks like 
an initrd
Freeing initrd memory: 4096k freed
NET: Registered protocol family 16
CPU quiet: 0
rtc: IRQ 8 is not free.
i8042.c: i8042 controller self test timeout.
Trying to free nonexistent resource <00000060-0000006f>
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 2) is a 16450
ttyS1 at I/O 0x2f8 (irq = 3) is a 16450
ttyS2 at I/O 0x3e8 (irq = 4) is a 16450
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 18432K size 1024 blocksize
loop: loaded (max 8 devices)
lan-lan.c 0.01: Joshua Wise <Joshua.Wise@SiCortex.com>
emu0: lan-lan found at 0xef0000000.
emu0: loaded successfully
NET: Registered protocol family 2
Sock_register done
Base protocols done
Socketside stuff done
inet_register_protosw(80343aa0)
spinlock: inetsw lock
got it
list done
spin unlock
synchronize net
net synch:
Synchronizing RCU...
Calling...
Waiting...
<hang>
