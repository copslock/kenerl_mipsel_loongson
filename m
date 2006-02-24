Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 00:50:01 +0000 (GMT)
Received: from grayson.netsweng.com ([207.235.77.11]:17061 "EHLO
	grayson.netsweng.com") by ftp.linux-mips.org with ESMTP
	id S8133749AbWBXAtp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Feb 2006 00:49:45 +0000
Received: from amavis by grayson.netsweng.com with scanned-ok (Exim 3.36 #1 (Debian))
	id 1FCRGU-0003RK-00; Thu, 23 Feb 2006 19:56:58 -0500
Received: from grayson.netsweng.com ([127.0.0.1])
	by localhost (grayson [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 12970-10; Thu, 23 Feb 2006 19:56:43 -0500 (EST)
Received: from h181.242.141.67.ip.alltel.net ([67.141.242.181] helo=trantor.stuart.netsweng.com)
	by grayson.netsweng.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FCRGF-0003RF-00; Thu, 23 Feb 2006 19:56:43 -0500
Date:	Thu, 23 Feb 2006 19:56:40 -0500 (EST)
From:	Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@trantor.stuart.netsweng.com
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: [RFC] SMP initialization order fixes.
In-Reply-To: <20060223113115.GA3728@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0602231954380.5110@trantor.stuart.netsweng.com>
References: <20060222190940.GA29967@linux-mips.org>
 <Pine.LNX.4.64.0602221636300.5110@trantor.stuart.netsweng.com>
 <20060223113115.GA3728@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at netsweng.com
Return-Path: <anderson@netsweng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anderson@netsweng.com
Precedence: bulk
X-list: linux-mips

On Thu, 23 Feb 2006, Ralf Baechle wrote:

>> I'm not sure if this is the specific fix or not, but I can report that git
>> as of today (approx 2pm est) is working better than is has since 2.6.14 for
>> me on a bcm1480. I had tried git a couple of weeks ago, and it still hung
>> when I stressed it.
>
> Seems unrelated then.  This fix should make the difference between working
> perfectly or not at all.  There have been numerous other fixes since 2.6.14
> so hard to say what made the difference.

You're right, it is unrelated. Shortly after this message wnet out & came
back, it hung up again like it had been doing 8-(. I should have just kept my
mouth shut and then it would still be working.

It really did run much longer that one time, but I haven't been able to
reproduce a run that lasted that long again. Sigh....


                                 Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                  BD03 0A62 E534 37A7 9149
