Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2005 14:51:33 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:1249 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S3458490AbVKJOvQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Nov 2005 14:51:16 +0000
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 491CCC048
	for <linux-mips@linux-mips.org>; Thu, 10 Nov 2005 15:52:38 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 23EA11BC08B
	for <linux-mips@linux-mips.org>; Thu, 10 Nov 2005 15:52:42 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 494921A18A5
	for <linux-mips@linux-mips.org>; Thu, 10 Nov 2005 15:52:42 +0100 (CET)
Subject: smc91x support
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Thu, 10 Nov 2005 15:52:11 +0100
Message-Id: <1131634331.18165.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

On 21st september Peter Popov modified:
arch/mips/au1000/common/platform.c

With the log message:
smc91x platform support; requires patch to smc91x.h which was sent
        upstream.

Any news about this?
What is the patch required for smc91x.h?

I also added support for smc91x.h to enable it on the DBAU1200,
but as I wrote in another mail, I get bad performance.
I enabled the debug mode and I now I see that I get a lot of 
overruns, like:
...
[4294761.172000] eth0: RX overrun (EPH_ST 0x0001)
[4294761.190000] eth0: RX overrun (EPH_ST 0x0001)
[4294761.198000] eth0: RX overrun (EPH_ST 0x0001)
...

Is there any solution to this?
Maybe to use DDMA?

BR,
Matej
