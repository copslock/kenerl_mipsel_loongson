Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2005 11:18:37 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:531 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8226231AbVDOKSW>;
	Fri, 15 Apr 2005 11:18:22 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1DMNwp-0007YC-00; Fri, 15 Apr 2005 11:21:15 +0100
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1DMNto-0007Z7-00; Fri, 15 Apr 2005 11:18:08 +0100
Received: from dom by arsenal.mips.com with local (Exim 4.44)
	id 1DMNto-0000Z3-4V; Fri, 15 Apr 2005 11:18:08 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16991.38112.114688.697412@arsenal.mips.com>
Date:	Fri, 15 Apr 2005 11:18:08 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Dominique Quatravaux <dom@kilimandjaro.dyndns.org>,
	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org
Subject: Re: [OFF-TOPIC] Cobalt 64-bit, what for? (was: 64-bit fix)
In-Reply-To: <20050415101422.GB5414@linux-mips.org>
References: <20050414185949.GA5578@skeleton-jack>
	<425F8776.6080703@kilimandjaro.dyndns.org>
	<20050415101422.GB5414@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.831,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> > And doesn't 64 bit mode have costs of its own (doubled i-fetch bandwidth
> > for starters)?

64-bit MIPS CPUs still have 32-bit instructions... it's the registers
and addressing range which grow, not the instructions.

Program data segments tend to grow when you use 64-bit pointers (N64
does, but N32 - paradoxically still a 64-bit ABI - doesn't)

--
Dominic Sweetman
MIPS Technologies
