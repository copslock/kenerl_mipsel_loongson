Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UNICc23521
	for linux-mips-outgoing; Wed, 30 May 2001 16:18:12 -0700
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UNI8h23515
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 16:18:08 -0700
Received: from murphy.dk (brian.localnet [10.0.0.2])
        by ubik.localnet (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f4UNHwbo021819
        for <linux-mips@oss.sgi.com>; Thu, 31 May 2001 01:18:00 +0200
Message-ID: <3B157FA4.ECCFEC76@murphy.dk>
Date: Thu, 31 May 2001 01:17:56 +0200
From: Brian Murphy <brian@murphy.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-mips@oss.sgi.com
Subject: Re: ramdisk funkiness
References: <3B157A53.5728029@palmchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ian Thompson wrote:

> Hi,
>
> I'm porting the 2.4 kernel to a custom board, and I'm running into some
> trouble while trying to mount the root filesystem.  There is no media
> (hard drives, cdrom drives, etc) attached to the system, but of course
> the kernel needs a root filesystem to boot.  So, I'm trying to create an
> empty ramdisk and have the kernel mount that as the root fs.  The kernel
> installs the ramdisk driver fine, but when it tries to open the ramdisk,
> I get this error message:
>
> RAMDISK driver initialized: 16 RAM disks of 128K size 1024 blocksize
> VFS: Cannot open root device "ram0" or 01:00
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 01:00
>

Have you got a filesystem on the ramdisk?

/Brian
