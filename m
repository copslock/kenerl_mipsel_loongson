Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 21:41:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55132 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006760AbaHYTl6WX6ri (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 21:41:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PJfudQ005468;
        Mon, 25 Aug 2014 21:41:56 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PJfsB0005467;
        Mon, 25 Aug 2014 21:41:54 +0200
Date:   Mon, 25 Aug 2014 21:41:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Chen Jie <chenj@lemote.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        =?utf-8?B?546L6ZSQ?= <wangr@lemote.com>
Subject: Re: [PATCH] mips: define _MIPS_ARCH_LOONGSON3A for Loongson3
Message-ID: <20140825194154.GC27238@linux-mips.org>
References: <1408504488-12319-1-git-send-email-chenj@lemote.com>
 <1408504488-12319-2-git-send-email-chenj@lemote.com>
 <20140820105356.GA21497@linux-mips.org>
 <CAGXxSxVqEs5jyckaOG=iX24UeV2P_WgmqV=EBQYycRJ1P9vPgg@mail.gmail.com>
 <20140825121240.GG27724@linux-mips.org>
 <alpine.LFD.2.11.1408252028580.18483@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.11.1408252028580.18483@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Mon, Aug 25, 2014 at 08:35:17PM +0100, Maciej W. Rozycki wrote:

> On Mon, 25 Aug 2014, Ralf Baechle wrote:
> 
> > > >> +cflags-$(CONFIG_CPU_LOONGSON3)  += -D_MIPS_ARCH_LOONGSON3A
> > > >
> > > > The _MIPS_ARCH_* namespace belongs to GCC.  While it seems current GCC
> > > > does not define this symbol _MIPS_ARCH_LOONGSON3A runs into the danger
> > > > of causing a conflict when GCC eventually will define the symbol.
> > > When this symbol will be defined? With option '-march=loongson3a'?
> > 
> > Well, not currently (at least not in my gcc 4.9.0) - but it might.  In
> > fact, I'm wondering why it doesn't.  Maciej?
> 
>  No idea, a _MIPS_ARCH_foo macro gets defined automagically by GCC 
> whenever `-march=foo' is in effect (be it implicitly or with the use of a 
> command-line option), so there should be one.
> 
>  Has support for "loongson3a" been present in 4.9.x (it is in trunk)?  If 
> so, then what _MIPS_ARCH_* macro gets defined for `-march=loongson3a'?

Hmm - I must have fatfingered something.  Now I'm getting:

$ mips-linux-gcc < /dev/null -E -C -dM -march=loongson3a - | grep _MIPS_ARCH
#define _MIPS_ARCH_LOONGSON3A 1
#define _MIPS_ARCH "loongson3a"
$

So that would conflict with a manual definition, thus the patch would not
be acceptable as it because:

$ cat > c.c << EOF
foo(){}
EOF
$ mips-linux-gcc -D_MIPS_ARCH_LOONGSON3A -march=loongson3a -Wall -c c.c 
c.c:1:1: warning: return type defaults to ‘int’ [-Wreturn-type]
 foo(){}
 ^
c.c: In function ‘foo’:
c.c:1:1: warning: control reaches end of non-void function [-Wreturn-type]
 foo(){}
 ^
$

  Ralf
