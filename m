Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2006 01:23:17 +0200 (CEST)
Received: from mother.pmc-sierra.com ([216.241.224.12]:35024 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S8133794AbWFAXXH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 2 Jun 2006 01:23:07 +0200
Received: (qmail 15838 invoked by uid 101); 1 Jun 2006 23:22:56 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 1 Jun 2006 23:22:56 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k51NMlKa021990;
	Thu, 1 Jun 2006 16:22:52 -0700
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <JPF6THA5>; Thu, 1 Jun 2006 16:22:47 -0700
Message-ID: <478F19F21671F04298A2116393EEC3D5274017@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Raj Palani <Rajesh_Palani@pmc-sierra.com>
To:	Roman Mashak <mrv@corecom.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: RE: compiling BCM5700 driver
Date:	Thu, 1 Jun 2006 16:22:39 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Rajesh_Palani@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rajesh_Palani@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi Roman,

   The titan_ge.c and titan_ge.h file are still in the kernel, for the Titan chip (Yosemite).

   Regarding the crash you mention below, kindly use mem=256M in the boot line.  The default value of the RAM size is setup to be 512MB and the Sequoia board that you are having may contain only 256MB of RAM.

-Raj

> -----Original Message-----
> From: Roman Mashak [mailto:mrv@corecom.co.kr] 
> Sent: Wednesday, May 31, 2006 6:42 PM
> To: Raj Palani
> Cc: linux-mips@linux-mips.org
> Subject: Re: compiling BCM5700 driver
> 
> Hello, Raj!
> You wrote to "Roman Mashak" <mrv@corecom.co.kr>; "Ralf Baechle" 
> <ralf@linux-mips.org> on Wed, 31 May 2006 09:06:44 -0700:
> 
>  RP> Yes.  We are currently maintaining the Titan GE driver 
> on "Sequoia"
>  RP> only in 2.6.x.  The GE driver in Sequoia has been 
> renamed to  RP> msp85xx_ge.c.  We are in the process of 
> generating a patchset to add  RP> support for Sequoia 
> (MSP8510/MSP8520) in the Linux/MIPS 2.6 tree.
> 
>  RP> Our most recent Linux 2.6 tree for Sequoia is available 
> on our ftp site  RP> (ftp.pmc-sierra.com) under  RP> 
> /pub/linux/2.6.12/linux-2.6.12-rc3_L002.tar.gz.
> 
> There are msp85x0_ge.[ch] in this tarball. And seems old code 
> from titan_ge.[ch] is still in used. Nevertheless kernel gets panic:
> 
> Linux version 2.6.12-rc3 (root@ecb-test32.corecom.local) (gcc version
> 3.3-mips64linux-031001) #1 Thu Jun 1 10:33:22 KST 2006 PMON 
> reports memory size 256MB cpu_clock set to 900000000 CPU 
> revision is: 000034c1 FPU revision is: 00003420 PMC-Sierra 
> Sequoia Board Setup 32-bit support Determined physical RAM map:
>  memory: 20000000 @ 00000000 (usable)
> Built 1 zonelists
> Kernel command line: tftp://192.168.11.43/vmlinux 
> root=/dev/nfs nfsroot=192.168.11.43:/export/linux/mips-fs-be
> ip=192.168.11.42:192.168.11.1::255.255.255.0::eth0
> Unknown boot option `tftp://192.168.11.43/vmlinux': ignoring 
> Primary instruction cache 16kB, physically tagged, 4-way, 
> linesize 32 bytes.
> Primary data cache 16kB, 4-way, linesize 32 bytes.
> Secondary cache size 256K, linesize 32 bytes.
> Synthesized TLB refill handler (27 instructions).
> Synthesized TLB load handler fastpath (39 instructions).
> Synthesized TLB store handler fastpath (39 instructions).
> Synthesized TLB modify handler fastpath (38 instructions).
> PID hash table entries: 4096 (order: 12, 65536 bytes) Using 
> 450.000 MHz high precision timer.
> Dentry cache hash table entries: 131072 (order: 7, 524288 
> bytes) Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 515712k/524288k available (1623k kernel code, 8440k 
> reserved, 372k data, 356k init, 0k highmem) CompactFlash ATA 
> Support for PMC-Sierra Sequoia  <6>Internal UART Support for 
> PMC-Sierra Sequoia  <7>Calibrating delay loop... 897.02 
> BogoMIPS (lpj=448512) Mount-cache hash table entries: 512 
> Checking for 'wait' instruction...  available.
> NET: Registered protocol family 16
> PCI: Failed to allocate mem resource #2:20000000@e0000000 for 
> 0000:00:01.0
> PCI: Failed to allocate mem resource #2:20000000@e8000000 for 
> 0000:01:01.0 Generic RTC Driver v1.07
> Serial: 8250/16550 driver $Revision: 1.1.1.1 $ 4 ports, IRQ 
> sharing disabled ttyS0 at MMIO 0x0 (irq = 0) is a 16550A io 
> scheduler noop registered io scheduler anticipatory 
> registered io scheduler deadline registered io scheduler cfq 
> registered
> loop: loaded (max 8 devices)
> PMC-Sierra MSP85x0 10/100/1000 Ethernet Driver Device Id : 
> 206014,  Version : 0
> : port 0 with MAC address 00:e0:04:00:02:4e Rx NAPI 
> supported, Tx Coalescing ON
> : port 1 with MAC address 00:e0:04:00:02:4f Rx NAPI 
> supported, Tx Coalescing ON
> NET: Registered protocol family 2
> IP: routing cache hash table of 4096 buckets, 32Kbytes TCP 
> established hash table entries: 131072 (order: 8, 1048576 
> bytes) TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Data bus error, epc == 802214d8, ra == 802214ac Oops in 
> arch/mips/kernel/traps.c::do_be, line 338[#1]:
> Cpu 0
> $ 0   : 00000000 90008000 9fc00840 9fc00840
> $ 4   : 00000001 00000000 00000000 8036b97c
> $ 8   : 00000000 801d8150 814df0f0 ffffffff
> $12   : 00200200 00100100 0000ffff 8036b974
> $16   : 9fc00000 816b5920 00000840 81690220
> $20   : 0000003c 00000008 ffffffc0 00200000
> $24   : 8036b97c 00000001
> $28   : 80380000 80381df8 81690000 802214ac
> Hi    : 0006d7ff
> Lo    : f8164000
> epc   : 802214d8 alloc_skb+0x98/0xec     Not tainted
> ra    : 802214ac alloc_skb+0x6c/0xec
> Status: 90008002    KERNEL EXL
> Cause : 0000801c
> PrId  : 000034c1
> Modules linked in:
> Process swapper (pid: 1, threadinfo=80380000, task=8037ab78) 
> Stack : 8010d6b0 8026e7e4 814e4e80 80369420 8169030c c01043b0 816b59c0
> 8021a044
>         0000001c 00180c01 00000000 00000000 c0000000 00000000 
> 81690220 81690000
>         8034bc14 00000000 00000000 00000000 00000000 8021a608 
> 803eb9c0 00000000
>         00000001 80381e68 18230458 80232598 81690000 00000000 
> 00000000 81690220
>         8021a684 00100000 8021a16c 00000000 8021aaf8 8023743c 
> 00000000 fb004000
>         ...
> Call Trace:
>  [<8010d6b0>] dma_map_single+0x5c/0x7c
>  [<8026e7e4>] fib_magic+0x114/0x144
>  [<8021a044>] msp85x0_ge_rx_task+0x74/0x174  [<8021a608>] 
> xdma_config+0x1cc/0x22c  [<80232598>] 
> rtnetlink_fill_ifinfo+0x474/0x57c  [<8021a684>] 
> msp85x0_ge_port_start+0x1c/0x74  [<8021a16c>] 
> msp85x0_port_init+0x28/0x80  [<8021aaf8>] 
> msp85x0_eth_setup_tx_ring+0x80/0xc8
>  [<8023743c>] netlink_broadcast+0x29c/0x478  [<8021adf0>] 
> msp85x0_ge_eth_open+0x114/0x250  [<8021af18>] 
> msp85x0_ge_eth_open+0x23c/0x250  [<80219f14>] 
> msp85x0_ge_open+0x30/0xec  [<80232b84>] 
> rtmsg_ifinfo+0x80/0xf8  [<80232b58>] rtmsg_ifinfo+0x54/0xf8  
> [<80227d2c>] dev_open+0x64/0xd8  [<80227d98>] 
> dev_open+0xd0/0xd8  [<8022d108>] dev_mc_upload+0x18/0x24  
> [<80229f28>] dev_change_flags+0x70/0x158  [<8019a84c>] 
> proc_create+0x9c/0x100  [<80311fb8>] ic_open_devs+0x20c/0x3a4 
>  [<8012a874>] msleep+0x48/0x5c  [<80313524>] 
> ip_auto_config+0x64/0x30c  [<8030a7f8>] seqgen_init+0x10/0x20 
>  [<8030a7f8>] seqgen_init+0x10/0x20  [<802f4828>] 
> do_initcalls+0x50/0x100  [<802f4828>] do_initcalls+0x50/0x100 
>  [<802f4908>] do_basic_setup+0x30/0x3c  [<801004ac>] 
> init+0x3c/0x120  [<801035d0>] kernel_thread_helper+0x10/0x18  
> [<801035c0>] kernel_thread_helper+0x0/0x18
> 
> 
> Code: ae30008c  ac640000  8e220094 <ac400004> 8e230094  
> a4600008  8e220094 a440000a  8e230094 Kernel panic - not 
> syncing: Attempted to kill init!
> 
> 
> With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
> 
> 
