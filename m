Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0C6QQR10756
	for linux-mips-outgoing; Fri, 11 Jan 2002 22:26:26 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0C6QNg10752
	for <linux-mips@oss.sgi.com>; Fri, 11 Jan 2002 22:26:23 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0C5QKn04944;
	Fri, 11 Jan 2002 21:26:20 -0800
Date: Fri, 11 Jan 2002 21:26:20 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Adrian.Hulse@taec.toshiba.com, linux-mips@oss.sgi.com
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
Message-ID: <20020111212620.A4809@dea.linux-mips.net>
References: <OFBDC20C8C.A135D7FF-ON88256B3E.006DCF0C@taec.com> <20020111120806.A28902@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020111120806.A28902@lucon.org>; from hjl@lucon.org on Fri, Jan 11, 2002 at 12:08:06PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 11, 2002 at 12:08:06PM -0800, H . J . Lu wrote:

> > I don't know for sure just yet, the package takes a long time to compile.
> > The last time I compiled the package it failed to build - whether it is due
> > to the warnings or not I don't really know - maybe not.
> > 
> 
> libtool is very fragile. If it doesn't cause the failure, I won't touch
> it.

This bug may result in libraries not getting linked against certain other
libraries thus DT_NEEDED entries missing.  Frequently that's harmless but
it breaks a few packages.  I remember fixing this in a large number of
RH 7.0 packages.

Bug are rarely harmless just their consequences are subtle.

  Ralf
