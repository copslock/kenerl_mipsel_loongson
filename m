Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2U8K7o08991
	for linux-mips-outgoing; Sat, 30 Mar 2002 00:20:07 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g2U8K4v08988
	for <linux-mips@oss.sgi.com>; Sat, 30 Mar 2002 00:20:04 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g2U8J1331741;
	Sat, 30 Mar 2002 00:19:01 -0800
Date: Sat, 30 Mar 2002 00:19:01 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: David Woodhouse <dwmw2@redhat.com>, Harald Koerfgen <hkoerfg@web.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4: DEC MS02-NV NVRAM module support
Message-ID: <20020330001901.A31717@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020328140909.11187D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020328140909.11187D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Mar 28, 2002 at 02:26:55PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Mar 28, 2002 at 02:26:55PM +0100, Maciej W. Rozycki wrote:

>  The patch adds support for the DEC MS02-type lithium battery backed-up
> NVRAM board.  The board provides 1MB (architecturally up to 4MB) of fast
> SRAM originally meant as a PrestoServe NFS accelerator for the MIPS-based
> DECstations.
> 
>  The code works fine for me since its creation back in August.  It was not
> tested by anyone else -- after announcing the code at the "linux-mips" 
> list last year I've read from two volunteers but they did not come back
> with results ever. 
> 
>  I believe it's suitable for inclusion in the official kernel.  The patch
> applies both to 2.4.19-pre4 and to the current CVS tree at oss.sgi.com. 

Looks good, applied to 2.4 and 2.5.

If you would have submitted this patch without prior testing in August I
certainly would have approved it as well as it had not potencial to break
things for other machines.

Thanks,

  Ralf
