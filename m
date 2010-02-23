Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 00:47:23 +0100 (CET)
Received: from alius.ayous.org ([78.46.213.165]:48211 "EHLO alius.ayous.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491984Ab0BWXrU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 00:47:20 +0100
Received: from eos.turmzimmer.net ([2001:a60:f006:aba::1])
        by alius.turmzimmer.net with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Nk4TF-0003p1-O0; Tue, 23 Feb 2010 23:47:18 +0000
Received: from aba by eos.turmzimmer.net with local (Exim 4.69)
        (envelope-from <aba@not.so.argh.org>)
        id 1Nk4TA-0005f8-4v; Wed, 24 Feb 2010 00:47:12 +0100
Date:   Wed, 24 Feb 2010 00:47:12 +0100
From:   Andreas Barth <aba@not.so.argh.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Problems and workarounds while building octeon kernels
Message-ID: <20100223234712.GA27216@mails.so.argh.org>
References: <20100220175125.GQ27216@mails.so.argh.org> <4B82F610.8070105@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B82F610.8070105@caviumnetworks.com>
X-Editor: Vim http://www.vim.org/
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aba@not.so.argh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aba@not.so.argh.org
Precedence: bulk
X-list: linux-mips

* David Daney (ddaney@caviumnetworks.com) [100222 22:25]:
> * Were you able to produce a *bootable* kernel after your workarounds?

We couldn't test that, as I don't have direct hardware access.

However file tells me it's the same type as the working kernel:
vmlinux: ELF 64-bit MSB executable, MIPS, MIPS64 rel2 version 1 (SYSV), statically linked, not stripped

As soon as it got tested, I'll tell you.


> * What did your make invocation look like?

"make" and "fakeroot make-kpkg --revision 1 kernel_image".


Cheers,
Andi
