Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2004 11:12:13 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:44808 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224949AbUCHLMM>;
	Mon, 8 Mar 2004 11:12:12 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1B0IZd-0003m5-00; Mon, 08 Mar 2004 11:05:29 +0000
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B0Ifm-0003Kk-00; Mon, 08 Mar 2004 11:11:51 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16460.21749.492494.926880@doms-laptop.algor.co.uk>
Date: Mon, 8 Mar 2004 11:11:49 +0000
To: Long Li <long21st@yahoo.com>
Cc: Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	linux-mips@linux-mips.org, David Ung <davidu@mips.com>,
	Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <20040305170349.86540.qmail@web40413.mail.yahoo.com>
References: <16456.21112.570245.1011@arsenal.mips.com>
	<20040305170349.86540.qmail@web40413.mail.yahoo.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.85, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


I wrote:

> > We added patterns to let our (old) GCC use the new rotates and
> > bit-insert/extracts, at least in simple cases.  I'm not sure whether
> > we've put those in our 3.4 evolution tree yet, but if we have we
> > should push those out.

Long Li (long21st@yahoo.com) replied:

> Thanks for the email. Could you give me a link to your
> 3.4 evolution tree?

Interesting.  It's not as simple as I'd like: our 3.4 work is not yet
published, and I'm pretty sure it includes support for hardware etc we
haven't generally released details of yet.

Nigel (our main gcc expert) is on vacation this week.  In his absence,
David: do you know whether the rotate/insert stuff is in 3.4 yet?

--
Dominic
