Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UMo6B22614
	for linux-mips-outgoing; Wed, 30 May 2001 15:50:06 -0700
Received: from mail.palmchip.com ([63.203.52.8])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UMo1h22611
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 15:50:02 -0700
Received: from palmchip.com (sabretooth.palmchip.com [10.1.10.110])
	by mail.palmchip.com (8.11.0/8.9.3) with ESMTP id f4UMnuc16798
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 15:49:56 -0700
Message-ID: <3B157A53.5728029@palmchip.com>
Date: Wed, 30 May 2001 15:55:15 -0700
From: Ian Thompson <iant@palmchip.com>
Organization: Palmchip Corporation
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: ramdisk funkiness
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi,

I'm porting the 2.4 kernel to a custom board, and I'm running into some
trouble while trying to mount the root filesystem.  There is no media
(hard drives, cdrom drives, etc) attached to the system, but of course
the kernel needs a root filesystem to boot.  So, I'm trying to create an
empty ramdisk and have the kernel mount that as the root fs.  The kernel
installs the ramdisk driver fine, but when it tries to open the ramdisk,
I get this error message:

RAMDISK driver initialized: 16 RAM disks of 128K size 1024 blocksize
VFS: Cannot open root device "ram0" or 01:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 01:00

Now for some possible complications: I'm not using LILO as of yet.  I've
written a custom bootloader, and one of the arguments I pass to the
kernel is "root=/dev/ram0" as it says to do in
Documentation/initrd.txt.  So my question is: what other setup am I
skipping?  I'd rather not have to store a ramdisk image in ROM, but I'm
guessing I'll run into problems just creating an empty one.  What else
do I need to do to get VFS to open the device correctly?

Thanks,
-ian

-- 
----------------------------------------
Ian Thompson           tel: 408.952.2023
Firmware Engineer      fax: 408.570.0910
Palmchip Corporation   www.palmchip.com
