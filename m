Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9GHUQr03579
	for linux-mips-outgoing; Tue, 16 Oct 2001 10:30:26 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9GHUKD03575
	for <linux-mips@oss.sgi.com>; Tue, 16 Oct 2001 10:30:20 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9GHWcB24799;
	Tue, 16 Oct 2001 10:32:38 -0700
Message-ID: <3BCC6EA3.A1A3BA3A@mvista.com>
Date: Tue, 16 Oct 2001 10:30:11 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hanks Li <hli@quicklogic.com>
CC: linux-mips@oss.sgi.com
Subject: Re: IDE DMA mode in Big endian for mips
References: <APEOLACBIPNAFKJDDFIIEECJCBAA.hli@quicklogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Some host-PCI bridge controller may have smart endian conversion features. 
Make sure you set it up correctly.  The fact that DMA does not work but
polling works might also indicate the smart conversion only happens from PCI
to memory, not in the patch PCI -> CPU.

Perhaps your memory is still in LE mode even when your CPU runs in BE mode?

Jun

Hanks Li wrote:
> 
> Hi,
> 
> We are working on the IDE/ATAPI for mips. When I changed to Big endian mode,
> the following information appared, and the program hang.
> 
> -------------------------------------
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PDC20262: IDE controller on PCI bus 00 dev 30
> PDC20262: chipset revision 1
> PDC20262: not 100% native mode: will probe irqs later
> PDC20262: ROM enabled at 0x06fb0000
> PDC20262: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
>     ide0: BM-DMA at 0xf800-0xf807, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xf808-0xf80f, BIOS settings: hdc:pio, hdd:pio
> hda: QUANTUM FIREBALL EX10.2A, ATA DISK drive
> ide0 at 0xec00-0xec07,0xe802 on irq 7
> hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63, (U)DMA
> Partition check:
>  hda:hda: dma_timer_expiry: status=0x58 { DriveReady SeekComplete
> DataRequest }
> hda: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> -------------------------------------
> 
> When I turned off "IDE,ATA and ATAPI Block Devices->Generic PCI bus-master
> DMA support", there was no problem at all. The following information
> appared:
> 
> ------------------------------------
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PDC20262: IDE controller on PCI bus 00 dev 30
> PDC20262: chipset revision 1
> PDC20262: not 100% native mode: will probe irqs later
> hda: QUANTUM FIREBALL EX10.2A, ATA DISK drive
> ide0 at 0xec00-0xec07,0xe802 on irq 7
> hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=19885/16/63
> Partition check:
>  hda: [PTBL] [1247/255/63] hda1 hda2 hda3
> ------------------------------------
> 
> What could be the cause of this problem?
> 
> Regards,
> 
> Hanshi Li
