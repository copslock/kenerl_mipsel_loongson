Received:  by oss.sgi.com id <S553715AbRCDTub>;
	Sun, 4 Mar 2001 11:50:31 -0800
Received: from u-155-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.155]:1796
        "EHLO u-155-18.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553738AbRCDTuM>; Sun, 4 Mar 2001 11:50:12 -0800
Received: from dea ([193.98.169.28]:8832 "EHLO dea.waldorf-gmbh.de")
	by bacchus.dhis.org with ESMTP id <S867210AbRCDTt7>;
	Sun, 4 Mar 2001 20:49:59 +0100
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f24JmQn16937;
	Sun, 4 Mar 2001 20:48:26 +0100
Date:	Sun, 4 Mar 2001 20:48:26 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Carsten Langgaard <carstenl@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Bug in get_insn_opcode.
Message-ID: <20010304204826.B15182@bacchus.dhis.org>
References: <20010303082115.B5750@bacchus.dhis.org> <Pine.LNX.4.10.10103031614440.455-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10103031614440.455-100000@cassiopeia.home>; from geert@linux-m68k.org on Sat, Mar 03, 2001 at 04:15:05PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Mar 03, 2001 at 04:15:05PM +0100, Geert Uytterhoeven wrote:

> > > Index: arch/mips/kernel/traps.c
> > > ===================================================================
> > > RCS file: /home/repository/sw/linux-2.4.0/arch/mips/kernel/traps.c,v
> > > retrieving revision 1.10
> > > diff -u -r1.10 traps.c
> > > --- traps.c     2001/02/28 13:46:43     1.10
> > > +++ traps.c     2001/03/02 16:50:27
> > 
> > Patch will behave (un-)funny on a cvs diff generated patch like this which
> > lacks full pathnames in the --- and +++ lines.  Patches for this
> > behaviour are available on ftp.cyclic.com (so it still exists ...) or in
> > more recent cvs rpms.
> 
> Isn't patch supposed to look at the `Index' line?

Only when the environment variable POSIXLY_CORRECT is set to y which has
a ton of other unwanted side effects, so patch would need wrapper scripts
or what not else.

  Ralf
