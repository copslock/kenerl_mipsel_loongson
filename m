Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Nov 2004 15:20:17 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:12037 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224902AbUKQPUM>;
	Wed, 17 Nov 2004 15:20:12 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CURjG-0005jI-00; Wed, 17 Nov 2004 15:28:18 +0000
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CURbD-0006p7-00; Wed, 17 Nov 2004 15:19:59 +0000
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1CURbD-0002zy-00; Wed, 17 Nov 2004 15:19:59 +0000
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16795.27678.928274.955392@arsenal.mips.com>
Date: Wed, 17 Nov 2004 15:19:58 +0000
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH]: R52x0 -> RM52xx
In-Reply-To: <20041117132937.GA23812@linux-mips.org>
References: <4196FE87.5050606@gentoo.org>
	<20041117132937.GA23812@linux-mips.org>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.843, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> > Attached is a minor cosmetic patch for 2.6 that just changes menuconfig to 
> > show the RM52xx CPU by the name it's known by on Systems that use it 
> > (Cobalt (RM5231), O2 RM5200).
> > 
> > It's a really minor thing, but afaict, it doesn't look to be incorrect.
> 
> The CPU core is originally a QED (today PMC-Sierra) core but there are
> licenses are selling it too such as IDT.  I'm not sure if all of them
> are using the RM prefix or not but I usually stick to whatever the
> original name was.

FWIW (not much) there was an RM5230, RM5260, RM5231 and RM5261 -
pretty much the same from a software point of view (the '3' and '6'
stand for the external bus width 32- vs 64-bit).  There was an RM5270,
too, to which you could bolt an external L2 cache.  So RM52xx is
really quite a good name...
