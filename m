Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2005 17:02:34 +0100 (BST)
Received: from smtp-out.hotpop.com ([IPv6:::ffff:38.113.3.61]:55682 "EHLO
	smtp-out.hotpop.com") by linux-mips.org with ESMTP
	id <S8226533AbVGMQCP> convert rfc822-to-8bit; Wed, 13 Jul 2005 17:02:15 +0100
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id DDD5113E8C3D
	for <linux-mips@linux-mips.org>; Wed, 13 Jul 2005 16:03:11 +0000 (UTC)
Received: from cavan (unknown [62.253.252.7])
	by smtp-2.hotpop.com (Postfix) with ESMTP id 3378A13E8BFB
	for <linux-mips@linux-mips.org>; Wed, 13 Jul 2005 16:03:05 +0000 (UTC)
Date:	Wed, 13 Jul 2005 16:00:00 +0000
From:	jaypee@hotpop.com
Subject: Au1550 ethernet throughput low
To:	linux-mips <linux-mips@linux-mips.org>
X-Mailer: Balsa 2.3.3
Message-Id: <1121270402l.7656l.3l@cavan>
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
X-archive-position: 8478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaypee@hotpop.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,
I've got a au1550 board based largely on the pb1550. The ethernet  
throughput is ~66Mbps using the 2.6 kernel. This also consumes a
lot of cpu cycles to send.

We have older designs using au1000 and mvista 2.4 kernel that achieve  
full line rate throughput without using a lot of the cpu.

Can someone with a pb/db1550 and linux 2.6 do a quick test to verify
that is is not a 2.6 kernel problem, and is a problem with our HW/SW.

If anyone can do the same with a 2.4 kernel too that would be great.

Thanks,
JP

- -- 
mailto:jaypee@hotpop.com
http://www.jaypee.org.uk
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1TqCZDxnKy3oOpYRAhwaAKCoY/3lEX/DksOEq42FfxlsF2rjEgCeNI0G
/72t16fNrA4XvX+KVumsNDw=
=yoD8
-----END PGP SIGNATURE-----
