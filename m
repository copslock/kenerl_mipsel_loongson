Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2005 15:15:29 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:33508 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3457893AbVKJPPL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2005 15:15:11 +0000
Received: from localhost (p5132-ipad207funabasi.chiba.ocn.ne.jp [222.145.87.132])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5EAB8AC43; Fri, 11 Nov 2005 00:16:39 +0900 (JST)
Date:	Fri, 11 Nov 2005 00:15:43 +0900 (JST)
Message-Id: <20051111.001543.93019156.anemo@mba.ocn.ne.jp>
To:	matej.kupljen@ultra.si
Cc:	linux-mips@linux-mips.org
Subject: Re: smc91x support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1131634331.18165.30.camel@localhost.localdomain>
References: <1131634331.18165.30.camel@localhost.localdomain>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 10 Nov 2005 15:52:11 +0100, Matej Kupljen <matej.kupljen@ultra.si> said:

matej> What is the patch required for smc91x.h?

I also want to know about the patch.

matej> I also added support for smc91x.h to enable it on the DBAU1200,
matej> but as I wrote in another mail, I get bad performance.  I
matej> enabled the debug mode and I now I see that I get a lot of
matej> overruns, like:
matej> ...
matej> [4294761.172000] eth0: RX overrun (EPH_ST 0x0001)
matej> [4294761.190000] eth0: RX overrun (EPH_ST 0x0001)
matej> [4294761.198000] eth0: RX overrun (EPH_ST 0x0001)
matej> ...

matej> Is there any solution to this?

I have similar problem on my several custom boards with SMC91C111.  I
see so many RX overrun, but I can not see why it happens.  Forcing to
10Mbps/HalfDuplex reduced the overrun count (and works better than
100Mbps), but it is not preferable, of course ...

---
Atsushi Nemoto
