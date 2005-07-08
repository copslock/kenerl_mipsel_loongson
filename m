Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 14:55:02 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:37131 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8226355AbVGHNyq>;
	Fri, 8 Jul 2005 14:54:46 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1DqtbD-0008GS-00; Fri, 08 Jul 2005 15:13:03 +0100
Received: from kenton.mips.com ([192.168.192.199])
	by olympia.mips.com with smtp (Exim 3.36 #1 (Debian))
	id 1DqtJf-0000RF-00; Fri, 08 Jul 2005 14:54:55 +0100
Date:	Fri, 8 Jul 2005 14:54:54 +0100
From:	Laurence Darby <ldarby@mips.com>
To:	Alex Gonzalez <linux-mips@packetvision.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Benchmarking RM9000
Message-Id: <20050708145454.7d5f9c74.ldarby@mips.com>
In-Reply-To: <1120825549.28569.949.camel@euskadi.packetvision>
References: <20050708091711Z8226352-3678+1954@linux-mips.org>
	<20050708120238.GA2816@linux-mips.org>
	<1120825549.28569.949.camel@euskadi.packetvision>
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
X-archive-position: 8408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ldarby@mips.com
Precedence: bulk
X-list: linux-mips

Alex Gonzalez wrote:

> Hi,
> 
> I am doing some basic benchmarking tests on our RM9000 based platform,
> running on just one of the two cores (non-smp kernel).

<snip>

> TEST                : Iterations/sec.  : Old Index   : New Index
>                     :                  : Pentium 90* : AMD K6/233*
> --------------------:------------------:-------------:------------>
> NUMERIC SORT        :          360.48  :       9.24  :       3.04


I'd expect a K6 to be able to do more Iterations per second than a
Pentium 90, not fewer. 


Laurence
