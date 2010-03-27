Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Mar 2010 00:07:58 +0100 (CET)
Received: from alius.ayous.org ([78.46.213.165]:55816 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491120Ab0C0XHy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 28 Mar 2010 00:07:54 +0100
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Nvf6c-0007hQ-TZ; Sat, 27 Mar 2010 23:07:51 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Nvf6W-00046K-Su; Sun, 28 Mar 2010 00:07:44 +0100
Date:   Sun, 28 Mar 2010 00:07:44 +0100
From:   Andreas Barth <aba@not.so.argh.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Peter 'p2' De Schrijver <p2@debian.org>, linux-mips@linux-mips.org
Subject: Re: movidis x16 hard lockup using 2.6.33
Message-ID: <20100327230744.GG27216@mails.so.argh.org>
References: <20100326184132.GU2437@apfelkorn> <4BAD03A5.9070701@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BAD03A5.9070701@caviumnetworks.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* David Daney (ddaney@caviumnetworks.com) [100326 19:57]:
> Also you could try running with the attached patch.  It is not the best  
> watchdog, but it will print the register state for each core when things  
> get stuck.  Occasionally that is enough to see where the problem is.

Thanks.

As our logging has only limited buffer size, I'd be happy about an
variant of the patch which doesn't reboot but just let the machine
hang after the third occurence.

Any chances for it?


Andi
