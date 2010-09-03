Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Sep 2010 12:01:50 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1490956Ab0ICKBm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Sep 2010 12:01:42 +0200
Date:   Fri, 3 Sep 2010 12:01:40 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bernhard Walle <walle@corscience.de>
Cc:     Arnaud Patard <apatard@mandriva.com>,
        Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        ddaney@caviumnetworks.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: N32: Fix getdents64 syscall for n32
Message-ID: <20100903100140.GA29187@linux-mips.org>
References: <1283501734-6532-1-git-send-email-walle@corscience.de>
 <20100903084213.GA32339@lst.de>
 <m3pqwvb438.fsf@anduin.mandriva.com>
 <4C80BC3A.7010406@corscience.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C80BC3A.7010406@corscience.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2490

On Fri, Sep 03, 2010 at 11:13:30AM +0200, Bernhard Walle wrote:

> >I guess the explanation is the one below :
> >
> >$ ./scripts/get_maintainer.pl -f arch/mips/kernel/scall64-n32.S
> >Ralf Baechle<ralf@linux-mips.org>
> >David Daney<ddaney@caviumnetworks.com>
> >Andrew Morton<akpm@linux-foundation.org>
> >"Eric W. Biederman"<ebiederm@xmission.com>
> >Christoph Hellwig<hch@lst.de>
> >linux-mips@linux-mips.org
> >linux-kernel@vger.kernel.org
> 
> Yes, I just used that script and trusted the results. Sorry for that.

I'm certainly not interested on getting cc'ed half of I2C patches or
Itanium framebuffer drivers.  The defaults are idiotic.  Anybody who
touched a file in the past year will get spammed.

Throw in a --nogit to disable the history search and you get:

Ralf Baechle <ralf@linux-mips.org>
linux-mips@linux-mips.org
linux-kernel@vger.kernel.org

cc'ing lkml is a bit pointless in many cases as well but the simplistic
filename pattern system in MAINTAINERS doesn't allow entries entries to
match only if no other previous entries are matching.

  Ralf
