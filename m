Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJi4nC013441
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 19 May 2002 12:44:04 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4JJi4n6013440
	for linux-mips-outgoing; Sun, 19 May 2002 12:44:04 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJi2nC013427
	for <linux-mips@oss.sgi.com>; Sun, 19 May 2002 12:44:02 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4JJiZd03340;
	Sun, 19 May 2002 12:44:35 -0700
Date: Sun, 19 May 2002 12:44:35 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>, Daniel Jacobowitz <dan@debian.org>,
   Matthew Dharm <mdharm@momenco.com>, Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020519124435.H20670@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020515214818.GA1991@nevyn.them.org> <3CE2DA46.3070402@mvista.com> <007a01c1fca9$86e14f70$10eca8c0@grendel> <3CE3E8BA.8080002@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3CE3E8BA.8080002@mvista.com>; from jsun@mvista.com on Thu, May 16, 2002 at 10:13:30AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 16, 2002 at 10:13:30AM -0700, Jun Sun wrote:

> BTW, I have been under the impression that demand for larger system RAM
> mainly comes from large router/switches to store routing table.  Does
> anybody know on such systems whether the routing code runs in kernel or
> user space and whether it requires all the memory space accessible at
> the same time or can live with dynamically managed memory space?

Kernel routing is more for the lower end systems; the highend systems use
hardware assisted routing / switching where software only handles the
boundary cases; such software might either live in user or in kernel space.

  Ralf
