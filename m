Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5K083Q19879
	for linux-mips-outgoing; Tue, 19 Jun 2001 17:08:03 -0700
Received: from mail.palmchip.com ([63.203.52.8])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5K082V19876
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 17:08:02 -0700
Received: from palmchip.com (sabretooth.palmchip.com [10.1.10.110])
	by mail.palmchip.com (8.11.0/8.11.0) with ESMTP id f5K28a207602
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 19:08:36 -0700
Message-ID: <3B2FEAA1.34DD1FFB@palmchip.com>
Date: Tue, 19 Jun 2001 17:13:21 -0700
From: Ian Thompson <iant@palmchip.com>
Organization: Palmchip Corporation
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Can't open root device
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I'm having some issues trying to open a ROM fs via initrd.  It seems
like kind of a paradox: mount_root() calls blkdev_get(), which calls
rd_open().  In blkdev_get(), the comments mention that the block device
->open() method is not supposed to access anthing in the 'inode'
argument except ->i_rdev.  However, rd_open() checks inode->i_bdev when
->i_rdev isn't INITRD_MINOR (->i_rdev is set to bd_dev in blkdev_get). 
Currently my minor number is 0 (major is 1).  Am I using the correct
major/minor numbers?  Should I use INITRD_MINOR instead of 0?  If I am
ok with 0, it appears that there is an inconsistency in the code...

Also, is there another driver I should try using instead of the ramdisk
driver?  uClinux has a blkmem driver, but I haven't seen that here...

Thanks for your time,
-ian

-- 
----------------------------------------
Ian Thompson           tel: 408.952.2023
Firmware Engineer      fax: 408.570.0910
Palmchip Corporation   www.palmchip.com
This message resent by the uclinux-dev@uclinux.org list server
http://www.uClinux.org/
