Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 15:07:31 +0200 (CEST)
Received: from mx2.mips.com ([206.31.31.227]:22527 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1123930AbSJDNHR>;
	Fri, 4 Oct 2002 15:07:17 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g94D72Nf016373;
	Fri, 4 Oct 2002 06:07:02 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA00681;
	Fri, 4 Oct 2002 06:07:31 -0700 (PDT)
Received: (from hartvige@localhost)
	by copfs01.mips.com (8.11.4/8.9.0) id g94D72G02838;
	Fri, 4 Oct 2002 15:07:02 +0200 (MEST)
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200210041307.g94D72G02838@copfs01.mips.com>
Subject: Re: Promblem with PREF (prefetching) in memcpy
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 4 Oct 2002 15:07:02 +0200 (MEST)
Cc: carstenl@mips.com (Carsten Langgaard),
	dom@algor.co.uk (Dominic Sweetman),
	ralf@linux-mips.org (Ralf Baechle), linux-mips@linux-mips.org
In-Reply-To: <1033736983.31861.26.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Oct 04, 2002 02:09:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hartvige@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 367
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hartvige@mips.com
Precedence: bulk
X-list: linux-mips

Yes, I think that must be the safest solution.

Any kernel routine which uses PREF instructions (but actually also user
space code as Ralf's example pointed out), must guarantee that it does
not issue prefetches to addresses which it is not specifically being
asked to mess around with. 

The other solutions seem too fragile, and will break at some point.

/Hartvig

Alan Cox writes:
> 
> On Fri, 2002-10-04 at 13:35, Carsten Langgaard wrote:
> > That's exactly the problem.
> > The actually loads and stores in memcpy is fine, it's the prefetching that
> > prefetch too much.
> 
> Then fix your prefetching code 8). We had problems with that on x86 too,
> prefetching off the last page into ISA space -> death. Was umm fun to
> debug
> 
> 
> 


-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
