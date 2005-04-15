Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2005 11:26:11 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:5143 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226235AbVDOKZ5>; Fri, 15 Apr 2005 11:25:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3FAPnST007698;
	Fri, 15 Apr 2005 11:25:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3FAPmOX007697;
	Fri, 15 Apr 2005 11:25:48 +0100
Date:	Fri, 15 Apr 2005 11:25:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	Dominique Quatravaux <dom@kilimandjaro.dyndns.org>,
	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: [OFF-TOPIC] Cobalt 64-bit, what for? (was: 64-bit fix)
Message-ID: <20050415102548.GD5414@linux-mips.org>
References: <20050414185949.GA5578@skeleton-jack> <425F8776.6080703@kilimandjaro.dyndns.org> <20050415101422.GB5414@linux-mips.org> <16991.38112.114688.697412@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16991.38112.114688.697412@arsenal.mips.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 15, 2005 at 11:18:08AM +0100, Dominic Sweetman wrote:

> > > And doesn't 64 bit mode have costs of its own (doubled i-fetch bandwidth
> > > for starters)?
> 
> 64-bit MIPS CPUs still have 32-bit instructions... it's the registers
> and addressing range which grow, not the instructions.

True - but number of instructions will grow, thus the bandwidth needed to
fetch them.

> Program data segments tend to grow when you use 64-bit pointers (N64
> does, but N32 - paradoxically still a 64-bit ABI - doesn't)

N32 is an ILP32 ABI so I'd count it as 32-bit.

  Ralf
