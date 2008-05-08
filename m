Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 01:06:34 +0100 (BST)
Received: from p549F6826.dip.t-dialin.net ([84.159.104.38]:19387 "EHLO
	p549F6826.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S28590401AbYE1VFy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 May 2008 22:05:54 +0100
Received: from smtp117.iad.emailsrvr.com ([207.97.245.117]:13721 "EHLO
	smtp117.iad.emailsrvr.com") by lappi.linux-mips.net with ESMTP
	id S528764AbYEHIby convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 May 2008 10:31:54 +0200
Received: from relay1.r1.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay1.r1.iad.emailsrvr.com (SMTP Server) with ESMTP id 2265444C261;
	Thu,  8 May 2008 04:30:51 -0400 (EDT)
Received: from vaultinfo.com (webmail4.r2.iad.emailsrvr.com [192.168.1.12])
	by relay1.r1.iad.emailsrvr.com (SMTP Server) with ESMTP id 1B96644C207;
	Thu,  8 May 2008 04:30:51 -0400 (EDT)
Received: by webmail.mailsin.net
    (Authenticated sender: abhiruchi.g@vaultinfo.com, from: abhiruchi.g@vaultinfo.com) 
    with HTTP; Thu, 8 May 2008 04:30:51 -0400 (EDT)
Date:	Thu, 8 May 2008 04:30:51 -0400 (EDT)
Subject: 
From:	abhiruchi.g@vaultinfo.com
To:	stehbrettsegeln@gmx.de
Cc:	linux-mips@linux-mips.org
Reply-To: abhiruchi.g@vaultinfo.com
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8BIT
Importance: Normal
X-Priority: 3 (Normal)
X-Type:	1
Message-ID: <58354.192.168.1.71.1210235451.webmail@192.168.1.71>
X-Mailer: webmail6.6.1
Return-Path: <abhiruchi.g@vaultinfo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abhiruchi.g@vaultinfo.com
Precedence: bulk
X-list: linux-mips

Hi,
   Thanks for the reply.
   I am using the default initramfs given in usr directory of source code.

Actually I copied linux image to SD card and ext2fs to SCSI device. I passed one of kernel parameters as root=/dev/sda1.
thats why It is getting detected.
 
I am the new one. so do know much.

-----Original Message-----
From: Thorsten Schulz <stehbrettsegeln@gmx.de>
Sent: Thursday, May 8, 2008 3:38am
To: abhiruchi.g@vaultinfo.com
Cc: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Subject: Re: Alchemy DB1200

Hi,

do you actually have that console device on your usb-stick?

mknod -m 0600 /path/to/stick/dev/console c 5 1
mknod -m 0777 /path/to/stick/mnt/dev/null c 1 3

Thorsten

PS btw. could you mail me your config/initramfslist/init how you got the kernel to boot the rootfs from usb, i never managed to. I am working on an au1550 system thats mtd-flash has problems with recent kernels.

On Thu, 08 May 2008 09:11:05 +0200, <abhiruchi.g@vaultinfo.com> wrote:

> I am trying to build kernel for DB1200 board.
> but kernel hangs after the following output:

> Waiting 10sec before mounting root device...
> scsi 0:0:0:0: Direct-Access     Ut163    USB2FlashStorage 0.00 PQ: 0 ANSI: 2
> sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sd 0:0:0:0: [sda] 983808 512-byte hardware sectors (504 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Assuming drive cache: write through
> sda:<7>usb-storage: queuecommand called
> sda1
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> VFS: Mounted root (ext2 filesystem) readonly.
> mount_block_root: name=/dev/root fs=ext2 flags=32769
> Freeing unused kernel memory: 164k freed
> Warning: unable to open an initial console.
> Algorithmics/MIPS FPU Emulator v1.5
