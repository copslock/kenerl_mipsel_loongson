Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Mar 2008 14:18:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:35274 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28600482AbYCQOS3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Mar 2008 14:18:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2HEIS3k026273;
	Mon, 17 Mar 2008 14:18:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2HEISSQ026272;
	Mon, 17 Mar 2008 14:18:28 GMT
Date:	Mon, 17 Mar 2008 14:18:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org
Subject: Re: Compiler error? [was: Re: new kernel oops in recent kernels]
Message-ID: <20080317141828.GA25798@linux-mips.org>
References: <1205664563.3050.4.camel@localhost> <1205699257.4159.14.camel@casa> <20080316233619.GA29511@alpha.franken.de> <1205741142.3515.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1205741142.3515.2.camel@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 17, 2008 at 09:05:42AM +0100, Giuseppe Sacco wrote:

> The patch you proposed, that use a larger buffer, does not seems to
> trigger the bug.

It may help but doesn't have a chance to be accepted upstream.  So
this is no more than an useful litmus test.

  Ralf
