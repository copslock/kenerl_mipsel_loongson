Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2004 14:29:07 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:26632 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224925AbUIAN3B>;
	Wed, 1 Sep 2004 14:29:01 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1C2VL3-0005Dc-00; Wed, 01 Sep 2004 14:39:49 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1C2VA2-0008Vl-00; Wed, 01 Sep 2004 14:28:26 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16693.52862.859233.198626@doms-laptop.algor.co.uk>
Date: Wed, 1 Sep 2004 14:28:30 +0100
To: Emmanuel Michon <em@realmagic.fr>
Cc: linux-mips@linux-mips.org
Subject: Re: TLB dimensioning
In-Reply-To: <1094033224.20643.1402.camel@nikita.france.sdesigns.com>
References: <1094033224.20643.1402.camel@nikita.france.sdesigns.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.849, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Emmanuel,

> regarding the hardware implementation of a 4KE (r4k style mmu
> if I remember) I'm wondering about the performance difference
> when the TLB has 16 pairs of entries (covering 128KBytes of
> data) or 32 pairs (covering 256KBytes).
> 
> Does someone have a useful advise regarding the `nice spot'
> for TLB size?

As you expected, there is no really simple answer.  The TLB is a
relatively large piece of logic, so it often isn't a trivial decision.

Applications - particularly embedded applications, which I suspect is
what you mean - vary a lot in the size of the mapped, user-space
working set.  Some Linux-powered embedded devices do nearly all their
work in the kernel...

However, the measurements we've done at MIPS suggest that for
moderate-size workloads where the user-space programs are working
hard, a 16-entry TLB can thrash quite badly, making a significant dent
in performance.

So the advice I'd give is that if:

1. Your application has a non-trivial user space of any size;

2. The performance of userland code is significant;

then you should pick a 32-entry TLB, until and unless you have
measurements of your own application to show you don't need it.

-- 
Dominic Sweetman
MIPS Technologies
