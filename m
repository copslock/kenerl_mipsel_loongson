Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2006 19:35:20 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:19212 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133612AbWEKRfJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 May 2006 19:35:09 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 9906564D54; Thu, 11 May 2006 17:34:08 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id EDA5366F5C; Thu, 11 May 2006 19:33:50 +0200 (CEST)
Date:	Thu, 11 May 2006 19:33:50 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Karel van Houten <Karel@vhouten.xs4all.nl>, macro@linux-mips.org
Cc:	debian-mips@lists.debian.org, linux-mips@linux-mips.org
Subject: Re: 2.6 for DECstation, d-i
Message-ID: <20060511173350.GM7827@deprecation.cyrius.com>
References: <44635C0D.7040901@vhouten.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44635C0D.7040901@vhouten.xs4all.nl>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Karel van Houten <Karel@vhouten.xs4all.nl> [2006-05-11 17:45]:
>    * You don't seem to have included the DEC serial drivers and console
>      support for the /260, because after the prom-io I loose all output
>      on the serial line (my /260 has serial console only).

Zilog Z8530 support for DECstation hasn't been ported to 2.6 yet.

>    * When I let it boot without console, it will happily go multiuser.
>      See boot messages below.
>    * My second SCSI card does not seem to work as it should. Works OK
>      under 2.4.27.

Maciej, do you have any idea?

kernel log:
> Linux version 2.6.16-1-sb1-bcm91250a (Debian 2.6.16-12) 
> (waldi@debian.org) (gcc version 4.0.3 20051201 (prerelease) (Debian 
> 4.0.2-5)) #2 Tue May 9 21:11:55 UTC 2006
> This is a DECstation 5000/2x0
> CPU revision is: 00000440
> FPU revision is: 00000500
> Determined physical RAM map:
> memory: 10000000 @ 00000000 (usable)
> On node 0 totalpages: 65536
>  DMA zone: 65536 pages, LIFO batch:15
>  DMA32 zone: 0 pages, LIFO batch:0
>  Normal zone: 0 pages, LIFO batch:0
>  HighMem zone: 0 pages, LIFO batch:0
> Built 1 zonelists
> Kernel command line: root=/dev/sda1 console=ttyS2
> Primary instruction cache 16kB, physically tagged, direct mapped, 
> linesize 16 bytes.
> Primary data cache 16kB, direct mapped, linesize 16 bytes.
> Unified secondary cache 1024kB direct mapped, linesize 32 bytes.
> Synthesized TLB refill handler (21 instructions).
> Synthesized TLB load handler fastpath (33 instructions).
> Synthesized TLB store handler fastpath (33 instructions).
> Synthesized TLB modify handler fastpath (32 instructions).
> PID hash table entries: 2048 (order: 11, 32768 bytes)
> Using 59.999 MHz high precision timer.
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Memory: 256224k/262144k available (2270k kernel code, 5716k reserved, 
> 414k data, 136k init, 0k highmem)
> Calibrating delay loop... 59.86 BogoMIPS (lpj=233472)
> Security Framework v1.0.0 initialized
> SELinux:  Disabled at boot.
> Capability LSM initialized
> Mount-cache hash table entries: 512
> Checking for 'wait' instruction...  unavailable.
> NET: Registered protocol family 16
> SCSI subsystem initialized
> TURBOchannel rev. 1 at 25.0 MHz (without parity)
>    slot 1: DEC      PMAZ-AA  V5.3d
> audit: initializing netlink socket (disabled)
> audit(1147360779.414:1): initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Initializing Cryptographic API
> io scheduler noop registered (default)
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> rtc: I/O port 530579456 is not free.
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> declance.c: v0.009 by Linux MIPS DECstation task force
> declance0: IOASIC onboard LANCE, addr = 08:00:2b:37:63:76, irq = 16
> declance0: registered as eth0.
> SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
> SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
> ESP: Total of 2 ESP hosts found, 2 actually in use.
> scsi0 : ESP236 (NCR53C9x)
> esp0: hoping for msgout
>  Vendor: COMPAQ    Model: ST34371N          Rev: 0388
>  Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi1 : ESP236 (NCR53C9x)
> esp1: hoping for msgout
>  Vendor: COMPAQ    Model: ST34371N          Rev: 0682
>  Type:   Direct-Access                      ANSI SCSI revision: 02
> esp1: hoping for msgout
>  Vendor: COMPAQ    Model: ST34371N          Rev: 0388
>  Type:   Direct-Access                      ANSI SCSI revision: 02
> esp1: hoping for msgout
>  Vendor: COMPAQ    Model: ST34371N          Rev: 0388
>  Type:   Direct-Access                      ANSI SCSI revision: 02
> esp1: hoping for msgout
>  Vendor: COMPAQ    Model: ST34371N          Rev: 0388
>  Type:   Direct-Access                      ANSI SCSI revision: 02
> esp1: hoping for msgout
>  Vendor: COMPAQ    Model: ST34371N          Rev: 0682
>  Type:   Direct-Access                      ANSI SCSI revision: 02
>  Vendor: SONY      Model: CD-ROM CDU-55S    Rev: 1.0t
>  Type:   CD-ROM                             ANSI SCSI revision: 02
> SCSI device sda: 8386000 512-byte hdwr sectors (4294 MB)
> sda: Write Protect is off
> sda: Mode Sense: c7 00 10 08
> SCSI device sda: drive cache: write through w/ FUA
> SCSI device sda: 8386000 512-byte hdwr sectors (4294 MB)
> sda: Write Protect is off
> sda: Mode Sense: c7 00 10 08
> SCSI device sda: drive cache: write through w/ FUA
> sda: sda1 sda2 < sda5 >
> sd 0:0:0:0: Attached scsi disk sda
> esp1: Warning, live target 0 not responding to selection.
> esp1: Resetting scsi bus
> esp1: SCSI bus reset interrupt
> esp1: SCSI bus reset interrupt
> esp1: hoping for msgout
> sd 1:0:0:0: scsi: Device offlined - not ready after error recovery
> sd 1:0:0:0: rejecting I/O to offline device
> sd 1:0:0:0: rejecting I/O to offline device
> sd 1:0:0:0: rejecting I/O to offline device
> sd 1:0:0:0: rejecting I/O to offline device
> sdb : READ CAPACITY failed.
> sdb : status=0, message=00, host=1, driver=00
> sdb : sense not available.
> sd 1:0:0:0: rejecting I/O to offline device
> sdb: Write Protect is off
> sdb: Mode Sense: 00 00 00 00
> sd 1:0:0:0: rejecting I/O to offline device
> sdb: asking for cache data failed
> sdb: assuming drive cache: write through
> sd 1:0:0:0: Attached scsi disk sdb
> esp1: hoping for msgout
> esp1: Warning, live target 1 not responding to selection.
> esp1: Resetting scsi bus
> esp1: SCSI bus reset interrupt
> esp1: SCSI bus reset interrupt
> esp1: hoping for msgout
> sd 1:0:1:0: scsi: Device offlined - not ready after error recovery
> sd 1:0:1:0: rejecting I/O to offline device
> sd 1:0:1:0: rejecting I/O to offline device
> sd 1:0:1:0: rejecting I/O to offline device
> sd 1:0:1:0: rejecting I/O to offline device
> sdc : READ CAPACITY failed.
> sdc : status=0, message=00, host=1, driver=00
> sdc : sense not available.
> sd 1:0:1:0: rejecting I/O to offline device
> sdc: Write Protect is off
> sdc: Mode Sense: 00 00 00 00
> sd 1:0:1:0: rejecting I/O to offline device
> sdc: asking for cache data failed
> sdc: assuming drive cache: write through
> sd 1:0:1:0: Attached scsi disk sdc
> esp1: hoping for msgout
> esp1: Warning, live target 2 not responding to selection.
> esp1: Resetting scsi bus
> esp1: SCSI bus reset interrupt
> esp1: SCSI bus reset interrupt
> esp1: hoping for msgout
> sd 1:0:2:0: scsi: Device offlined - not ready after error recovery
> sd 1:0:2:0: rejecting I/O to offline device
> sd 1:0:2:0: rejecting I/O to offline device
> sd 1:0:2:0: rejecting I/O to offline device
> sd 1:0:2:0: rejecting I/O to offline device
> sdd : READ CAPACITY failed.
> sdd : status=0, message=00, host=1, driver=00
> sdd : sense not available.
> sd 1:0:2:0: rejecting I/O to offline device
> sdd: Write Protect is off
> sdd: Mode Sense: 00 00 00 00
> sd 1:0:2:0: rejecting I/O to offline device
> sdd: asking for cache data failed
> sdd: assuming drive cache: write through
> sd 1:0:2:0: Attached scsi disk sdd
> esp1: hoping for msgout
> esp1: Warning, live target 3 not responding to selection.
> esp1: Resetting scsi bus
> esp1: SCSI bus reset interrupt
> esp1: SCSI bus reset interrupt
> esp1: hoping for msgout
> sd 1:0:3:0: scsi: Device offlined - not ready after error recovery
> sd 1:0:3:0: rejecting I/O to offline device
> sd 1:0:3:0: rejecting I/O to offline device
> sd 1:0:3:0: rejecting I/O to offline device
> sd 1:0:3:0: rejecting I/O to offline device
> sde : READ CAPACITY failed.
> sde : status=0, message=00, host=1, driver=00
> sde : sense not available.
> sd 1:0:3:0: rejecting I/O to offline device
> sde: Write Protect is off
> sde: Mode Sense: 00 00 00 00
> sd 1:0:3:0: rejecting I/O to offline device
> sde: asking for cache data failed
> sde: assuming drive cache: write through
> sd 1:0:3:0: Attached scsi disk sde
> esp1: hoping for msgout
> esp1: Warning, live target 5 not responding to selection.
> esp1: Resetting scsi bus
> esp1: SCSI bus reset interrupt
> esp1: SCSI bus reset interrupt
> esp1: hoping for msgout
> sd 1:0:5:0: scsi: Device offlined - not ready after error recovery
> sd 1:0:5:0: rejecting I/O to offline device
> sd 1:0:5:0: rejecting I/O to offline device
> sd 1:0:5:0: rejecting I/O to offline device
> sd 1:0:5:0: rejecting I/O to offline device
> sdf : READ CAPACITY failed.
> sdf : status=0, message=00, host=1, driver=00
> sdf : sense not available.
> sd 1:0:5:0: rejecting I/O to offline device
> sdf: Write Protect is off
> sdf: Mode Sense: 00 00 00 00
> sd 1:0:5:0: rejecting I/O to offline device
> sdf: asking for cache data failed
> sdf: assuming drive cache: write through
> sd 1:0:5:0: Attached scsi disk sdf
> NET: Registered protocol family 2
> IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
> TCP established hash table entries: 16384 (order: 4, 65536 bytes)
> TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
> TCP: Hash tables configured (established 16384 bind 16384)
> TCP reno registered
> TCP bic registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused PROM memory: 124k freed
> Freeing unused kernel memory: 260k freed
> Warning: unable to open an initial console.
> Adding 208804k swap on /dev/sda5.  Priority:-1 extents:1 across:208804k
> EXT3 FS on sda1, internal journal
> 

-- 
Martin Michlmayr
http://www.cyrius.com/
