Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5IJfjj22759
	for linux-mips-outgoing; Mon, 18 Jun 2001 12:41:45 -0700
Received: from dea.waldorf-gmbh.de (u-95-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.95])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5IJfgV22755
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 12:41:43 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5IJfHA27105;
	Mon, 18 Jun 2001 21:41:17 +0200
Date: Mon, 18 Jun 2001 21:41:17 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Brian Murphy <brian@murphy.dk>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Problems with mips2 compiled libc and linux 2.4.3
Message-ID: <20010618214116.A26781@bacchus.dhis.org>
References: <3B2E4458.1637A08A@murphy.dk> <20010618112253.A28744@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010618112253.A28744@lucon.org>; from hjl@lucon.org on Mon, Jun 18, 2001 at 11:22:53AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 18, 2001 at 11:22:53AM -0700, H . J . Lu wrote:

> > which fails if any of the high 4 bits in the flags are set. According to
> > the
> > specs these are set for the various mipsx (x != 1) flavors - this seems
> 
> > to mean
> > that we do no allow anything higher than mips1 run on linux - can this
> > be
> > true? If so, why?
> 
> There is no very good reason. I think we should add a MIPS ISA level
> field in the mips cpuinfo so that we can check what ISA the hardware
> support at the run-time.

Yes and no.  It would be nice but the available flags are not an suitable
representation of processor capabilities.

  Ralf
