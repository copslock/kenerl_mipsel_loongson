Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 23:44:27 +0200 (CEST)
Received: from alg133.algor.co.uk ([62.254.210.133]:31460 "EHLO
	oval.algor.co.uk") by linux-mips.org with ESMTP id <S1122987AbSIQVo0>;
	Tue, 17 Sep 2002 23:44:26 +0200
Received: from gladsmuir.algor.co.uk (pubfw.algor.co.uk [62.254.210.129])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g8HLiCr26331;
	Tue, 17 Sep 2002 22:44:17 +0100 (BST)
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15751.41516.224075.295052@gladsmuir.algor.co.uk>
Date: Tue, 17 Sep 2002 22:44:12 +0100
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [RFC] FPU context switch
In-Reply-To: <20020917110423.E17321@mvista.com>
References: <20020917110423.E17321@mvista.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Return-Path: <dom@algor.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@algor.co.uk
Precedence: bulk
X-list: linux-mips


Jun Sun (jsun@mvista.com) writes:

> 1) always blindly save and restore during context switch (switch_to())

Just a suggestion...

> Not interesting.  Just list it here for completeness.

Agreed, it's not interesting.

But it would work, every time; while the current scheme has been a
fertile source of interesting bugs.  How much useful optimisation
might have been done with the effort required to fix them?

Saving all the FPU registers on a 400MHz CPU takes about a tenth of a
microsecond.  Does anyone reading this list have evidence that this is
ever any kind of problem?

Dominic Sweetman
MIPS Technologies.
