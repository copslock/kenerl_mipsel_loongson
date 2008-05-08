Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2008 08:38:52 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:12490 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20021650AbYEHHit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 May 2008 08:38:49 +0100
Received: (qmail invoked by alias); 08 May 2008 07:38:43 -0000
Received: from unknown (EHLO localhost) [86.56.122.148]
  by mail.gmx.net (mp023) with SMTP; 08 May 2008 09:38:43 +0200
X-Authenticated: #2913508
X-Provags-ID: V01U2FsdGVkX1/KproR/mPKll64QaAnAinpz/1cB9THNuTiq1PVQt
	N3YiqB7kQzHsbL
Date:	Thu, 08 May 2008 09:38:41 +0200
To:	abhiruchi.g@vaultinfo.com
Subject: Re: Alchemy DB1200
From:	"Thorsten Schulz" <stehbrettsegeln@gmx.de>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
References: <40369.192.168.1.71.1210230665.webmail@192.168.1.71>
Content-Transfer-Encoding: 8BIT
Message-ID: <op.uatrirwg33s53m@localhost>
In-Reply-To: <40369.192.168.1.71.1210230665.webmail@192.168.1.71>
User-Agent: Opera Mail/9.27 (Linux)
X-Y-GMX-Trusted: 0
Return-Path: <stehbrettsegeln@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stehbrettsegeln@gmx.de
Precedence: bulk
X-list: linux-mips

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
