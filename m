Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7AEpqS14855
	for linux-mips-outgoing; Fri, 10 Aug 2001 07:51:52 -0700
Received: from dea.waldorf-gmbh.de (u-65-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7AEpmV14850
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 07:51:48 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7AEnjo24938;
	Fri, 10 Aug 2001 16:49:45 +0200
Date: Fri, 10 Aug 2001 16:49:45 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>,
   linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: /usr/bin/file
Message-ID: <20010810164945.B24889@bacchus.dhis.org>
References: <20010810132056.D23866@bacchus.dhis.org> <Pine.GSO.3.96.1010810153057.7147A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010810153057.7147A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Aug 10, 2001 at 03:37:58PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 10, 2001 at 03:37:58PM +0200, Maciej W. Rozycki wrote:

>  Libtool doesn't really need the file program for decent shared library
> systems.  Linux/ELF is one of them and the current CVS version of libtool
> shouldn't depend on file for MIPS/Linux anymore. 

We're talking about old code here.

The fact that each package based on libtool is carrying it's own copy of
libtool around doesn't exactly help to eleminate old libtool copies
quickly either.

  Ralf
