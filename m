Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A9AaA06464
	for linux-mips-outgoing; Fri, 10 Aug 2001 02:10:36 -0700
Received: from dvmwest.gt.owl.de (postfix@dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A9AZV06460
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 02:10:35 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 3441DC4FE; Fri, 10 Aug 2001 11:10:33 +0200 (CEST)
Date: Fri, 10 Aug 2001 11:10:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: Problem with PMAD-AA / DECStation 5000/200
Message-ID: <20010810111033.B760@lug-owl.de>
Mail-Followup-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@oss.sgi.com
References: <20010809183552.B25724@lug-owl.de> <Pine.GSO.3.96.1010810105208.2724E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010810105208.2724E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Aug 10, 2001 at 11:00:40AM +0200
X-Operating-System: Linux mail 2.4.5 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2001-08-10 11:00:40 +0200, Maciej W. Rozycki <macro@ds2.pg.gda.pl>
wrote in message <Pine.GSO.3.96.1010810105208.2724E-100000@delta.ds2.pg.gda.pl>:
> On Thu, 9 Aug 2001, Jan-Benedict Glaw wrote:
> 
> > I'm not that sure. Does there always exist a "clean" PROM? For
> > example, I'm searching for a tftp/bootp enabled PROM for a
> > DEC 5000/240 (or was it /200?). Does anybody have sth like this?
> 
>  Look at 'http://www.netbsd.org/Ports/pmax/board-list.html'.  They list MB
> ROMs only, though.  Note that certain options (FDDI controllers) have a
> Flash ROM that is soldered to the PCB, so they can only be updated via
> appropriate software. 

Or via a soldering iron:-) I don't fear using it, but currently
I don't own an EPROM burner:-(

MfG, JBG
