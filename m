Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f35IlgI03650
	for linux-mips-outgoing; Thu, 5 Apr 2001 11:47:42 -0700
Received: from dea.waldorf-gmbh.de (u-199-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.199])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f35IleM03646
	for <linux-mips@oss.sgi.com>; Thu, 5 Apr 2001 11:47:40 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f35CWdX13764;
	Thu, 5 Apr 2001 14:32:39 +0200
Date: Thu, 5 Apr 2001 14:32:39 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Florian Lohoff <flo@rfc822.org>,
   "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010405143239.B13023@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010404171225.6521F-100000@delta.ds2.pg.gda.pl> <3ACC4EF4.D0F7D810@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACC4EF4.D0F7D810@mips.com>; from carstenl@mips.com on Thu, Apr 05, 2001 at 12:54:44PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 05, 2001 at 12:54:44PM +0200, Carsten Langgaard wrote:

> Thanks a lot.
> I have question about installation of the SRPMs, though.
> How can I relocate the packages, so they don't need to reside under
> /usr/src/redhat/ ?

That patch is compiled into rpm and a number of the config files of rpm
in /usr/lib/rpm which are generated are rpm build time.  So changing
isn't that easy, you'll have to rebuild rpm configured with a different
pathname, I think.

  Ralf
