Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2005 09:21:00 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.61]:21679 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8226643AbVGOIUn> convert rfc822-to-8bit; Fri, 15 Jul 2005 09:20:43 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2179014242C8
	for <linux-mips@linux-mips.org>; Fri, 15 Jul 2005 08:21:48 +0000 (UTC)
Received: from cavan (unknown [62.253.252.7])
	by smtp-3.hotpop.com (Postfix) with ESMTP
	id 3A83A16DB4A2; Fri, 15 Jul 2005 08:21:43 +0000 (UTC)
Date:	Fri, 15 Jul 2005 08:21:38 +0000
From:	jaypee@hotpop.com
Subject: Re: Au1550 ethernet throughput low
To:	Clem Taylor <clem.taylor@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
References: <1121270402l.7656l.3l@cavan>
	<1121353347.10582.3.camel@orionlinux.starfleet.com>
	<1121354144l.5178l.2l@cavan> <ecb4efd1050714171318ce81aa@mail.gmail.com>
In-Reply-To: <ecb4efd1050714171318ce81aa@mail.gmail.com> (from
	clem.taylor@gmail.com on Fri Jul 15 01:13:29 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1121415711l.5178l.3l@cavan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Return-Path: <jaypee@hotpop.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On 15/07/05 01:13:29, Clem Taylor wrote:
> The source I'm using originated from http://www.linux-mips.org/. It
> was checked out from the head of
> ':pserver:cvs@ftp.linux-mips.org:/home/cvs' on 2005.03.18. At the time
> of checkout, the linux-mips tree was missing a 2.6.11 tag. The closest
> tag was linux_2_6_11_rc5, but the code is 2.6.11.

Mine was checked out at the latest was 2.6.11 rc3.

> Yeah, UDP is running at near line rate, but it does consume a bunch of
> CPU. I'm running our 1550s at 492MHz, but I have to run the memory at
> 123MHz (DDR). I just ran the test again, here's what ttcp said:
> 

Same here expect memory is at 166

> udp recv on au1550
> ttcp -u -r -s -n 16384 -l 32768 -A 32768 -v -b 262144 -f M
> ttcp-r: buflen=32768, nbuf=16384, align=32768/0, port=5001,
> sockbufsize=262144  udp
> ttcp-r: 536608768 bytes in 44.72 real seconds = 11.44 MB/sec +++
> ttcp-r: 536608768 bytes in 17.41 CPU seconds = 29.39 MB/cpu sec
> ttcp-r: 16378 I/O calls, msec/call = 2.80, calls/sec = 366.21
> ttcp-r: 0.1user 17.2sys 0:44real 38% 0i+0d 0maxrss 0+7pf 16344+13csw
> 

That looks ok though (Well it would be good enough for my application).

Yours is using ~30% cpu to send 100Mbps.
Mine is using 100% to send 66Mbps.

I've just checked out and  merged the latest CVS.
There were a few compile problems but I'll iron them out today and see  
if that solves the problem. It is encouraging that someone has this
working though.

Thanks again

- -- 
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC13IfZDxnKy3oOpYRAtrpAKDXFwbVpxD0c4g6aWvknTrzYddLMQCdFmvP
m8mDpiQYKerMjxJr9YhH/lg=
=qDeX
-----END PGP SIGNATURE-----
