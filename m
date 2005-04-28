Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 14:37:43 +0100 (BST)
Received: from smtp10.wanadoo.fr ([IPv6:::ffff:193.252.22.21]:58318 "EHLO
	smtp10.wanadoo.fr") by linux-mips.org with ESMTP
	id <S8225767AbVD1Nh1>; Thu, 28 Apr 2005 14:37:27 +0100
Received: from me-wanadoo.net (unknown [127.0.0.1])
	by mwinf1003.wanadoo.fr (SMTP Server) with ESMTP id 1CCB82000359
	for <linux-mips@linux-mips.org>; Thu, 28 Apr 2005 15:37:20 +0200 (CEST)
Received: from smtp.innova-card.com (AMarseille-206-1-6-143.w80-14.abo.wanadoo.fr [80.14.198.143])
	by mwinf1003.wanadoo.fr (SMTP Server) with ESMTP id 9E7DB2000328;
	Thu, 28 Apr 2005 15:37:19 +0200 (CEST)
X-ME-UUID: 20050428133719649.9E7DB2000328@mwinf1003.wanadoo.fr
Received: by smtp.innova-card.com (Postfix, from userid 100)
	id 195383800A; Thu, 28 Apr 2005 15:37:12 +0200 (CEST)
Received: from [192.168.0.24] (spoutnik.innova-card.com [192.168.0.24])
	by smtp.innova-card.com (Postfix) with ESMTP
	id 709A138009; Thu, 28 Apr 2005 15:37:11 +0200 (CEST)
Message-ID: <4270E678.7050402@innova-card.com>
Date:	Thu, 28 Apr 2005 15:34:48 +0200
From:	Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Dmitriy Tochansky <toch@dfpost.ru>
Cc:	linux-mips@linux-mips.org
Subject: Re: ramfs
References: <20050427195552.41f92184.toch@dfpost.ru>
In-Reply-To: <20050427195552.41f92184.toch@dfpost.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <franck.bui-huu@innova-card.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: franck.bui-huu@innova-card.com
Precedence: bulk
X-list: linux-mips

Hi

Dmitriy Tochansky wrote:

>Hello!
>
>Im trying to use embedded ramdisk on boot.
>The error is:
>
>[4294668.794000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0) 
>
>In make menuconfig I pass to initrdfs directory with my root("/mips/root"),
>there are no errors on make. 
>Ramdisk size set to 7777k
>([4294668.691000] RAMDISK driver initialized: 2 RAM disks of 7777K size 1024 blocksize)
>
>populate_rootfs() works fine:
>
>
>[4294667.502000] init/initramfs.c void __init populate_rootfs(void);
>[4294668.313000] checking if image is initramfs... it is
>  
>
why using initramfs with initrd ?

>then on do_mounts in void __init mount_block_root(char *name, int flags)
>it tryes to mount initrd with no result. :( As final:
>
>
>[4294668.794000] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
>
>Any ideas?
>  
>
maybe try to add in your kernel command option: "rootfstype=ramfs"

>Kernel from cvs(yesterday updated).
>
>Which type of fs is initrd? AFAIK gen_init_cpio just generates cpio archive with my root. Seems like it unpacked fine but who did mkfs on /dev/ram0?
>
>
>  
>
initrd fs depends on how your initrd image is built.
initramfs fs is ramfs.

cheers,

                Franck


-------------------------------------------------------------------------------
Come to visit Innova Card at Cards Asia (Singapore, April 27-29, 2005) on booth 4A04 !

links:
 - www.worldofcards.biz/2005/cardsa_SG/

-------------------------------------------------------------------------------
This message contains confidential information and is intended only for the
individual named. If you are not the named addressee you should not
disseminate, distribute or copy this e-mail. Please notify the sender
immediately by e-mail if you have received this e-mail by mistake and delete
this e-mail from your system.
Innova Card will not therefore be liable for the message if modified.
