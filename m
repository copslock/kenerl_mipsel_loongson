Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2004 12:15:50 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:58120 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225229AbUCHMPt>;
	Mon, 8 Mar 2004 12:15:49 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1B0JZ5-0004kh-00; Mon, 08 Mar 2004 12:08:59 +0000
Received: from stockwell.mips.com ([192.168.192.238])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B0Jf3-00049F-00; Mon, 08 Mar 2004 12:15:09 +0000
Subject: Re: gcc support of mips32 release 2
From: David Ung <davidu@mips.com>
To: Dominic Sweetman <dom@mips.com>
Cc: Long Li <long21st@yahoo.com>,
	Eric Christopher <echristo@redhat.com>,
	linux-mips@linux-mips.org, Nigel Stephens <nigel@mips.com>
In-Reply-To: <16460.21749.492494.926880@doms-laptop.algor.co.uk>
References: <16456.21112.570245.1011@arsenal.mips.com>
	 <20040305170349.86540.qmail@web40413.mail.yahoo.com>
	 <16460.21749.492494.926880@doms-laptop.algor.co.uk>
Content-Type: text/plain
Organization: MIPS Technologies UK
Message-Id: <1078748108.2483.13.camel@stockwell.mips.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Mar 2004 12:15:08 +0000
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.622, required 4, AWL,
	BAYES_00)
Return-Path: <davidu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davidu@mips.com
Precedence: bulk
X-list: linux-mips

On Mon, 2004-03-08 at 11:11, Dominic Sweetman wrote:
> I wrote:
> 
> > > We added patterns to let our (old) GCC use the new rotates and
> > > bit-insert/extracts, at least in simple cases.  I'm not sure whether
> > > we've put those in our 3.4 evolution tree yet, but if we have we
> > > should push those out.
> 
> Long Li (long21st@yahoo.com) replied:
> 
> > Thanks for the email. Could you give me a link to your
> > 3.4 evolution tree?
> 
> Interesting.  It's not as simple as I'd like: our 3.4 work is not yet
> published, and I'm pretty sure it includes support for hardware etc we
> haven't generally released details of yet.
> 
> Nigel (our main gcc expert) is on vacation this week.  In his absence,
> David: do you know whether the rotate/insert stuff is in 3.4 yet?
> 

No, it is not part of the our 3.4 extension yet, but it is part of SDE.
I think the support for rotates already exists in the 3.4 mainline.

David.
