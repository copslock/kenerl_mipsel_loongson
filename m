Received:  by oss.sgi.com id <S553682AbQJTVl4>;
	Fri, 20 Oct 2000 14:41:56 -0700
Received: from u-122.karlsruhe.ipdial.viaginterkom.de ([62.180.18.122]:54544
        "EHLO u-122.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553673AbQJTVli>; Fri, 20 Oct 2000 14:41:38 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870179AbQJTVky>;
        Fri, 20 Oct 2000 23:40:54 +0200
Date:   Fri, 20 Oct 2000 23:40:54 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Guido Guenther <guido.guenther@gmx.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20001020234054.A25125@bacchus.dhis.org>
References: <20001015021522.B3106@bilbo.physik.uni-konstanz.de> <20001019222501.A20568@bacchus.dhis.org> <20001020091858.A32040@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001020091858.A32040@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Fri, Oct 20, 2000 at 09:18:58AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 20, 2000 at 09:18:58AM +0200, Guido Guenther wrote:

> > I've applied your patches with exception of the debug junk and the
> > partition ID stuff - the values for the prtition ids exceed the maximum
> > value and we don't have assigned partition ids anyway.
> Fdisk created the linux partitions with 0x83 which is the same as on
> i386. Any reasons why we can't use them?

The permitted number space for partition types is only 0 - 15.  Don't ask
me why - it's not important anywyay imho and so there is no reason to
use the same partition ids as for PC-style partitions.

  Ralf
