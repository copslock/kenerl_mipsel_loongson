Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 02:20:23 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:61191
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225201AbTBUCUX>; Fri, 21 Feb 2003 02:20:23 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 21 Feb 2003 02:20:21 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 6B9D0B46D; Fri, 21 Feb 2003 11:20:11 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA06235; Fri, 21 Feb 2003 11:20:11 +0900 (JST)
Date: Fri, 21 Feb 2003 11:24:56 +0900 (JST)
Message-Id: <20030221.112456.41627052.nemoto@toshiba-tops.co.jp>
To: krishnakumar@naturesoft.net
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: Ramdisk image on flash.
From: Atsushi Nemoto <anemo@mba.sphere.ne.jp>
In-Reply-To: <200302201135.09154.krishnakumar@naturesoft.net>
References: <200302201135.09154.krishnakumar@naturesoft.net>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.sphere.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.sphere.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 20 Feb 2003 11:35:09 +0530, "Krishnakumar. R" <krishnakumar@naturesoft.net> said:
krishnakumar> Is there any way that I can keep a ramdisk image
krishnakumar> (containing the root filesystem) in a flash device and
krishnakumar> boot to it.

If your flash device can be accessed as MTD block device, you can use
"root=/dev/mtdblockN load_ramdisk=1" (and also "ramdisk_start=N") boot
option to load your (compressed) ramdisk image from the flash device.

This method needs following patch (for 2.4.20).  Also, this method
does not need initrd support or bootloader support.

--- linux-2.4.20/init/do_mounts.c	Wed Dec 25 15:30:02 2002
+++ linux/init/do_mounts.c	Wed Dec 25 16:56:40 2002
@@ -883,6 +883,18 @@
 		}
 	} else if (is_floppy && rd_doload && rd_load_disk(0))
 		ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
+#if defined(CONFIG_MTD_BLOCK) || defined(CONFIG_MTD_BLOCK_RO)
+#ifndef MTD_BLOCK_MAJOR
+#define MTD_BLOCK_MAJOR 31
+#endif
+	else if (MAJOR(ROOT_DEV) == MTD_BLOCK_MAJOR && rd_doload) {
+#ifdef CONFIG_BLK_DEV_RAM
+		create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, 0), NULL);
+#endif
+		if (rd_load_image("/dev/root"))
+			ROOT_DEV = MKDEV(RAMDISK_MAJOR, 0);
+	}
+#endif
 	mount_root();
 out:
 	sys_umount("/dev", 0);
---
Atsushi Nemoto
