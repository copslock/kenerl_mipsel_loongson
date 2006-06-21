Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2006 13:11:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:14007 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133653AbWFUMLO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Jun 2006 13:11:14 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5LCBBI8013148;
	Wed, 21 Jun 2006 13:11:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5LCBAWG013146;
	Wed, 21 Jun 2006 13:11:10 +0100
Date:	Wed, 21 Jun 2006 13:11:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Domen Puncer <domen.puncer@ultra.si>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu(): disable local interrupts) Breaks SGI IP32
Message-ID: <20060621121110.GA12545@linux-mips.org>
References: <4478C0F1.8000006@gentoo.org> <20060528010603.GA24997@linux-mips.org> <20060527194243.a8157338.akpm@osdl.org> <4479250E.3080604@gentoo.org> <20060528105014.GA28621@linux-mips.org> <20060621095150.GO5568@domen.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621095150.GO5568@domen.ultra.si>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 21, 2006 at 11:51:50AM +0200, Domen Puncer wrote:

> > #define on_each_cpu(func,info,retry,wait)       \
> >         ({                                      \
> > 		WARN_ON(irqs_disabled());	\
> >                 func(info);                     \
> >                 0;                              \
> >         })
> 
> On Alchemy au1200 this produces:
> [4294667.296000] Synthesized TLB modify handler fastpath (33 instructions).
> [4294667.296000] Badness in r4k_flush_icache_range at /home/domen/tmp/linux-2.6.bisecting/linux-mips.git/arch/mips/mm/c-r4k.c:516
> [4294667.296000] Call Trace:
> [4294667.296000]  [<80113434>] r4k_flush_icache_range+0x144/0x150
> [4294667.296000]  [<803f0000>] inflate_dynamic+0x634/0x70c
> [4294667.296000]  [<803f3630>] trap_init+0x3c/0x440

Pretty much as expected, thanks!

  Ralf
