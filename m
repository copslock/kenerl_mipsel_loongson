Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2004 12:00:42 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:39694 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225248AbUBZMAl>;
	Thu, 26 Feb 2004 12:00:41 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1AwK5n-0002ah-00; Thu, 26 Feb 2004 11:54:15 +0000
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AwKBa-0004TO-00; Thu, 26 Feb 2004 12:00:14 +0000
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1AwKBa-0001Uf-00; Thu, 26 Feb 2004 12:00:14 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16445.57293.864473.100987@arsenal.mips.com>
Date: Thu, 26 Feb 2004 12:00:13 +0000
To: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Doubt in updating the cache..
In-Reply-To: <20040226104929.3711.qmail@web10102.mail.yahoo.com>
References: <20040226104929.3711.qmail@web10102.mail.yahoo.com>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.85, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4451
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Karthi,

>     When the Instruction/data is read from memory,
> it's copy will be put into the cache.
> 
> Question:
> 
>     How does the R4k processor determines whether the
> value read from memory is Instruction or Data so that
> the value will be put into the appropriate primary 
> cache?

The caches are not prescient...

Data is only ever put into the cache when the CPU *uses* it (and it
isn't there already).  If the CPU was do ingan instruction fetch, the
copy of the memory data goes in the I-cache; if the CPU was trying to
do a load it goes in the D-cache.

--
Dominic
