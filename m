Received:  by oss.sgi.com id <S42368AbQJFWWm>;
	Fri, 6 Oct 2000 15:22:42 -0700
Received: from u-150.karlsruhe.ipdial.viaginterkom.de ([62.180.18.150]:10502
        "EHLO u-150.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42342AbQJFWWe>; Fri, 6 Oct 2000 15:22:34 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869490AbQJFQVW>;
        Fri, 6 Oct 2000 18:21:22 +0200
Date:   Fri, 6 Oct 2000 18:21:22 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:     Jun Sun <jsun@mvista.com>, "Kevin D. Kissell" <kevink@mips.com>,
        Dominic Sweetman <dom@algor.co.uk>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr
Subject: Re: load_unaligned() and "uld" instruction
Message-ID: <20001006182122.A9061@bacchus.dhis.org>
References: <20001006024337.A3429@bacchus.dhis.org> <Pine.GSO.3.96.1001006113602.26752A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.3.96.1001006113602.26752A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Oct 06, 2000 at 11:54:18AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 06, 2000 at 11:54:18AM +0200, Maciej W. Rozycki wrote:

>  I vote for dual code for now and then we may remove the egcs 1.0.3
> compatibility cruft one day (for 2.6, for example). 

Not much point in that - we end up with performancewise identical code for
both C and assembler variants with current compilers.  So whenever we
finally retire egcs 1.0.3 I think we should switch completly to the
new compiler and the C written unaligned.h.

  Ralf
