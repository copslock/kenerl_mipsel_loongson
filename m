Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4V17t225925
	for linux-mips-outgoing; Wed, 30 May 2001 18:07:55 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4V17oh25922
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 18:07:50 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA09195
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 17:42:16 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f4V0g9018348;
	Wed, 30 May 2001 17:42:09 -0700
Message-ID: <3B159331.CC353580@mvista.com>
Date: Wed, 30 May 2001 17:41:21 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Thompson <iant@palmchip.com>
CC: linux-mips@oss.sgi.com
Subject: Re: ramdisk funkiness
References: <3B157A53.5728029@palmchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ian Thompson wrote:
> 
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

You don't need to supply "root=/dev/ram0" argument as long as you give the
configure in the following option:

 Initial RAM disk (initrd) support (CONFIG_BLK_DEV_INITRD)

Jun
