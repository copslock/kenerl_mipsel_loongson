Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0C6gi711016
	for linux-mips-outgoing; Fri, 11 Jan 2002 22:42:44 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0C6gbg11013;
	Fri, 11 Jan 2002 22:42:37 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 4A591125CB; Fri, 11 Jan 2002 21:42:35 -0800 (PST)
Date: Fri, 11 Jan 2002 21:42:34 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Adrian.Hulse@taec.toshiba.com, linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
Message-ID: <20020111214234.A5294@lucon.org>
References: <OFBDC20C8C.A135D7FF-ON88256B3E.006DCF0C@taec.com> <20020111120806.A28902@lucon.org> <20020111212620.A4809@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020111212620.A4809@dea.linux-mips.net>; from ralf@oss.sgi.com on Fri, Jan 11, 2002 at 09:26:20PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 11, 2002 at 09:26:20PM -0800, Ralf Baechle wrote:
> On Fri, Jan 11, 2002 at 12:08:06PM -0800, H . J . Lu wrote:
> 
> > > I don't know for sure just yet, the package takes a long time to compile.
> > > The last time I compiled the package it failed to build - whether it is due
> > > to the warnings or not I don't really know - maybe not.
> > > 
> > 
> > libtool is very fragile. If it doesn't cause the failure, I won't touch
> > it.
> 
> This bug may result in libraries not getting linked against certain other
> libraries thus DT_NEEDED entries missing.  Frequently that's harmless but
> it breaks a few packages.  I remember fixing this in a large number of
> RH 7.0 packages.
> 
> Bug are rarely harmless just their consequences are subtle.

Ok. Please try

ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/SRPMS/libtool-1.3.5-8.3.src.rpm

You have to rebuild it on your Linux/mips system with

# su
# rpm --rebuild libtool-1.3.5-8.3.src.rpm

Let me know if it works for you.


H.J.
to

ELF [0-9][0-9]*-bit [LM]SB [.]* (shared object | dynamic lib)


H.J.

H.J.
