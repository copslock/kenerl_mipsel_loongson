Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HH59c08518
	for linux-mips-outgoing; Mon, 17 Sep 2001 10:05:09 -0700
Received: from dea.linux-mips.net (u-68-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.68])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HH50e08515
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 10:05:01 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f8HE1qX27118;
	Mon, 17 Sep 2001 16:01:52 +0200
Date: Mon, 17 Sep 2001 16:01:52 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Eugenio Diaz <getnito@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Origin 200
Message-ID: <20010917160152.C26631@dea.linux-mips.net>
References: <Pine.LNX.4.33.0109161018030.27130-100000@mercury.shreve.net> <20010917075345.52314.qmail@web14007.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010917075345.52314.qmail@web14007.mail.yahoo.com>; from getnito@yahoo.com on Mon, Sep 17, 2001 at 12:53:45AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Sep 17, 2001 at 12:53:45AM -0700, Eugenio Diaz wrote:

> > Its the rackmount version..............I will search for some
> > benchmarks to see how this system ranks compared to some
> > PIII and other systems.
> > 
> > Are there any graphics options available for these, or just console?
> > 
> > I realize the origin is more of a "server", used for serving files
> > and web pages, than a workstation.
> 
> I used to work for an SGI VAR, and we sold expensive (he, he) but SGI approved
> third party PCI video cards; I don't remember what manufacturer tough. I
> remember one particular customer (an NT shop) who was not comfortable with
> head-less servers, and required us to put a head on it :-)

Head-less users ;-)

With the firmware not supporting video that is just a halfbreed headless
system anyway ...

> However, I think that if Linux is currently handling the PCI Bus (I think it's
> a 64-bit) on that architecture, you can use any PCI video card supported by
> Linux ... am I right?

Yes.  In theory.  The usual problem with video card initialization through
the BIOS applies.  Aside of this PCI video cards should work fine.

  Ralf
