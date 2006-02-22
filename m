Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Feb 2006 21:35:01 +0000 (GMT)
Received: from grayson.netsweng.com ([207.235.77.11]:3037 "EHLO
	grayson.netsweng.com") by ftp.linux-mips.org with ESMTP
	id S8133731AbWBVVen (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Feb 2006 21:34:43 +0000
Received: from amavis by grayson.netsweng.com with scanned-ok (Exim 3.36 #1 (Debian))
	id 1FC1k9-0002n1-00
	for <linux-mips@linux-mips.org>; Wed, 22 Feb 2006 16:41:53 -0500
Received: from grayson.netsweng.com ([127.0.0.1])
	by localhost (grayson [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10644-03 for <linux-mips@linux-mips.org>;
	Wed, 22 Feb 2006 16:41:45 -0500 (EST)
Received: from h181.242.141.67.ip.alltel.net ([67.141.242.181] helo=trantor.stuart.netsweng.com)
	by grayson.netsweng.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FC1k1-0002mw-00
	for <linux-mips@linux-mips.org>; Wed, 22 Feb 2006 16:41:45 -0500
Date:	Wed, 22 Feb 2006 16:41:43 -0500 (EST)
From:	Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@trantor.stuart.netsweng.com
To:	linux-mips@linux-mips.org
Subject: Re: [RFC] SMP initialization order fixes.
In-Reply-To: <20060222190940.GA29967@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0602221636300.5110@trantor.stuart.netsweng.com>
References: <20060222190940.GA29967@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at netsweng.com
Return-Path: <anderson@netsweng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anderson@netsweng.com
Precedence: bulk
X-list: linux-mips

On Wed, 22 Feb 2006, Ralf Baechle wrote:

> This one should hopefully fix the SMP problems of the resent times.  It
> works on Malta with 34K, it seems to work on IP27 (the kernel is
> presumably failing due to other issues), so now I'd ask especially
> RM9000 & BCM1250 users for testing.  This really needs to be fixed for
> 2.6.16.

I'm not sure if this is the specific fix or not, but I can report that git
as of today (approx 2pm est) is working better than is has since 2.6.14 for
me on a bcm1480. I had tried git a couple of weeks ago, and it still hung
when I stressed it.

I use NFS root, and the stress test that would hang the system is simply
"make -j 4" of the kernel. Previously this would hang the syste before
finishing.

Now that things seem to be better, I'll leave this looping for a while,
and then run some other tests. It's time to run the ltp on the 3 different
ABIs again anyway.


                                  Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                   BD03 0A62 E534 37A7 9149
