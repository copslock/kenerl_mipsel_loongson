Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5NEQIB24026
	for linux-mips-outgoing; Sat, 23 Jun 2001 07:26:18 -0700
Received: from dea.waldorf-gmbh.de (u-136-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.136])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5NEQFV24020
	for <linux-mips@oss.sgi.com>; Sat, 23 Jun 2001 07:26:16 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5NEMLO29995;
	Sat, 23 Jun 2001 16:22:21 +0200
Date: Sat, 23 Jun 2001 16:22:21 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: Bug in memmove
Message-ID: <20010623162221.A29966@bacchus.dhis.org>
References: <3B1E2BF7.5C0CADB8@niisi.msk.ru> <Pine.GSO.3.96.1010622200059.18677C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010622200059.18677C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jun 22, 2001 at 08:21:30PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jun 22, 2001 at 08:21:30PM +0200, Maciej W. Rozycki wrote:

> > It seems there is a bug in our memmove routine. The condition is rare
> > though, for example, memmove copies incorrectly, if src=5, dst=4, len=9.
> [...]
> > Two questions here. First, do we have a pattern that satisfies the
> > condition, i.e. is the bug showstopper? My guess, it's not. Second, does
> > somebody have ideas how to fix the bug? Well, I have, but want to hear
> > somebody else.
> 
>  Here is a quick fix I developed after reading your report.  It fixes the
> case you described.  Now memcpy() is invoked only if there is no overlap
> at all -- the approach is taken from the Alpha port. 
> 
>  The copy loop begs for optimization (the original memmove() bits do as
> well), but at least it works correctly.  The patch applies cleanly to
> 2.4.5 as of today. 
> 
>  Ralf, I think it should get applied unless someone cooks up a better
> solution, i.e. optimizes it.  I'll optimize it myself, eventually, if no
> one else does, but don't hold your breath.

Applied to my working tree.  I'll commit it in a few hours once I found
time to implement the same fix for 2.2 and mips64.

  Ralf
