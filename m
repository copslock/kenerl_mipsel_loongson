Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 09:41:56 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:20707 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20029014AbYGWIlw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 09:41:52 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 12C45C8051;
	Wed, 23 Jul 2008 11:41:47 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id BZrVZI903QT9; Wed, 23 Jul 2008 11:41:46 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id E7B1BC8042;
	Wed, 23 Jul 2008 11:41:46 +0300 (EEST)
Message-ID: <4886EECA.7060009@movial.fi>
Date:	Wed, 23 Jul 2008 11:41:46 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Naresh Bhat <nareshgbhat@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Kernel is Hanging for page size 16KB.
References: <cf9b3c760807230016j6c1acc32qd1e54f3a9fa60403@mail.gmail.com>	 <4886E380.6060300@movial.fi> <cf9b3c760807230113x1194f6b3j692a2cb0867b7885@mail.gmail.com>
In-Reply-To: <cf9b3c760807230113x1194f6b3j692a2cb0867b7885@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Naresh Bhat wrote:
> Hi Dmitri,
> 
> I would like to know regarding the support of 16 KB
> page size option in the linux 2.6.10 for MIPS architectures.

Normally the page size is 4KiB for all architectures except DEC Alpha, AFAIR. Most probably you simply do not want to change the page size at all. Could you please explain why do you need 16KiB pages?

Dmitri

> 
> By default the page size set as 4KB ( CONFIG_PAGE_SIZE_4KB=y).
> 
> As I reconfigure and boot the kernel with 16 KB page size, the
> kernel hangs at the line "Algorithmics/MIPS FPU Emulator v1.5"* *in
> the kernel boot up message.
> 
> /Freeing prom memory: 1024kb freed/
> 
> /Freeing unused kernel memory: 144k freed/
> 
> /Algorithmics/MIPS FPU Emulator v1.5/
> 
> 
> After this line nothing was displayed in console. kernel hangs there.
> 
> Thanks for your support
> 
> Regards
> Naresh Bhat
> 
> On Wed, Jul 23, 2008 at 1:23 PM, Dmitri Vorobiev
> <dmitri.vorobiev@movial.fi <mailto:dmitri.vorobiev@movial.fi>> wrote:
> 
>     Naresh Bhat wrote:
>     > Hi Guys,
>     >
>     > I have a board MIPS Malta and Linux 2.6.10 is running on that. By
>     > default 4KB page size will be allocated in the kernel (I mean to say I
>     > saw it when I do the "make menuconfig".
>     >
>     > Problem is:
>     >
>     > When I changed the page size to 16KB it will hang after mounting the
>     > file system. I am using the NFS for booting the board.
> 
>     What was the reason to change the default page size? What do you
>     think you'll gain from it?
> 
>     >
>     >
>     > Can anybody help me on this issue...
> 
>     Please tell what kind of problem you're really trying to solve...
> 
>     Regards,
>     Dmitri
> 
>     >
>     > --
>     > Thanks
>     > Naresh Bhat
> 
> 
>  
> 
> 
