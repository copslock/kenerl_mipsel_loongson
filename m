Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3LBAhqf003602
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 21 Apr 2002 04:10:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3LBAhUH003601
	for linux-mips-outgoing; Sun, 21 Apr 2002 04:10:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3LBAQqf003595
	for <linux-mips@oss.sgi.com>; Sun, 21 Apr 2002 04:10:27 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 0DFB98D35; Sun, 21 Apr 2002 13:10:51 +0200 (CEST)
Date: Sun, 21 Apr 2002 13:10:51 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Dani Eichhorn <dani.eichhorn@squix.ch>
Cc: linux-mips@oss.sgi.com
Subject: Re: Challenge S crashes configuring the base system
Message-ID: <20020421131051.A12044@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Dani Eichhorn <dani.eichhorn@squix.ch>,
	linux-mips@oss.sgi.com
References: <OBEHJEMLCCGNNEAACCLCAEAICCAA.dani.eichhorn@squix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OBEHJEMLCCGNNEAACCLCAEAICCAA.dani.eichhorn@squix.ch>; from dani.eichhorn@squix.ch on Fri, Apr 19, 2002 at 07:57:48PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Apr 19, 2002 at 07:57:48PM +0200, Dani Eichhorn wrote:
> Hi!
> 
> I really hope anyone can help me out of this.
> I've got a SGI Challenge S 180 MHz. First I did set up NetBsd on it and it
> worked fine, but because the lack of software I decided to install Linux.
> The installation process didn't cause any troubles, but during the first
> boot (and every boot afterwards) the Challenge restarts/crashes during
> configuring the base system. This is the output of the boot sequence:
> 
> 2027520+0+95120 entry: 0x8800246c
> ARCH: SGI-IP22
> PROMLIB: ARC firmware Version 1 Revision 10
> CPU: MIPS-R5000 FPU<MIPS-R5000FPC> ICACHE DCACHE SCACHE
> CPU revision is: 00002310
> FPU revision is: 00002310
> Primary instruction cache 32kb, linesize 32 bytes.
> Primary data cache 32kb, linesize 32 bytes.
> TLB has 48 entries.
> Linux version 2.4.16 (root@nocontrol) (gcc version 2.95.4 20011006 (Debian
> prere
> lease)) #1 Sun Dec 16 16:38:44 CET 2001
> MC: SGI memory controller Revision 3
> R4600/R5000 SCACHE size 512K, linesize 32 bytes.
> Determined physical RAM map:
>  memory: 00001000 @ 00000000 (reserved)
>  memory: 00001000 @ 00001000 (reserved)
>  memory: 00207000 @ 08002000 (reserved)
>  memory: 00537000 @ 08209000 (usable)
>  memory: 000c0000 @ 08740000 (ROM data)
>  memory: 07800000 @ 08800000 (usable)
> On node 0 totalpages: 65536
> zone(0): 65536 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/sda1
> Calibrating system timer... 900000 [180.00 MHz CPU]
> zs0: console input
> Console: ttyS0 (Zilog8530), 9600 baud
> Calibrating delay loop... 179.81 BogoMIPS
> Memory: 124104k/128220k available (1732k kernel code, 4116k reserved, 157k
> data,
>  84k init)
> Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Checking for 'wait' instruction...  available.
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> VFS: Diskquotas version dquot_6.4.0 initialized
> Journalled Block Device driver loaded
> initialize_kbd: Keyboard reset failed, no ACK
> pty: 256 Unix98 ptys configured
> keyboard: Timeout - AT keyboard not present?(ed)
> keyboard: Timeout - AT keyboard not present?(f4)
> DS1286 Real Time Clock Driver v1.0
> streamable misc devices registered (keyb:150, gfx:148)
> block: 128 slots per queue, batch=32
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> sgiseeq.c: David S. Miller (dm@engr.sgi.com)
> eth0: SGI Seeq8003 08:00:69:0a:1f:8b
> loop: loaded (max 8 devices)
> SCSI subsystem driver Revision: 1.00
> wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
>            setup_args=,,,,,,,,,
>            Version 1.25 - 09/Jul/1997, Compiled Dec 16 2001 at 16:56:27
> scsi0 : SGI WD93
>  sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST15150N
>  Rev: 0020
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Attached scsi disk sda at scsi0, channel 0, id 2, lun 0
> SCSI device sda: 8388315 512-byte hdwr sectors (4295 MB)
> Partition check:
>  sda: sda1 sda2 sda3 sda4
> SGI Zilog8530 serial driver version 1.00
> tty00 at 0xbfbd9830 (irq = 29) is a Zilog8530
> tty01 at 0xbfbd9838 (irq = 29) is a Zilog8530
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 16384)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> EXT3-fs: INFO: recovery required on readonly filesystem.
> EXT3-fs: write access will be enabled during recovery.
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: recovery complete.
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing prom memory: 768kb freed
> Freeing unused kernel memory: 84k freed
> INIT: version 2.84 booting
> Activating swap.
> Adding Swap: 66280k swap-space (priority -1)
> Checking root file system...
> fsck 1.27 (8-Mar-2002)
> /dev/sda1: clean, 7735/502944 files, 46723/1004970 blocks
> EXT3 FS 2.4-0.9.15, 06 Nov 2001 on sd(8,1), internal journal
> System time was Fri Apr 19 17:40:52 UTC 2002.
> Setting the System Clock using the Hardware Clock as reference...
> System Clock set. System local time is now Fri Apr 19 17:40:55 UTC 2002.
> Calculating module dependencies... done.
> Loading modules: sg
> Checking all file systems...
> fsck 1.27 (8-Mar-2002)
> Setting kernel variables.
> Mounting local filesystems...
> nothing was mounted
> Running 0dns-down to make sure resolv.conf is ok...done.
> Cleaning: /etc/network/ifstate.
> Setting up IP spoofing protection: rp_filter.
> Configuring network interfaces: done.
> 
> Setting the System Clock using the Hardware Clock as reference...
> System Clock set. Local time: Fri Apr 19 17:41:05 UTC 2002
> 
> Cleaning: /tmp /var/lock /var/run.
> Initializing random number generator... done.
> Recovering nvi editor sessions... done.
> INIT: Entering runlevel: 2
> Starting system log daemon: syslogd.
> Starting kernel log daemon: klogd.
> Starting internet superserver: inetd.
> Starting deferred execution scheduler: atd.
> Starting periodic command scheduler: cron.
> Configuring the base system...
It doesn't really "crash". The porblem is that the installer doesn't
correctly detect the serial console and therefore displays everything on
tty1 not ttyS0. Boot with /bin/bash as init (use "boot init=/bin/bash"
in the PROM) and edit /etc/inittab. Look for lines containing "base-config".
Are you using recent boot-floppies(3.0.22)? If so, please file a
bugreport.
 -- Guido
