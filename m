Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Dec 2005 16:55:22 +0000 (GMT)
Received: from alg145.algor.co.uk ([62.254.210.145]:21257 "EHLO
	dmz.algor.co.uk") by ftp.linux-mips.org with ESMTP id S8133481AbVLPQzF
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Dec 2005 16:55:05 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1EnIpi-0007Zh-00; Fri, 16 Dec 2005 16:53:26 +0000
Received: from olympia.mips.com ([192.168.192.128] helo=boris)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EnIro-0005vl-00; Fri, 16 Dec 2005 16:55:36 +0000
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17314.61848.570755.340908@mips.com>
Date:	Fri, 16 Dec 2005 16:55:52 +0000
To:	madprops@gmx.net
Cc:	linux-mips@linux-mips.org
Subject: Re: Timer interrupts
In-Reply-To: <2987.1134747276@www10.gmx.net>
References: <2987.1134747276@www10.gmx.net>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.856,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


> i'm using CP0_Count/CP0_Compare to get timer interrupts. They should be
> turned off while being in kernel mode (performing syscalls / handling
> tlb-misses etc) and enabled in user mode. 

This isn't going to work.  The hardware does nothing to inhibit
interrupts in kernel mode, and the system depends on them (performance
would be truly dreadful if no interrupt could be taken in kernel mode).

The kernel is already using CP0_Status and Count/Compare for its own
purposes, which you will be breaking...

Whatever it is you were trying to do, you need to do some other way!

--
Dominic Sweetman
MIPS Technologies
