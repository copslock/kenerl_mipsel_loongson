Received:  by oss.sgi.com id <S553885AbQKCVGL>;
	Fri, 3 Nov 2000 13:06:11 -0800
Received: from u-120.karlsruhe.ipdial.viaginterkom.de ([62.180.10.120]:53266
        "EHLO u-120.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553879AbQKCVGC>; Fri, 3 Nov 2000 13:06:02 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869485AbQKCRQJ>;
        Fri, 3 Nov 2000 18:16:09 +0100
Date:   Fri, 3 Nov 2000 18:16:09 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: HZ
Message-ID: <20001103181608.A25339@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

2.4.0-test10 finally received a mechanism which allows a userprogram to
find about the frequency at which times() is counting by calling
sysconf(_SC_CLK_TCK).  It requires glibc 2.2 from 2000-11-01 or later.
As the result I plan to remove our current kernel patches which fake
a 100HZ rate for machines with clock rates other than 100Hz as soon as
I can assume glibc 2.2 to be reasonably well established.  Since the
Linux distribution work for 2.0 is already essentilly dead I hope this
will soon be the case.

Right now DECstations are the only affected machines; everybody else can
ignore this message.

  Ralf
