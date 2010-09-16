Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Sep 2010 01:57:45 +0200 (CEST)
Received: (from localhost user: 'ralf' uid#500 fake: STDIN
        (ralf@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1491076Ab0IPX5l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Sep 2010 01:57:41 +0200
Date:   Fri, 17 Sep 2010 00:57:39 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Porting Linux MIPS issue: maltaint.h files
Message-ID: <20100916235739.GA16949@linux-mips.org>
References: <AEA634773855ED4CAD999FBB1A66D076010CFA4E@CORPEXCH1.na.ads.idt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D076010CFA4E@CORPEXCH1.na.ads.idt.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-archive-position: 27759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13241

On Wed, Sep 15, 2010 at 01:04:02PM -0700, Ardelean, Andrei wrote:

> I am porting LINUX MIPS from MALTA on a new board. The problem is that
> .../mips-boards/maltaint.h files is included in a non-MALTA specific
> file, irq-gic.c, without #ifdef CONFIG_MALTA protection. The only need
> there is for the following constant:
> #define X			0xdead

That's just poor programming style.  1 character long names in headers are
begging for conflicts and with few exceptions as the universal loop index
variables i, j, k are not descriptive.

Including system specific headers hinders code reusability and reusability
is the reason why most of the irq-*.c files are in arch/mips/kernel and not
hidden away in some platform specific directory.

> What is the recommended way to follow since I will replace maltaint.h
> with my new file gdint.h?

Post a patch to cleanup the mess.

In this case (and I haven't looked at it for more than 30s ...) it seems
that the constant X should be moved into <asm/gic.h> after which the
inclusion of the Malta header can go away.

  Ralf
