Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 13:19:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:8384 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133506AbWEaLTc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 13:19:32 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4VBJ1mT005130;
	Wed, 31 May 2006 12:19:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4VBJ0de005129;
	Wed, 31 May 2006 12:19:00 +0100
Date:	Wed, 31 May 2006 12:19:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Roman Mashak <mrv@corecom.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: Re: compiling BCM5700 driver
Message-ID: <20060531111900.GA4944@linux-mips.org>
References: <000101c6838e$437abdf0$9d0ba8c0@mrv> <20060530140616.GA18432@linux-mips.org> <001001c68455$29746ba0$9d0ba8c0@mrv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001c68455$29746ba0$9d0ba8c0@mrv>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 31, 2006 at 10:54:31AM +0900, Roman Mashak wrote:

> I'm more concerned with Titan GE driver on "Sequoia" board (by PMC-sierra). 
> What's the status of this driver in 2.4.26? If I understand correct - it's 
> maintained now only in 2.6.x? Upon compilation of 2.4.26 for Sequoia" board 
> and installation on to target, we observed a lot of CRC errors on gigabit 
> ethernet (we used SmartBit for testing). Is the driver in this version 
> broken?

Likely.  There is a new Titan driver written from scratch which permitting
time hope to integrate soon but nothing like that will happen for 2.4.
2.4 has a shrinking userbase and all focus is on 2.6, and hardly a
distribution or platform still needs 2.4 so there is very little happening
wrt. to Linux 2.4 these days.

  Ralf
