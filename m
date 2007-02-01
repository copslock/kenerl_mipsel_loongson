Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 13:09:58 +0000 (GMT)
Received: from www.pc-net.at ([193.238.157.29]:53439 "EHLO MrWeb01.pc-net.at")
	by ftp.linux-mips.org with ESMTP id S20038930AbXBANJy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Feb 2007 13:09:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id 0BD5D215ED1
	for <linux-mips@linux-mips.org>; Thu,  1 Feb 2007 14:09:18 +0100 (CET)
Received: from MrWeb01.pc-net.at ([127.0.0.1])
	by localhost (MrWeb01 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05032-07 for <linux-mips@linux-mips.org>;
	Thu, 1 Feb 2007 14:09:07 +0100 (CET)
Received: from www.amilda.org (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id 19316215EC9
	for <linux-mips@linux-mips.org>; Thu,  1 Feb 2007 14:08:54 +0100 (CET)
Received: from 201.240.249.124
        (SquirrelMail authenticated user amilda0001)
        by www.amilda.org with HTTP;
        Thu, 1 Feb 2007 08:09:07 -0500 (PET)
Message-ID: <10879.201.240.249.124.1170335347.squirrel@www.amilda.org>
In-Reply-To: <45C11812.9050808@wp.pl>
References: <45C0C956.2050009@wp.pl>
    <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>
    <200701312302.05473.florian.fainelli@int-evry.fr>
    <45C11812.9050808@wp.pl>
Date:	Thu, 1 Feb 2007 08:09:07 -0500 (PET)
Subject: Re: Advice needed.
From:	"Sergio Aguayo" <sergio@amilda.org>
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.6-rc1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at pc-net.at
Return-Path: <sergio@amilda.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergio@amilda.org
Precedence: bulk
X-list: linux-mips

> <cut>
>
>>The board he is talking about is based on a rtl8186 which has few things
>> in
>>common with admtek 5120?
>>
>>
> As i realize, it is a MIPS too, and he's talking about utilities, not
> the kernel. (I'll download sources tomorrow, i have only GPRS internet
> connection, so i will take several hours, and the i'll examine it). At
> least some idea ;)
>

The realtek chipset by itself doesn't have many things in common with the
ADM5120. But the board used (in this case by Edimax), is very similar for
both chipsets. Almost the only thing needed to make the software of the
one work in the other is placing some platform-dependent code in the
kernel. The user-space should be quite the same (except the wireless
driver, which is different).

> <cut>
>
>>I think you had better using dd rather than cat, because /dev/mtdblock
>> are
>>block devices, and should be treated like that. If your image has a valid
>>format, i.e : the bootloader accepts it, unless you made important
>>modifications to the system code, it should at least be booting.
>>
>>
>
> Using dd also suggests padding resulting file to 2048*1024 bytes, am i
> right? And using block size of 64k?
> As of image, i remarked, that file resulting from reading /dev/mtd look
> like: boot&variables(64k) + original image I have uploaded using Edimax
> program(approx 1.9M) + zeros to the end of 2M boundary.
>

The structure (of the flash memory) is something like this:

32KB             Boot loader
32KB             Config stuff
rest             Kernel+BZIP2 RAMDISK

The exact size of the kernel and the ramdisk varies greatly between
firmware versions. YOu can find the start of the ramdisk by searching for
the bzip2 signature (in this case 'BZh'). The kernel+ramdisk doesn't have
to occupy the rest of the flash memory: the part not occupied by it is
just undefined and its contents may be whatever.


> So you think it may work? (dd ?) Image generation and upload using
> Edimax-supplied tools works.
>

dd would certainly work. I would suggest you to check the way AMiLDA
generates the firmware image. It's a lot more practical than a dd :D

Regards,

Sergio

> W.P.
>
>
>
