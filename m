Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 13:38:21 +0100 (BST)
Received: from baldrick.bootc.net ([83.142.228.48]:43421 "EHLO
	baldrick.bootc.net") by ftp.linux-mips.org with ESMTP
	id S8133380AbWC3MiL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Mar 2006 13:38:11 +0100
Received: from [192.168.1.6] (cpc3-hudd6-0-0-cust471.hudd.cable.ntl.com [86.3.1.216])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by baldrick.bootc.net (Postfix) with ESMTP id DB1481400BE9;
	Thu, 30 Mar 2006 13:48:48 +0100 (BST)
In-Reply-To: <20060330080746.GM31939@networkno.de>
References: <44299EE6.7010309@bootc.net> <20060328235827.GC31939@networkno.de> <671FD00E-F2EB-4D8C-A391-5393096BC43D@bootc.net> <20060329160337.GI31939@networkno.de> <E9A44E96-DD59-4543-AC62-586BFDB6E720@bootc.net> <20060330061950.GA29489@domen.ultra.si> <20060330080746.GM31939@networkno.de>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <14615E6C-4AD5-4760-91EE-3DCFB42BFACA@bootc.net>
Cc:	Domen Puncer <domen.puncer@ultra.si>, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Chris Boot <bootc@bootc.net>
Subject: Re: Emulating MIPS -- please help!
Date:	Thu, 30 Mar 2006 13:48:45 +0100
To:	Thiemo Seufer <ths@networkno.de>
X-Mailer: Apple Mail (2.746.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bootc.plus.com
Return-Path: <bootc@bootc.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bootc@bootc.net
Precedence: bulk
X-list: linux-mips


On 30 Mar 2006, at 09:07, Thiemo Seufer wrote:

>>> Well, I added a few more patches and it finally boots now, but it
>>> can't mount the root FS off the RAMDISK. I'm not sure if this is a
>>> side-effect of the previous initrd problem or what, but it feels  
>>> good
>>> to be getting further...
>>
>> I was unable to boot userspace from initrd too. It was loaded to the
>> wrong address or something. "Fixing" that didn't work either.
>
> It gets loaded to 0x80800000, feeding rd_start/rd_size derived from
> that address as kernel parameters should work.

That does the trick! Thank you so much!

That made my day. Now for a few little fixups and my experiment is a  
success.

Chris

Boot messages:

bootc@arcadia nsfdb $ qemu-system-mips -kernel linux-2.6.16/arch/mips/ 
boot/vmlinux.bin -nographic -initrd buildroot/rootfs.mips.squashfs - 
append "rd_start=0x80800000 rd_size=495616 console=ttyS0"
(qemu) mips_r4k_init: load BIOS '/usr/share/qemu/mips_bios.bin' size  
131072
Linux version 2.6.16 (bootc@arcadia) (gcc version 3.4.6) #9 Wed Mar  
29 16:35:35 BST 2006
CPU revision is: 00018000
Determined physical RAM map:
memory: 08000000 @ 00000000 (usable)
Initial ramdisk at: 0x80800000 (495616 bytes)
Built 1 zonelists
Kernel command line: rd_start=0x80800000 rd_size=495616 console=ttyS0
Primary instruction cache 2kB, physically tagged, 2-way, linesize 16  
bytes.
Primary data cache 2kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (19 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (30 instructions).
PID hash table entries: 1024 (order: 10, 16384 bytes)
Using 100.000 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 121116k/131072k available (907k kernel code, 9920k reserved,  
172k data, 96k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
checking if image is initramfs...it isn't (bad gzip magic numbers);  
looks like an initrd
Freeing initrd memory: 484k freed
Squashfs 2.1-r2 (released 2004/12/15) (C) 2002-2004 Phillip Lougher
io scheduler noop registered (default)
Real Time Clock Driver v1.12ac
Software Watchdog Timer: 0.07 initialized. soft_noboot=0  
soft_margin=60 sec (nowayout= 0)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing  
disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16450
RAMDISK driver initialized: 1 RAM disks of 1024K size 1024 blocksize
RAMDISK: squashfs filesystem found at block 0
RAMDISK: Loading 482KiB [1 disk] into ram disk... done.
VFS: Mounted root (squashfs filesystem) readonly.
Freeing unused kernel memory: 96k freed
Initializing random number generator... rm: unable to remove `/etc/ 
random-seed': Read-only file system
urandom start: failed.
done.



Welcome to the Erik's uClibc development environment.

(none) login:

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
