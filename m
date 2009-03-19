Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Mar 2009 23:27:43 +0000 (GMT)
Received: from ultra1.eskimo.com ([204.122.16.64]:15494 "EHLO
	ultra1.eskimo.com") by ftp.linux-mips.org with ESMTP
	id S21369669AbZCSX1g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Mar 2009 23:27:36 +0000
Received: from ultra1.eskimo.com (localhost [127.0.0.1])
	by ultra1.eskimo.com (8.14.0/8.14.0) with ESMTP id n2JNRVGd031323
	for <linux-mips@linux-mips.org>; Thu, 19 Mar 2009 16:27:31 -0700
Received: (from sqrlmail@localhost)
	by ultra1.eskimo.com (8.14.0/8.12.10/Submit) id n2JNRQKV031305;
	Thu, 19 Mar 2009 19:27:26 -0400
X-Authentication-Warning: ultra1.eskimo.com: sqrlmail set sender to craig@nadler.us using -f
Received: from fw.drs-ss.com ([63.237.78.40]) (proxying for 192.168.22.238)
        (SquirrelMail authenticated user cwn)
        by www.eskimo.com with HTTP;
        Thu, 19 Mar 2009 19:27:25 -0400 (EDT)
Message-ID: <0124667e2b16bc6c1ec9870b17e5ddbb.squirrel@www.eskimo.com>
Date:	Thu, 19 Mar 2009 19:27:25 -0400 (EDT)
Subject: PCI IO access problem on BCM1480
From:	"Craig Nadler" <craig@nadler.us>
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.17
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <craig@nadler.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: craig@nadler.us
Precedence: bulk
X-list: linux-mips

     I'm have problems using a Technobox 4960 4-port RS-232 PMC (PCI) card
on a board based on the Broadcom 1480 (MIPS) SOC. Each serial port on
the PMC card uses a 16550A UART accessed using BAR2 thru BAR5. The
BCM1480 based system board is running Linux 2.6.20.1 and a boot
loader software called CFE from Broadcom.
     I/O port accesses over the PCI bus from the CPU to the PMC card don't
seem to work. Any time I try to read an I/O register over the PCI bus
I get a "Data Bus Error" kernel panic. The SOC manual says that the
base address for PCI I/O Space is 0x2C000000. Below is the output of
lspci -vvx to show what is on the PCI bus and how it's configured.
Below that is a kernel panic caused by reading the first byte of the
IO registers for the first RS-232 serial port on the card.
     Any help would be very much appreciated.

Best Regards,

Craig Nadler




root@mobo-5 /root# lspci -vvx

0000:00:00.0 Host bridge: Broadcom Corporation SiByte BCM1x55/BCM1x80 PCI
(rev 01)
        Subsystem: Broadcom Corporation: Unknown device 1280
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 252, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 8
        Region 0: Memory at 60000000 (64-bit, prefetchable) [size=16M]
        Region 2: Memory at 70000000 (64-bit, prefetchable) [size=4K]
        Region 4: Memory at <unassigned> (64-bit, prefetchable)
        Expansion ROM at 73000000 [disabled] [size=64K]
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/5
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=3
                Status: Bus=0 Dev=0 Func=0 64bit+ 133MHz+ SCD- USC-,
DC=bridge, DMMRBC=0, DMOST=3, DMCRS=0, RSCEM-
00: 6d 16 12 00 46 01 b0 22 01 00 00 06 08 fc 00 00
10: 0c 00 00 60 00 00 00 00 0c 00 00 70 00 00 00 00
20: 0c 00 00 00 00 00 00 00 00 00 00 00 6d 16 80 12
30: 00 00 00 73 d0 00 00 00 00 00 00 00 08 01 00 00


0000:00:01.0 Bridge: Tundra Semiconductor Corp. Tsi148 [Tempe] (rev 01)
        Subsystem: Tundra Semiconductor Corp.: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 8
        Region 0: Memory at 31000000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=2
                Status: Bus=0 Dev=1 Func=0 64bit+ 133MHz+ SCD- USC-,
DC=bridge, DMMRBC=3, DMOST=2, DMCRS=1, RSCEM-
00: e3 10 48 01 46 01 30 02 01 00 80 06 08 f8 00 00
10: 04 00 00 31 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 e3 10 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 08 01 00 00


0001:00:01.0 PCI bridge: Broadcom Corporation SiByte BCM1x80 Secondary
bridge (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #08 [2001]
        Capabilities: [5c] #08 [4000]
        Capabilities: [74] #08 [b800]
00: 6d 16 11 00 47 01 10 00 01 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 11 01 00 00
20: 10 00 00 00 11 00 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00


0001:00:02.0 PCI bridge: Broadcom Corporation SiByte BCM1x80 Secondary
bridge (rev 01) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: 41000000-410fffff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] #08 [2001]
        Capabilities: [5c] #08 [4000]
        Capabilities: [74] #08 [b800]
00: 6d 16 11 00 47 01 10 00 01 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 04 00 81 81 00 20
20: 00 41 00 41 11 00 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 02 00


0001:00:04.0 Host bridge: Broadcom Corporation SiByte BCM1x80 Host Bridge
(rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at 60000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at <ignored> (32-bit, prefetchable)
        Region 2: Memory at 70000000 (32-bit, prefetchable) [size=4K]
        Region 4: Memory at <unassigned> (64-bit, prefetchable)
00: 6d 16 14 00 46 00 00 20 01 00 00 06 00 00 00 00
10: 08 00 00 60 08 00 00 40 08 00 00 70 00 00 00 00
20: 0c 00 00 00 00 00 00 00 00 00 00 00 ff ff 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00


0001:02:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00008000-00008fff
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]
        Capabilities: [c0] #08 [0041]
00: 22 10 50 74 57 01 30 02 12 00 04 06 00 ff 81 00
10: 00 00 00 00 00 00 00 00 02 03 03 00 81 81 20 22
20: 10 00 00 00 11 00 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 02 00


0001:02:01.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev
01) (prog-if 10 [IO-APIC])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at 41001000 (64-bit, non-prefetchable) [size=4K]
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 04 10 00 41 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


0001:02:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X
Bridge (rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 255
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]
00: 22 10 50 74 57 01 30 02 12 00 04 06 00 ff 81 00
10: 00 00 00 00 00 00 00 00 02 04 04 00 11 01 20 22
20: 10 00 00 00 11 00 01 00 00 00 00 00 00 00 00 00
30: ff ff 00 00 a0 00 00 00 00 00 00 00 00 00 02 00


0001:02:02.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev
01) (prog-if 10 [IO-APIC])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at 41000000 (64-bit, non-prefetchable) [size=4K]
00: 22 10 51 74 06 00 00 02 01 10 00 08 00 00 00 00
10: 04 00 00 41 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


0001:03:00.0 DMA controller: PLX Technology, Inc.: Unknown device 1023
(rev 02) (prog-if 00 [8237])
        Subsystem: PLX Technology, Inc.: Unknown device 1023
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 1: I/O ports at 8000 [size=128]
        Region 2: I/O ports at 8098 [size=8]
        Region 3: I/O ports at 8090 [size=8]
        Region 4: I/O ports at 8088 [size=8]
        Region 5: I/O ports at 8080 [size=8]
00: b5 10 23 10 43 01 80 02 02 00 01 08 08 00 00 00
10: 00 00 00 00 01 80 00 00 99 80 00 00 91 80 00 00
20: 89 80 00 00 81 80 00 00 00 00 00 00 b5 10 23 10
30: 00 00 00 00 00 00 00 00 00 00 00 00 09 01 00 00










root@mobo-5 /root# tram -m 0 -r 0x2c008098

DBE physical address: 002c008080
Data bus error, epc == c000000000076ae4, ra == c000000000076adc
Oops[#1]:
Cpu 1
$ 0   : 0000000000000000 000000ffffa44b50 900000002c008098 0000000000000000
$ 4   : ffffffffffffffff 000000002c008098 c000000000077390 0000000000000000
$ 8   : c000000000077390 c000000000000000 0000000000077390 ffffffffc0000000
$12   : 0000000000070000 ffffffffc0000000 0000000000000000 9000000000000000
$16   : 000000ffffa44b38 000000ffffa44b78 000000ffffa44b38 0000000040087802
$20   : 0000000000000003 0000000000000005 00000001200033e0 0000000120000000
$24   : fffffffffffffff9 0000000000000000
$28   : a800000177340000 a800000177343db0 0000000120000000 c000000000076adc
Hi    : 0000000000000000
Lo    : 0000000000003738
epc   : c000000000076ae4 xyly_ioctl+0x5dc/0xaa8 [xyly]     Tainted: P
ra    : c000000000076adc xyly_ioctl+0x5d4/0xaa8 [xyly]
Status: 34011fe3    KX SX UX KERNEL EXL IE
Cause : 0080801c
PrId  : 03041100
Modules linked in: comp_drv(P) xyly onntp(P) rma(P) hsp_rdm(P) zcopy_ba(P)
hsp_net hsp_pkt fa
p(P) mmtmr env(P)
Process tram (pid: 14398, threadinfo=a800000177340000, task=a800000000669348)
Stack : a8000000cffc16a0 a80000017f52ac80 0000005555729350 0040000000000000
        900000002c008098 0000000000000000 a8000000004e95c0 0000000040087802
        ffffffff801a753c 0000000010051080 000000ffffa44b38 a8000000004e95c0
        0000000000000003 ffffffff801a77e0 a80000017ffea070 0000000120000000
        0000000000000000 a8000000004e95c0 000000ffffa44b38 0000000040087802
        0000000000000003 0000000000000005 ffffffff801a7a44 fffffffffffe61b8
        0000000020003560 0000000000000180 000000ffffa44b38 fffffffffffe61b8
        0000000120003560 0000000000000180 0000000000000003 ffffffff8010c754
        0000000000000000 0000000034011fe0 0000000000001397 00000001200136f0
        0000000000000003 0000000040087802 000000ffffa44b38 000000ffffa441d9
        ...

Call Trace:
[<c000000000076ae4>] xyly_ioctl+0x5dc/0xaa8 [xyly]
[<ffffffff801a753c>] do_ioctl+0x9c/0xe0
[<ffffffff801a77e0>] vfs_ioctl+0x260/0x410
[<ffffffff801a7a44>] sys_ioctl+0xb4/0x100
[<ffffffff8010c754>] handle_sys64+0x54/0x70


Code: 00000000  dc440000  ffa20020 <ffa40028> 0801da7e  df830028  1085001c
 24070008  1487ff6
5
Segmentation fault
