Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJNmnC007913
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 19 May 2002 12:23:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4JJNmUm007912
	for linux-mips-outgoing; Sun, 19 May 2002 12:23:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJNknC007900
	for <linux-mips@oss.sgi.com>; Sun, 19 May 2002 12:23:46 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4JJOJT03014;
	Sun, 19 May 2002 12:24:19 -0700
Date: Sun, 19 May 2002 12:24:19 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Matthew Dharm <mdharm@momenco.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020519122419.B20670@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020515214818.GA1991@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020515214818.GA1991@nevyn.them.org>; from dan@debian.org on Wed, May 15, 2002 at 05:48:18PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 15, 2002 at 05:48:18PM -0400, Daniel Jacobowitz wrote:

> On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:
> > So... I'm looking at porting Linux to a system with 1.5GiB of RAM.
> > That kinda blows the 32-bit MIPS port option right out of the water...
> 
> Not unless you count bits differently than I do... 32-bit is 4 GiB.  Is
> there any reason MIPS has special problems in this area?

The basic assumption is that we can address all memory through KSEG0.

  Ralf
