Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 10:21:18 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:33030 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224947AbULAKVN>;
	Wed, 1 Dec 2004 10:21:13 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CZRj8-0002Qd-00; Wed, 01 Dec 2004 10:28:50 +0000
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CZRar-0006JY-00; Wed, 01 Dec 2004 10:20:18 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16813.39660.948092.328493@doms-laptop.algor.co.uk>
Date: Wed, 1 Dec 2004 10:20:28 +0000
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
cc: Nigel Stephens <nigel@mips.com>, David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
In-Reply-To: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.829, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Thiemo writes:

> the atomic functions use so far memory references for the inline
> assembler to access the semaphore. This can lead to additional
> instructions in the ll/sc loop, because newer compilers don't
> expand the memory reference any more but leave it to the assembler.
> 
> The appended patch...

I thought it was an explicit aim of the substantial rewrite of the
MIPS backend for 3.x to get the compiler to generate only "real"
instructions, not macros which expand to multiple instructions inside
the assembler.  So it's disappointing if newer compilers got worse.

Can one of our compiler-knowledgable people follow this up?

--
Dominic Sweetman
MIPS Technologies
