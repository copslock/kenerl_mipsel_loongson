Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5G9Er701587
	for linux-mips-outgoing; Sat, 16 Jun 2001 02:14:53 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5G9EmZ01584;
	Sat, 16 Jun 2001 02:14:49 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id AEF647FD; Sat, 16 Jun 2001 11:14:46 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 431F042FF; Sat, 16 Jun 2001 11:14:43 +0200 (CEST)
Date: Sat, 16 Jun 2001 11:14:43 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: 2.4.5 in cvs - Did anyone try ?
Message-ID: <20010616111443.A9156@paradigm.rfc822.org>
References: <20010615210433.A4282@paradigm.rfc822.org> <20010616041455.A19841@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010616041455.A19841@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Jun 16, 2001 at 04:14:55AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 16, 2001 at 04:14:55AM +0200, Ralf Baechle wrote:
> On Fri, Jun 15, 2001 at 09:04:33PM +0200, Florian Lohoff wrote:
> 
> > i am  just trying 2.4.5 on an Indy and i have no luck. The kernel
> > gets confused very fast on the root ext2 filesystem the 2.4.3 continues
> > to boot from. It is spitting our "EXT2: Bit already set for inode x"
> > and hangs in a tight loop.
> 
> There was a stupid braino in include/asm-mips/bitops.h, make sure you
> have revision 1.16 of that file.

I have 1.16 of that file.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
