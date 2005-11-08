Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 01:40:51 +0000 (GMT)
Received: from grayson.netsweng.com ([207.235.77.11]:52968 "EHLO
	grayson.netsweng.com") by ftp.linux-mips.org with ESMTP
	id S8135590AbVKHBk1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Nov 2005 01:40:27 +0000
Received: from amavis by grayson.netsweng.com with scanned-ok (Exim 3.36 #1 (Debian))
	id 1EZIUV-0003LC-00
	for <linux-mips@linux-mips.org>; Mon, 07 Nov 2005 20:41:39 -0500
Received: from grayson.netsweng.com ([127.0.0.1])
	by localhost (grayson [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12653-03 for <linux-mips@linux-mips.org>;
	Mon, 7 Nov 2005 20:41:30 -0500 (EST)
Received: from h168.98.28.71.ip.alltel.net ([71.28.98.168] helo=trantor.stuart.netsweng.com)
	by grayson.netsweng.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EZIUM-0003L0-00
	for <linux-mips@linux-mips.org>; Mon, 07 Nov 2005 20:41:30 -0500
Date:	Mon, 7 Nov 2005 20:41:28 -0500 (EST)
From:	Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@trantor.stuart.netsweng.com
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS - 64bit woes
In-Reply-To: <436FD396.9080807@jg555.com>
Message-ID: <Pine.LNX.4.61.0511072036340.3511@trantor.stuart.netsweng.com>
References: <436D0061.5070100@jg555.com> <436D3DF7.5000002@gentoo.org>
 <436FD396.9080807@jg555.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at netsweng.com
Return-Path: <anderson@netsweng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anderson@netsweng.com
Precedence: bulk
X-list: linux-mips

On Mon, 7 Nov 2005, Jim Gifford wrote:

> I've talked to a few others, who are having similar issues also Kumba, I made 
> a diff of 2.6.12 and 2.6.14, trying to figure out what's causing this. Looks 
> like some major rewrites have occured in some areas.

I have a 2.6.14-rc1 kernel that works great, and when I tried
2.6.14-rc2, it would have up on boot. In my case, I'm using NFS root,
and the networking would just go away when the system got busy. This
would cause the nfsroot to hang, and then any process that touched a file
would hang. It sort of felt like interrupts stopped working, but I was
not able to verify that. It seems that a serial console continued to
work, so it doesn't seem like all interrupts stopped working.

I have backported nearly all of the relevent arch/mips files to my
2.6.14-rc1 tree, and everything is still happy, so I'm inclined to think
it might not be something inside arch/mips.

I've stared at the diffs between rc1 and rc2 until I'm corss-eyed, but nothing
has jumped out at me as being obviously broken.

                                 Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                  BD03 0A62 E534 37A7 9149
