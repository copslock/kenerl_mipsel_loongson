Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 15:52:05 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19093 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026792AbYBSPwC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Feb 2008 15:52:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1JFpumn029314;
	Tue, 19 Feb 2008 15:51:56 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1JFpu4f029313;
	Tue, 19 Feb 2008 15:51:56 GMT
Date:	Tue, 19 Feb 2008 15:51:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Michael Buesch <mb@bu3sch.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux MIPS PCI resource sanity check
Message-ID: <20080219155156.GA29067@linux-mips.org>
References: <200802161139.10791.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200802161139.10791.mb@bu3sch.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 16, 2008 at 11:39:10AM +0100, Michael Buesch wrote:

Can you take a look at ed6d14f9760857c745206c978b80352fc09cfd19 which fixed
a somewhat similar problem for i386, does that seem to be related to your
problem?

The i386 fix makes sense so I'm almost decieded to apply to the MIPS code
even if it should turn out not to make a difference for you.

  Ralf
