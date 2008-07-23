Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 08:53:44 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:60635 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20027411AbYGWHxm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 08:53:42 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id DFBF4C806C;
	Wed, 23 Jul 2008 10:53:36 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id kzZBYPxSfD8l; Wed, 23 Jul 2008 10:53:36 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id C1203C8042;
	Wed, 23 Jul 2008 10:53:36 +0300 (EEST)
Message-ID: <4886E380.6060300@movial.fi>
Date:	Wed, 23 Jul 2008 10:53:36 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Naresh Bhat <nareshgbhat@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Kernel is Hanging for page size 16KB.
References: <cf9b3c760807230016j6c1acc32qd1e54f3a9fa60403@mail.gmail.com>
In-Reply-To: <cf9b3c760807230016j6c1acc32qd1e54f3a9fa60403@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Naresh Bhat wrote:
> Hi Guys,
> 
> I have a board MIPS Malta and Linux 2.6.10 is running on that. By
> default 4KB page size will be allocated in the kernel (I mean to say I
> saw it when I do the "make menuconfig".
> 
> Problem is:
> 
> When I changed the page size to 16KB it will hang after mounting the
> file system. I am using the NFS for booting the board.

What was the reason to change the default page size? What do you think you'll gain from it?

> 
> 
> Can anybody help me on this issue...

Please tell what kind of problem you're really trying to solve...

Regards,
Dmitri

> 
> -- 
> Thanks
> Naresh Bhat
