Received:  by oss.sgi.com id <S553679AbQJUBZ3>;
	Fri, 20 Oct 2000 18:25:29 -0700
Received: from u-247.karlsruhe.ipdial.viaginterkom.de ([62.180.21.247]:62480
        "EHLO u-247.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553660AbQJUBZE>; Fri, 20 Oct 2000 18:25:04 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870339AbQJUBYo>;
        Sat, 21 Oct 2000 03:24:44 +0200
Date:   Sat, 21 Oct 2000 03:24:44 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jay Carlson <nop@nop.com>
Cc:     aj@suse.de, Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001021032444.A27648@bacchus.dhis.org>
References: <u8k8b3ydjk.fsf@gromit.rhein-neckar.de> <KEEOIBGCMINLAHMMNDJNOECHCAAA.nop@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <KEEOIBGCMINLAHMMNDJNOECHCAAA.nop@nop.com>; from nop@nop.com on Fri, Oct 20, 2000 at 08:03:24AM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 20, 2000 at 08:03:24AM -0400, Jay Carlson wrote:

> > {AJ} Either use as compiler egcs 1.1.2 or the current development
> > version of
> > gcc 2.96 from CVS.  gcc 2.95.x does not work correctly on mips-linux.
> 
> Why not 1.0.3a+patches?  And could you mention a day that a 2.97 checkout
> was known to work?

1.0.3a doesn't work for compiling glibc 2.1.94 on any architecture due to
a bug in the handling of weak undefined symbols - they're emitted as
strong symbols.

  Ralf
