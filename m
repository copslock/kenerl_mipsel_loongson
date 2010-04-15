Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Apr 2010 20:43:33 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:41072 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492138Ab0DOSn1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Apr 2010 20:43:27 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1O2U22-000347-CI; Thu, 15 Apr 2010 18:43:18 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1O2U1w-0008Ae-Ot; Thu, 15 Apr 2010 20:43:12 +0200
Date:   Thu, 15 Apr 2010 20:43:12 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: irqbalance on movidis crashes the machine (was: movidis x16 hard
        lockup using 2.6.33)
Message-ID: <20100415184312.GK2942@mails.so.argh.org>
References: <20100326184132.GU2437@apfelkorn> <4BAD03A5.9070701@caviumnetworks.com> <20100327230744.GG27216@mails.so.argh.org> <4BB0DB2A.9080405@caviumnetworks.com> <20100402133224.GR27216@mails.so.argh.org> <20100403154312.GY2437@apfelkorn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100403154312.GY2437@apfelkorn>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* Peter 'p2' De Schrijver (p2@debian.org) [100403 17:43]:
> http://zobel.ftbfs.de/.x/lucatelli-nmi-watchdog-output.txt 
> Dump of one of those hangs. Most cores seem to be stuck in wait 
> (0xffffffff81100b80), except for core 1 which is in octeon_irq_ciu0_ack 
> (octeon_irq_ciu0_ack).

On further investigation we found out that this happens when
irqbalance is started. The version of irqbalance being run is 0.55.

We removed this program from the affected machine, but of course this
still should be fixed (and we still get a few reboots on another
machine without irqbalance).


Andi
