Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2008 12:11:29 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:57817 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S263499AbYC0LLZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Mar 2008 12:11:25 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2RB9kQb016279
	for <linux-mips@linux-mips.org>; Thu, 27 Mar 2008 04:09:47 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2RBAKKo017329;
	Thu, 27 Mar 2008 11:10:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2RBAJs7017328;
	Thu, 27 Mar 2008 11:10:19 GMT
Date:	Thu, 27 Mar 2008 11:10:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add missing 4KEC TLB refill handler
Message-ID: <20080327111019.GA16498@linux-mips.org>
References: <20080326154254.D6760C2B7D@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080326154254.D6760C2B7D@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 26, 2008 at 04:42:54PM +0100, Thomas Bogendoerfer wrote:

> Early 4KEc were MIPS32r1 and therefore need some love to get a TLB 
> refill handler.

Good catch.  Thanks!

  Ralf
