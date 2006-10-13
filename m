Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 14:40:55 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:52459 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20038845AbWJMNku (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Oct 2006 14:40:50 +0100
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by farad.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GYNH9-0002E1-Ia; Fri, 13 Oct 2006 15:40:35 +0200
Message-ID: <452F9744.9010109@aurel32.net>
Date:	Fri, 13 Oct 2006 15:40:20 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	linux-mips@linux-mips.org
Subject: Re: qemu initrd and ide support
References: <20061012211228.GA17383@nevyn.them.org>
In-Reply-To: <20061012211228.GA17383@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi!

Daniel Jacobowitz a écrit :
> These patches for qemu let IDE and initrd work in the defconfig.
> It seems to function - I was able to get as far as partitioning
> the drive in the debian installer and the next time I started qemu
> the new partitions were found.  But the installer hangs up trying
> to format swap.
> 
> Of course, what would be really nice would be a PCI controller.
> I'm not brave enough to try.
> 
> I'm not going to submit the qemu change until I have some better
> evidence that it all works right (or someone else does).
> 

First of all, thanks a lot for your work, that makes QEMU mips more usable.

The IDE part works very well, though there seems to be some problems 
with userland tools (mke2fs), an instruction is probably not/bad 
emulated. I now have a system with the root on the IDE drive and with swap.

The initrd seems to works well, but it generates a strange failure 
during the boot:

[...]
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
checking if image is initramfs...it isn't (bad gzip magic numbers); 
looks like an initrd
Bad page state in process 'swapper'
page:81010000 flags:0x00080000 mapping:00000000 mapcount:0 count:0
Trying to fix it up, but a reboot is needed
Backtrace:
Call Trace:
  [<8005c748>] bad_page+0x68/0xa8
  [<8005ccf0>] free_hot_cold_page+0x1a4/0x1b4
  [<802a0000>] ic_bootp_recv+0x238/0x6a0
  [<80080138>] __fput+0x14c/0x1cc
  [<8001b094>] free_init_pages+0xa4/0xfc
  [<802a0000>] ic_bootp_recv+0x238/0x6a0
  [<802a0000>] ic_bootp_recv+0x238/0x6a0
  [<802a0000>] ic_bootp_recv+0x238/0x6a0
  [<80288d98>] free_initrd+0x28/0x44
  [<80288e80>] populate_rootfs+0xcc/0x110
  [<80292860>] spawn_softlockup_task+0x30/0x50
  [<80010498>] init+0x54/0x300
  [<80010498>] init+0x54/0x300
  [<80013074>] kernel_thread_helper+0x10/0x18
  [<80013064>] kernel_thread_helper+0x0/0x18

Freeing initrd memory: 2520k freed
NET: Registered protocol family 16
NET: Registered protocol family 2
[...]

This message is not present when initrd is not used, and it also does 
not appear with the previous way of passing the size and location of the 
initrd.

I don't have time to look more now, I will give you some more details 
when/if I found some time to work on that.

Bye,
Aurelien

-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian developer           | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
