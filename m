Received:  by oss.sgi.com id <S553691AbRBGU3P>;
	Wed, 7 Feb 2001 12:29:15 -0800
Received: from mail.ivm.net ([62.204.1.4]:25656 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553696AbRBGU3O>;
	Wed, 7 Feb 2001 12:29:14 -0800
Received: from franz.no.dom (port162.duesseldorf.ivm.de [195.247.65.162])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id VAA08757;
	Wed, 7 Feb 2001 21:28:56 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.010207212905.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010203212356.C24513@stav.org.il>
Date:   Wed, 07 Feb 2001 21:29:05 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Adi Stav <stav@actcom.co.il>
Subject: RE: Progress with Linux on O2?
Cc:     linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 03-Feb-01 Adi Stav wrote:
> I have an O2 and would very much like to run Linux on it. I was
> looking for information on Linux on O2 but could not find any -- I
> understand that there is no such usable port yet, but I was wondering
> if someone could refer me to anyone working on it, or to work that has
> been done already, so that I could follow the progress or maybe help a
> bit. Or has no such work been done yet?

Status:

> hinv
                   System: IP32
                Processor: 180 Mhz R5000, with FPU
     Primary I-cache size: 32 Kbytes
     Primary D-cache size: 32 Kbytes
     Secondary cache size: 512 Kbytes
              Memory size: 128 Mbytes
                 Graphics: CRM, Rev C
                    Audio: A3 version 1
                SCSI Disk: scsi(0)disk(1)
               SCSI CDROM: scsi(0)cdrom(4)
> boot bootp()/vmlinux root=/dev/ram
130768+22320+3184+341792+48560d+4604+6816 entry: 0x87fa60d0
Setting $netaddr to 192.168.0.7 (from server intel)
Obtaining /vmlinux from server intel
934384+117828 entry: 0x800025a8
ARCH: SGI-IP32
PROMLIB: ARC firmware Version 1 Revision 10
Loading R4000 MMU routines.
CPU revision is: 00002321
Primary instruction cache 32kb, linesize 32 bytes.
Primary data cache 32kb, linesize 32 bytes.
Secondary cache 512kb, linesize 32 bytes.
R5000 with secondary cache detected, disabling secondary cache
Linux version 2.4.1 (harry@intel) (gcc version egcs-2.91.66 19990314
(egcs-1.1.2 release)) #14 Mit Feb 7 20:44:38 CET 2001
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 00101000 @ 00002000 (reserved)
 memory: 00c4d000 @ 00103000 (usable)
 memory: 002b0000 @ 00d50000 (ROM data)
 memory: 00100000 @ 01000000 (reserved)
 memory: 00300000 @ 01100000 (ROM data)
 memory: 06b86000 @ 01400000 (usable)
 memory: 0007a000 @ 07f86000 (reserved)
On node 0 totalpages: 32646
zone(0): 32646 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram
Calibrating delay loop... 179.40 BogoMIPS
Memory: 120516k/122700k available (693k kernel code, 2184k reserved, 44k data,
172k init)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Checking for 'wait' instruction...  available.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
block: queued sectors max/low 80042kB/26680kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
RAMDISK: Compressed image found at block 0
Serial driver version 5.02 (2000-08-09) with SHARE_IRQ enabled
ttyS00 at 0x0000 (irq = 14) is a 16550A
VFS: Mounted root (ext2 filesystem).
Freeing prom memory: 5824kb freed
Freeing unused kernel memory: 172k freed
Stand-alone shell (version 2.1)
> -mount -t proc none /proc
> -dd if=/proc/cpuinfo of=/dev/console
cpu                     : MIPS
cpu model               : R5000 V2.1
system type             : SGI O2
BogoMIPS                : 179.40
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : yes
microsecond timers      : yes
extra interrupt vector  : no
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available
0+1 records in
0+1 records out
> -dd if=/proc/uptime of=/dev/console
442.60 442.29
0+1 records in
0+1 records out
> -dd if=/proc/interrupts of=/dev/console
 0:    97396 + timer
14:      242   serial
0+1 records in
0+1 records out
> 

Please note that PCI support is non-existing. The timer interrupt is
realised with CP0 count/compare, the second level cache is disabled, and the
only device working is the serial console.

-- 
Regards,
Harald
