Received:  by oss.sgi.com id <S42253AbQIKRfA>;
	Mon, 11 Sep 2000 10:35:00 -0700
Received: from u-188.karlsruhe.ipdial.viaginterkom.de ([62.180.10.188]:36360
        "EHLO u-188.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42241AbQIKRey>; Mon, 11 Sep 2000 10:34:54 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868877AbQIKReC>;
        Mon, 11 Sep 2000 19:34:02 +0200
Date:   Mon, 11 Sep 2000 19:34:02 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Guido Guenther <guido.guenther@gmx.net>
Cc:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@oss.sgi.com
Subject: Re: glibc again
Message-ID: <20000911193402.A32311@bacchus.dhis.org>
References: <20000909000736.A6050@bilbo.physik.uni-konstanz.de> <20000908191612.B17687@chem.unr.edu> <20000909130219.A6979@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000909130219.A6979@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Sat, Sep 09, 2000 at 01:02:19PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Sep 09, 2000 at 01:02:19PM +0200, Guido Guenther wrote:

> On Fri, Sep 08, 2000 at 07:16:12PM -0700, Keith M Wesolowski wrote:
> > I'm astonished it only complained about unresolved symbols. If you
> > leave it as is, it tries to link in your build system's libraries. I
> > always replace the two with full paths to the mips libraries. I'm
> > fairly sure this is also in my cross-build faq.

> Acutally it really first tried to link in the glibc in /lib, which I
> overrided with LDFLAGS=-L/u/l/mips-linux/...
> I couldn't find anything about it in the cross-mips faq. But IMHO it
> would be worth a note(maybe also in the mips-howto?).

If the crosscompiler ever tries to link in something from /lib, /usr/lib
or other directories with native binaries then either the compiler
was missconfigured when built or the makefiles pass bogus -L arguments.

  Ralf
