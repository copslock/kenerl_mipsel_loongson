Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJUSnC009663
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 19 May 2002 12:30:28 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4JJUSBQ009662
	for linux-mips-outgoing; Sun, 19 May 2002 12:30:28 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJUQnC009649
	for <linux-mips@oss.sgi.com>; Sun, 19 May 2002 12:30:26 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4JJUxd03165;
	Sun, 19 May 2002 12:30:59 -0700
Date: Sun, 19 May 2002 12:30:59 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: Daniel Jacobowitz <dan@debian.org>, Matthew Dharm <mdharm@momenco.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020519123059.E20670@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020515214818.GA1991@nevyn.them.org> <3CE2DA46.3070402@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3CE2DA46.3070402@mvista.com>; from jsun@mvista.com on Wed, May 15, 2002 at 02:59:34PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 15, 2002 at 02:59:34PM -0700, Jun Sun wrote:

> Back to 64bit port, it seems to me much of the 32bit work we have done in the 
> past a year or so needs to be moved over.  Or better yet, if we can clean up 
> integer/long issues, we might be able to use 32bit kernel code straight for 
> 64bit kernel.

Int vs. long was a very small issue as I discovered during porting for the
first 64-bit machines, the IP22 and IP27.

  Ralf
