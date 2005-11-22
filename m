Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 12:39:05 +0000 (GMT)
Received: from alg145.algor.co.uk ([62.254.210.145]:64013 "EHLO
	dmz.algor.co.uk") by ftp.linux-mips.org with ESMTP id S3466290AbVKVMir
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 12:38:47 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1EeXOn-0004H3-00; Tue, 22 Nov 2005 12:37:25 +0000
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EeXSQ-0003FB-00; Tue, 22 Nov 2005 12:41:11 +0000
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17283.4578.898036.622893@gargle.gargle.HOWL>
Date:	Tue, 22 Nov 2005 12:41:06 +0000
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Knittel, Brian" <Brian.Knittel@powertv.com>,
	linux-mips@linux-mips.org
Subject: Re: Saving arguments on the stack
In-Reply-To: <20051122113801.GC2706@linux-mips.org>
References: <762C0A863A7674478671627FEAF5848105AF92D2@hqmail01.powertv.com>
	<20051122113801.GC2706@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.848,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Brian,

> > I'd like to force the compiler to store arguments on the stack
> > with otherwise optimized code.

Sounds like you're out of luck.  Perhaps you'd do better to go one
step back and explain what you're trying to do?

--
Dominic Sweetman
MIPS Technologies
