Received: (from mail@localhost)
	by linux-xfs.sgi.com (8.12.0.Beta5/8.12.0.Beta5) id f59EOIeT012088
	for linux-mips-outgoing; Sat, 9 Jun 2001 07:24:18 -0700
X-Authentication-Warning: linux-xfs.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.waldorf-gmbh.de (u-42-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.42])
	by linux-xfs.sgi.com (8.12.0.Beta5/8.12.0.Beta5) with SMTP id f59EOC3D012070
	for <linux-mips@oss.sgi.com>; Sat, 9 Jun 2001 07:24:15 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f59EO4o08938;
	Sat, 9 Jun 2001 16:24:04 +0200
Date: Sat, 9 Jun 2001 16:24:04 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Does anyone know this?
Message-ID: <20010609162404.A8916@bacchus.dhis.org>
References: <20010608225036.A4162@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010608225036.A4162@lucon.org>; from hjl@lucon.org on Fri, Jun 08, 2001 at 10:50:36PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jun 08, 2001 at 10:50:36PM -0700, H . J . Lu wrote:

> Does anyone know this?
> 
> http://mail-index.netbsd.org/port-mips/2001/05/24/0002.html
> 
> Do we still have the pthread problems mentioned there?

The varargs bug afair was fixed in glibc by Chris Johnson and Andreas
Jaeger and Maciej recently posted a patch for the kernel to linux-kernel.

  Ralf
