Received:  by oss.sgi.com id <S42253AbQFRQhF>;
	Sun, 18 Jun 2000 09:37:05 -0700
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:24556 "EHLO
        altrade.nijmegen.inter.nl.net") by oss.sgi.com with ESMTP
	id <S42212AbQFRQgp>; Sun, 18 Jun 2000 09:36:45 -0700
Received: from whale.dutch.mountain by altrade.nijmegen.inter.nl.net
	via 1Cust62.tnt19.rtm1.nl.uu.net [213.53.12.62] with ESMTP for <linux-mips@oss.sgi.com>
	id SAA29575 (8.8.8/3.41); Sun, 18 Jun 2000 18:36:15 +0200 (MET DST)
Received: from localhost(really [127.0.0.1]) by whale.dutch.mountain
	via in.smtpd with smtp
	id <m133i2Q-0006DoC@whale.dutch.mountain>
	for <linux-mips@oss.sgi.com>; Sun, 18 Jun 2000 18:35:10 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #2 built 1996-Nov-26)
Date:   Sun, 18 Jun 2000 18:35:09 +0200 (MET DST)
From:   Richard van den Berg <R.vandenBerg@inter.NL.net>
X-Sender: ravdberg@whale.dutch.mountain
To:     linux-mips@oss.sgi.com
Subject: Re: Kinda related to Linux
In-Reply-To: <394CF02E.89BBBB37@bellsouth.net>
Message-ID: <Pine.LNX.3.95.1000618183104.485B-100000@whale.dutch.mountain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, 18 Jun 2000, dave wrote:

> Hello,
> I did not know where else to send this to. I originally subscribed to
> see if there was anyway I could  help. Have been reading the posts and
> decided all I can do is try out stuff you guys port. As far as working
> on the port, the posts read to me like a 4th grader would look at
> quantum physics.
> My problem is I can't get my Indy to go through my Linux box to the
> 'net. It  (Linux,Irix) will not transfer  eth0 to ppp. Have tried
> everything I know of, read or just made upwith no luck. In /etc/hosts on
> Indy I must have my ISP or it reads "network unknown" in ping. Have I
> missed something major/minor in Irix 6.2 or is it in Linux? I do not
> mean to be a pain in the ***, but would like to get this resolved so I
> can get Linux on Indy and really screw it up!
> Thanks in advance for any help anyone would be willing to give.
> Dave Keen

Make sure your Linux box is running a kernel with support for a kind of
packet filtering like ipfwadm or ipchains. There are HOWTO's available for
this. 

Regards,
Richard
