Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2003 15:00:37 +0100 (BST)
Received: from pfepb.post.tele.dk ([IPv6:::ffff:193.162.153.3]:1664 "EHLO
	pfepb.post.tele.dk") by linux-mips.org with ESMTP
	id <S8225334AbTFFOAc>; Fri, 6 Jun 2003 15:00:32 +0100
Received: from 0x50c49fa4.adsl-fixed.tele.dk (0x50c49fa4.adsl-fixed.tele.dk [80.196.159.164])
	by pfepb.post.tele.dk (Postfix) with ESMTP id AB1DF5EE130
	for <linux-mips@linux-mips.org>; Fri,  6 Jun 2003 16:00:15 +0200 (CEST)
Subject: pcmcia problem on pb1500
From: Jan Pedersen <jp@q-networks.com>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 06 Jun 2003 15:59:23 +0200
Message-Id: <1054907964.14600.172.camel@jp>
Mime-Version: 1.0
Return-Path: <jp@q-networks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jp@q-networks.com
Precedence: bulk
X-list: linux-mips

Hi

I am having problems getting a pci-pcmcia card up and running with
kernel 2.4.19 on my pb1500 board.

A am executing:
insmod pcmcia_core.o cis_speed=10
insmod yenta_socket.o
insmod ds.o
cardmgr -v

output:
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
Yenta IRQ list 0000, PCI irq4
Socket status: 30000046
Yenta IRQ list 0000, PCI irq4
Socket status: 30000011
cardmgr[148]: watching 2 sockets
cardmgr[149]: starting, version is 3.2.4
Done.
cardmgr[cs: memory probe 0x80000000-0x80ffffff:149]: initializing socket
1
 excluding 0x80000000-0x800fffff 0x80400000-0x80bfffff
cardmgr[149]: socket 1: 350 Series Wireless LAN Adapter
cardmgr[149]:   product info: "Cisco Systems", "350 Series Wireless LAN
Adapter"
cardmgr[149]:   manfid: 0x015f, 0x000a  function: 6 (network)
cardmgr[149]: module airo_cs.o not available
cardmgr[149]: executing: 'modprobe airo_cs'
airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo_cs: GetNextTuple: No more items
cardmgr[149]: get dev info on socket 1 failed: Resource temporarily
unavailable



It seems like it has something to do with the io area. When digging into
the airo_cs.c, it fails in the folowing line.
CFG_CHECK(RequestIO, link->handle, &link->io);

When compiled for x86 everything works fine.

lspci -v shows:
00:0d.0 Class 0607: 104c:ac55 (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 4
        Memory at 80000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 80001000-80002000 (prefetchable)
        Memory window 1: 80400000-807ff000
        I/O window 0: 00000000-00000fff
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

00:0d.1 Class 0607: 104c:ac55 (rev 01)
        Flags: bus master, medium devsel, latency 168, IRQ 4
        Memory at 80004000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
        Memory window 0: 80005000-80006000 (prefetchable)
        Memory window 1: 80800000-80bff000
        I/O window 0: 00000000-00000003
        I/O window 1: 00001000-00001fff
        16-bit legacy interface ports at 0001


/etc/pcmcia/config.opts:
include port 0x100-0x4ff, port 0xc00-0xcff
include memory 0x80000000-0x80ffffff

THEN, i saw in the linux-mips archives, that Jeff Baitis has succeeded
in getting it working on 2.4. He had applied two patches: 
Pete's 36bit_addr_2.4.21-pre4.patch
Pete's 64bit_pcmcia.patch

I've found and patched theese into my kernel, but now, nothing works!

output is now:
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
Yenta IRQ list 0000, PCI irq4
Socket status: 30000046
Yenta IRQ list 0000, PCI irq4
Socket status: 30000011
cardmgr[153]: watching 2 sockets
cardmgr[153]: could not adjust resource: IO ports 0xc00-0xcff: Invalid
argument
cardmgr[153]: could not adjust resource: IO ports 0x100-0x4ff: Invalid
argument
cardmgr[153]: could not adjust resource: memory 0x80000000-0x80ffffff:
Invalid argument
cardmgr[154]: starting, version is 3.2.4
Done.
cardmgr[154]: initiacs: unable to map card memory!
lics: unable to map card memory!
zing socket 1
cardmgr[154]: socket 1: Anonymous Memory
cardmgr[154]: module memory_cs.o not available
cardmgr[154]: executing: 'modprobe memory_cs'
cardmgr[154]: get dev info on socket 1 failed: Resource temporarily
unavailable

I am really stock here. Any help would be greatful.

Thanks
Jan
