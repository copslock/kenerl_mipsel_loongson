Received:  by oss.sgi.com id <S42502AbQJFAoX>;
	Thu, 5 Oct 2000 17:44:23 -0700
Received: from u-174.karlsruhe.ipdial.viaginterkom.de ([62.180.18.174]:8965
        "EHLO u-174.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42501AbQJFAoA>; Thu, 5 Oct 2000 17:44:00 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869488AbQJFAnh>;
        Fri, 6 Oct 2000 02:43:37 +0200
Date:   Fri, 6 Oct 2000 02:43:37 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
        Dominic Sweetman <dom@algor.co.uk>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
Message-ID: <20001006024337.A3429@bacchus.dhis.org>
References: <39D0E51C.79A0BE50@mvista.com> <Pine.GSO.3.96.1000927112232.25150A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1000927112232.25150A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Sep 27, 2000 at 12:06:31PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Sep 27, 2000 at 12:06:31PM +0200, Maciej W. Rozycki wrote:

>  Please don't.  Gcc already has means to generate proper unaligned
> accesses.  See include/asm-alpha/unaligned.h for how to achieve them in a
> portable way (i.e. using packed structs) without the problematic inline
> asm.

That's all very nice and guess what - I tried it when I originally wrote
ualigned.h for Linux.  Try building the mentioed Alpha code with and older
compiler like egcs 1.0.3a and take a look at it [1].  23 instructions for
loading a double world - that's just mindboggling.

  Ralf

[1] free barf bag on request.
