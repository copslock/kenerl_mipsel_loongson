Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 08:01:54 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:19716 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225072AbULBIBs>;
	Thu, 2 Dec 2004 08:01:48 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CZm1j-0005uS-00; Thu, 02 Dec 2004 08:09:23 +0000
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CZlu7-0001AF-00; Thu, 02 Dec 2004 08:01:32 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16814.52180.502747.597080@doms-laptop.algor.co.uk>
Date: Thu, 2 Dec 2004 08:01:24 +0000
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
In-Reply-To: <20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
	<16813.39660.948092.328493@doms-laptop.algor.co.uk>
	<20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de>
	<Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl>
	<20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.831, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Thiemo,

> I had guessed you already know what i mean. :-)

Generally a bad guess, of course...

> Current 64bit MIPS kernels run in (C)KSEG0, and exploit sign-extension
> to optimize symbol loads (2 instead of 6/7 instructions, the same as in
> 32bit kernels).

Gross... yet ingenious. I see the problem.  You want to use a
32-bit-pointer "la" for the addresses of static variables in the
kernel build (which works, because the kernel is in the
32-bit-pointer-accessible 'kseg0').

The assembler macro was a very Linux solution, if you don't mind my
saying so...  A more native compiler fix would probably be a good
idea.

What ABI are you using for the 64-bit kernel build (n64? how do you
get it to build non-PIC?)  And what constraints are there on
your choice of gcc version? - it would be easier if 3.4 was OK.

--
Dominic Sweetman
MIPS Technologies
