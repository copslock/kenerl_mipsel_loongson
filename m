Received:  by oss.sgi.com id <S553806AbRAPPqO>;
	Tue, 16 Jan 2001 07:46:14 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:27888 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553798AbRAPPpu>; Tue, 16 Jan 2001 07:45:50 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869419AbRAPPoy>; Tue, 16 Jan 2001 13:44:54 -0200
Date:	Tue, 16 Jan 2001 13:44:54 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Christoph Martin <martin@uni-mainz.de>,
        Joe deBlaquiere <jadb@redhat.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        linux-mips <linux-mips@fnet.fr>
Subject: Re: strace package
Message-ID: <20010116134453.B12858@bacchus.dhis.org>
References: <20010116061252.B9752@bacchus.dhis.org> <Pine.GSO.3.96.1010116123223.5546B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010116123223.5546B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Jan 16, 2001 at 12:40:11PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 16, 2001 at 12:40:11PM +0100, Maciej W. Rozycki wrote:

> > > > There is a debian package of strace for mips in
> > > > ftp://ftp.rfc822.org/pub/local/debian-mips/packages/. It is working
> > > > with linux 2.4.
> > > 
> > >  And the sources are at...?
> > 
> > See strace.sourceforge.net.
> 
>  I mean patches for MIPS, of course.  Strace 4.2 does not work for MIPS
> out of the box.  The proper source still appears to be
> http://www.liacs.nl/~wichert/strace/, BTW. 

Wiggy somewhen gave me write access to the strace source some time ago, so
I assume that the stuff on sourceforge is now the official CVS.  For MIPS
I was using some CVS snapshot which was working for me out of the box
after I checked in some fixes.  But that's again already some time ago,
things may have changed since then.

  Ralf
