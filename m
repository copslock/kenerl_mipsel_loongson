Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jan 2004 08:18:02 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:56326 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225255AbUAWISC>;
	Fri, 23 Jan 2004 08:18:02 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AjwR0-0001DK-00; Fri, 23 Jan 2004 08:12:58 +0000
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AjwVY-0007cD-00; Fri, 23 Jan 2004 08:17:40 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16400.55534.330161.302962@doms-laptop.algor.co.uk>
Date: Fri, 23 Jan 2004 08:18:54 +0000
To: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Cc: Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org
Subject: Re: Doubt in timer interrupt
In-Reply-To: <20040122092738.52844.qmail@web10105.mail.yahoo.com>
References: <16399.36167.575161.386963@doms-laptop.algor.co.uk>
	<20040122092738.52844.qmail@web10105.mail.yahoo.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.812, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Karthi,

>     May i know the purpose of the NMI interrupt and
> in what way it differ from the timer interrupt.

On MIPS CPUs the NMI is a sort of second-class reset.  You could use
it for debugging and the kind of last-ditch everything-is-dead
watchdog interrupt you might use in a high-availability system.

Most systems don't connect it to anything.

It's not for use for regular device interrupts at all.

--
Dominic
