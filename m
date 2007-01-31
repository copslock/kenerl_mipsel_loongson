Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2007 21:39:59 +0000 (GMT)
Received: from www.pc-net.at ([193.238.157.29]:46508 "EHLO MrWeb01.pc-net.at")
	by ftp.linux-mips.org with ESMTP id S20038798AbXAaVjz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Jan 2007 21:39:55 +0000
Received: from localhost (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id DA956215EC6
	for <linux-mips@linux-mips.org>; Wed, 31 Jan 2007 22:39:19 +0100 (CET)
Received: from MrWeb01.pc-net.at ([127.0.0.1])
	by localhost (MrWeb01 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07458-05 for <linux-mips@linux-mips.org>;
	Wed, 31 Jan 2007 22:39:07 +0100 (CET)
Received: from www.amilda.org (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id BFE79215EAF
	for <linux-mips@linux-mips.org>; Wed, 31 Jan 2007 22:38:57 +0100 (CET)
Received: from 201.240.249.124
        (SquirrelMail authenticated user amilda0001)
        by www.amilda.org with HTTP;
        Wed, 31 Jan 2007 16:39:07 -0500 (PET)
Message-ID: <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>
In-Reply-To: <45C0C956.2050009@wp.pl>
References: <45C0C956.2050009@wp.pl>
Date:	Wed, 31 Jan 2007 16:39:07 -0500 (PET)
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
X-archive-position: 13868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergio@amilda.org
Precedence: bulk
X-list: linux-mips

Hello

I think you should check my webpage, www.amilda.org. It's a distro for
other Edimax routers, based on the (also MIPS) ADM5120. While the kernel
may not be what you need, the rest is quite the same. It may still be
useful for you.

Regards,

Sergio Aguayo

> Hello,
> currently i am "fighting" with Edimax BR-6024Wg, (Realtek-8186 based,
> lexra-mips). I need an advice from a system developer/programmer:
>
> 1). When using original firmware (EDIMAX-developed Linux-mips), task of
> upgrading firmware is done by web server binary: webs, which is GoAhead
> 2.1.1, BUT Edimax didn't published "applets" -> C functions, that
> implement real functionality.
>
> 2). In /dev directory there is a block node with mtd name. I have cat'ed
> it's contents to /web, and downloaded to PC. File seems to be raw
> contents of Flash memory: 2048*1024bytes long. If I drop first 64kB and
> truncate file to same length that Edimax-supplied firmware, files show
> to be the same (using cmp). The first 64kB looks to contain among
> others, variables used in BR system. There is originally an utility
> "flash" to get/set variables.
>
> Now the question:
> When I will have a new firmware (image) will it be safe(!?) to do such
> thing: (instead of using webs binary):
> cat /dev/mtd > some.file
> dd first 64k of some.file to other.file,
> then download image (from PC) to a third.file
> cat other.file third.file > /dev/mtd back.??????
>
> W.Piotrzkowski
>
>
