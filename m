Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 08:53:46 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:35847 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225207AbTHAHxo>;
	Fri, 1 Aug 2003 08:53:44 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 19iUkb-0006i2-00; Fri, 01 Aug 2003 08:54:57 +0100
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 19iUhQ-0003cr-00; Fri, 01 Aug 2003 08:51:40 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16170.7179.635988.268987@doms-laptop.algor.co.uk>
Date: Fri, 1 Aug 2003 08:51:39 +0100
To: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
Cc: "'Ralf Baechle'" <ralf@linux-mips.org>,
	Fuxin Zhang <fxzhang@ict.ac.cn>, <linux-mips@linux-mips.org>
Subject: RE: RM7k cache_flush_sigtramp
In-Reply-To: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02>
References: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-5.8, required 4, BAYES_01,
	QUOTED_EMAIL_TEXT, REFERENCES)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


> If this is just to ensure the I Cache coherency for modified code
> then the following should be sufficient:
> 
> cache Hit_Writeback_D, offset(base_register)
> cache Hit_Invalidate_I, offset(base_register)
> 
> The ordering does matter however since the Hit_Invalidate_I makes
> sure the write buffer is flushed.

I'm probably jumping into the middle of something, sorry... 

The MIPS32/MIPS64 release 2 architecture includes a useful instruction
SYNCI which does the whole job (repeat on each affected cache line)
and is legal in user mode; this will take a while to spread but I'd
recommend it as a model worth following.

So I hope that kernels will provide one function for "I've just
written instructions and now I want to execute them", and not export
the separate writeback-D/invalidate-I interface.

--
Dominic Sweetman
MIPS Technologies
dom@mips.com
