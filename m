Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDNEBI06610
	for linux-mips-outgoing; Thu, 13 Dec 2001 15:14:11 -0800
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDNE7o06607
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 15:14:07 -0800
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (SGI-8.9.3/8.9.3) with ESMTP id XAA23391
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 23:13:59 +0100 (MET)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.32 #1 (Debian))
	id 16Ee75-0005cK-00
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 23:13:59 +0100
Date: Thu, 13 Dec 2001 23:13:59 +0100
To: linux-mips@oss.sgi.com
Subject: Re: .section problems in entry.S
Message-ID: <20011213231359.I487@rembrandt.csv.ica.uni-stuttgart.de>
References: <20011209221835.A11737@dea.linux-mips.net> <Pine.GSO.3.96.1011210165719.24010A-100000@delta.ds2.pg.gda.pl> <20011213184541.A7171@dea.linux-mips.net> <20011213221254.G487@rembrandt.csv.ica.uni-stuttgart.de> <20011213162752.A6983@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213162752.A6983@nevyn.them.org>
User-Agent: Mutt/1.3.23i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> On Thu, Dec 13, 2001 at 10:12:54PM +0100, Thiemo Seufer wrote:
> > Ralf Baechle wrote:
> > [snip]
> > > >  There are no working released binutils for a modern MIPS/Linux system,
> > > > AFAIK.  However, version 2.11.92 from the CVS seems to work reasonably
> > > > well now, so chances are the next release will do as well.  Maybe 2.12
> > > > will be a good candidate then, once it is released and tested a bit. 
> > > 
> > > What is the schedule for 2.12?
> > 
> > AFAIK it is to be done in parallel to the GCC schedule:
> >   2001-12-15  Functionality freeze.
> >   2002-02-15  Branch for gcc 3.1 and binutils 2.12.
> >   2002-04-15  Release.
> 
> Where did you get this information from?

The schedule for GCC can be found at http://gcc.gnu.org/develop.html .
For the last binutils release there was some connection to the GCC
schedule. I _assume_ the next release will be done in a similiar way
due to the dependencies between both projects.


Thiemo
