Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Mar 2006 08:49:02 +0000 (GMT)
Received: from mailout.mbnet.fi ([194.100.161.24]:25375 "HELO
	mail3.mbnet.mbnet.fi") by ftp.linux-mips.org with SMTP
	id S8133435AbWCRIsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 18 Mar 2006 08:48:52 +0000
Received: from unknown[194.100.161.243]:36438 (EHLO webmail.mbnet.fi)
 by mail3.mbnet.mbnet.fi ([10.10.20.80]:25) (F-Secure Anti-Virus for Internet Mail 6.41.4 Release)
 with SMTP; Sat, 18 Mar 2006 08:58:07 -0000
Received: from 88.192.17.186
        (SquirrelMail authenticated user turja)
        by webmail.mbnet.fi with HTTP;
        Sat, 18 Mar 2006 10:58:12 +0200 (EET)
Message-ID: <2052.88.192.17.186.1142672292.squirrel@webmail.mbnet.fi>
In-Reply-To: <20060318015941.GY18750@deprecation.cyrius.com>
References: <Pine.GSO.4.58.0603171412170.11482@kekkonen.cs.hut.fi>
    <20060318015941.GY18750@deprecation.cyrius.com>
Date:	Sat, 18 Mar 2006 10:58:12 +0200 (EET)
Subject: Re: [PATCH] SGI VINO driver 64-bit fix / V4L ioctl compatibility 
     layer needs fixes
From:	"Mikael Nousiainen" <turja@mbnet.fi>
To:	"Martin Michlmayr" <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <turja@mbnet.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: turja@mbnet.fi
Precedence: bulk
X-list: linux-mips

> * turja@mbnet.fi <turja@mbnet.fi> [2006-03-17 14:19]:
>> This patch should fix problems with VINO drivers when using a 64-bit
>> kernel.
>
> Did you test this?

To be honest, I didn't test this (as I didn't have 64-bit kernel available),
but the fix was quite trivial. Basically I only had to change one unsigned
long
back to u32 as the DMA addresses VINO uses are always 32-bit.
Nothing else should prevent the driver from working in a 64-bit environment.

>
> It looks exactly like the patch you gave me for testing a few days ago
> and that did not work...

Yup, it didn't work...

>
>> There are also other bugs which prevent V4L drivers from functioning
>> correctly when using 32-bit userland with a 64-bit kernel as the ioctl
>> compatibility layer (in drivers/media/video/compat_ioctl32.c) doesn't
>> seem
>> to handle VIDIOC_CROPCAP.
>
> ... or did I see this bug?

.... because the bug you saw was this. The compatibility layer
doesn't forward certain ioctls to the driver and only returns an error code.

Also please remember to download the newest version (0.7.1) of the
patched camsource from my web page when testing the driver.
The newest version has a couple of fixes which should allow
the application to work with the driver even if VIDIOC_CROPCAP fails.
But anyway the V4L ioctl compatibility layer needs to be fixed.

http://www.mbnet.fi/~turja/vino/


Mikael Nousiainen
