Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2003 11:22:37 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:64780 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225358AbTKNLWD>;
	Fri, 14 Nov 2003 11:22:03 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AKbz8-00047Q-00; Fri, 14 Nov 2003 11:19:30 +0000
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AKc1K-0003bj-00; Fri, 14 Nov 2003 11:21:46 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16308.47817.319852.989830@gladsmuir.mips.com>
Date: Fri, 14 Nov 2003 11:21:45 +0000
To: "ashish  anand" <ashish_ibm@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: does CP0_CAUSE gets set by spurious interrupts..?.
In-Reply-To: <20031114084606.23062.qmail@webmail29.rediffmail.com>
References: <20031114084606.23062.qmail@webmail29.rediffmail.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.858, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ashish,

> would a spurious interrupt ( edge vs. level trigger mismatching)
> cause CP0_CAUSE to show any pending interupts.?

CP0_CAUSE reflects the real-time inputs to the CPU, not the state of
those inputs at the time the interrupt was detected, nor is it
sensitive to the "mask" bits in the status register.

So it's perfectly possible to find no active bits in CP0_CAUSE which
account for your interrupt.  But it does all depend how your interrupt
controller works...

--
Dominic Sweetman
MIPS Technologies
