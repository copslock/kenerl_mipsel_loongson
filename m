Received:  by oss.sgi.com id <S42227AbQFQDbD>;
	Fri, 16 Jun 2000 20:31:03 -0700
Received: from filer2.isc.rit.edu ([129.21.2.226]:12047 "EHLO
        filer2.isc.rit.edu") by oss.sgi.com with ESMTP id <S42218AbQFQDae>;
	Fri, 16 Jun 2000 20:30:34 -0700
Received: from hork ("port 1025"@[129.21.10.76])
 by osfmail.isc.rit.edu (PMDF V5.2-33 #41785)
 with ESMTP id <0FWA000464DYAN@osfmail.isc.rit.edu> for linux-mips@oss.sgi.com;
 Fri, 16 Jun 2000 23:30:00 -0400 (EDT)
Received: from molotov (helo=localhost)
	by hork with local-esmtp (Exim 3.12 #1 (Debian))	id 1339JQ-000056-00; Fri,
 16 Jun 2000 23:30:24 -0400
Date:   Fri, 16 Jun 2000 23:30:24 -0400 (EDT)
From:   Chris Ruvolo <csr6702@osfmail.isc.rit.edu>
Subject: TFTP Problem Resolved!
X-Sender: molotov@hork
To:     linux-mips@oss.sgi.com
Cc:     jbglaw@lug-owl.de, florian@void.s.bawue.de
Message-id: <Pine.LNX.4.21.0006162228001.504-100000@hork>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Those of you maintaing FAQs or installation instructions might want to
make note of this.

When using bootp/tftp to boot, some of us have been running into
trouble.  We are able to get an IP with bootp, but when it came to
tftping a kernel, the client would issue a request, the server would
respond, but the response would be ignored.

Apparently, this is because the "Don't Fragment" flag is being set on the
TFTP UDP data packets.  This is set by default on kernels >= 2.3.x due to
path MTU discovery!

To correct for this, either boot your tftp server with a 2.2.x kernel, or
"echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc" before you boot the remote
machine.

Thanks to the guys on #mipslinux on irc.openprojects.net for their help
figuring this problem out and testing this solution.  Ralf Baechle
informed us about the /proc configuration.

This (mis)behavior has been observed on my Indy and another machine
(Siemens?) that belongs to flawed on #mipslinux.

For clarification, this affects TFTP servers running linux 2.3.x.

Thanks for everyone's help in getting this resolved.

-Chris

PS: Yea!  My Indy works!  I've been so frustrated, I've been considering
just getting rid of it and selling it on Ebay. :)  Now I'm glad I didn't.
