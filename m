Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 16:30:34 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:12042 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225545AbUASQad>;
	Mon, 19 Jan 2004 16:30:33 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AicDZ-00042p-00; Mon, 19 Jan 2004 16:25:37 +0000
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AicHr-0003ZL-00; Mon, 19 Jan 2004 16:30:03 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16396.1546.496342.570908@gladsmuir.mips.com>
Date: Mon, 19 Jan 2004 16:30:02 +0000
To: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Cc: Dominic Sweetman <dom@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: In r4k, where does PC point to?
In-Reply-To: <20040119151403.71569.qmail@web10106.mail.yahoo.com>
References: <16395.61512.498041.811385@gladsmuir.mips.com>
	<20040119151403.71569.qmail@web10106.mail.yahoo.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.865, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Karthi,

One more try:

> > A MIPS CPU does not have a register called "PC".  In...
> 
> In the r4k user manual, it is mentioned that there is
> a special register PC in the core CPU (other than the 
> HI & LO special registers).

OK, by "register" I mean strictly something which is
software-visible - like "$2" or the coprocessor-zero register called
"EPC".

There is no PC register in my sense, and if you've found a manual
claiming that one exists, that manual is wrong - send me URL and
tell me how to find this text.

--
Dominic
