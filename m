Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB8EGPp12447
	for linux-mips-outgoing; Sat, 8 Dec 2001 06:16:25 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB8EGHo12444
	for <linux-mips@oss.sgi.com>; Sat, 8 Dec 2001 06:16:17 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA02743;
	Sat, 8 Dec 2001 05:16:09 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id FAA00576;
	Sat, 8 Dec 2001 05:16:06 -0800 (PST)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fB8DG0A12249;
	Sat, 8 Dec 2001 14:16:01 +0100 (MET)
Message-ID: <3C121382.1DE7CA05@mips.com>
Date: Sat, 08 Dec 2001 14:20:02 +0100
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: balaji.ramalingam@philips.com
CC: linux-mips@oss.sgi.com
Subject: Re: not getting the kernel prompt
References: <OFBC8C65B4.81E473E6-ON08256B1B.006A7240@diamond.philips.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

balaji.ramalingam@philips.com wrote:

> Hello,
>
> I had been trying to get the linux kernel 2.4.3 on our
> latest mips core which is mips32 ISA complient.
>
> Finally I was able to boot the kernel after facing a lot of
> issues. But I was not able to get a  kernel prompt.
> I got the below messages
>
> ##########################################################################################
>
> Detected 32MB of memory
> Loading MIPS32 MMU routines.
> CPU revision is: 00061200
> Primary instruction cache 16kb, linesize 32 bytes (2 ways)
> Primary data cache 16kb, linesize 32 bytes (4 ways)
> Number of TLB entries 32.
> Linux version 2.4.3-MIPS-01.01 (ramaling@svlhp106.sv.sc.philips.com) (gcc version 3.0 2001042
> 2 (prerelease)) #11 Wed Nov 28 19:45:33 PST 2001
> Determined physical RAM map:
>  memory: 02000000 @ 00000000 (usable)
> Initial ramdisk at: 0x8010e000 (1916920 bytes)
> On node 0 totalpages: 8192
> zone(0): 8192 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/ram rw console=ttyS0
> calculating viper_offset... 00001200(4608)
> CPU frequency in quickturn 0.46 MHz
> Memory: 29184k/32768k available (603k kernel code, 3584k reserved, 1923k data, 36k init)
> Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Checking for 'wait' instruction...  available.
> POSIX conformance testing by UNIFIX
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> block: queued sectors max/low 19333kB/6444kB, 64 slots per queue
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> RAMDISK: Compressed image found at block 0
> crc errorFreeing initrd memory:  1871k freed

You get a CRC error from the ramdisk images.
It look like you need to increase the configuration setting of your ramdisk.
Try set CONFIG_BLK_DEV_RAM_SIZE to 18432.

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
>
> I'm using the ttyS00 device (COM1) for both printing the debug messages as well
> as getting the kernel prompt. I dont know where I'm messing up.
>
> PLEASE give me some tips.
> Any help would be greatly appreciated.
>
> regards,
> Balaji
>
> Finished kernel_thread; Going to do unlock and cpu_idle
>
> Linux NET4.0 for Linux 2.4
