Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g17GpAX26844
	for linux-mips-outgoing; Thu, 7 Feb 2002 08:51:10 -0800
Received: from dea.linux-mips.net (a1as01-p27.stg.tli.de [195.252.185.27])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g17Gp6A26837
	for <linux-mips@oss.sgi.com>; Thu, 7 Feb 2002 08:51:07 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g17Gmgn23669;
	Thu, 7 Feb 2002 17:48:42 +0100
Date: Thu, 7 Feb 2002 17:48:41 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] Eliminate more compiler warnings...
Message-ID: <20020207174841.A23659@dea.linux-mips.net>
References: <3C62A3D5.C9F7808E@cotw.com> <Pine.GSO.3.96.1020207171253.11756G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020207171253.11756G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Feb 07, 2002 at 05:18:30PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Feb 07, 2002 at 05:18:30PM +0100, Maciej W. Rozycki wrote:

>  Why is it needed?  hwif->io_ports[...] or ide_ioreg_t is short which gets
> promoted to int due to varargs automatically. 
> 
>  BTW, please send patches to the list as inlined plain text if possible. 

And split into individual independant patches.

  Ralf
