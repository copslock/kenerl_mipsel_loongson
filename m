Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2VLsxH11911
	for linux-mips-outgoing; Sun, 31 Mar 2002 13:54:59 -0800
Received: from mailhost.uni-koblenz.de (root@mailhost.uni-koblenz.de [141.26.64.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2VLsqv11891;
	Sun, 31 Mar 2002 13:54:52 -0800
Received: from eddie (eddie.uni-koblenz.de [141.26.64.59])
	by mailhost.uni-koblenz.de (8.11.6/8.11.6/SuSE Linux 0.5) with SMTP id g2VLsBt03917;
	Sun, 31 Mar 2002 23:54:11 +0200
Received: from dea.linux-mips.net by eddie (SMI-8.6/KO-2.0)
	id XAA20174; Sun, 31 Mar 2002 23:54:10 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g2UKIBt02122;
	Sat, 30 Mar 2002 12:18:11 -0800
Date: Sat, 30 Mar 2002 12:18:11 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Raoul Borenius <raoul@shuttle.de>
Cc: linux-mips@oss.sgi.com, devfs@oss.sgi.com
Subject: Re: broken devfs-support in SGI Zilog8530 serial driver
Message-ID: <20020330121811.A2049@dea.linux-mips.net>
References: <20020329103244.GA15765@bunny.shuttle.de> <20020329233559.A31160@dea.linux-mips.net> <20020330132856.GA24305@bunny.shuttle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020330132856.GA24305@bunny.shuttle.de>; from raoul@shuttle.de on Sat, Mar 30, 2002 at 02:28:56PM +0100
X-Accept-Language: de,en,fr
X-Virus-Scanned: by AMaViS-perl11-milter (http://amavis.org/)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Mar 30, 2002 at 02:28:56PM +0100, Raoul Borenius wrote:

> > > I just compiled my own mips-kernel from oss.sgi.com:/cvs to get
> > > devfs-support. Unfortunately there seems to be a problem with the
> > > serial-driver at least in the linux_2_4 branch:
> > > 
> > > SGI Zilog8530 serial driver version 1.00
> > > devfs_register(ttyS): could not append to parent, err: -17
> > > devfs_register(cua): could not append to parent, err: -17
> > 
> > At this time we don't even claim to have proper devfs support in the
> > Indy serial drivers ...
> 
> But it would be nice to have ;-)
> 
> Especially because you only need the small change pointed out by
> Russell Coker:

Ok :-)  Applied to 2.4 and 2.5.

  Ralf
