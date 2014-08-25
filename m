Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 21:35:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55002 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006599AbaHYTfRyzDfh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 21:35:17 +0200
Date:   Mon, 25 Aug 2014 20:35:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Chen Jie <chenj@lemote.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?GB2312?B?s8K7qrLF?= <chenhc@lemote.com>,
        =?GB2312?B?zfXI8Q==?= <wangr@lemote.com>
Subject: Re: [PATCH] mips: define _MIPS_ARCH_LOONGSON3A for Loongson3
In-Reply-To: <20140825121240.GG27724@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1408252028580.18483@eddie.linux-mips.org>
References: <1408504488-12319-1-git-send-email-chenj@lemote.com> <1408504488-12319-2-git-send-email-chenj@lemote.com> <20140820105356.GA21497@linux-mips.org> <CAGXxSxVqEs5jyckaOG=iX24UeV2P_WgmqV=EBQYycRJ1P9vPgg@mail.gmail.com>
 <20140825121240.GG27724@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 25 Aug 2014, Ralf Baechle wrote:

> > >> +cflags-$(CONFIG_CPU_LOONGSON3)  += -D_MIPS_ARCH_LOONGSON3A
> > >
> > > The _MIPS_ARCH_* namespace belongs to GCC.  While it seems current GCC
> > > does not define this symbol _MIPS_ARCH_LOONGSON3A runs into the danger
> > > of causing a conflict when GCC eventually will define the symbol.
> > When this symbol will be defined? With option '-march=loongson3a'?
> 
> Well, not currently (at least not in my gcc 4.9.0) - but it might.  In
> fact, I'm wondering why it doesn't.  Maciej?

 No idea, a _MIPS_ARCH_foo macro gets defined automagically by GCC 
whenever `-march=foo' is in effect (be it implicitly or with the use of a 
command-line option), so there should be one.

 Has support for "loongson3a" been present in 4.9.x (it is in trunk)?  If 
so, then what _MIPS_ARCH_* macro gets defined for `-march=loongson3a'?

  Maciej
