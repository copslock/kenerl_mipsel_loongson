Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 08:43:14 +0100 (BST)
Received: from p508B75A1.dip.t-dialin.net ([IPv6:::ffff:80.139.117.161]:50244
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224916AbUHQHnK>; Tue, 17 Aug 2004 08:43:10 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7H7h8Uv022767;
	Tue, 17 Aug 2004 09:43:08 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7H7h7d1022748;
	Tue, 17 Aug 2004 09:43:07 +0200
Date: Tue, 17 Aug 2004 09:43:07 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Kaj-Michael Lang <milang@tal.org>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: cpu_has_llsc cleanup broke compilation.
Message-ID: <20040817074307.GA21407@linux-mips.org>
References: <001901c48427$6272acd0$54dc10c3@amos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901c48427$6272acd0$54dc10c3@amos>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 17, 2004 at 09:56:53AM +0300, Kaj-Michael Lang wrote:

> The "using cpu_has_llsc cleanup all users of ll/sc and lld/scd." broke
> compilation:
> 
>   CC      arch/mips/kernel/offset.s
> In file included from include/asm/bitops.h:35,
>                  from include/linux/bitops.h:4,

Clearly a kernel bug - but one that also shows poor maintenance of your
target.  It should define cpu_has_llsc which it doesn't, so the kernel
will use generic code and deciede at runtime it should use ll/sc.  I'm
fixing this problem but you really should fix your target also.

  Ralf
