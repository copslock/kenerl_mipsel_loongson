Received:  by oss.sgi.com id <S42185AbQHGM1S>;
	Mon, 7 Aug 2000 05:27:18 -0700
Received: from jarre.otscorp.com ([203.44.145.48]:43785 "EHLO shorts.cx")
	by oss.sgi.com with ESMTP id <S42183AbQHGM0q>;
	Mon, 7 Aug 2000 05:26:46 -0700
Received: from jarre.house (ndf@jarre.house [192.168.10.1])
	by shorts.cx (8.11.0/8.11.0) with ESMTP id e77CShG09064
	for <linux-mips@oss.sgi.com>; Mon, 7 Aug 2000 22:28:43 +1000
Date:   Mon, 7 Aug 2000 22:27:03 +1000 (EST)
From:   Nathan Fraser <ndf@shorts.cx>
X-Sender: ndf@jarre.house
To:     linux-mips@oss.sgi.com
Subject: Re: [Install trouble] : mount failed: bad address
Message-ID: <Pine.LNX.4.20.0008072030210.4379-100000@jarre.house>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

....
>> creating 100k of ramdisk space... done
>> mounting /tmp from ramdisk... failed
>> 
>> I can't recover from this.
>> <<<<<<<

> Probably this is a kernel with no ramdisk support ?  Ah wait - No - 
> You have booted the kernel with a read-only root - Which means - When
> mounting /tmp i tries to write /etc/mtab which is read-only - Try
> to append "rw" to your prom console boot line

I just tried installing with vmlinux-000804-IP22-4400 and
hardhat-sgi-5.1.tar.gz - i get the same error as soon as the drive is
formatted and is mounted (ie: mount failed: bad address)

my boot command was (minor variations of):

boot bootp():/vmlinux root=/dev/nfs rw /home/tftboot/mipseb

The root fs is mounted via nfs ok read-write which i verified by writing a
file to it.. As far as i can tell the redhat installer is all working ok..
it just can't mount the newly formatted partition (or even an irix
formatted efs partition).

Is there a 'better' kernel to use to get the base system installed? Or am
i making some sort of stoopid installation mistake? The kernel that came
in the hardhat tarball failed with:

Looking up port of RPC 100003/2 on 192.168.10.30
page fault from irq

then locked up toally :( Sometimes it would not even print the 'q'.

The nfs is being served from a pc with slackware 7 / linux 2.2.16 / dhcp
2.0 / nfs: Universal NFS Server 2.2beta47. oh yeah.. and setenv netaddr 0
prior to boot... was a big help :)

I was trying to install to the second hard drive: /dev/sdb1 (under linux). 

my hinv:

Iris Audio Processor: version A2 revision 4.1.0
1 200 MHZ IP22 Processor
FPU: MIPS R4010 Floating Point Chip Revision: 0.0
CPU: MIPS R4400 Processor Chip Revision: 6.0
On-board serial ports: 2
On-board bi-directional parallel port
Data cache size: 16 Kbytes
Instruction cache size: 16 Kbytes
Secondary unified instruction/data cache size: 1 Mbyte
Main memory size: 128 Mbytes
Integral ISDN: Basic Rate Interface unit 0, revision 1.0
Integral Ethernet: ec0, version 1
Integral SCSI controller 0: Version WD33C93B, revision D
Disk drive: unit 2 on SCSI controller 0
Disk drive: unit 1 on SCSI controller 0
Graphics board: Indy 24-bit
Vino video: unit 0, revision 0, IndyCam connected

Any pointers would be greatly appreciated! 
