Received:  by oss.sgi.com id <S553709AbQJRBic>;
	Tue, 17 Oct 2000 18:38:32 -0700
Received: from u-237.karlsruhe.ipdial.viaginterkom.de ([62.180.18.237]:45069
        "EHLO u-237.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553700AbQJRBiW>; Tue, 17 Oct 2000 18:38:22 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868617AbQJRBiE>;
        Wed, 18 Oct 2000 03:38:04 +0200
Date:   Wed, 18 Oct 2000 03:38:04 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: 16K page size?
Message-ID: <20001018033804.E7865@bacchus.dhis.org>
References: <39ED40B4.EEB5F444@mvista.com> <20001018033002.D7865@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001018033002.D7865@bacchus.dhis.org>; from ralf@oss.sgi.com on Wed, Oct 18, 2000 at 03:30:02AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 18, 2000 at 03:30:02AM +0200, Ralf Baechle wrote:

> Most applications probably use the getpagesize() function, so they should
> be fine.  libc itself should also be clean.
> 
> In the kernel we don't handle this properly yet.  There are also some
> optimizations which are possible for larger page sizes.  IA64 already
> has a larger pagesize than Intel, so I hope they have already solve
                             ^^^^^
                             i386
> most of the problems for us.

  Ralf
