Received:  by oss.sgi.com id <S42228AbQJJAVc>;
	Mon, 9 Oct 2000 17:21:32 -0700
Received: from u-240.karlsruhe.ipdial.viaginterkom.de ([62.180.18.240]:28421
        "EHLO u-240.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42213AbQJJAU6>; Mon, 9 Oct 2000 17:20:58 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870064AbQJJATx>;
        Tue, 10 Oct 2000 02:19:53 +0200
Date:   Tue, 10 Oct 2000 02:19:53 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: BFD: bfd assertion fail elfcode.h:1205
Message-ID: <20001010021953.E25504@bacchus.dhis.org>
References: <20001009175032.B7288@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001009175032.B7288@paradigm.rfc822.org>; from flo@rfc822.org on Mon, Oct 09, 2000 at 05:50:32PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 09, 2000 at 05:50:32PM +0200, Florian Lohoff wrote:

> Hi,
> while building glibc 2.2 for mips with cvs gcc/binutils as
> of 20001007 i get the following - multiple times ( >1000 ) when
> building the package (probably while stripping the binarys)
> 
> BFD: bfd assertion fail elfcode.h:1205
> BFD: bfd assertion fail elfcode.h:1205
> BFD: bfd assertion fail elfcode.h:1205
> BFD: bfd assertion fail elfcode.h:1205
> BFD: bfd assertion fail elfcode.h:1205
> BFD: bfd assertion fail elfcode.h:1205
> BFD: bfd assertion fail elfcode.h:1205
> BFD: bfd assertion fail elfcode.h:1205
> BFD: bfd assertion fail elfcode.h:1205

In my source tree from cvs line 1205 is empty and there have not been changes
to elfcode.h since September 27 so it seems we're looking at different
trees.  Also I haven't observed these assertions.  Can you isolate the
changes triggering them?

  Ralf
