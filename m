Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5GB06u02313
	for linux-mips-outgoing; Sat, 16 Jun 2001 04:00:06 -0700
Received: from dea.waldorf-gmbh.de (u-15-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.15])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5GB00Z02300
	for <linux-mips@oss.sgi.com>; Sat, 16 Jun 2001 04:00:01 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5G9OIl21310;
	Sat, 16 Jun 2001 11:24:18 +0200
Date: Sat, 16 Jun 2001 11:24:18 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Keith Owens <kaos@melbourne.sgi.com>, Florian Lohoff <flo@rfc822.org>,
   Raoul Borenius <borenius@shuttle.de>, linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010616112418.B21117@bacchus.dhis.org>
References: <20010613140550.B31221@bacchus.dhis.org> <Pine.GSO.3.96.1010613153740.9854H-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010613153740.9854H-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Jun 13, 2001 at 03:44:28PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 13, 2001 at 03:44:28PM +0200, Maciej W. Rozycki wrote:

>  The point is whether addresses should be extended at all if a 32-bit
> target is selected.  IMHO -- not, that's a limitation of BFD when
> configured for both a 32-bit and a 64-bit target and it should be fixed
> sooner or later (at least it's on my to-do list for some time).  BFD is
> free to handle addresses as it likes internally, be it 64-bit or 32-bit,
> but they should be truncated on final output to a 32-bit target, as they
> already are for certain cases. 

Agreed, that'd be much more readable for humans.  For processing by
software having some canonical form, that is 64-bit would be a bit more
handy though.

  Ralf
