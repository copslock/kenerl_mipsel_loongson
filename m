Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f858q6O16908
	for linux-mips-outgoing; Wed, 5 Sep 2001 01:52:06 -0700
Received: from storm.physik.tu-cottbus.de (storm.physik.TU-Cottbus.De [141.43.75.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f858q0d16902
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 01:52:00 -0700
Received: by storm.physik.tu-cottbus.de (Postfix, from userid 7215)
	id 499886004D; Wed,  5 Sep 2001 10:51:55 +0200 (CEST)
Date: Wed, 5 Sep 2001 10:51:55 +0200
To: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: ramdisk support failing
Message-ID: <20010905105154.C2477@physik.tu-cottbus.de>
Mail-Followup-To: heinold@physik.tu-cottbus.de,
	"'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
References: <DC10067A2F4A5944B7811FCF59ABB114744FA1@sjc2exm01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC10067A2F4A5944B7811FCF59ABB114744FA1@sjc2exm01>
User-Agent: Mutt/1.3.20i
From: heinold@physik.tu-cottbus.de (H.Heinold)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Sep 04, 2001 at 07:17:32PM -0700, Manoj Ekbote wrote:
> Hi,
> 
> I am trying to load a kernel with ramdisk support linked in it. It is a 2.4.5 kernel, ported for Ocelot board running a PMC RM7000 chip.
> The kernel hangs while trying to load the "init" process. The "init" is actually the sash program. I have placed the init in /sbin, /sbin and /etc.The "execve" in setup.c returns ENOEXEC while running /sbin/init. The CONFIG_BINFMT_ELF is set in the .config file.
> The init has the x attribute.
> 
> Here's the output:
> 
> >g root=/dev/ram
> ...........
> ...........
> Initial ramdisk at: 0x80285000 (1161262 bytes)
> ...........
> 
> POSIX conformance testing by UNIFIX
> 
> Linux NET4.0 for Linux 2.4
> 
> Based upon Swansea University Computer Society NET3.039
> 
> Initializing RT netlink socket
> 
> Starting kswapd v1.8
> 
> pty: 256 Unix98 ptys configured
> 
> Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> 
> ttyS00 at 0x0000 (irq = 4) is a ST16650
> 
> block: queued sectors max/low 83088kB/27696kB, 256 slots per queue
> 
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> 
> SCSI subsystem driver Revision: 1.00
> 
> NET4: Linux TCP/IP 1.0 for NET4.0
> 
> IP Protocols: ICMP, UDP, TCP, IGMP
> 
> IP: routing cache hash table of 1024 buckets, 8Kbytes
> 
> TCP: Hash tables configured (established 8192 bind 16384)
> 
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> 
> RAMDISK: Compressed image found at block 0
> 
> Freeing initrd memory: 1134k freed
> 
> EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
> 
> VFS: Mounted root (ext2 filesystem).
> 
> Freeing unused kernel memory: 72k freed
> 
> /sbin/init failed..8           <------ ENOEXEC returned by execve("init")
> 
> etc/init failed...14
> 
> /bin/init failed...14
> 
> Kernel panic: No init found.  Try passing init= option to kernel.
> 
> 
> Any ideas?
> Manoj
> 

Yep,

the ramdisk support is broken. But thats not new and til now nobody fixed it.
Only on mipsel it is fixed partly. There the ramdisk is linkend in the compile
prozess of the kernel.


-- 


Henning
