Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 15:03:05 +0100 (BST)
Received: from mf2.realtek.com.tw ([IPv6:::ffff:220.128.56.22]:21765 "EHLO
	mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8225240AbUJTOC7>; Wed, 20 Oct 2004 15:02:59 +0100
Received: from msx.realtek.com.tw (unverified [172.20.1.77]) by mf2.realtek.com.tw
 (Content Technologies SMTPRS 4.3.14) with ESMTP id <T6cc4c6aee3dc803816a20@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Wed, 20 Oct 2004 22:03:43 +0800
Received: from rtpdii3098 ([172.19.26.139])
          by msx.realtek.com.tw (Lotus Domino Release 6.0.2CF1)
          with ESMTP id 2004102022034112-115641 ;
          Wed, 20 Oct 2004 22:03:41 +0800 
Message-ID: <001301c4b6ad$70ce4420$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-mips@linux-mips.org>
Subject: Strange! Cannot use JFFS2 as root
Date: Wed, 20 Oct 2004 22:02:26 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/10/20 =?Bog5?B?pFWkyCAxMDowMzo0MQ==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/10/20
 =?Bog5?B?pFWkyCAxMDowMzo0Mw==?=,
	Serialize complete at 2004/10/20 =?Bog5?B?pFWkyCAxMDowMzo0Mw==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi all,
I had booted up Linux with nfs root, and write a JFFS2 image to /dev/mtd1.
Here is my cmdline for Kernel:
     go 0x80305018 root=/dev/nfs rw nfsroot=172.19.26.145:/nfs/rootfs
ip=172.19.27.193::172.19.27.254:255.255.254.0:::
mtdparts=maltaflash:1536k(ldr),2048k(root)

After writing the JFFS2 image to /dev/mtd1, I can mount /dev/mtdblcok1 to
some directory.
    mount -t jffs2 /dev/mtdblock1 /mnt

Next, I hope to boot up Linux with JFFS2 root, and try to give this cmdline
to Kernel:
    go 0x80305018 rootfstype=jffs2
mtdparts=maltaflash:1536k(ldr),2048k(root) root=/dev/mtdblock1

and the Kernel would complain me about no root:
    VFS: Unable to mount root fs via NFS, trying floppy.
    Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)

I traced the code and found that when passing "/dev/mtdblock1" to
name_to_dev_t() in do_mounts.c, it would return 0 at every try_name(),
 which will fail at open() with the path "/sys/block/%s/dev".

What's the problem? Could anyone tell me?

Thanks and regards,
Colin
