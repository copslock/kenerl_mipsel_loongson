Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6G4r6k25892
	for linux-mips-outgoing; Sun, 15 Jul 2001 21:53:06 -0700
Received: from dea.waldorf-gmbh.de (pD956F5FD.dip.t-dialin.net [217.86.245.253])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6G4r3V25889
	for <linux-mips@oss.sgi.com>; Sun, 15 Jul 2001 21:53:03 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6G4pqo04660;
	Mon, 16 Jul 2001 06:51:52 +0200
Date: Mon, 16 Jul 2001 06:51:52 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch
Message-ID: <20010716065151.A1333@bacchus.dhis.org>
References: <20010712224520.C23062@bacchus.dhis.org> <Pine.GSO.3.96.1010713124802.3193B-100000@delta.ds2.pg.gda.pl> <20010714125312.A6713@bacchus.dhis.org> <20010715213224.A19636@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010715213224.A19636@mvista.com>; from jsun@mvista.com on Sun, Jul 15, 2001 at 09:32:24PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jul 15, 2001 at 09:32:24PM -0700, Jun Sun wrote:

> For compatibility reasons, I assume we still keep sysmips() around
> for a while, right?  And if that is yes, we better take either flo's or
> my fix (derived from Maceij's new syscall) to get rid of the illegal 
> instruction bug, which really becomes an untolerable FAQ now.

I've also debugged sysmips.

  Ralf
