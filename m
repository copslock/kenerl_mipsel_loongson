Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4I1g6Q01967
	for linux-mips-outgoing; Thu, 17 May 2001 18:42:06 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4I1g4F01964
	for <linux-mips@oss.sgi.com>; Thu, 17 May 2001 18:42:05 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4I1VdZ30837;
	Thu, 17 May 2001 22:31:39 -0300
Date: Thu, 17 May 2001 22:31:39 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Steven Liu <stevenliu@psdc.com>
Cc: Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@oss.sgi.com
Subject: Re: mips-tfile
Message-ID: <20010517223139.A19781@bacchus.dhis.org>
References: <000801c0a572$b7471e40$dde0490a@BANANA> <20010305205516.A25870@foobazco.org> <001201c0df37$2befb920$dde0490a@pcs.psdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001201c0df37$2befb920$dde0490a@pcs.psdc.com>; from stevenliu@psdc.com on Thu, May 17, 2001 at 06:09:17PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 17, 2001 at 06:09:17PM -0700, Steven Liu wrote:

> I have a question about GCC:
> 
> How can we make gcc do not use the MIPS instructions lwl, lwr, swl, and swr?

Modify gcc.  Unless you're using a new flavour (And I'm tempted to use some
curseword instead ...) of a cpu core without lwl/lwr/swl/swr there should
never be a reason to avoid those instructions.

  Ralf
