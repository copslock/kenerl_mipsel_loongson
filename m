Received:  by oss.sgi.com id <S42248AbQILXJe>;
	Tue, 12 Sep 2000 16:09:34 -0700
Received: from u-207.karlsruhe.ipdial.viaginterkom.de ([62.180.18.207]:59653
        "EHLO u-207.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42209AbQILXJH>; Tue, 12 Sep 2000 16:09:07 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868900AbQILXIq>;
        Wed, 13 Sep 2000 01:08:46 +0200
Date:   Wed, 13 Sep 2000 01:08:46 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Andreas Jaeger <aj@suse.de>
Cc:     Ulf Carlsson <ulfc@engr.sgi.com>,
        Keith M Wesolowski <wesolows@foobazco.org>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: One more gcc patch
Message-ID: <20000913010846.A5527@bacchus.dhis.org>
References: <20000908205810.A11920@bacchus.dhis.org> <u8ya0xbnao.fsf@gromit.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <u8ya0xbnao.fsf@gromit.rhein-neckar.de>; from aj@suse.de on Tue, Sep 12, 2000 at 06:14:07PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 12, 2000 at 06:14:07PM +0200, Andreas Jaeger wrote:

> Did you run the testsuite?

No; I tried rebuilding a large number of RH 6.2 packages.  A few of them
are broken in ways that make me suspect the compiler is broken.  Might
also be binutils; I did upgrade both in one step.

> It doesn't seem to fix C++:
> 
>                 === libstdc++ Summary ===
> 
> # of expected passes            9
> # of unexpected failures        10
> # of expected failures          11
> 
> The number for g++ are even worse, I stopped the check
> 
> Any idea how to get C++ working?

Debugging?

I think historically nobody did ever invest time into getting the libg++
to work so we somewhen have to pay that price ...

  Ralf
