Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2003 23:39:08 +0000 (GMT)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:20449 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225421AbTLJXjI>; Wed, 10 Dec 2003 23:39:08 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc12) with SMTP
          id <200312102339000140080imbe>
          (Authid: kumba12345);
          Wed, 10 Dec 2003 23:39:00 +0000
Message-ID: <3FD7AEAB.9020908@gentoo.org>
Date: Wed, 10 Dec 2003 18:39:23 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
References: <Pine.GSO.4.21.0312101203110.6456-100000@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0312101203110.6456-100000@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:

> That's different from what I'm seeing. My box doesn't respond at all.

That's what I thought was happening initially, but I noticed that a 
very, very minute trickle of data gets through.  Not enough to really be 
useful, but it indicates that it isn't a total freeze.  Things like ssh 
will eventually time out simply because they don't wait around long 
enough for a response.


> I don't know what these registers mean, but tulip_select_media() doesn't seem
> to affect the 21st register directly. Perhaps as a hardware side effect?

I'm not too sure.  The only tool I got running was mii-diag.  tulip-diag 
won't compile on mips due to differences in the includes (I haven't 
tinkered with it enough to make it compile yet).


> Here it is. I've been using it on 2.4.21 for more than 6 months. I upgraded to
> 2.4.23 9 days ago, and so far I haven't seen any of the printk()s, though.
> 
> Without the patch, the driver switches from 10-baseT to 10-base2
> unconditionally if the problem happens.
> With the patch, the switch is performed only if there's no 10-baseT link beat,
> and the driver recovers after a few minutes. This may still cause an annoying
> hick up, but the network (incl. open TCP connections) recovers.

Well, this patch definitely alter's the tulip's behavior.  It's staying 
up for longer periods of time.  I have a gentoo install that I kludged 
on the cobalt over a pre-existing debian install, and before, an "emerge 
rsync" didn't even make its way through receiving the rsync file list. 
Now with this patch, "emerge rsync" got about 80% complete before tulip 
hung.  I wound up powering the machine down and restarting it to get 
tulip to work again, and it lasted a good while before hanging again.  I 
restarted the interface the second time, and now it's going fine, so 
I'll see if it hangs again.

When it does mess up, mii-diag reports the same exact change on the 21st 
register, so that means something...I just wish I knew what...

It would seem the patch does correct one of the conditions that makes 
tulip act up....It would appear there is another condition still 
triggering it, but not as frequently.


> I have a 21041, using 10-baseT on a 10 Mbit hub. What Tulip does the Cube have?

My cobalt looks to have a Digital 21143-PD chip.  I know it's got 
something funny with the eeprom, as it requires a kernel patch to read 
the eeprom properly and detect the chip in the first place.  The machine 
itself is used in 100mbps mode on a 16-port netgear switch.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
