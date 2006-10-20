Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Oct 2006 16:49:31 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:62649 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20038885AbWJTPt0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Oct 2006 16:49:26 +0100
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by farad.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GawcU-0005GL-94; Fri, 20 Oct 2006 17:49:14 +0200
Message-ID: <4538EFEB.8010809@aurel32.net>
Date:	Fri, 20 Oct 2006 17:48:59 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	linux-mips@linux-mips.org
Subject: Re: qemu initrd and ide support
References: <20061012211228.GA17383@nevyn.them.org> <452F9744.9010109@aurel32.net>
In-Reply-To: <452F9744.9010109@aurel32.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Aurelien Jarno a écrit :
> The initrd seems to works well, but it generates a strange failure 
> during the boot:
> 
> [...]
> Mount-cache hash table entries: 512
> Checking for 'wait' instruction...  available.
> checking if image is initramfs...it isn't (bad gzip magic numbers); 
> looks like an initrd
> Bad page state in process 'swapper'
> page:81010000 flags:0x00080000 mapping:00000000 mapcount:0 count:0
> Trying to fix it up, but a reboot is needed
> Backtrace:
> Call Trace:
>  [<8005c748>] bad_page+0x68/0xa8
>  [<8005ccf0>] free_hot_cold_page+0x1a4/0x1b4
>  [<802a0000>] ic_bootp_recv+0x238/0x6a0
>  [<80080138>] __fput+0x14c/0x1cc
>  [<8001b094>] free_init_pages+0xa4/0xfc
>  [<802a0000>] ic_bootp_recv+0x238/0x6a0
>  [<802a0000>] ic_bootp_recv+0x238/0x6a0
>  [<802a0000>] ic_bootp_recv+0x238/0x6a0
>  [<80288d98>] free_initrd+0x28/0x44
>  [<80288e80>] populate_rootfs+0xcc/0x110
>  [<80292860>] spawn_softlockup_task+0x30/0x50
>  [<80010498>] init+0x54/0x300
>  [<80010498>] init+0x54/0x300
>  [<80013074>] kernel_thread_helper+0x10/0x18
>  [<80013064>] kernel_thread_helper+0x0/0x18
> 
> Freeing initrd memory: 2520k freed
> NET: Registered protocol family 16
> NET: Registered protocol family 2
> [...]
> 
> This message is not present when initrd is not used, and it also does 
> not appear with the previous way of passing the size and location of the 
> initrd.
> 
> I don't have time to look more now, I will give you some more details 
> when/if I found some time to work on that.
> 

This failure is due to the fact that initrd_reserve_bootmem is not set 
anymore to 1 in arch/mips/kernel/setup.c. It is set to 1 when the initrd 
location and size are read from the command line arguments, but not when 
  read from the place where QEMU put it.

Setting this value to 1 fixes the problem, but it is rather a big hack 
than a fix.

About the patch itself, another comment: you should add a #ifdef 
CONFIG_BLK_DEV_INITRD #endif for the block concerning the initrd in 
arch/mips/qemu/q-firmware.c

Bye,
Aurelien

-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian developer           | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
