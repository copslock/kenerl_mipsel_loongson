Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49L6XJ09979
	for linux-mips-outgoing; Wed, 9 May 2001 14:06:33 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49L6UF09971;
	Wed, 9 May 2001 14:06:30 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f49L6T014798;
	Wed, 9 May 2001 14:06:29 -0700
Message-ID: <3AF9B173.5E13AD2@mvista.com>
Date: Wed, 09 May 2001 14:06:59 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: lift the ioport_resource limit ...
References: <3AF97FD0.7F382E49@mvista.com> <20010509162608.C2466@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Wed, May 09, 2001 at 10:35:12AM -0700, Jun Sun wrote:
> 
> > Currently IO_SPACE_LIMIT is 0xffff, which is probably borrowed from the legacy
> > i386 code.  Let us remove that limit, so that each machine does not have to
> > laboriously reset it.
> 
> ISA?
> 
>    Ralf

ISA bus?

The PCI IO space essentially extends the ISA bus, which effectively removes
the 0xffff limits.

If you are really paranoid, we can do something like this:

#if defined(CONFIG_ISA) && !defined(CONFIG_PCI)
#define IO_SPACE_LIMIT 0xffff
#else
#define IO_SPACE_LIMIT 0xffffffff
#endif


Jun
