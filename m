Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9GETTw00458
	for linux-mips-outgoing; Tue, 16 Oct 2001 07:29:29 -0700
Received: from quicklogic.com (quick1.quicklogic.com [206.184.225.224])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9GETOD00453
	for <linux-mips@oss.sgi.com>; Tue, 16 Oct 2001 07:29:24 -0700
Received: from enghanks
	([207.81.96.51])
	by quicklogic.com; Tue, 16 Oct 2001 07:28:35 -0700
From: "Hanks Li" <hli@quicklogic.com>
To: <linux-mips@oss.sgi.com>
Subject: IDE DMA mode in Big endian for mips
Date: Tue, 16 Oct 2001 10:28:56 -0400
Message-ID: <APEOLACBIPNAFKJDDFIIEECJCBAA.hli@quicklogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <20011012225433.A10523@lucon.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

We are working on the IDE/ATAPI for mips. When I changed to Big endian mode,
the following information appared, and the program hang.

-------------------------------------
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20262: IDE controller on PCI bus 00 dev 30
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0x06fb0000
PDC20262: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0xf800-0xf807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf808-0xf80f, BIOS settings: hdc:pio, hdd:pio
hda: QUANTUM FIREBALL EX10.2A, ATA DISK drive
ide0 at 0xec00-0xec07,0xe802 on irq 7
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63, (U)DMA
Partition check:
 hda:hda: dma_timer_expiry: status=0x58 { DriveReady SeekComplete
DataRequest }
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
-------------------------------------

When I turned off "IDE,ATA and ATAPI Block Devices->Generic PCI bus-master
DMA support", there was no problem at all. The following information
appared:

------------------------------------

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20262: IDE controller on PCI bus 00 dev 30
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
hda: QUANTUM FIREBALL EX10.2A, ATA DISK drive
ide0 at 0xec00-0xec07,0xe802 on irq 7
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63
Partition check:
 hda: [PTBL] [1247/255/63] hda1 hda2 hda3
------------------------------------

What could be the cause of this problem?

Regards,

Hanshi Li
