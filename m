Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 12:02:51 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:48924 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225762AbVFMLCY>; Mon, 13 Jun 2005 12:02:24 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5DAxjPh020970;
	Mon, 13 Jun 2005 11:59:45 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5DAxjYF020943;
	Mon, 13 Jun 2005 11:59:45 +0100
Date:	Mon, 13 Jun 2005 11:59:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	qemu-devel@nongnu.org, linux-mips@linux-mips.org
Cc:	Jocelyn Mayer <l_indien@magic.fr>,
	Fabrice Bellard <fabrice@bellard.org>
Subject: Qemu for MIPS
Message-ID: <20050613105944.GA19704@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I've posted updated Qemu patches on

  ftp://ftp.linux-mips.org/pub/linux/mips/qemu
  http://www.linux-mips.org/wiki/index.php/Qemu

Enhancements over last week's patches:

 o The count/compare interrupt will now properly be delivered.
 o mfc0 will now return the proper value for the EXL and ERL flags
 o eret will now consider the value of ERL and EXL.
 o i8259 PIC is now properly cascaded to a CPU interrupt.
 o An ISA NE2000 card will now be emulated.
 o The CPU's random register now considers the value of the wired register

The new kernel patch is against the latest Linux/MIPS CVS kernel du jour
2.6.12-rc6 and has been updated to match Qemu's improvments.

Known bugs:

 o ll/sc don't use a ll_bit like the real hardware thus right now any atomic
   functions aren't really atomic.
 o ll/sc really should be watching a physical not a virtual address or they
   won't do much useful on any kind of shared memory structure.
 o MIPS documentation documents the lladdr register to contain the virtual
   address of the location being watched but about every implementation
   since the R4000 actually keeps the physical address there - and documents
   that as an erratum even though it actually the sensible thing to do.  We
   should do the same.  Fortunately nothing that I know of actually relies
   on the content of the lladdr register, so this one is cosmetic.

Last, not least, this is what you've been waiting for:

[root@dea qemu-mips]# mips-softmmu/qemu-system-mips -kernel ~ralf/src/linux/linux-cvs/arch/mips/boot/vmlinux.bin -m 16 -nographic
nb_nics = 1
Connected to host network interface: tun0
/etc/qemu-ifup tun0
+ ifconfig tun0 up
+ brctl addbr qnet
device qnet already exists; can't create bridge with the same name
+ brctl addif qnet tun0
+ ifconfig qnet 172.20.0.1
(qemu) mips_r4k_init: start
mips_r4k_init: load BIOS '/usr/local/share/qemu/mips_bios.bin' size 131072
Linux version 2.6.12-rc5 (ralf@dea.linux-mips.net) (gcc version 3.4.3) #257 Mon Jun 13 02:58:23 BST 2005
CPU revision is: 00018000
Determined physical RAM map:
 memory: 01000000 @ 00000000 (usable)
On node 0 totalpages: 4096
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: console=ttyS0 debug ip=172.20.0.2:172.20.0.1::255.255.0.0
Primary instruction cache 2kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 2kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (19 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (30 instructions).
PID hash table entries: 128 (order: 7, 2048 bytes)
Using 100.000 MHz high precision timer.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 14464k/16384k available (1293k kernel code, 1900k reserved, 190k data, 104k init, 0k highmem)
Calibrating delay loop... 144.58 BogoMIPS (lpj=722944)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16450
io scheduler noop registered
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 52 54 00 12 34 56
eth0: NE2000 found at 0x300, using IRQ 9.
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
NET: Registered protocol family 1
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth0, addr=172.20.0.2, mask=255.255.0.0, gw=255.255.255.255,
     host=172.20.0.2, domain=, nis-domain=(none),
     bootserver=172.20.0.1, rootserver=172.20.0.1, rootpath=
Looking up port of RPC 100003/2 on 172.20.0.1
Looking up port of RPC 100005/1 on 172.20.0.1
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 104k freed
Kernel panic - not syncing: No init found.  Try passing init= option to kernel.

Which is a bug - there is a valid root filesystem.  Something for tomorrow.

Enjoy,

  Ralf
