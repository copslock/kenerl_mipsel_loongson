Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JFpw631576
	for linux-mips-outgoing; Fri, 19 Oct 2001 08:51:58 -0700
Received: from dea.linux-mips.net (a1as03-p40.stg.tli.de [195.252.186.40])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JFprD31573
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 08:51:53 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9JFlOp27413;
	Fri, 19 Oct 2001 17:47:24 +0200
Date: Fri, 19 Oct 2001 17:47:24 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
Subject: Re: Strange behavior of serial console under 2.4.9
Message-ID: <20011019174724.A27300@dea.linux-mips.net>
References: <20011018194014.A8744@lucon.org> <Pine.GSO.3.96.1011019152309.1657F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011019152309.1657F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Oct 19, 2001 at 03:26:10PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Oct 19, 2001 at 03:26:10PM +0200, Maciej W. Rozycki wrote:

> > I am using 9600 buad. It used to be ok under 2.4.3/2.4.5. But under
> > 2.4.9, the first 10 minutes after boot is very slow. After that, it
> > seems ok.
> 
>  That might be driver-specific.  I'm using drivers/tc/zs.c and it works
> fine at 115200 bps.

I haven't noticed this problem ever on Origins which use the standard
16550 driver.

  Ralf
