Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 22:02:16 +0100 (BST)
Received: from p508B5C08.dip.t-dialin.net ([IPv6:::ffff:80.139.92.8]:34663
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225993AbUE1VAW>; Fri, 28 May 2004 22:00:22 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i4SKxPwS015582;
	Fri, 28 May 2004 22:59:25 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i4SKxNql015581;
	Fri, 28 May 2004 22:59:23 +0200
Date: Fri, 28 May 2004 22:59:23 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
Cc: "'hadi@cyberus.ca'" <hadi@cyberus.ca>, linux-mips@linux-mips.org,
	sibyte-users@bitmover.com
Subject: Re: [SiByte] RE: weird sb1250 behavior
Message-ID: <20040528205923.GA14682@linux-mips.org>
References: <9DFF23E1E33391449FDC324526D1F2590283C58B@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DFF23E1E33391449FDC324526D1F2590283C58B@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5220
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 28, 2004 at 01:11:38PM -0700, Adam Kiepul wrote:

> There is a possible cache line read-after-write pseudo-dependency that, along with the code alignment in terms of the instruction pair doublewords, may do something weird to the sb1250 pipeline. Just my guess.

memcpy's source deals with what probably is another instance of the same
effect:

#ifdef CONFIG_CPU_SB1
        nop                             # improves slotting
#endif

  Ralf
