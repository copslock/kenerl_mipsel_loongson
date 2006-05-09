Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 16:38:53 +0200 (CEST)
Received: from mx5.kent.ac.uk ([129.12.21.36]:54192 "EHLO mx5.kent.ac.uk")
	by ftp.linux-mips.org with ESMTP id S8133859AbWEIOil (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2006 16:38:41 +0200
Received: from hathor.ukc.ac.uk ([129.12.4.12])
	by mx5.kent.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FdTM7-0000Cv-L2
	for linux-mips@linux-mips.org; Tue, 09 May 2006 15:38:31 +0100
Received: from myrtle.ukc.ac.uk ([129.12.3.176] ident=exim)
	by hathor.ukc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.60)
	(envelope-from <djd20@kent.ac.uk>)
	id 1FdTM7-0000Tk-HQ
	for linux-mips@linux-mips.org; Tue, 09 May 2006 15:38:31 +0100
Received: from fingerpoken.ukc.ac.uk ([129.12.16.14])
	by myrtle.ukc.ac.uk with esmtp (Exim 4.60)
	(envelope-from <djd20@kent.ac.uk>)
	id 1FdTM7-0005Zf-CD
	for linux-mips@linux-mips.org; Tue, 09 May 2006 15:38:31 +0100
From:	Damian Dimmich <djd20@kent.ac.uk>
To:	linux-mips@linux-mips.org
Subject: Re: zilog oops with bad scsi
Date:	Tue, 9 May 2006 15:30:17 +0100
User-Agent: KMail/1.8.3
References: <200605091516.24427.djd20@kent.ac.uk>
In-Reply-To: <200605091516.24427.djd20@kent.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091530.17748.djd20@kent.ac.uk>
X-UKC-Mail-System: No virus detected
X-UKC-SpamCheck: 
X-UKC-MailScanner-From:	djd20@kent.ac.uk
Return-Path: <djd20@kent.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djd20@kent.ac.uk
Precedence: bulk
X-list: linux-mips

Oh, if I wait and do not press any keys (takes a short time) then after a 
while the scsi driver times out/stops trying to connect to the not-working 
device and boot continues.  Once it is out of the scsi driver the system does 
not crash on keypress any more.

Damian

On Tuesday 09 May 2006 15:16, Damian Dimmich wrote:
> Hi,
>
> I have, what I think is a badly set-up scsi system.  I think there is an
> issue with the termination, the attached drives are wide-scsi and I think
> there is some issue with the termination.
>
> That isn't the interesting bit though.  When booting with a freshly
> compiled 2.6.16.12 kernel, running headless with the output coming in on
> ttyS1, I can get the kernel to oops by pressing any key (sending a keypress
> down the serial line) while it is trying to figure out what is going on
> with the scsi subsystem.  With the external scsi it boots fine.
>
> Interestingly, this did not happen with the debian-rolled 2.4.27 kernel (as
> in, it would complain about the scis, but not crash when i pressed keys).
>
> Thought this may be useful to someone. Please let me know if you need any
> further information.
>
> Cheers,
> Damian
>
> Linux version 2.6.16.12 (ddimmich@indigo) (gcc version 4.0.3 20051201
> (prerelea6
> ARCH: SGI-IP22
> PROMLIB: ARC firmware Version 1 Revision 10
> CPU revision is: 00000460
> FPU revision is: 00000500
> MC: SGI memory controller Revision 3
> MC: Probing memory configuration:
>  bank0:  64M @ 10000000
>  bank1:  32M @ 14000000
>  bank2: 128M @ 08000000
> Determined physical RAM map:
>  memory: 0e000000 @ 08000000 (usable)
> Built 1 zonelists
> Kernel command line: root=/dev/sda1 console=ttyS0 auto
> Primary instruction cache 16kB, physically tagged, direct mapped, linesize
> 16 b.
> Primary data cache 16kB, direct mapped, linesize 16 bytes.
> Unified secondary cache 1024kB direct mapped, linesize 128 bytes.
> Synthesized TLB refill handler (21 instructions).
> Synthesized TLB load handler fastpath (33 instructions).
> Synthesized TLB store handler fastpath (33 instructions).
> Synthesized TLB modify handler fastpath (32 instructions).
> EISA: Probing bus...
> EISA: Detected 0 card.
> ISA support compiled in.
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Calibrating system timer... 100500 [201.0000 MHz CPU]
> Using 100.500 MHz high precision timer.
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 222688k/229376k available (2385k kernel code, 6556k reserved, 518k
> data)
> Mount-cache hash table entries: 512
> Checking for 'wait' instruction...  unavailable.
> NET: Registered protocol family 16
> EISA bus registered
> SCSI subsystem initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Initializing Cryptographic API
> io scheduler noop registered
> io scheduler anticipatory registered (default)
> io scheduler deadline registered
> io scheduler cfq registered
> serio: i8042 AUX port at 0xbfbd9843,0xbfbd9847 irq 44
> serio: i8042 KBD port at 0xbfbd9843,0xbfbd9847 irq 44
> Serial: IP22 Zilog driver (1 chips).
> ttyS0 at MMIO 0xc001a830 (irq = 45) is a IP22-Zilog
> Console: ttyS0 (IP22-Zilog)
> ttyS1 at MMIO 0xc001c838 (irq = 45) is a IP22-Zilog
> eth0: SGI Seeq8003 08:00:69:08:43:b2
> wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
>            setup_args=,,,,,,,,,
>            Version 1.26 - 22/Feb/2003, Compiled Apr 15 2006 at 10:15:46
> wd33c93-1: chip=unknown/255 no_sync=0xff no_dma=0 debug_flags=0x00
>            setup_args=,,,,,,,,,
>            Version 1.26 - 22/Feb/2003, Compiled Apr 15 2006 at 10:15:46
> --UNKNOWN INTERRUPT:80:01:00--<6>scsi0 : SGI WD93
>  sending SDTR 0103013f0csync_xfer=2c<5>  Vendor: SEAGATE   Model: ST34501W
> 8
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi1 : SGI WD93
> scsi1: warning : SCSI command probably completed successfully        
> before ab4
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 1000cc01 01470000 00000000
> $ 4   : 95e5dc00 bfbd9830 882a1ee0 1000cc00
> $ 8   : 1000cc00 1000001f 00000000 89364000
> $12   : 00000002 88310000 ffffffff 00000001
> $16   : 00000004 95e5dc00 bfbd9830 0147ae13
> $20   : 882a1ee0 88310000 00000038 887fe594
> $24   : 00000000 00000000
> $28   : 882a0000 882a1df8 00000001 8819b784
> Hi    : 000000f7
> Lo    : ae135c80
> epc   : 8819b254 ip22zilog_receive_chars+0x38/0x3cc     Not tainted
> ra    : 8819b784 ip22zilog_interrupt+0x19c/0x1a4
> Status: 1000cc03    KERNEL EXL IE
> Cause : 30000008
> BadVA : 00000000
> PrId  : 00000460
> Modules linked in:
> Process swapper (pid: 0, threadinfo=882a0000, task=882a2000)
> Stack : 00200200 882a1e68 0000001a 01baa080 00000000 883142dc 00000004
> 95e5dc00
>         bfbd9830 0147ae13 882a1ee0 88310000 00000038 887fe594 00000001
> 8819b784
>         0000000a 88310000 00000001 88315dd0 95e58300 00000000 00000000
> 00000001
>         882a1ee0 0000002d 88810000 8804bd88 882a1e68 882a1e68 00000000
> 883142dc
>         882d75e0 95e58300 0000002d fffffffb 88310000 882a1ee0 8804beb0
> 8804bf24
>         ...
> Call Trace:
>  [<8819b784>] ip22zilog_interrupt+0x19c/0x1a4
>  [<8804bd88>] handle_IRQ_event+0x80/0xf8
>  [<8804beb0>] __do_IRQ+0xb0/0x140
>  [<8804bf24>] __do_IRQ+0x124/0x140
>  [<882d9000>] kernel_entry+0x0/0x7c
>  [<882d9000>] kernel_entry+0x0/0x7c
>  [<880067cc>] do_IRQ+0x1c/0x34
>  [<8802ee88>] do_softirq+0x90/0xbc
>  [<88003620>] indyIRQ+0x120/0x180
>  [<88003608>] indyIRQ+0x108/0x180
>  [<882d9000>] kernel_entry+0x0/0x7c
>  [<88006e6c>] cpu_idle+0x48/0x50
