Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 19:48:41 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:57506 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225208AbTDXSsk>;
	Thu, 24 Apr 2003 19:48:40 +0100
Received: (qmail 12840 invoked by uid 6180); 24 Apr 2003 18:48:33 -0000
Date: Thu, 24 Apr 2003 11:48:32 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: linux-mips@linux-mips.org
Subject: Au1500 PCI autoconfig issues with multiple PCI devices?
Message-ID: <20030424114832.O10148@luca.pas.lab>
Reply-To: baitisj@evolution.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hi ya'll:

This is the first time I've tried multiple PCI devices on the Au1500. I have a
PCI->CardBus bridge and a 3Com ethernet plugged into the Au1500's PCI bus. I'm
using the linux_2_4 branch.

Here's the applicable dmesg:


    ...
    Autoconfig PCI channel 0x8028e518
    Scanning bus 00, I/O 0x00000300:0x00100000, Mem 0x40000000:0x44000000
    00:0b.0 Class 0607: 104c:ac56
      CARDBUS  Bridge: primary=00, secondary=01
    PCI Autoconfig: Found CardBus bridge, device 11 function 0
            Mem at 0x40000000 [size=0x1000]
    Scanning sub bus 01, I/O 0x00000300, Mem 0x40001000
    Back to bus 00, sub_bus is 1
    00:0d.0 Class 0200: 10b7:9200 (rev 78)
            I/O at 0x00000300 [size=0x80]
            Mem at 0x40001000 [size=0x80]
    Linux NET4.0 for Linux 2.4
    ...


Here's lspci output:

    root@10.1.1.122:~# lspci -vx
    00:0b.0 CardBus bridge: Texas Instruments: Unknown device ac56
            Flags: bus master, medium devsel, latency 168, IRQ 255
            Memory at 40000000 (32-bit, non-prefetchable) [size=4K]
            Bus: primary=00, secondary=01, subordinate=01, sec-latency=176
            Memory window 0: 40000000-403ff000 (prefetchable)
            Memory window 1: 40400000-407ff000
            I/O window 0: 00004000-000040ff
            I/O window 1: 00004400-000044ff
            16-bit legacy interface ports at 0001
    00: 4c 10 56 ac 07 00 10 02 00 00 07 06 08 a8 02 00
    10: 00 00 00 40 a0 00 00 02 00 01 01 b0 00 00 00 40
    20: 00 f0 3f 40 00 00 40 40 00 f0 7f 40 00 40 00 00
    30: fc 40 00 00 00 44 00 00 fc 44 00 00 ff 01 40 05
    40: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
    50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
    70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

    00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 78)
            Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
            Flags: bus master, medium devsel, latency 128, IRQ 1
            I/O ports at 0300 [size=128]
            Memory at 40001000 (32-bit, non-prefetchable) [size=128]
            Expansion ROM at <unassigned> [disabled] [size=128K]
            Capabilities: [dc] Power Management version 2
    00: b7 10 00 92 07 00 10 02 78 00 00 02 00 80 00 00
    10: 01 03 00 00 00 10 00 40 00 00 00 00 00 00 00 00
    20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
    30: 00 00 00 00 dc 00 00 00 00 00 00 00 01 01 0a 0a

    -------------------------------------------------------------------------


My 3Com card is communicating over the network very effectively (as a matter of
fact, I've been using the 3Com card for netboot since I've been having problems
with my onboard PHY). I guess it's a (blessing?) that I was forced to use
multiple PCI devices...

Anyhow, since the 3Com card is configured in the same PCI memory space, card
services has a very hard time talking to the CardBus bridge. Below, I tried
a couple of different base addresses for the memory probe:

    cardmgr[203]cs: memory probe 0x40000000-0x40ffffff:: starting, version is 3.2.3
     excluding 0x40000000-0x40bfffff
    <6>cs: memory probe 0x40000000-0x40ffffff: excluding 0x40000000-0x40bfffff
    cardmgr[203]: socket 0: Anonymous Memory
    cardmgr[203]: executing: 'modprobe memory_cs'
    cardmgr[203]: + modprobe: Can't locate module memory_cs
    cardmgr[203]: modprobe exited with status 255
    cardmgr[203]: module /lib/modules/2.4.21-pre4/pcmcia/memory_cs.o not available
    cardmgr[203]: get dev info on socket 0 failed: Resource temporarily unavailable
    cardmgr[203]: executing: 'modprobe -r memory_cs'
    Trying to free nonexistent resource <40c00000-40c00fff>
    cardmgr[203]: exiting
    <4>Trying to free nonexistent resource <40c00000-40c00fff>
    unloading Kernel Card Services
    <6>unloading Kernel Card Services
    Linux Kernel Card Services 3.1.22
      options:  [pci] [cardbus]
    <6>Linux Kernel Card Services 3.1.22
    <6>  options:  [pci] [cardbus]
    Yenta IRQ list 0000, PCI irq0
    Socket status: 30000110
    <4>Yenta IRQ list 0000, PCI irq0
    <4>Socket status: 30000110

    cardmgr[253]:cs: memory probe 0x40001000-0x40ffffff: starting, version is 3.2.3
     excluding 0x40001000-0x410defff
    cs: unable to map card memory!
    cs: unable to map card memory!
    <6>cs: memory probe 0x40001000-0x40ffffff: excluding 0x40001000-0x410defff
    <5>cs: unable to map card memory!
    <5>cs: unable to map card memory!
    cardmcs: unable to map card memory!
    grcs: unable to map card memory!
    [2cs: unable to map card memory!
    53cs: unable to map card memory!
    ]: socket 0: Anonymous Memory
    <5>cs: unable to map card memory!
    <5>cs: unable to map card memory!
    <5>cs: unable to map card memory!
    <5>cs: unable to map card memory!
    cardmgr[253]: executing: 'modprobe memory_cs'
    cardmgr[253]: + modprobe: Can't locate module memory_cs
    cardmgr[253]: modprobe exited with status 255
    cardmgr[253]: module /lib/modules/2.4.21-pre4/pcmcia/memory_cs.o not available
    cardmgr[253]: get dev info on socket 0 failed: Resource temporarily unavailable

I can only assume that this has to do with PCI misconfiguration.

Thoughts?

Thanks for taking a look!

-Jeff


-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
