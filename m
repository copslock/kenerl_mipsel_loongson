Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2004 10:03:11 +0100 (BST)
Received: from kilimandjaro.dyndns.org ([IPv6:::ffff:212.43.221.157]:5436 "HELO
	kilimandjaro.dyndns.org") by linux-mips.org with SMTP
	id <S8225296AbUFOJDH>; Tue, 15 Jun 2004 10:03:07 +0100
Received: by kilimandjaro.dyndns.org (Postfix, from userid 500)
	id 35D231F7864; Tue, 15 Jun 2004 11:02:59 +0200 (CEST)
Received: from saperlipopette ([127.0.0.1] helo=kilimandjaro.dyndns.org)
	by saperlipopette with esmtp (Exim 4.22)
	id 1Ba9qA-0003NW-T6; Tue, 15 Jun 2004 11:02:46 +0200
Message-ID: <40CEBB36.1030707@kilimandjaro.dyndns.org>
Date: Tue, 15 Jun 2004 11:02:46 +0200
From: Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
User-Agent: Mozilla Thunderbird 0.4 (X11/20040306)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: jospehchan <jospehchan@yahoo.com.tw>
Cc: linux-mips@linux-mips.org, jbglaw@lug-owl.de
Subject: Re: "No such device" with PCI card
References: <20040615020159.56838.qmail@web16612.mail.tpe.yahoo.com>
In-Reply-To: <20040615020159.56838.qmail@web16612.mail.tpe.yahoo.com>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-Path: <dom@kilimandjaro.dyndns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@kilimandjaro.dyndns.org
Precedence: bulk
X-list: linux-mips

jospehchan wrote:

>
> After loading the 8139too or usb-uhci module, the same problem
> still happened. So I doubt that something missed when configuring
> the kernel.

Sorry, but your diagnosis is not quite correct. I'm guessing you are
new to Linux kernel programming, device drivers etc (BTW, Jan-Benedict
suggested you *modify* your kernel source then recompile). Why not try
and get your USB PCI card working on a Linux PC computer first? That
would get most of your questions sorted out without compositing them
with MIPS issues. Then come back on this list and knowing that "it
works on i386" we could help you crossing the little gap remaining.
(Right now it's not even clear whether your USB card is supported by
Linux at all!)

Not to mean that this list is not ready to provide assistance to you
:-) but the MIPS platform still has rough edges, and better suited for
hardcore programmers to date. I know that because I've jumped through
those hoops myself before: I bought a desktop PCI Alpha computer
almost a decade ago and suffered no end of a pain on it :-). This was
a fun and teaching experience, sure - but also a frustrating one at times.

> BTW, how to mount the sysfs to /sys? I can not find the sysfs file
> system in kernel configuration.


As root, type:

mkdir /sys # Ignore error if already
# exists
mount /sys /sys -t sysfs

Then read up on the "Linux 2.6 device driver model":
Documentation/driver-model/* in the kernel source, and
http://lwn.net/Articles/31185/

-- 
<< Tout n'y est pas parfait, mais on y honore certainement les
jardiniers >>

Dominique Quatravaux <dom@kilimandjaro.dyndns.org>
