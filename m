Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jul 2008 15:16:22 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:54685 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20024771AbYG1OQP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jul 2008 15:16:15 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 3D4EFC806D;
	Mon, 28 Jul 2008 17:16:09 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id xnK0w328uWOK; Mon, 28 Jul 2008 17:16:09 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id 1EDDFC8016;
	Mon, 28 Jul 2008 17:16:09 +0300 (EEST)
Message-ID: <488DD4A8.6040209@movial.fi>
Date:	Mon, 28 Jul 2008 17:16:08 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Kevin Hickey <khickey@rmicorp.com>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] Initialization of Alchemy boards
References: <1217002430.10968.30.camel@kh-ubuntu.razamicroelectronics.com>	 <488D707A.4090800@movial.fi> <1217254063.9208.3.camel@kh-ubuntu.razamicroelectronics.com>
In-Reply-To: <1217254063.9208.3.camel@kh-ubuntu.razamicroelectronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Kevin Hickey wrote:
> Dmitri,
> 
> On Mon, 2008-07-28 at 10:08 +0300, Dmitri Vorobiev wrote:
>> Kevin Hickey wrote:
>>> I found this when I updated to version 2.6.26.  None of my development
>>> boards would boot.  It appears that a previous update changed some calls
>>> to simple_strtol to strict_strtol but did not account for the different
>>> call semantics.
>> Hi Kevin,
>>
>> 1) you forgot to sign your patch off;
> Indeed I did.  Is it sufficient to reply to the original post and add a
> sign-off line?

Well, I think it would be better to recreate the diff. What you have now does not apply:

dvorobye@sd048:/work/zoo/src/linux-2.6$ git apply

[pasted the patch]

error: mips/au1000/pb1000/init.c: No such file or directory
error: mips/au1000/pb1100/init.c: No such file or directory
error: mips/au1000/pb1200/init.c: No such file or directory
error: mips/au1000/mtx-1/init.c: No such file or directory
error: mips/au1000/pb1500/init.c: No such file or directory
error: mips/au1000/xxs1500/init.c: No such file or directory
error: mips/au1000/pb1550/init.c: No such file or directory
error: mips/au1000/db1x00/init.c: No such file or directory
dvorobye@sd048:/work/zoo/src/linux-2.6$

For a quick intro to creating the kernel patches, please see Documentation/SubmittingPatches, which describes the gitless approach. However, as I mentioned earlier, using git is much better.

Thanks,
Dmitri
