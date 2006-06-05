Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2006 11:23:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:32967 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133489AbWFEJXF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Jun 2006 11:23:05 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k559N4tT003612;
	Mon, 5 Jun 2006 10:23:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k559N4wn003611;
	Mon, 5 Jun 2006 10:23:04 +0100
Date:	Mon, 5 Jun 2006 10:23:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	art <art@sigrand.ru>
Cc:	linux-mips@linux-mips.org
Subject: Re: Perfomance problem on MIPS
Message-ID: <20060605092304.GA3132@linux-mips.org>
References: <15613.060605@sigrand.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15613.060605@sigrand.ru>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 05, 2006 at 02:43:47PM +0700, art wrote:

> Hello all!
>       I work with processor: MIPS 4KC.
>       I check network performance without iptables & conntrac enabled
>       and it has near 80Mbit/s.
>       When I enable (without adding rules) network performance was
>       near 40Mbit/s.
>       While testing ksoftirqd is get near 50% of cpu. And (it is so
>       strange) top eats the same! However cpu has 100% load and
>       perfomance is real bad.
>       Has anybody same problem?

Just loading the connection tracking module will pull networking
performance into a deep hole, no surprise there.  All your numbers are on
the low side though.  What clock rate is your CPU running?

  Ralf
