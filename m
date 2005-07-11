Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jul 2005 12:09:55 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:6674 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8226444AbVGKLJf>;
	Mon, 11 Jul 2005 12:09:35 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1DrwSD-0006bQ-00; Mon, 11 Jul 2005 12:28:05 +0100
Received: from kenton.mips.com ([192.168.192.199])
	by olympia.mips.com with smtp (Exim 3.36 #1 (Debian))
	id 1DrwAi-0005pT-00; Mon, 11 Jul 2005 12:10:00 +0100
Date:	Mon, 11 Jul 2005 12:09:59 +0100
From:	Laurence Darby <ldarby@mips.com>
To:	Alex Gonzalez <linux-mips@packetvision.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Benchmarking RM9000
Message-Id: <20050711120959.564da2f4.ldarby@mips.com>
In-Reply-To: <1120833749.28569.965.camel@euskadi.packetvision>
References: <20050708091711Z8226352-3678+1954@linux-mips.org>
	<20050708120238.GA2816@linux-mips.org>
	<1120825549.28569.949.camel@euskadi.packetvision>
	<20050708130131.GC2816@linux-mips.org>
	<1120833749.28569.965.camel@euskadi.packetvision>
X-Mailer: Sylpheed version 2.0.0beta2 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.878,
	required 4, AWL, BAYES_00)
Return-Path: <ldarby@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ldarby@mips.com
Precedence: bulk
X-list: linux-mips

Alex Gonzalez wrote:

> The performance of our video application is well below our
> expectations. We are still doing some profiling work on it, but we
> are also looking at other possibilities.
> 
> What other benchmarking tool would you recommend?


There's lmbench, available only from 
http://ftp.debian.org/debian/pool/non-free/l/lmbench/lmbench_2.0-patch2.orig.tar.gz
(the debian package itself doesn't work, and its main ftp site seems to
be down)

glxgears is nice and simple for 3d bmarks.

mplayer may be useful with its -benchmark option. Its docs, though
mostly x86 specific, are still interesting for video performance
issues.


Laurence
