Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33IN4u13976
	for linux-mips-outgoing; Tue, 3 Apr 2001 11:23:04 -0700
Received: from dea.waldorf-gmbh.de (u-231-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.231])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33IMvM13970
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 11:22:58 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f33ILR600471;
	Tue, 3 Apr 2001 20:21:27 +0200
Date: Tue, 3 Apr 2001 20:21:27 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: "Scott G. Miller" <scgmille@indiana.edu>, <linux-kernel@vger.kernel.org>,
   Andy Carlson <naclos@swbell.net>, Carsten Langgaard <carstenl@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: pcnet32 (maybe more) hosed in 2.4.3
Message-ID: <20010403202127.A316@bacchus.dhis.org>
References: <20010330190137.A426@indiana.edu> <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0103311541300.406-100000@fs131-224.f-secure.com>; from szaka@f-secure.com on Sat, Mar 31, 2001 at 03:58:11PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Carsten,

seems your pcnet32 changes which made it into 2.4.3 are causing trouble
on i386 machines.  Can you try to solve that problem?

On Sat, Mar 31, 2001 at 03:58:11PM +0200, Szabolcs Szakacsits wrote:

> On Fri, 30 Mar 2001, Scott G. Miller wrote:
> 
> > Linux 2.4.3, Debian Woody.  2.4.2 works without problems.  However, in
> > 2.4.3, pcnet32 loads, gives an error message:
> 
> 2.4.3 (and -ac's) are also broken as guest in VMWware due to the pcnet32
> changes [doing 32 bit IO on 16 bit regs on the 79C970A controller].
> Reverting this part of patch-2.4.3 below made things work again.
> 
> 	Szaka
> 
> @@ -528,11 +535,13 @@
>      pcnet32_dwio_reset(ioaddr);
>      pcnet32_wio_reset(ioaddr);
> 
> -    if (pcnet32_wio_read_csr (ioaddr, 0) == 4 && pcnet32_wio_check (ioaddr)) {
> -       a = &pcnet32_wio;
> +    /* Important to do the check for dwio mode first. */
> +    if (pcnet32_dwio_read_csr(ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
> +        a = &pcnet32_dwio;
>      } else {
> -       if (pcnet32_dwio_read_csr (ioaddr, 0) == 4 && pcnet32_dwio_check(ioaddr)) {
> -           a = &pcnet32_dwio;
> +        if (pcnet32_wio_read_csr(ioaddr, 0) == 4 &&
> +           pcnet32_wio_check(ioaddr)) {
> +           a = &pcnet32_wio;
>         } else
>             return -ENODEV;
>      }
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

  Ralf
