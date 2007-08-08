Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Aug 2007 13:33:46 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:7165 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20026876AbXHHMdo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 8 Aug 2007 13:33:44 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l78CPwFi014415;
	Wed, 8 Aug 2007 05:25:58 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l78CQ3BC012619;
	Wed, 8 Aug 2007 05:26:04 -0700 (PDT)
Message-ID: <010a01c7d9b7$49c5a280$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Alex Gonzalez" <langabe@gmail.com>, <bamakhrama@gmail.com>,
	<linux-mips@linux-mips.org>
References: <1186573652.31136.19.camel@euskadi> <c58a7a270708080501i61d0cd32q6d5b2795877f4fd1@mail.gmail.com>
Subject: Re: [Fwd: Problems with NFS boot]
Date:	Wed, 8 Aug 2007 14:26:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Yeah, I saw that the missing colon before the root path was the fatal typo
that Ralf mentioned, but I was also a bit worried about not seeing the net
device name at the end of the string. 

----- Original Message ----- 
From: "Alex Gonzalez" <langabe@gmail.com>
To: <bamakhrama@gmail.com>; <linux-mips@linux-mips.org>
Sent: Wednesday, August 08, 2007 2:01 PM
Subject: Fwd: [Fwd: Problems with NFS boot]


> Hi,
> 
> I am NFS booting with
> 
> root=/dev/nfs nfsroot=192.168.2.30:/tftpboot/rootfs
> ip=192.168.2.31:192.168.2.30::::eth0
> 
> See if it helps,
> Alex
> -----------------------------
> 
> 
> Hi list,
> I have a Malta board for which I was able to build the kernel, load it
> and start it. The problem comes when it tries to boot through the NFS.
> 
> I start the kernel with the following command:
> go . nfsroot=192.168.1.1/mnt/danube_rootfs ip=192.168.1.4:192.168.1.1:::
> 
> The kernel starts up and I get the following output:
> 
> ***** BEGIN OUTPUT *****
> YAMON> go . nfsroot=192.168.1.1/mnt/danube_rootfs ip=192.168.1.4:192.168.1.1:::
> Linux version 2.6.22.1-default (danube@peng) (gcc version 3.3.6) #3 Tue Aug 7 18
> :59:37 CEST 2007
> 
> LINUX started...
> Config serial console: console=ttyS0,38400n8r
> CPU revision is: 00019640
> Determined physical RAM map:
> memory: 00001000 @ 00000000 (reserved)
> memory: 000ef000 @ 00001000 (ROM data)
> memory: 003cc000 @ 000f0000 (reserved)
> memory: 03b43000 @ 004bc000 (usable)
> Wasting 38784 bytes for tracking 1212 unused pages
> Initrd not found or empty - disabling initrd
> Built 1 zonelists.  Total pages: 16256
> Kernel command line: nfsroot=192.168.1.1/mnt/danube_rootfs ip=192.168.1.4:192.16
> 8.1.1::: console=ttyS0,38400n8r
> Primary instruction cache 64kB, physically tagged, 4-way, linesize 32 bytes.
> Primary data cache 64kB, 4-way, linesize 32 bytes.
> Synthesized TLB refill handler (20 instructions).
> Synthesized TLB load handler fastpath (32 instructions).
> Synthesized TLB store handler fastpath (32 instructions).
> Synthesized TLB modify handler fastpath (31 instructions).
> Cache parity protection disabled
> PID hash table entries: 256 (order: 8, 1024 bytes)
> CPU frequency 33.00 MHz
> Using 16.501 MHz high precision timer.
> console handover: boot [early0] -> real [ttyS0]
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 60096k/60684k available (2684k kernel code, 572k reserved, 695k data, 15
> 6k init, 0k highmem)
> Security Framework v1.0.0 initialized
> Mount-cache hash table entries: 512
> NET: Registered protocol family 16
> SCSI subsystem initialized
> Time: MIPS clocksource has been installed.
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 2048 (order: 2, 16384 bytes)
> TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> TCP reno registered
> audit: initializing netlink socket (disabled)
> audit(1186573381.443:1): initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> rtc: SRM (post-2000) epoch (2000) detected
> Real Time Clock Driver v1.12ac
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> mice: PS/2 mouse device common for all mice
> atkbd.c: keyboard reset failed on isa0060/serio0
> atkbd.c: keyboard reset failed on isa0060/serio1
> oprofile: using mips/24K performance monitoring.
> NET: Registered protocol family 1
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> VFS: Cannot open root device "<NULL>" or unknown-block(0,0)
> Please append a correct "root=" boot option; here are the available partitions:
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> ***** END OUTPUT *****
> 
> 
> 
> I am sure that all my NFS settings are correct since I have another
> board which is working fine with that server. Does anyone know how to
> boot the board over NFS?
> 
> Best regards,
> 
> 
