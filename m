Received:  by oss.sgi.com id <S553717AbQJaCoM>;
	Mon, 30 Oct 2000 18:44:12 -0800
Received: from u-180.karlsruhe.ipdial.viaginterkom.de ([62.180.21.180]:65291
        "EHLO u-180.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553683AbQJaCny>; Mon, 30 Oct 2000 18:43:54 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868617AbQJaCne>;
        Tue, 31 Oct 2000 03:43:34 +0100
Date:   Tue, 31 Oct 2000 03:43:34 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: r4k_dma_cache_inv_pc() does writeback
Message-ID: <20001031034334.A27427@bacchus.dhis.org>
References: <39FDC1B1.A4E33DDE@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39FDC1B1.A4E33DDE@mvista.com>; from jsun@mvista.com on Mon, Oct 30, 2000 at 10:45:05AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 30, 2000 at 10:45:05AM -0800, Jun Sun wrote:

> It just occur to me that r4k_dma_cache_inv_pc() actually does a
> writeback before it invalidates the cache.  Is there story behind it? 
> Or just a plain bug?

No big story, I was simply to lazy to implement yet another function.
You could probably get some performance gains.

> If it is a bug, I don't find an easy way to invalidate the whole dcache
> other than writing a new function, perhaps in r4kcache.h.

  Ralf
