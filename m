Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Feb 2003 15:29:07 +0000 (GMT)
Received: from smtp2.infineon.com ([IPv6:::ffff:194.175.117.77]:55801 "EHLO
	smtp2.infineon.com") by linux-mips.org with ESMTP
	id <S8225200AbTB0P3G>; Thu, 27 Feb 2003 15:29:06 +0000
Received: from mucse011.eu.infineon.com (mucse011.ifx-mail1.com [172.29.27.228])
	by smtp2.infineon.com (8.12.2/8.12.2) with ESMTP id h1RFQk5N026197
	for <linux-mips@linux-mips.org>; Thu, 27 Feb 2003 16:26:46 +0100 (MET)
Received: by mucse011.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <FY22H2VK>; Thu, 27 Feb 2003 16:29:00 +0100
Message-ID: <3A5A80BF651115469CA99C8928706CB603D7B300@mucse004.eu.infineon.com>
From: ZhouY.external@infineon.com
To: linux-mips@linux-mips.org
Subject: MIPS Malta board Linux installation 
Date: Thu, 27 Feb 2003 16:28:51 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <ZhouY.external@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ZhouY.external@infineon.com
Precedence: bulk
X-list: linux-mips

Hello everyone,
  I tried to install a Linux to my MIPS Malta board, but during the time of
NFS installation, the linux crashed. The linux distribution is provided by
MIPS Malta Board CD  and I exactly followed the installation manual. The
following messages are the error messages and the configuration information.
  Do you have any clues about it?
  Thanks in advance!

  Best regards,

  Yidan Zhou 


----------------------------------------------------------------------

YAMON> info all

**** Info boot ****

YAMON ROM Monitor, Revision 02.02.
Copyright (c) 1999-2001 MIPS Technologies, Inc. - All Rights Reserved.

For a list of available commands, type 'help'.

Compilation time =              Sep 12 2002  11:41:49


**** Info board ****

Board type/revision =           0x02 (Malta) / 0x00
Core board type/revision =      0x01 (CoreLV) / 0x01
FPGA revision =                 0x0001
MAC address =                   00.d0.a0.00.01.77
Board S/N =                     0000000127
PCI bus frequency =             16.67 MHz


**** Info cpu ****

Processor Company ID/options =  0x01 (MIPS Technologies, Inc.) / 0x00
Processor ID/revision =         0x80 (MIPS 4Kc) / 0x05
Endianness =                    Big
CPU/Bus frequency =             125 MHz / 63 MHz
ICACHE size =                   16 kByte
ICACHE line size =              16 bytes
ICACHE associativity =          4-way
DCACHE size =                   16 kByte
DCACHE line size =              16 bytes
DCACHE associativity =          4-way
TLB entries =                   16
CPU type =                      MIPS32
MIPS16e implemented =           No
EJTAG implemented =             Yes
FPU implemented =               No


**** Info memory ****

Monitor flash phys base =       0x1e000000
Monitor flash size =            0x003e0000
Env. flash phys base =          0x1e3e0000
Env. flash size =               0x00020000

SDRAM phys base =               0x00000000
SDRAM size =                    0x04000000
SDRAM refresh interval =        14520 ns
SDRAM CAS latency =             2 cycles
SDRAM SRAS precharge =          2 cycles
SDRAM SRAS to SCAS delay =      2 cycles
SDRAM write burst length =      8
SDRAM read burst length =       8

First free SDRAM address =      0x800991f8
Stack size =                    0x5000 bytes
Application stack size =        0x5000 bytes


**** Info uart ****

TTY0:
 Bytes transmitted:             3381
 Bytes received:                63
 Receive overruns:              0
 Receive parity errors:         0
 Receive framing errors:        0
 Receive breaks:                0
 Receive Interrupts:            0
 No of resets:                  1
TTY1:
 Bytes transmitted:             0
 Bytes received:                0
 Receive overruns:              0
 Receive parity errors:         0
 Receive framing errors:        0
 Receive breaks:                0
 Receive Interrupts:            0
 No of resets:                  1


**** Info pci ****

PCI bus frequency = 16.67 MHz

PCI devices:
Bus count = 1, Device count = 7

Bus = 0x00, Dev = 0x00, Function = 0x00
Vendor Id = 0x11ab (Galileo), Dev ID = 0x4620 (64120)
 Min Gnt = 0x00, Max Lat = 0x00, Lat Tim = 0x20
 Int Pin = A, Int Line = None
 BAR count = 0x03
  MEM: Pos = 0x10, Base(CPU/PCI) = 0x00000000/0x00000000, Size = 0x04000000
  MEM: Pos = 0x20, Base(CPU/PCI) = 0x04000000/0x04000000, Size = 0x00000010
  MEM: Pos = 0x14, Base(CPU/PCI) = 0x04000000/0x04000000, Size = 0x00000000

Bus = 0x00, Dev = 0x0a, Function = 0x00
Vendor Id = 0x8086 (Intel), Dev ID = 0x7110 (PIIX4 Bridge)
 Min Gnt = 0x00, Max Lat = 0x00, Lat Tim = 0x20
 Int Pin = None, Int Line = None
 BAR count = 0x01
  IO:  Pos = 0x10, Base(CPU/PCI) = 0x18000000/0x00000000, Size = 0x00001000

Bus = 0x00, Dev = 0x0a, Function = 0x01
Vendor Id = 0x8086 (Intel), Dev ID = 0x7111 (PIIX4 IDE)
 Min Gnt = 0x00, Max Lat = 0x00, Lat Tim = 0x20
 Int Pin = None, Int Line = None
 BAR count = 0x01
  IO:  Pos = 0x20, Base(CPU/PCI) = 0x18001240/0x00001240, Size = 0x00000010

Bus = 0x00, Dev = 0x0a, Function = 0x02
Vendor Id = 0x8086 (Intel), Dev ID = 0x7112 (PIIX4 USB)
 Min Gnt = 0x00, Max Lat = 0x00, Lat Tim = 0x20
 Int Pin = D, Int Line = 0x0b
 BAR count = 0x01
  IO:  Pos = 0x20, Base(CPU/PCI) = 0x18001220/0x00001220, Size = 0x00000020

Bus = 0x00, Dev = 0x0a, Function = 0x03
Vendor Id = 0x8086 (Intel), Dev ID = 0x7113 (PIIX4 Power)
 Min Gnt = 0x00, Max Lat = 0x00, Lat Tim = 0x20
 Int Pin = None, Int Line = 0x09
 BAR count = 0x02
  IO:  Pos = 0x40, Base(CPU/PCI) = 0x18001000/0x00001000, Size = 0x00000100
  IO:  Pos = 0x90, Base(CPU/PCI) = 0x18001100/0x00001100, Size = 0x00000100

Bus = 0x00, Dev = 0x0b, Function = 0x00
Vendor Id = 0x1022 (AMD), Dev ID = 0x2000 (79C973)
 Min Gnt = 0x18, Max Lat = 0x18, Lat Tim = 0x20
 Int Pin = A, Int Line = 0x0a
 BAR count = 0x02
  IO:  Pos = 0x10, Base(CPU/PCI) = 0x18001200/0x00001200, Size = 0x00000020
  MEM: Pos = 0x14, Base(CPU/PCI) = 0x08011000/0x08011000, Size = 0x00000020

Bus = 0x00, Dev = 0x0c, Function = 0x00
Vendor Id = 0x1013 (Crystal), Dev ID = 0x6005 (4281)
 Min Gnt = 0x04, Max Lat = 0x18, Lat Tim = 0x20
 Int Pin = A, Int Line = 0x0b
 BAR count = 0x02
  MEM: Pos = 0x10, Base(CPU/PCI) = 0x08010000/0x08010000, Size = 0x00001000
  MEM: Pos = 0x14, Base(CPU/PCI) = 0x08000000/0x08000000, Size = 0x00010000


**** Info ide ****



**** Info isa ****

Device   Address(ISA)   Address(CPU)   Interrupt line
-----------------------------------------------------
TTY0     0x3f8          0x180003f8     IRQ4
TTY1     0x2f8          0x180002f8     IRQ3
LPT      0x378          0x18000378     IRQ7
FDD      0x3f0          0x180003f0     IRQ6
KYBD     0x060          0x18000060     IRQ1
MOUSE    0x060          0x18000060     IRQ12


**** Info lan ****

 MII status: Link is up, mode: 10 Mbit/s, half-duplex

 Packets received:               0
 Packets transmitted:            0
 Bytes received:                 0
 Bytes transmitted:              0
 Receive errors:                 0
 Transmit errors:                0
 Multicasts received:            0
 Collisions:                     0
 Interrupts:                     4
 Receive CRC errors:             0
 Receive frame error:            0
 Receive FIFO overrun errors :   0
 Transmit aborted errors:        0
 Transmit lost carrier errors:   0
 Transmit FIFO underrun errors:  0
 Transmit signal quality errors: 0
 Transmit late collision errors: 0
 Transmit timeout errors:        0

YAMON> set

baseboardserial (RO)   0000000127
bootfile        (R/W)  bootrom.hex
bootprot        (R/W)  tftp
bootserport     (R/W)  tty0
bootserver      (R/W)  192.168.149.114
cpuconfig       (R/W)
ethaddr         (RO)   00.d0.a0.00.01.77
gateway         (R/W)  0.0.0.0
ipaddr          (R/W)  192.168.149.116
memsize         (RO)   0x04000000
modetty0        (R/W)  38400,n,8,1,hw
modetty1        (R/W)  38400,n,8,1,hw
prompt          (R/W)  YAMON
start           (R/W)
subnetmask      (R/W)  255.255.255.0
yamonrev        (RO)   02.02

YAMON> load tftp://192.168.149.1/vmlinux-2.2.12.mips.malta.eb-01.05.srec
About to load tftp://192.168.149.1/vmlinux-2.2.12.mips.malta.eb-01.05.srec
Press Ctrl-C to break
........................................
........................................
........................................
..
Start = 0x80100608, range = (0x80100000,0x8024015f), format = SREC
YAMON> go . nfsroot=192.168.149.1:/c/linux/mipseb ip=192.168.149.116

LINUX started...
EURfΠρoeνο>ίόÿϋ_ÿÿφ~ÿÿΏίÿλ¬RÿίοώλÿΫώοωϊίm»>ÿÿÿϋÿλ®ήύν}®Ώωύoήχÿο?mÿκσ―Νλύοÿ³ÿ
ÿέϋοξ―χÿοÿϋÿΟÿÿΏ―ÿύ»ΊÿgÿΏÿ~ÿÿίώÿϋώκώÿχÿÿοÿκχΧΆÿh«Οÿίύοÿÿώϋÿÿύϋÿ{ÿ®ÿÿÿÿίχ/σÿν
ÿξίϋÿ©χÿÿ®ÿ;ΏύΏσÿϋÿyΏÿwÿÿÿÿmώ®ύ
χξϋνλλίÿΚίοΏό^ÿÿοÿλλϋώ}ÿÿÿλοοÿYχώÿÿÿώΫχÿώÿΏώÿÿÿÿ|rÿοÿÿÿξÿοίοϋÿ{ÿϊνÿΏÿχÿÿÿo―ϋ
_ÿwϊ{yΏοÿÿÿ―ώϋÿ_οί―ÿÿξϊÿσοÿύ~οÿÿÿίό?λΎϋÿÿωÿÿϋÿÿÿÿÿύοΎÿϋÿ·ώÿÿ―ÿχnίhΏΏÿοχοϋίοϋ
οÿÿλύώίÿχuοÿÿκϋÿοχ»Ϋwοÿÿύύοÿ
mΏΏÿΏ_ϋίÿΏξ_{ύ―ÿÿο«ÿÿύώÿοΏίϋ}ΏÿλÿÿÿÿϋÿύÿμΏÿύξÿϋzÿÿωÿÿ+ϋϋΟύÿϊ_οÿϊ―ΏύΏο―Oÿύϋÿ
οÿοϋύίζÿύÿÿΫΏχϊσλÿώÿ½ύÿύοÿÿοχÿÿoοοÿÿÿοÿσϋ®ÿύÿϋÿÿοώÿÿÿο§ÿÿÿÿΧ_κÿοϋ»ÿÿ=ÿÿ»οϊσυ
Ώήύώ»Ϊÿ/?ÿYξÿώÿίÿoÿώϊχ»ÿύϋÿ
ÿÿύÿ_λÿΏÿοÿÿÿνÿϋϋÿ_οÿÿξο?ÿΧλÿ?ΏΎÿχÿΏώνοώϋ·ξÿkοΏÿÿÿϋÿoώοϋχχΊώϋ?ÿÿÿ®ÿο»ÿύÿÿωΏώ
ÿύÿ½ÿÿÿχί>ÿÿ«οÿύχοwÿοÿÿÿώÿ=ςκÿwÿ½oÿΎÿ?ώοϊύλμÿχÿώÿνÿϋÿÿοÿω«Ύοÿώÿο£»ÿYίο{οψΏÿÿ
ϋÿÿ}όÿÿÿÿωξÿΫÿÿÿϋϋΎώÿώίÿϊοÿϊ
ÿÿχΏÿiÿξÿÿύώϋ}ϋϋύÿÿ―ΏÿYλÿώÿλώ{ΏώÿοÿÿÿΏYί·ÿϋίωμύÿÿÿΏ―ÿ―ώÿούÿÿώχίÿϋνοϋϋωy―ÿ}οΎ
ÿ~ϋÿωÿΏoÿÿÿώ|ΎώΫÿÿκϋ{ΏÿίÿοώÿÿÿώΏέΏÿοοϋÿοÿÿύλÿϋύÿώÿϋÿϊÿÿίÿϋλÿÿϋÿϋϊyΏÿίÿÿλώο·ÿ
ÿÿϋΏίωÿÿÿÿÿ½ώΏzίίοϋ}―ώÿÿÿ½ÿο
οÿÿχέΊÿmΎϋÿώϋÿοΊλÿχί―ίϋϋοϋÿίÿy»ΎϋΏÿΏίϋÿÿÿύΧοÿύΏξÿοχÿÿο―ϋίÿύ―Ώÿλϊÿÿÿÿίoϋÿίχ
ώÿÿ=οΎÿÿίÿ»ÿ―~ÿϋΎÿ|Ό»ÿέ»ÿ?«κÿÿÿολÿϋοί-ÿσÿÿϋÿώÿχÿÿύϋ»ÿÿÿοήωΎοÿχϋίÿϋO½ίÿÿyϋΏÿΏ
ÿÿÿooÿΏύΧΎώύÿίήÿίÿϋΩÿ»ϋοχώÿο
[ξϋÿχϊϋmÿώzώ}ÿύÿμÿÿοϋΏϋΟÿ?ώÿ{ÿÿώύώÿύώΏÿÿÿ»ÿλ―ώÿΗÿΌϋ
