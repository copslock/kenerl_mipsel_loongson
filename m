Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 19:49:45 +0100 (BST)
Received: from p0064.as-l042.contactel.cz ([IPv6:::ffff:194.108.237.64]:64004
	"EHLO kopretinka") by linux-mips.org with ESMTP id <S8225072AbTGPStn>;
	Wed, 16 Jul 2003 19:49:43 +0100
Received: from ladis by kopretinka with local (Exim 3.35 #1 (Debian))
	id 19crHU-0001jU-00; Wed, 16 Jul 2003 20:45:36 +0200
Date: Wed, 16 Jul 2003 20:45:15 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Subject: Re: sudo oops on mips64 linux_2_4
Message-ID: <20030716184515.GA971@kopretinka>
References: <20030716142136.GA13810@paradigm.rfc822.org> <Pine.GSO.3.96.1030716165657.25959C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030716165657.25959C-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.3.28i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 16, 2003 at 05:21:20PM +0200, Maciej W. Rozycki wrote:
> On Wed, 16 Jul 2003, Florian Lohoff wrote:
> 
> > >  Please pass it through ksymoops for more details.  Version 2.4.9 should
> > > work just fine for mips64.
> > 
> > This looks still broken - Giving the vmlinux file to ksymoops makes it
> > even worse - tons or errors.
> > 
> > ksymoops 2.4.8 on mips 2.4.19-r5k-ip22.  Options used
> >      -v /dev/null (specified)
> >      -k /dev/null (specified)
> >      -l /dev/null (specified)
> >      -o /dev/null (specified)
> >      -m /home/flo/System.map (specified)
> 
>  Hmm, I would use "-V -K -L -O -m /home/flo/System.map" instead. ;-)  And
> also "-t elf64-tradbigmips -a mips:5000" as you really want 64-bit
> addresses and opcodes beyond R3k (and your ksymoops isn't configured to
> use a 64-bit target by default).  Using vmlinux might give additional
> information beyond what System.map can provide and it should work just
> fine once right options are passed to ksymoops -- I used to get correct
> output with no warnings at all. 
> 
>  At least we know the error is in drivers/video/fbmem.c:fbmem_read_proc() 

and at least we know there is something wrong. why is fbmem compiled in
at all?

> because of buf being null.  But please retry with the above options to get
> some addresses decoded.

	ladis
