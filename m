Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJSenC009144
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 19 May 2002 12:28:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4JJSeqe009143
	for linux-mips-outgoing; Sun, 19 May 2002 12:28:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJScnC009133
	for <linux-mips@oss.sgi.com>; Sun, 19 May 2002 12:28:38 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4JJTBM03131;
	Sun, 19 May 2002 12:29:11 -0700
Date: Sun, 19 May 2002 12:29:11 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Kip Walker <kwalker@broadcom.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020519122911.D20670@dea.linux-mips.net>
References: <3CE2DDEB.5DA6E868@broadcom.com> <NEBBLJGMNKKEEMNLHGAICEACCHAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAICEACCHAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, May 15, 2002 at 03:26:08PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 15, 2002 at 03:26:08PM -0700, Matthew Dharm wrote:

> So, how should my boot code convey that info?  With more
> add_memory_region() calls?  Is that really all I need?

Yes.  At this time you just have to make sure you don't add_memory_region()
areas which aren't supported by your particular kernel configuration.  There
is also a second limit which is memory above physical address 4GB; if you
need that you have to enable CONFIG_64BIT_PHYS_ADDR as well.

  Ralf
