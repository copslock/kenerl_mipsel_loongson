Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2010 00:24:00 +0200 (CEST)
Received: from alius.ayous.org ([78.46.213.165]:49486 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492417Ab0C2WX5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Mar 2010 00:23:57 +0200
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NwNNE-0001f1-33; Mon, 29 Mar 2010 22:23:56 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1NwNN8-0007bT-5Z; Tue, 30 Mar 2010 00:23:50 +0200
Date:   Tue, 30 Mar 2010 00:23:50 +0200
From:   Andreas Barth <aba@not.so.argh.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Peter 'p2' De Schrijver <p2@debian.org>, linux-mips@linux-mips.org
Subject: Re: movidis x16 hard lockup using 2.6.33
Message-ID: <20100329222350.GL27216@mails.so.argh.org>
References: <20100326184132.GU2437@apfelkorn> <4BAD03A5.9070701@caviumnetworks.com> <20100327230744.GG27216@mails.so.argh.org> <4BB0DB2A.9080405@caviumnetworks.com> <20100329220223.GK27216@mails.so.argh.org> <4BB12616.5010507@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BB12616.5010507@caviumnetworks.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* David Daney (ddaney@caviumnetworks.com) [100330 00:14]:
> At the end of octeon_watchdog_nmi_stage3, instead of returning, do:
>
> for(;;) watchdog_poke_irq(0, NULL);
>
> That should prevent it from rebooting.  The messages will appear on the  
> serial port, not in syslog.

Thanks, trying that now.


Andi
