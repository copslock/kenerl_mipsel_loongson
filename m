Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7Kee822383
	for linux-mips-outgoing; Fri, 7 Dec 2001 12:40:40 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7Keco22376
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 12:40:38 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fB7JeM6n012583;
	Fri, 7 Dec 2001 11:40:22 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fB7JeKMZ012575;
	Fri, 7 Dec 2001 11:40:21 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Fri, 7 Dec 2001 11:40:18 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: balaji.ramalingam@philips.com
cc: linux-mips@oss.sgi.com
Subject: Re: not getting the kernel prompt
In-Reply-To: <OFBC8C65B4.81E473E6-ON08256B1B.006A7240@diamond.philips.com>
Message-ID: <Pine.LNX.4.10.10112071139380.2763-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> RAMDISK: Compressed image found at block 0
> crc errorFreeing initrd memory:  1871k freed
> VFS:  Mounted root (ext2 filesystem) .
> Freeing unused kernel memory:  36k freed
> Warning:  unable to open an initial console.
> attempt to access beyond end of device
> 01:00: rw=0, want=7771, limit=4096
> 
> ##########################################################################################
> 
> I played around the ramdisk image and made sure that the /etc has fstab file
> with /dev/ram entry in it. Also there is a inittab file with /sbin/agetty entry to take
> care of the console ttyS0.

Do you have a /dev/console on that ramdisk?
