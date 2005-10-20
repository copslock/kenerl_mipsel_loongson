Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 12:03:42 +0100 (BST)
Received: from alg145.algor.co.uk ([62.254.210.145]:15889 "EHLO
	dmz.algor.co.uk") by ftp.linux-mips.org with ESMTP id S3465689AbVJTLDU
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 12:03:20 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1ESY9q-0002Jb-00; Thu, 20 Oct 2005 12:00:26 +0100
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1ESYBt-0001GQ-00; Thu, 20 Oct 2005 12:02:33 +0100
Received: from dom by arsenal.mips.com with local (Exim 4.44)
	id 1ESYBt-0005UN-4S; Thu, 20 Oct 2005 12:02:33 +0100
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.31049.107570.828550@arsenal.mips.com>
Date:	Thu, 20 Oct 2005 12:02:33 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Andrew Isaacson <adi@broadcom.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 8/12]  cerr-printk-not-prom-printf
In-Reply-To: <20051020104902.GA9491@linux-mips.org>
References: <20051020065320.GA23857@broadcom.com>
	<20051020065757.GH23899@broadcom.com>
	<20051020104902.GA9491@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.838,
	required 4, AWL, BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Ralf Baechle (ralf@linux-mips.org) writes:

> The reason for this old commit was that this code is running
> uncached, so the operation of ll/sc in the spinlocks is undefined
> according to the MIPS64 spec...

The answer is more complicated.  MIPS64 (elsewhere) requires that the
ll/sc "link" is broken on an exceptin - in fact on an 'eret'
instruction.

So ll/sc on an uncached location works just fine in a uniprocessor.  
However, it's unlikely that any cache-coherent mulitprocessor system
will snoop uncached reads and writes, so it won't work in an SMP
system.

--
Dominic
