Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 04:00:30 +0100 (BST)
Received: from mf2.realtek.com.tw ([IPv6:::ffff:220.128.56.22]:61195 "EHLO
	mf2.realtek.com.tw") by linux-mips.org with ESMTP
	id <S8225240AbUJUDAY>; Thu, 21 Oct 2004 04:00:24 +0100
Received: from msx.realtek.com.tw (unverified [172.20.1.77]) by mf2.realtek.com.tw
 (Content Technologies SMTPRS 4.3.14) with ESMTP id <T6cc78eb777dc803816a20@mf2.realtek.com.tw> for <linux-mips@linux-mips.org>;
 Thu, 21 Oct 2004 11:01:27 +0800
Received: from rtpdii3098 ([172.19.26.139])
          by msx.realtek.com.tw (Lotus Domino Release 6.0.2CF1)
          with ESMTP id 2004102111012599-133520 ;
          Thu, 21 Oct 2004 11:01:25 +0800 
Message-ID: <007101c4b71a$171bd830$8b1a13ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
Cc: <linux-mips@linux-mips.org>
References: <001301c4b6ad$70ce4420$8b1a13ac@realtek.com.tw> <20041020163048.GC17445@gate.ebshome.net>
Subject: Re: [*VIP*] Re: Strange! Cannot use JFFS2 as root
Date: Thu, 21 Oct 2004 11:00:11 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at
 2004/10/21 =?Bog5?B?pFekyCAxMTowMToyNQ==?=,
	Serialize by Router on msx/Realtek(Release 6.0.2CF1|June 9, 2003) at 2004/10/21
 =?Bog5?B?pFekyCAxMTowMToyNw==?=,
	Serialize complete at 2004/10/21 =?Bog5?B?pFekyCAxMTowMToyNw==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="iso-8859-1"
To: unlisted-recipients:; (no To-header on input)
Return-Path: <colin@realtek.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com.tw
Precedence: bulk
X-list: linux-mips


Hi Eugene,
The Kernel I use is 2.6.4, and I donot see the entry you mentioned.

Regards,
Colin


----- Original Message ----- 
From: "Eugene Surovegin" <ebs@ebshome.net>
To: "colin" <colin@realtek.com.tw>
Cc: <linux-mips@linux-mips.org>
Sent: Thursday, October 21, 2004 12:30 AM
Subject: [*VIP*] Re: Strange! Cannot use JFFS2 as root


> On Wed, Oct 20, 2004 at 10:02:26PM +0800, colin wrote:
> >
> > Hi all,
> > I had booted up Linux with nfs root, and write a JFFS2 image to
/dev/mtd1.
> > Here is my cmdline for Kernel:
> >      go 0x80305018 root=/dev/nfs rw nfsroot=172.19.26.145:/nfs/rootfs
> > ip=172.19.27.193::172.19.27.254:255.255.254.0:::
> > mtdparts=maltaflash:1536k(ldr),2048k(root)
> >
> > After writing the JFFS2 image to /dev/mtd1, I can mount /dev/mtdblcok1
to
> > some directory.
> >     mount -t jffs2 /dev/mtdblock1 /mnt
> >
> > Next, I hope to boot up Linux with JFFS2 root, and try to give this
cmdline
> > to Kernel:
> >     go 0x80305018 rootfstype=jffs2
> > mtdparts=maltaflash:1536k(ldr),2048k(root) root=/dev/mtdblock1
> >
> > and the Kernel would complain me about no root:
> >     VFS: Unable to mount root fs via NFS, trying floppy.
> >     Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)
> >
> > I traced the code and found that when passing "/dev/mtdblock1" to
> > name_to_dev_t() in do_mounts.c, it would return 0 at every try_name(),
> >  which will fail at open() with the path "/sys/block/%s/dev".
> >
> > What's the problem? Could anyone tell me?
>
> What is the kernel version you are using?
>
> Check that root_dev_names array in init/do_mounts.c has an entry,
> which looks like
>
> { "mtdblock", 0x1f00 }
>
> --
> Eugene
