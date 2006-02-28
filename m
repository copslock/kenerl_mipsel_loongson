Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 21:45:47 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:47880 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133642AbWB1Vpi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2006 21:45:38 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 28 Feb 2006 13:54:51 -0800
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 116D62AF; Tue, 28 Feb 2006 13:53:08 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id DCAC92AE; Tue, 28 Feb
 2006 13:53:07 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id DAA77926; Tue, 28 Feb 2006 13:53:06 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 9E5AA20501; Tue, 28 Feb 2006 13:53:06 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: BCM91x80A/B PCI DMA problems
Date:	Tue, 28 Feb 2006 13:53:00 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D077D6432@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: BCM91x80A/B PCI DMA problems
Thread-Index: AcY8sJnW18FnuScmTX6XXJ0kKNI32QAACEVA
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006022807; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230372E34343034433546342E303036362D412D;
 ENG=IBF; TS=20060228215452; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006022807_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 681A192136W2808634-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

I have one in the slot closest to the CPU.  All of them are supposed to
work, but they're off of different controllers.

[4294667.639000] Uniform Multi-Platform E-IDE driver Revision:
7.00alpha2
[4294667.640000] ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
[4294667.641000] CMD649: IDE controller at PCI slot 0000:00:01.0
[4294667.642000] CMD649: chipset revision 2
[4294667.643000] CMD649: 100% native mode on irq 8
[4294667.644000]     ide0: BM-DMA at 0x8000-0x8007, BIOS settings:
hda:pio, hdb:pio
[4294667.646000]     ide1: BM-DMA at 0x8008-0x800f, BIOS settings:
hdc:pio, hdd:pio
[4294667.912000] hda: WDC AC35100L, ATA DISK drive
[4294668.526000] ide0 at 0x8010-0x8017,0x8022 on irq 8
[4294669.566000] hda: max request size: 128KiB
[4294669.567000] hda: 10085040 sectors (5163 MB) w/256KiB Cache,
CHS=10672/15/63[4294669.570000]  hda: hda1 hda2 < hda5 >

Is this a 32-bit, or 64-bit kernel?  If 64-bit, do you have more than 1G
of DRAM installed in the system (DRAM above 1G is accessed at >32-bit
physical addresses).

Are you using CFE 1.2.5?  The PCI interrupt assignments in earlier
versions of CFE were not correct.

Thanks,
Mark

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Martin 
> Michlmayr
> Sent: Tuesday, February 28, 2006 1:47 PM
> To: linux-mips@linux-mips.org
> Subject: BCM91x80A/B PCI DMA problems
> 
> Has anyone here successfully used a PCI IDE card on BCM91x80?
> I immediately get lots of PCI DMA problems, e.g:
> 
> 
> SiI680: IDE controller at PCI slot 0000:00:01.0
> SiI680: chipset revision 2
> SiI680: BASE CLOCK == 133
> SiI680: 100% native mode on irq 8
>     ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
>     ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
> hda: FUJITSU MPB3043ATU E, ATA DISK drive isa bounce pool 
> size: 16 pages ide0 at 
> 0x9000000031080080-0x9000000031080087,0x900000003108008a on irq 8
> hda: max request size: 64KiB
> hda: 8448300 sectors (4325 MB), CHS=8940/15/63, UDMA(33)
>  hda:<4>hda: dma_timer_expiry: dma status == 0x22
> hda: DMA timeout error
> hda: dma timeout error: status=0x01 { Error }
> hda: dma timeout error: error=0x7f { DriveStatusError 
> UncorrectableError SectorIdNotFound TrackZeroNotFound 
> AddrMarkNotFound }, LBAsect=260013951, sector=0
> ide: failed opcode was: unknown
> end_request: I/O error, dev hda, sector 0
> 
> --
> Martin Michlmayr
> http://www.cyrius.com/
> 
> 
> 
