Received:  by oss.sgi.com id <S553729AbRAFRhb>;
	Sat, 6 Jan 2001 09:37:31 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:25341 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S553716AbRAFRhR>;
	Sat, 6 Jan 2001 09:37:17 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S868150AbRAFR1Z>;
	Sat, 6 Jan 2001 15:27:25 -0200
Date:	Sat, 6 Jan 2001 15:27:22 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Nicu Popovici <octavp@isratech.ro>, linux-mips@oss.sgi.com
Subject: Re: Kernel compile error.
Message-ID: <20010106152722.C2841@bacchus.dhis.org>
References: <3A56483D.17B57BD5@isratech.ro> <Pine.GSO.3.96.1010105213325.9384F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010105213325.9384F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jan 05, 2001 at 09:39:54PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 05, 2001 at 09:39:54PM +0100, Maciej W. Rozycki wrote:

>  You are trying to assemble i386 instructions -- probably your include/asm
> symlink is incorrect.  Make sure the ARCH make variable is set to "mips",
> i.e. either run `make ARCH=mips <whatever>' or modify the top-level
> Makefile (the one from our CVS appears to have ARCH hardcoded to "mips"
> already). 

The MIPS sources have ARCH hardwired to mips so his problem means he's trying
to compile some other source tree - which probably will fail even with your
hints.

  Ralf
