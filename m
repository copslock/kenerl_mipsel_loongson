Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Mar 2003 00:49:51 +0000 (GMT)
Received: from p508B652B.dip.t-dialin.net ([IPv6:::ffff:80.139.101.43]:52971
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224861AbTC2Atv>; Sat, 29 Mar 2003 00:49:51 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2T0nlO27010;
	Sat, 29 Mar 2003 01:49:47 +0100
Date: Sat, 29 Mar 2003 01:49:47 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: mipslist <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: c-r4k.c 1/7 s/switch/formula/
Message-ID: <20030329014947.A26735@linux-mips.org>
References: <m2y9309utu.fsf@neno.mitica>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m2y9309utu.fsf@neno.mitica>; from quintela@mandrakesoft.com on Fri, Mar 28, 2003 at 01:51:57AM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 28, 2003 at 01:51:57AM +0100, Juan Quintela wrote:

> 	use the same calculation for sc_size as in every other *_size.

Thanks, this pointless switch has been on my list for a while.

  Ralf
