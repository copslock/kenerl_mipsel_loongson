Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2U7ajL08214
	for linux-mips-outgoing; Fri, 29 Mar 2002 23:36:45 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g2U7acv08202;
	Fri, 29 Mar 2002 23:36:38 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g2U7Zx131264;
	Fri, 29 Mar 2002 23:35:59 -0800
Date: Fri, 29 Mar 2002 23:35:59 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Raoul Borenius <raoul@shuttle.de>
Cc: linux-mips@oss.sgi.com, devfs@oss.sgi.com
Subject: Re: broken devfs-support in SGI Zilog8530 serial driver
Message-ID: <20020329233559.A31160@dea.linux-mips.net>
References: <20020329103244.GA15765@bunny.shuttle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020329103244.GA15765@bunny.shuttle.de>; from raoul@shuttle.de on Fri, Mar 29, 2002 at 11:32:44AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Mar 29, 2002 at 11:32:44AM +0100, Raoul Borenius wrote:

> I'm not sure if this is a devfs or mips problem so I'm sending it
> to both lists.
> 
> I just compiled my own mips-kernel from oss.sgi.com:/cvs to get
> devfs-support. Unfortunately there seems to be a problem with the
> serial-driver at least in the linux_2_4 branch:
> 
> SGI Zilog8530 serial driver version 1.00
> devfs_register(ttyS): could not append to parent, err: -17
> devfs_register(cua): could not append to parent, err: -17

At this time we don't even claim to have proper devfs support in the
Indy serial drivers ...

  Ralf
