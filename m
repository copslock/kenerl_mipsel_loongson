Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 10:33:35 +0000 (GMT)
Received: from p508B7274.dip.t-dialin.net ([IPv6:::ffff:80.139.114.116]:8331
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225192AbTBRKde>; Tue, 18 Feb 2003 10:33:34 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1IAXEm26891;
	Tue, 18 Feb 2003 11:33:14 +0100
Date: Tue, 18 Feb 2003 11:33:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Andrew Clausen <clausen@melbourne.sgi.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: weirdness in bootmem_init(), arch/mips64/kernel/setup.c
Message-ID: <20030218113314.A25047@linux-mips.org>
References: <20030218065427.GA915@pureza.melbourne.sgi.com> <86ptpplw8k.fsf@trasno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <86ptpplw8k.fsf@trasno.mitica>; from quintela@mandrakesoft.com on Tue, Feb 18, 2003 at 11:27:23AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 18, 2003 at 11:27:23AM +0100, Juan Quintela wrote:

> andrew> That test looks like it will always succeed... and it looks like the
> andrew> author wanted it to be a sanity check.
> 
> andrew> Why all this business with PFN_UP and PFN_DOWN?  (They are bit
> andrew> shifts... PFN_UP shifts left, PFN_DOWN shifts right)
> 
> Not completely sure, but I think that it is related with the weird
> discontig memory that Origins (and I think other MIPS machines) have.

It's not used on Origins.

  Ralf
