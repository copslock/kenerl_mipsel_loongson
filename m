Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2VMGcE14773
	for linux-mips-outgoing; Sun, 31 Mar 2002 14:16:38 -0800
Received: from mailhost.uni-koblenz.de (root@mailhost.uni-koblenz.de [141.26.64.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2VMGUv14743;
	Sun, 31 Mar 2002 14:16:30 -0800
Received: from eddie (eddie.uni-koblenz.de [141.26.64.59])
	by mailhost.uni-koblenz.de (8.11.6/8.11.6/SuSE Linux 0.5) with SMTP id g2VMFnt05948;
	Mon, 1 Apr 2002 00:15:49 +0200
Received: from dea.linux-mips.net by eddie (SMI-8.6/KO-2.0)
	id AAA20250; Mon, 1 Apr 2002 00:15:48 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g2VMFkK12765;
	Sun, 31 Mar 2002 14:15:46 -0800
Date: Sun, 31 Mar 2002 14:15:45 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Raoul Borenius <raoul@shuttle.de>
Cc: linux-mips@oss.sgi.com, devfs@oss.sgi.com
Subject: Re: broken devfs-support in SGI Zilog8530 serial driver
Message-ID: <20020331141545.A12756@dea.linux-mips.net>
References: <20020329103244.GA15765@bunny.shuttle.de> <20020329233559.A31160@dea.linux-mips.net> <20020330132856.GA24305@bunny.shuttle.de> <20020331150023.GA30224@bunny.shuttle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020331150023.GA30224@bunny.shuttle.de>; from raoul@shuttle.de on Sun, Mar 31, 2002 at 05:00:23PM +0200
X-Accept-Language: de,en,fr
X-Virus-Scanned: by AMaViS-perl11-milter (http://amavis.org/)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Mar 31, 2002 at 05:00:23PM +0200, Raoul Borenius wrote:

> Thanks for including the changes fr the ttyS's. But it seems you forgot the
> callout-devices:

That's what you get for submitting patches that don't apply ;)  Did you do
cut'n'paste or similiar cruelties to that poor little patch?

> > @@ -1911,7 +1915,11 @@
> >          * major number and the subtype code.
> >          */
> >         callout_driver = serial_driver;
> > +#ifdef CONFIG_DEVFS_FS
> > +       callout_driver.name = "cua/%d";
> > +#else
> >         callout_driver.name = "cua";
> > +#endif
> >         callout_driver.major = TTYAUX_MAJOR;
> >         callout_driver.subtype = SERIAL_TYPE_CALLOUT;
> > 
> 
> Could you commit that too?

Sure.

  Ralf
