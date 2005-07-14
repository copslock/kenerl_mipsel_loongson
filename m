Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 17:13:08 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.61]:6542 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8226711AbVGNQMs> convert rfc822-to-8bit; Thu, 14 Jul 2005 17:12:48 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7704B14090C8
	for <linux-mips@linux-mips.org>; Thu, 14 Jul 2005 16:13:47 +0000 (UTC)
Received: from cavan (unknown [62.253.252.7])
	by smtp-1.hotpop.com (Postfix) with ESMTP id 0EAB51A0237
	for <linux-mips@linux-mips.org>; Thu, 14 Jul 2005 15:15:43 +0000 (UTC)
Date:	Thu, 14 Jul 2005 15:15:42 +0000
From:	jaypee@hotpop.com
Subject: Re: Au1550 ethernet throughput low
To:	linux-mips <linux-mips@linux-mips.org>
References: <1121270402l.7656l.3l@cavan>
	<1121353347.10582.3.camel@orionlinux.starfleet.com>
In-Reply-To: <1121353347.10582.3.camel@orionlinux.starfleet.com> (from
	matej.kupljen@ultra.si on Thu Jul 14 16:02:26 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1121354144l.5178l.2l@cavan>
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
X-archive-position: 8492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> I've got a au1550 board based largely on the pb1550. The ethernet
> throughput is ~66Mbps using the 2.6 kernel. This also consumes a
> lot of cpu cycles to send.

I put a test into YAMON and I can get full line rate out no problem.

I think this narrows it down to a problem with the kernel or my port
of it.

The actual au1000_eth driver doesn't do much work other than copy a  
packet into cache aligned buffer. It must be more to do with the  
scheduling of sending a new packet. tx_ack.

The kernel I'm using is a snapshot linux-mips CVS of 2.6.11-rc5.
Can anyone tell me if there improvements/fixes to this area since then?

Clem sent me the output of a test. In which he is getting 11MBs
I'm assuming the B is bytes in which case that is as near line rate as
dammit.

Clem you said were using 2.6.11 was that a kernel.org kernel or one
from linux-mips.org?

thnks for running the test clem.


- -- 
JP
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1oGgZDxnKy3oOpYRAvw4AJ4kkGrJ/DneIqfkXYfyrKqJ5k2u1wCgo0oQ
0BYyAl8y5rBzgh1dBczJKpY=
=icdF
-----END PGP SIGNATURE-----
