Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2006 03:48:06 +0100 (BST)
Received: from venus.localdns.com ([202.190.203.180]:24248 "EHLO
	venus.localdns.com") by ftp.linux-mips.org with ESMTP
	id S20037713AbWHGCsA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Aug 2006 03:48:00 +0100
Received: from [192.168.1.103] ([218.111.170.45])
 by venus.localdns.com (Sun Java System Messaging Server 6.2-4.03 (built Sep 22
 2005)) with ESMTPA id <0J3L00HIHWDH3N80@venus.localdns.com> for
 linux-mips@linux-mips.org; Mon, 07 Aug 2006 10:32:07 +0800 (MYT)
Date:	Mon, 07 Aug 2006 10:47:25 +0800
From:	WCT Tang <wct_tang@yahoo.com>
Subject: Re: EXT2-fs error
In-reply-to: <20060806083743.8348D352625@atlas.denx.de>
To:	Wolfgang Denk <wd@denx.de>
Cc:	linux-mips@linux-mips.org
Message-id: <44D6A9BD.9010100@yahoo.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
References: <20060806083743.8348D352625@atlas.denx.de>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Return-Path: <wct_tang@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wct_tang@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello Wolfgang,

Thanks for your reply.  I have checked that my total file size is only 
384KB, and the ramdisk I created is 4096KB, and my Kernel's ram size 
CONFIG_BLK_DEV_RAM_SIZE is set to 4096.

Here are the steps I used to create ramdisk:

dd if=/dev/zero of=/dev/ram bs=1k count=4096
mke2fs -vm0 /dev/ram 4096
mount /dev/ram ramdisk/
cd ramdisk/
cp -r /home/devel/root/* .
mkdir dev etc tmp var proc mnt home root
cd dev/
mknod console c 5 1
mknod ttyS0 c 4 64
mknod tty c 5 0
mknod ram0 b 1 0
mknod ram1 b 1 1
mknod mem c 1 1
mknod kmem c 1 2
mknod null c 1 3
mknod zero c 1 5
mknod fb0 c 29 0
ln -s fb0 fb
ln -s ram1 ram
ln -s ram0 ramdisk
ln -s ../proc/kcore kcore
ln -s ../proc/self/fd/0 stdin
ln -s ../proc/self/fd/1 stdout
ln -s ../proc/self/fd/2 stderr
cd ..
umount ramdisk
dd if=/dev/ram bs=1k count=4096 | gzip -vf > 
/home/devel/linux/arc/mips/ramdisk/ramdisk.gz


Any other suggestion?


p/s: I have got lots of junk mails sent from this mailing lists, 
probably triggered by my email. Could the administrator do something?


Wolfgang Denk wrote:
> In message <20060806040329.51416.qmail@web27003.mail.ukl.yahoo.com> you wrote:
>
>   
>> I built Linux kernel (V2.4) as follows: 
>> - Created EXT2 ramdisk.gz as documented in Documentation/ramdisk.txt 
>> - The ramdisk contains the content of buildroot/build_mipsel/root/, which contains bin, etc, lib, linuxrc, sbin (sh.. etc), usr. I also created under /dev console null, tty*.... 
>> - Copied ramdisk.gz to /linux/arc/mips/ramdisk/ 
>>     
> ...
>   
>> Tracing down the codes, I noticed I got EXT2-fs error. 
>>     
>
> Your ramdisk is probably much bigger than the kernel's default of 4 MB.
>
> Please see the FAQ at
> http://www.denx.de/wiki/view/DULG/RamdiskGreaterThan4MBCausesProblems
>
> Best regards,
>
> Wolfgang Denk
>
>   
