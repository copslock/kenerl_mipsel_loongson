Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 15:55:20 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:1922 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225203AbVAFPzQ>; Thu, 6 Jan 2005 15:55:16 +0000
Received: from sjhill by real.realitydiluted.com with local (Exim 4.34 #1 (Debian))
	id 1CmZyk-0001Gc-01; Thu, 06 Jan 2005 09:55:14 -0600
Subject: Re: [RFC] Add 4/8 bytes to 'struct k_sigaction'...
In-Reply-To: <20050106154852.GA23433@lst.de>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 6 Jan 2005 09:55:13 -0600 (CST)
CC: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1CmZyk-0001Gc-01@real.realitydiluted.com>
From: sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

> 
> #ifdef __mipseb__ maybe?
> 
I thought about that too. I spoke with Ralf on IRC privately and
there are race conditions associated with removing the module. That
aside, I was concerned about how people felt about the extra 4 or 8
bytes.

> Is IRIX emulation even working?
> 
That is what I am working on.

-Steve
