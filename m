Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 08:42:54 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:9235 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225254AbUAVImy>;
	Thu, 22 Jan 2004 08:42:54 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AjaLY-0002eC-00; Thu, 22 Jan 2004 08:37:52 +0000
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AjaQ9-0004Oi-00; Thu, 22 Jan 2004 08:42:38 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16399.36167.575161.386963@doms-laptop.algor.co.uk>
Date: Thu, 22 Jan 2004 08:43:51 +0000
To: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Doubt in timer interrupt
In-Reply-To: <20040122072407.11156.qmail@web10102.mail.yahoo.com>
References: <20040122072407.11156.qmail@web10102.mail.yahoo.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.838, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Karthi,

>   In R4000 & descendent processors, interrupt number 7
> is being used for internal timer interrupt. From this
> i understand that the timer interrupt is also maskable
> when the IE bit in status register is cleared. If 
> somebody mask this interrupt for a long time 
> erroneously, then won't there be a problem in 
> maintaining the system time?

Yes, there may be a long delay.  So the standard way of using the
onchip counter to generate a periodic interrupt is that the counter
itself is allowed to free-run, keeping accurate time.

The 'Compare' register is then incremented by a fixed amount.

So long as the interrupt is not delayed by a whole tick, this keeps
perfect time.

I'm sure this is described in "See MIPS Run" - do you have a copy?

--
Dominic Sweetman
MIPS Technologies Inc
