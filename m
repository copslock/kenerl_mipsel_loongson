Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 17:09:02 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:17162 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225547AbUASRIo>;
	Mon, 19 Jan 2004 17:08:44 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AicoW-0004Xt-00; Mon, 19 Jan 2004 17:03:48 +0000
Received: from gladsmuir.algor.co.uk ([172.20.192.66] helo=gladsmuir.mips.com)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Aicsv-0004C7-00; Mon, 19 Jan 2004 17:08:21 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16396.3844.762068.691269@gladsmuir.mips.com>
Date: Mon, 19 Jan 2004 17:08:20 +0000
To: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
Subject: Re: In r4k, where does PC point to?
In-Reply-To: <20040119154538.92376.qmail@web10108.mail.yahoo.com>
References: <20040119152214.GA9933@linux-mips.org>
	<20040119154538.92376.qmail@web10108.mail.yahoo.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.866, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


> Am curious to know, how the PC register can be used to
> locate the instruction which caused the exception as 
> the exception can happen at any one of the eight 
> pipeline stages..

You can't, of course, because there isn't a "PC register".  But now I
understand your question...

Most MIPS implementations actually respond to all exceptions at the
same pipe-stage.  (If you took exceptions when you first noticed them,
an early-stage event like a I-side TLBmiss might happen before a
D-side TLBmiss for an instruction which is earlier in the instruction
stream... and that would be bad.  We're pretending this is a
sequential processor).

So exception conditions detected early in the pipe set a flag which is
then carried down the pipeline and always looked at in the same stage.

The choice of which stage to do this is somewhat implementation
dependent; it wants to be the last stage where you can find out that
an exception is needed.  Generally that will be about the same time as
you'd access the D-cache (you may get exceptions when you're
translating the D-address).

So there needs to be a way to figure out the address where the
instruction currently at the "X" pipestage came from.  You need that
for exceptions; but you also need it (for example) when executing a
'jal' instruction and figuring out the return address.

A conceptually simple way to do this is to carry the instruction's
address along the pipeline with it, in case you need it.  But
sometimes CPU designers do something more complicated to save the
storage.

> Here is the link..
> http://www.cag.lcs.mit.edu/raw/documents/R4400_Uman_book_Ed2.pdf
> 
> The documentation about the PC is present in the chapter-1 under the
> section "CPU Register Overview".
> 
> Please let me know whether this manual is correct.

Ah, that book.  That picture is nonsense, really.  Sorry, that
happens!

--
Dominic Sweetman
MIPS Technologies.
