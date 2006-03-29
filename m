Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 16:37:03 +0100 (BST)
Received: from baldrick.bootc.net ([83.142.228.48]:23017 "EHLO
	baldrick.bootc.net") by ftp.linux-mips.org with ESMTP
	id S8133764AbWC2Pgv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Mar 2006 16:36:51 +0100
Received: from [192.168.1.6] (cpc3-hudd6-0-0-cust471.hudd.cable.ntl.com [86.3.1.216])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	by baldrick.bootc.net (Postfix) with ESMTP id C6B481400BE9;
	Wed, 29 Mar 2006 16:47:24 +0100 (BST)
In-Reply-To: <20060328235827.GC31939@networkno.de>
References: <44299EE6.7010309@bootc.net> <20060328235827.GC31939@networkno.de>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <671FD00E-F2EB-4D8C-A391-5393096BC43D@bootc.net>
Cc:	linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Chris Boot <bootc@bootc.net>
Subject: Re: Emulating MIPS -- please help!
Date:	Wed, 29 Mar 2006 16:47:23 +0100
To:	Thiemo Seufer <ths@networkno.de>
X-Mailer: Apple Mail (2.746.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bootc.plus.com
Return-Path: <bootc@bootc.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bootc@bootc.net
Precedence: bulk
X-list: linux-mips

Hi there,

On 29 Mar 2006, at 00:58, Thiemo Seufer wrote:

> On Tue, Mar 28, 2006 at 09:39:02PM +0100, Chris Boot wrote:
>> Hi all,
>>
>> I'm desperately trying to get a MIPS emulator running Linux, and  
>> while
>> I've managed to get gxemul and (I think) qemu running, I can't for  
>> the
>> life of me get them to (1) output anything or (2) use an initrd.
>>
>> Can anyone post some instructions and, perhaps, a .config for  
>> 2.6.16 so
>> I can get some output like kernel boot messages and a login screen?
>>
>> I've got gxemul emulating code and running a kernel, which I can  
>> test by
>> stopping emulation and stepping the code. Qemu seems to boot my
>> qemu-specific kernel but I get no output and qemu appears to hang  
>> (won't
>> take keyboard input).
>
> VGA support for qemu isn't there yet, use -nographics to get the  
> serial
> console output.
>
>> I can't seem to get either emulator to load my
>> initrd, but that doesn't really matter at this stage since I can't  
>> see
>> anything anyway (I have no idea how to using gxemul, and qemu  
>> refuses to
>> load the image).
>
> Current qemu confuses virtual and physical adresses when loading  
> initrds,
> this and a bunch of other bugs are fixed in a set of patches I have.
> Note that these are work in progress, and may cause different bugs.
> Notably, the gcc4 support patch won't work on x86, and probably  
> only on
> powerpc. It has, however, emulated IDE support, I use a self-compiled
> qemu kernel and a Debian/mips image to boot from, no ramdisk. The
> patchset is available at
>
> http://people.debian.org/~ths/qemu-patches-bogus/
>
> Use at your own risk.

Thanks for all the help, I've now got a step further (I think) and  
get a few boot messages from 2.6.16, and it appears as though my  
initrd loads. However, it gets stuck early in the boot process:

bootc@arcadia nsfdb $ qemu-system-mips -kernel linux-2.6.16/arch/mips/ 
boot/vmlinux.bin -nographic -initrd buildroot/rootfs.mips.squashfs 
(qemu) mips_r4k_init: load BIOS '/usr/share/qemu/mips_bios.bin' size  
131072
Linux version 2.6.16 (bootc@arcadia) (gcc version 3.4.6) #9 Wed Mar  
29 16:35:35 BST 2006
CPU revision is: 00018000
Determined physical RAM map:
memory: 08000000 @ 00000000 (usable)
Built 1 zonelists
Kernel command line: console=ttyS0
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
Memory: 128480k/131072k available (907k kernel code, 2556k reserved,  
172k data, 96k init, 0k highmem)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.

At this stage it gets stuck and I have to kill qemu. Any ideas how to  
debug this? I've only applied the elf-loader patch since I was having  
trouble applying some of the others to my Ubuntu qemu 0.8.0.

Many thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
