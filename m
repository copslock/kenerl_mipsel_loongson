Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Mar 2005 22:43:38 +0000 (GMT)
Received: from p3EE066C8.dip.t-dialin.net ([IPv6:::ffff:62.224.102.200]:2689
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224917AbVCTWnX>; Sun, 20 Mar 2005 22:43:23 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2KMg54g014935;
	Sun, 20 Mar 2005 22:42:05 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2KMg5mT014891;
	Sun, 20 Mar 2005 22:42:05 GMT
Date:	Sun, 20 Mar 2005 22:42:05 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Brian Murphy <brm@murphy.dk>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] R43XX tlb write entry missing
Message-ID: <20050320224205.GC6727@linux-mips.org>
References: <200503201944.j2KJiaPc021625@brian.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503201944.j2KJiaPc021625@brian.localnet>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 20, 2005 at 08:44:36PM +0100, Brian Murphy wrote:

> Hi Ralf,
> 	the R43XX is missing an entry in the tlbw synthesizer.
> Here is a patch.

Are you testing on a R4300 series processor?  I think I've not had any
test reports in years.

  Ralf
