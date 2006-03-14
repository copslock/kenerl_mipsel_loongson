Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 02:23:05 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:4362 "EHLO MMS3.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S8134488AbWCNCWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Mar 2006 02:22:54 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Mon, 13 Mar 2006 18:33:39 -0800
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 8F51B2AF; Mon, 13 Mar 2006 18:31:42 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 64F802AE; Mon, 13 Mar
 2006 18:31:42 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.3a-GA) with ESMTP
 id DCC00358; Mon, 13 Mar 2006 18:31:41 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 CF61B20502; Mon, 13 Mar 2006 18:31:41 -0800 (PST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: BCM91x80A/B PCI DMA problems
Date:	Mon, 13 Mar 2006 18:31:14 -0800
Message-ID: <7E000E7F06B05C49BDBB769ADAF44D07868120@NT-SJCA-0750.brcm.ad.broadcom.com>
Thread-Topic: BCM91x80A/B PCI DMA problems
Thread-Index: AcZG4LS9x7ftWGaMTRShZutQOYOfbgALnTYw
From:	"Mark E Mason" <mark.e.mason@broadcom.com>
To:	"Martin Michlmayr" <tbm@cyrius.com>,
	"Alan Cox" <alan@lxorguk.ukuu.org.uk>
cc:	linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006031311; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E37463030303130312E34343136324143352E303032412D412D;
 ENG=IBF; TS=20060314023344; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006031311_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6808F40936W6581284-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.e.mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

Again -- which PCI slot are you seeing this with?  There's two PCI
controllers on this system -- and they work fairly differently.  The
slot closest to the CPU is direct PCI-X, and I believe the better tested
of the two.  The other slots are off of a HT/PCI-X bridge, and more
likely to be flakey.

Thanks,
Mark 

> -----Original Message-----
> From: Martin Michlmayr [mailto:tbm@cyrius.com] 
> Sent: Monday, March 13, 2006 12:57 PM
> To: Alan Cox
> Cc: Mark E Mason; linux-mips@linux-mips.org
> Subject: Re: BCM91x80A/B PCI DMA problems
> 
> * Alan Cox <alan@lxorguk.ukuu.org.uk> [2006-02-28 23:06]:
> > > Is this driver known to work with 64-bit kernels (specifically: 
> > > 64-bit DMA addresses)?  It sounds like that might be the problem.
> > 
> > The standard ATA IDE hardware supports only 32bit 
> addressing. However 
> > if your I/O mapping logic is correctly implemented for the 
> > architecture that should cause no problems as the buffers 
> will be bounced.
> 
> Something is definitely broken in the implemention of this 
> architecture.  With a 64-bit kernel, my SII PCI card shows DMA errors.
> With a 32-bit kernel I get some other weird errors.  What I 
> managed to do is to add the SII device ID to the generic IDE 
> support.  This works but is obviously quite slow...
> 
> > The SIL680 hardware actually can support 64bit DMA using a private 
> > non-standard PRD format and the data sheet is available if someone 
> > wants to do the work. Probably best to do it for the new 
> libata driver 
> > but its doable for either
> 
> I just tried the SCSI PATA patch to see if that works.  
> Unfortunately, it doesn't.  As I said above, something must 
> be broken in the architecture code of SB1.  However, Alan, I 
> think you might be interested in the oops I get anyway 
> because I suspect you may want to fail in a more gracious way.
> 
> BTW, does anyone have the knowledge and time to see what's 
> broken in the SB1 code?  I really need something better than 
> generic IDE support.  It's not fun having a quad-core CPU 
> when your box has to wait for IO all the time. :/
> 
> Alan, for you:
> 
> [4294667.296000] Linux version 2.6.16-rc6 (Debian 
> 2.6.15+2.6.16-rc6-0experimental.1) (waldi@debian.org) (gcc 
> version 4.1.0 (Debian 4.1.0-0)) #7 SMP Mon Mar 13 20:45:43 
> UTC 2006 [4294667.296000] CPU revision is: 01041100 
> [4294667.296000] FPU revision is: 000f0103 [4294667.296000] 
> swarm setup: M41T81 RTC detected.
> [4294667.296000] This kernel optimized for board runs with 
> CFE [4294667.296000] Determined physical RAM map:
> [4294667.296000]  memory: 000000000fe91e00 @ 0000000000000000 
> (usable) [4294667.296000]  memory: 000000001ffffe00 @ 
> 0000000080000000 (usable) [4294667.296000]  memory: 
> 000000000ffffe00 @ 00000000c0000000 (usable) [4294667.296000] 
>  memory: 000000003ffffe00 @ 0000000140000000 (usable) 
> [4294667.296000] Detected 3 available secondary CPU(s) 
> [4294667.296000] Built 1 zonelists [4294667.296000] Kernel 
> command line: root=/dev/hda2 [4294667.296000] Primary 
> instruction cache 32kB, 4-way, linesize 32 bytes.
> [4294667.296000] Primary data cache 32kB, 4-way, linesize 32 bytes.
> [4294667.296000] Synthesized TLB refill handler (35 instructions).
> [4294667.296000] Synthesized TLB load handler fastpath (49 
> instructions).
> [4294667.296000] Synthesized TLB store handler fastpath (49 
> instructions).
> [4294667.296000] Synthesized TLB modify handler fastpath (48 
> instructions).
> [4294667.296000] PID hash table entries: 4096 (order: 12, 
> 131072 bytes) [4294667.313000] Dentry cache hash table 
> entries: 1048576 (order: 11, 8388608 bytes) [4294667.340000] 
> Inode-cache hash table entries: 524288 (order: 10, 4194304 
> bytes) [4294667.653000] Memory: 1991912k/2095672k available 
> (2374k kernel code, 103144k reserved, 643k data, 208k init, 
> 0k highmem) [4294667.674000] Mount-cache hash table entries: 
> 256 [4294667.676000] Checking for 'wait' instruction...  unavailable.
> [4294667.678000] Checking for the multiply/shift bug... no.
> [4294667.680000] Checking for the daddi bug... no.
> [4294667.681000] Checking for the daddiu bug... no.
> [4294667.683000] CPU revision is: 03041100 [4294667.683000] 
> FPU revision is: 000f0103 [4294667.683000] Primary 
> instruction cache 32kB, 4-way, linesize 32 bytes.
> [4294667.683000] Primary data cache 32kB, 4-way, linesize 32 bytes.
> [4294667.683000] Synthesized TLB refill handler (35 instructions).
> [4294667.703000] CPU revision is: 05041100 [4294667.703000] 
> FPU revision is: 000f0103 [4294667.703000] Primary 
> instruction cache 32kB, 4-way, linesize 32 bytes.
> [4294667.703000] Primary data cache 32kB, 4-way, linesize 32 bytes.
> [4294667.703000] Synthesized TLB refill handler (35 instructions).
> [4294667.723000] CPU revision is: 07041100 [4294667.723000] 
> FPU revision is: 000f0103 [4294667.723000] Primary 
> instruction cache 32kB, 4-way, linesize 32 bytes.
> [4294667.723000] Primary data cache 32kB, 4-way, linesize 32 bytes.
> [4294667.723000] Synthesized TLB refill handler (35 instructions).
> [4294667.743000] Brought up 4 CPUs
> [4294667.757000] migration_cost=1000
> [4294667.762000] NET: Registered protocol family 16 
> [4294667.765000] SCSI subsystem initialized [4294667.769000] 
> Initializing Cryptographic API [4294667.770000] io scheduler 
> noop registered [4294667.771000] io scheduler anticipatory 
> registered (default) [4294667.773000] io scheduler deadline 
> registered [4294667.774000] io scheduler cfq registered 
> [4294667.787000] Generic RTC Driver v1.07 [4294667.788000] 
> eth0: enabling TCP rcv checksum [4294667.789000] eth0: SiByte 
> Ethernet at 0x10064000, address: 00:02:4C:F5:2C:3C 
> [4294667.790000] eth1: enabling TCP rcv checksum 
> [4294667.791000] eth1: SiByte Ethernet at 0x10065000, 
> address: 00:02:4C:F5:2C:3D [4294667.792000] eth2: enabling 
> TCP rcv checksum [4294667.793000] eth2: SiByte Ethernet at 
> 0x10066000, address: 00:02:4C:F5:2C:3E [4294667.794000] eth3: 
> enabling TCP rcv checksum [4294667.795000] eth3: SiByte 
> Ethernet at 0x10067000, address: 00:02:4C:F5:2C:3F 
> [4294667.797000] sil680: BA5_EN = 1 clock = 00 
> [4294667.798000] sil680: BA5_EN = 1 clock = 10 
> [4294667.799000] sil680: 133MHz clock.
> [4294667.800000] ata1: PATA max UDMA/133 cmd 0x8010 ctl 
> 0x8022 bmdma 0x8000 irq 8 [4294667.802000] ata2: PATA max 
> UDMA/133 cmd 0x8018 ctl 0x8026 bmdma 0x8008 irq 8 
> [4294667.957000] ata1: dev 0 ATA-6, max UDMA/33, 19932192 
> sectors: LBA [4294667.958000] ata1: dev 0 configured for 
> UDMA/33 [4294667.959000] scsi0 : pata_sil680 [4294668.114000] 
> ata2: dev 0 ATA-6, max UDMA/66, 19932192 sectors: LBA 
> [4294668.115000] ata2: dev 0 configured for UDMA/33 
> [4294668.116000] scsi1 : pata_sil680
> [4294668.117000]   Vendor: ATA       Model: SAMSUNG SV1021H   
> Rev: PJ10
> [4294668.122000]   Type:   Direct-Access                      
> ANSI SCSI revision: 05
> [4294668.124000]   Vendor: ATA       Model: SAMSUNG SV1021H   
> Rev: PJ10
> [4294668.129000]   Type:   Direct-Access                      
> ANSI SCSI revision: 05
> [4294668.132000] SCSI device sda: 19932192 512-byte hdwr 
> sectors (10205 MB) [4294668.133000] sda: Write Protect is off 
> [4294668.134000] SCSI device sda: drive cache: write back 
> [4294668.135000] SCSI device sda: 19932192 512-byte hdwr 
> sectors (10205 MB) [4294668.136000] sda: Write Protect is off 
> [4294668.137000] SCSI device sda: drive cache: write back 
> [4294668.138000]  sda:DBE physical address: 002c008020 
> [4294698.139000] Data bus error, epc == ffffffff80293a48, ra 
> == ffffffff8029b4d4 [4294698.139000] Oops[#1]:
> [4294698.139000] Cpu 0
> [4294698.139000] $ 0   : 0000000000000000 0000000014001fe0 
> 00000000000000ff 900000002c008022
> [4294698.139000] $ 4   : 900000002c000000 a80000017ff63458 
> ffffffff80360000 ffffffffffff00fe
> [4294698.139000] $ 8   : 0000000000000001 ffffffffffffffc0 
> ffffffff80360000 ffffffff80360000
> [4294698.139000] $12   : ffffffff80430000 0000000000001f00 
> 0000000000000000 ffffffff803a0000
> [4294698.139000] $16   : a80000017ff63000 a80000017ff63458 
> a80000017ff63990 a80000017ff21b00
> [4294698.139000] $20   : 0000000000000002 0000000014001fe1 
> 0000000000000000 0000000000000000
> [4294698.139000] $24   : ffffffff80430000 ffffffff80430000    
>                               
> [4294698.139000] $28   : a800000000504000 a800000000507ea0 
> 0000000000000006 ffffffff8029b4d4
> [4294698.139000] Hi    : 0000000000000000
> [4294698.139000] Lo    : 0000000019643e80
> [4294698.139000] epc   : ffffffff80293a48 
> ata_altstatus+0x68/0x88     Not tainted
> [4294698.139000] ra    : ffffffff8029b4d4 ata_eng_timeout+0x15c/0x1b0
> [4294698.139000] Status: 14001fe2    KX SX UX KERNEL EXL 
> [4294698.139000] Cause : 8080801c
> [4294698.139000] PrId  : 01041100
> [4294698.139000] Modules linked in:
> [4294698.139000] Process scsi_eh_0 (pid: 36, 
> threadinfo=a800000000504000, task=a800000000503968) 
> [4294698.139000] Stack : a80000017ff63000 ffffffff8028ac68 
> a80000017ff63000 fffffffffffffffc
> [4294698.139000]         0000000000000000 a800000000507f10 
> ffffffff8029b954 0000000000000000
> [4294698.139000]         a80000017ff63000 ffffffff8028ad78 
> 0000000000000003 0000000000000000
> [4294698.139000]         ffffffff80422100 ffffffff80125a5c 
> a80000009fffbb60 ffffffff803a4000
> [4294698.139000]         ffffffff80422100 ffffffff80422100 
> a800000000507f20 0000000000000000
> [4294698.139000]         a80000017ff63000 ffffffff8028ac68 
> a80000009fffbb50 fffffffffffffffc
> [4294698.139000]         0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [4294698.139000]         0000000000000000 ffffffff8014fe90 
> ffffffffffffffff ffffffffffffffff
> [4294698.139000]         0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [4294698.139000]         ffffffff801049b0 0000000000000000 
> 0000000000000000 ffffffff801049a0
> [4294698.139000]         ...
> [4294698.139000] Call Trace:
> [4294698.139000]  [<ffffffff8028ac68>] 
> scsi_error_handler+0x0/0xa48 [4294698.139000]  
> [<ffffffff8029b954>] ata_scsi_error+0x24/0x50 
> [4294698.139000]  [<ffffffff8028ad78>] 
> scsi_error_handler+0x110/0xa48 [4294698.139000]  
> [<ffffffff80125a5c>] __wake_up_common+0x7c/0xd8 
> [4294698.139000]  [<ffffffff8028ac68>] 
> scsi_error_handler+0x0/0xa48 [4294698.139000]  
> [<ffffffff8014fe90>] kthread+0xf8/0x160 [4294698.139000]  
> [<ffffffff801049b0>] kernel_thread_helper+0x10/0x18 
> [4294698.139000]  [<ffffffff801049a0>] 
> kernel_thread_helper+0x0/0x18 [4294698.139000] 
> [4294698.139000] [4294698.139000] Code: dc448c50  0064182d  
> 90620000 <03e00008> 304200ff  dc8200a0  67bd0010  90430000  03e00008 
> 
> --
> Martin Michlmayr
> http://www.cyrius.com/
> 
> 
