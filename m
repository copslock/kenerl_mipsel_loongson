Received:  by oss.sgi.com id <S553861AbQJODDD>;
	Sat, 14 Oct 2000 20:03:03 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:8205 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553858AbQJODCk>;
	Sat, 14 Oct 2000 20:02:40 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 62D9B7F8; Sun, 15 Oct 2000 05:02:38 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 56F38900C; Sun, 15 Oct 2000 04:47:53 +0200 (CEST)
Date:   Sun, 15 Oct 2000 04:47:53 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: Re: delo 0.1 / Decstation Boot Loader
Message-ID: <20001015044752.A3817@paradigm.rfc822.org>
References: <20001014133502.A1685@paradigm.rfc822.org> <20001014200337.D1598@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001014200337.D1598@paradigm.rfc822.org>; from flo@rfc822.org on Sat, Oct 14, 2000 at 08:03:37PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 08:03:37PM +0200, Florian Lohoff wrote:
> Update
> 
> delo 0.2 is up and running

Next update - Delo 0.5 up and running 

I added MS-Dos Partition support that Delo can load from and partition
you select - Syntax for me is

boot 3/rz0 5/boot/vmlinux root=/dev/sda5 console=ttyS2

As you might guess - 5 is the partition number as in /dev/sda5. Currently
i do have the problem that the machine locks hard as soon as the kernel
spits out the Kernel Command Line and i am unsure if this is Kernel or
Bootloader related.

KN05 V2.1k    (PC: 0xa002cab8, SP: 0x83a4dde8)
3/prcache
>>boot 3/rz0 5/boot/vmlinux root=/dev/sda5 console=ttyS2
delo V0.3
Opening ext2fs on partition 5
Loading /boot/vmlinux ................................................ok
This DECstation is a DS5000/2x0
Loading R4000 MMU routines.
CPU revision is: 00000440
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.0-test8-pre1 (flo@slimer.rfc822.org) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) #3 Fri Oct 13 16:27:07 CEST 2000
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: 5/boot/vmlinux root=/dev/sda5 console=ttyS2

At this position it locks hard (No reset button pressing - Powercycle)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
