Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 17:31:06 +0100 (BST)
Received: from gate.ebshome.net ([IPv6:::ffff:64.81.67.12]:40681 "EHLO
	gate.ebshome.net") by linux-mips.org with ESMTP id <S8225325AbUJTQbB>;
	Wed, 20 Oct 2004 17:31:01 +0100
Received: (qmail 25878 invoked by uid 1000); 20 Oct 2004 09:30:48 -0700
Date: Wed, 20 Oct 2004 09:30:48 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: colin <colin@realtek.com.tw>
Cc: linux-mips@linux-mips.org
Subject: Re: Strange! Cannot use JFFS2 as root
Message-ID: <20041020163048.GC17445@gate.ebshome.net>
Mail-Followup-To: colin <colin@realtek.com.tw>, linux-mips@linux-mips.org
References: <001301c4b6ad$70ce4420$8b1a13ac@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001301c4b6ad$70ce4420$8b1a13ac@realtek.com.tw>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Return-Path: <ebs@ebshome.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebs@ebshome.net
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2004 at 10:02:26PM +0800, colin wrote:
> 
> Hi all,
> I had booted up Linux with nfs root, and write a JFFS2 image to /dev/mtd1.
> Here is my cmdline for Kernel:
>      go 0x80305018 root=/dev/nfs rw nfsroot=172.19.26.145:/nfs/rootfs
> ip=172.19.27.193::172.19.27.254:255.255.254.0:::
> mtdparts=maltaflash:1536k(ldr),2048k(root)
> 
> After writing the JFFS2 image to /dev/mtd1, I can mount /dev/mtdblcok1 to
> some directory.
>     mount -t jffs2 /dev/mtdblock1 /mnt
> 
> Next, I hope to boot up Linux with JFFS2 root, and try to give this cmdline
> to Kernel:
>     go 0x80305018 rootfstype=jffs2
> mtdparts=maltaflash:1536k(ldr),2048k(root) root=/dev/mtdblock1
> 
> and the Kernel would complain me about no root:
>     VFS: Unable to mount root fs via NFS, trying floppy.
>     Kernel panic: VFS: Unable to mount root fs on unknown-block(2,0)
> 
> I traced the code and found that when passing "/dev/mtdblock1" to
> name_to_dev_t() in do_mounts.c, it would return 0 at every try_name(),
>  which will fail at open() with the path "/sys/block/%s/dev".
> 
> What's the problem? Could anyone tell me?

What is the kernel version you are using?

Check that root_dev_names array in init/do_mounts.c has an entry, 
which looks like

	{ "mtdblock", 0x1f00 }

--
Eugene
