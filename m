Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DFsPa11989
	for linux-mips-outgoing; Mon, 13 Aug 2001 08:54:25 -0700
Received: from dea.waldorf-gmbh.de (u-86-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.86])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DFsNj11986
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 08:54:23 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7DFqQW02284;
	Mon, 13 Aug 2001 17:52:26 +0200
Date: Mon, 13 Aug 2001 17:52:26 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>,
   linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: /usr/bin/file
Message-ID: <20010813175226.D2228@bacchus.dhis.org>
References: <20010810164945.B24889@bacchus.dhis.org> <Pine.GSO.3.96.1010813133045.18279C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010813133045.18279C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Aug 13, 2001 at 01:32:19PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 13, 2001 at 01:32:19PM +0200, Maciej W. Rozycki wrote:

> > The fact that each package based on libtool is carrying it's own copy of
> > libtool around doesn't exactly help to eleminate old libtool copies
> > quickly either.
> 
>  It's worth to run `libtoolize -c -f' before building any libtool-based
> software. 

That results in build failures for a few rpms.  Many packages already do
that but unfortunately not all.

  Ralf
