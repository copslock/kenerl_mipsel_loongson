Received:  by oss.sgi.com id <S553721AbQJPBBX>;
	Sun, 15 Oct 2000 18:01:23 -0700
Received: from u-227.karlsruhe.ipdial.viaginterkom.de ([62.180.21.227]:5131
        "EHLO u-227.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553678AbQJPBBH>; Sun, 15 Oct 2000 18:01:07 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868868AbQJPBAx>;
        Mon, 16 Oct 2000 03:00:53 +0200
Date:   Mon, 16 Oct 2000 03:00:53 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Guido Guenther <guido.guenther@gmx.net>
Cc:     ian@ichilton.co.uk, linux-mips@oss.sgi.com
Subject: Re: CVS GCC Problem
Message-ID: <20001016030053.G15377@bacchus.dhis.org>
References: <20001014125855.A28429@woody.ichilton.co.uk> <20001014211850.A2774@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001014211850.A2774@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Sat, Oct 14, 2000 at 09:18:50PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 09:18:50PM +0200, Guido Guenther wrote:

> On Sat, Oct 14, 2000 at 12:58:55PM +0100, Ian Chilton wrote:
> > /crossdev/mips-linux/bin/ld: cannot open crti.o: No such file or directory
> I see the same thing here. gcc from cvs 000925 seems to be o.k. 

The file crti.o should be in /crossdev/mips-linux/lib/crti.o.  Is it actually
there?  Can you checkout where the x-compiler is actually searching
for those files?

  Ralf
