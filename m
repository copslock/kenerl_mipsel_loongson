Received:  by oss.sgi.com id <S553743AbQKUDj2>;
	Mon, 20 Nov 2000 19:39:28 -0800
Received: from u-194.karlsruhe.ipdial.viaginterkom.de ([62.180.10.194]:5382
        "EHLO u-194.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553711AbQKUDjV>; Mon, 20 Nov 2000 19:39:21 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868471AbQKUDjD>;
        Tue, 21 Nov 2000 04:39:03 +0100
Date:   Tue, 21 Nov 2000 04:39:03 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Dominic Sweetman <dom@algor.co.uk>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-cvs@oss.sgi.com, linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20001121043903.A24831@bacchus.dhis.org>
References: <20001118132233Z553804-494+838@oss.sgi.com> <XFMail.001118180639.Harald.Koerfgen@home.ivm.de> <20001118182114.A19710@bacchus.dhis.org> <200011191516.PAA00336@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200011191516.PAA00336@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Sun, Nov 19, 2000 at 03:16:33PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, Nov 19, 2000 at 03:16:33PM +0000, Dominic Sweetman wrote:

> ll/sc between CPUs certainly won't work for uncached accesses, since
> they rely on the cache coherency protocols.
> 
> On a uniprocessor CPU the ll/sc link is typically broken on any
> exception.  You'd have to try very hard to design the CPU so that it
> would work any differently for cached and uncached accesses.

Ok, so now CONFIG_MIPS_UNCACHED is only selectable for UP kernels.

  Ralf
