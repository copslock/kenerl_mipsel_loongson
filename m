Received:  by oss.sgi.com id <S553691AbQJRBac>;
	Tue, 17 Oct 2000 18:30:32 -0700
Received: from u-237.karlsruhe.ipdial.viaginterkom.de ([62.180.18.237]:42509
        "EHLO u-237.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553681AbQJRBaR>; Tue, 17 Oct 2000 18:30:17 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868617AbQJRBaC>;
        Wed, 18 Oct 2000 03:30:02 +0200
Date:   Wed, 18 Oct 2000 03:30:02 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: 16K page size?
Message-ID: <20001018033002.D7865@bacchus.dhis.org>
References: <39ED40B4.EEB5F444@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39ED40B4.EEB5F444@mvista.com>; from jsun@mvista.com on Tue, Oct 17, 2000 at 11:18:28PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 17, 2000 at 11:18:28PM -0700, Jun Sun wrote:

> Has anybody tried that before?
> 
> I wonder if it is just as simple as changing PAGE_SHIFT from 12 to 14 in
> include/asm-mips/page.h.  
> 
> I remember I have seen many places in kernel and drivers that assume 4k
> page size (perhaps minimum 4k page size in reality.)  What about glibc? 
> Does it assume any page size?

Most applications probably use the getpagesize() function, so they should
be fine.  libc itself should also be clean.

In the kernel we don't handle this properly yet.  There are also some
optimizations which are possible for larger page sizes.  IA64 already
has a larger pagesize than Intel, so I hope they have already solve
most of the problems for us.

  Ralf
