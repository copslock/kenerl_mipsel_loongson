Received:  by oss.sgi.com id <S42230AbQJJDqd>;
	Mon, 9 Oct 2000 20:46:33 -0700
Received: from u-240.karlsruhe.ipdial.viaginterkom.de ([62.180.18.240]:50181
        "EHLO u-240.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42213AbQJJDqL>; Mon, 9 Oct 2000 20:46:11 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870064AbQJJDpG>;
        Tue, 10 Oct 2000 05:45:06 +0200
Date:   Tue, 10 Oct 2000 05:45:06 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith Owens <kaos@melbourne.sgi.com>
Cc:     Linux on MIPS <linux-mips@oss.sgi.com>
Subject: Re: sgiserial.c
Message-ID: <20001010054506.F25504@bacchus.dhis.org>
References: <20001010051348.A36498@wo1133.wohnheim.uni-wuerzburg.de> <3417.971147957@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3417.971147957@kao2.melbourne.sgi.com>; from kaos@melbourne.sgi.com on Tue, Oct 10, 2000 at 02:19:17PM +1100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 10, 2000 at 02:19:17PM +1100, Keith Owens wrote:

> >     The serial ports of all SGI systems support several standard rates
> >     up through 38400 bps (see termio(7) for these standard rates).
> >     The serial ports on O2, OCTANE, Origin2000, Onyx2 and Origin200
> >     systems also support
> >     
> >                                31250   57600
> >                                76800   115200
> 
> FWIW, O2's may be rated at 115200 but I can kill my O2 by feeding it
> the output from a Linux serial console at 115200.  No diagnostics, just
> a solid machine hang.

The Origin's IOC3 16550 can go even higher rates at low interrupt load
due to it's higher crystal frequency and a NIC-like DMA descriptors.
We just don't do it yet in the Linux driver ...

  Ralf
