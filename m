Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 15:20:23 +0100 (BST)
Received: from smtp104.rog.mail.re2.yahoo.com ([IPv6:::ffff:206.190.36.82]:48305
	"HELO smtp104.rog.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8225228AbUJTOUR>; Wed, 20 Oct 2004 15:20:17 +0100
Received: from unknown (HELO ?192.168.1.100?) (charles.eidsness@rogers.com@24.157.59.167 with plain)
  by smtp104.rog.mail.re2.yahoo.com with SMTP; 20 Oct 2004 14:19:57 -0000
Message-ID: <41767409.5010209@ieee.org>
Date: Wed, 20 Oct 2004 10:19:53 -0400
From: Charles Eidsness <charles.eidsness@ieee.org>
Reply-To: charles.eidsness@ieee.org
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: colin <colin@realtek.com.tw>
CC: linux-mips@linux-mips.org
Subject: Re: Strange! Cannot use JFFS2 as root
References: <001301c4b6ad$70ce4420$8b1a13ac@realtek.com.tw>
In-Reply-To: <001301c4b6ad$70ce4420$8b1a13ac@realtek.com.tw>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-Path: <charles.eidsness@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charles.eidsness@ieee.org
Precedence: bulk
X-list: linux-mips

Hi Colin,

I had a similar problem. You're passing root=/dev/mtdblock1 which has a
major value of 31 and a minor value of 1 but the by the looks of the
error message the kernel thinks you want to boot from a device with a
major number of 2 and a minor number of zero. You could try passing an
explicitly defined root=1F01 instead (major 31, minor 1). This works for
me. I have no idea why the kernel doesn't recognize the text based
declaration and haven't had time to investigate. Maybe someone else has
a better idea than I do.

Hope that helps,
Charles

colin wrote:
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
> 
> Thanks and regards,
> Colin
> 
> 
> 
> 
> 
> 
