Received:  by oss.sgi.com id <S553748AbRAPIMJ>;
	Tue, 16 Jan 2001 00:12:09 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:56309 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553734AbRAPILo>; Tue, 16 Jan 2001 00:11:44 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869419AbRAPIKw>; Tue, 16 Jan 2001 06:10:52 -0200
Date:	Tue, 16 Jan 2001 06:10:52 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: crash in __alloc_bootmem_core on SGI current cvs
Message-ID: <20010116061052.A9752@bacchus.dhis.org>
References: <20010115181133.A2439@paradigm.rfc822.org> <Pine.GSO.3.96.1010115220514.16619Z-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010115220514.16619Z-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jan 15, 2001 at 10:21:27PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 15, 2001 at 10:21:27PM +0100, Maciej W. Rozycki wrote:

>  As I see prink() works for you could you please also check and report the
> memory map as found by the kernel, i.e. the lines output after "Determined
> physical RAM map:", if any?  The code is executed very early, before an
> actual allocation takes place, so it should run regardless.

Apropos printk, could port maintainers look into
arch/mips64/sgi-27/ip27-console.c.  It has some code which enables the
kernel to use printk already during the very early kernel startup.  I
found this capability to be invaluable and think others will also want
to have it without the uglyness of having a separate function for
early printing such as prom_printf.  I already have such a patch for
the Indy but not for other systems.

  Ralf
