Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4A2Bdq17574
	for linux-mips-outgoing; Wed, 9 May 2001 19:11:39 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4A2BYF17570
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 19:11:36 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4A28lf02466;
	Wed, 9 May 2001 23:08:47 -0300
Date: Wed, 9 May 2001 23:08:47 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: macro@ds2.pg.gda.pl, linux-mips@oss.sgi.com
Subject: Re: machine types for MIPS in ELF file
Message-ID: <20010509230847.A2456@bacchus.dhis.org>
References: <3AF843F7.72BC47F0@mvista.com> <20010508164846.A1471@bacchus.dhis.org> <3AF86306.343F53D0@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF86306.343F53D0@mvista.com>; from jsun@mvista.com on Tue, May 08, 2001 at 02:20:06PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 08, 2001 at 02:20:06PM -0700, Jun Sun wrote:

> > EM_MIPS_RS4_BE was apparently only in use for a short time; EM_MIPS is
> > being used for both byte order.  The byteorder is nowadays identified by
> > EI_DATA.
> > 
> 
> That makes a lot of sense.
> 
> BTW, where is the latest ELF spec that says so?  Maciej, which spec are you
> referring to?

I checked with the keepers of the ABI - EM_MIPS_RS4_BE was never registered
and EM_MIPS_RS3_LE was already registered in '92.  Anyway, my statement
stays.  I've never seen object files using architecture number 10 nor
EM_MIPS_RS3_LE used in any source except the constant definitions.

  Ralf
