Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g09CVEm03681
	for linux-mips-outgoing; Wed, 9 Jan 2002 04:31:14 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g09CV7g03678
	for <linux-mips@oss.sgi.com>; Wed, 9 Jan 2002 04:31:08 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g09BUeX01772;
	Wed, 9 Jan 2002 09:30:40 -0200
Date: Wed, 9 Jan 2002 09:30:40 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jason Gunthorpe <jgg@debian.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Q about ST0_UX
Message-ID: <20020109093039.A1468@dea.linux-mips.net>
References: <Pine.LNX.3.96.1020109000346.9606F-100000@wakko.deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020109000346.9606F-100000@wakko.deltatee.com>; from jgg@debian.org on Wed, Jan 09, 2002 at 12:08:47AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 09, 2002 at 12:08:47AM -0700, Jason Gunthorpe wrote:

> I just noticed that in setup.c there is this little bit:
> 
>         s = read_32bit_cp0_register(CP0_STATUS);
>         s &= ~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_KX|ST0_SX|ST0_FR);
>         s |= ST0_CU0;
>         write_32bit_cp0_register(CP0_STATUS, s);
> 
> And it doesn't mask off ST0_UX - is this an oversight? With my RM7K the
> kernel is called with ST0_UX set, and since it doesn't clear it the XTLB
> handler is called - which faults things..

On all firmware I've made the 32-bit kernel run on it is invoked with UX
cleared so I just didn't bother to clear it myself.

> So, would this patch be appropriate in general:
> 
> --- setup.c     2001/12/02 11:34:38     1.96
> +++ setup.c     2002/01/09 08:05:43
> @@ -558,7 +558,7 @@
>  
>         /* Disable coprocessors and set FPU for 16 FPRs */
>         s = read_32bit_cp0_register(CP0_STATUS);
> -       s &= ~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_KX|ST0_SX|ST0_FR);
> +       s &= ~(ST0_CU1|ST0_CU2|ST0_CU3|ST0_UX|ST0_KX|ST0_SX|ST0_FR);
>         s |= ST0_CU0;
>         write_32bit_cp0_register(CP0_STATUS, s);
> 
> or is it better to make the xtlb handler work in the 32 bit case?

No, your patch is the right thing.  Enabeling UX would also permit the
use of 64-bit instructions and that wouldn't work on the 32-bit kernel.

  Ralf
