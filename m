Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 14:57:27 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:522 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224914AbUASO50>;
	Mon, 19 Jan 2004 14:57:26 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AialS-0002tb-00; Mon, 19 Jan 2004 14:52:30 +0000
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Aiaq1-0000F3-00; Mon, 19 Jan 2004 14:57:13 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16395.61512.498041.811385@gladsmuir.mips.com>
Date: Mon, 19 Jan 2004 14:57:12 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: karthikeyan natarajan <karthik_96cse@yahoo.com>,
	linux-mips@linux-mips.org
Subject: Re: In r4k, where does PC point to?
In-Reply-To: <20040119145017.GA9141@linux-mips.org>
References: <20040119074219.15886.qmail@web10106.mail.yahoo.com>
	<20040119145017.GA9141@linux-mips.org>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.864, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


> >     Basically, the PC points to the next instruction
> > to
> > be executed. But, in R4k, there are 8 instructions
> > getting executed in parallel. Where does the PC point
> > to? My understanding is that PC points to the next 
> > instruction that will be entered into the pipeline.
> >     Please correct me if i am wrong..

Ralf Baechle (ralf@linux-mips.org) writes:
 
> The fact that instructions are issued in a pipeline is not visible in
> the EPC value.

Which is true, but perhaps a bit cryptic given the question.

A MIPS CPU does not have a register called "PC".  In the MIPS
architecture, "PC" is just slang meaning "the address of this
instruction" - and only makes any sense if you're prepared to say
WHICH instruction you mean.

There IS a register called "EPC" (for "exception PC").  When you
take any kind of exception, it's the address of the first instruction
which didn't get run because the CPU took the exception instead.  So
EPC tells you where to jump back to after the exception handler runs.

Did any of that make any sense?

--
Dominic Sweetman
MIPS Technologies.
