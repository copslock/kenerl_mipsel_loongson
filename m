Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LItX728577
	for linux-mips-outgoing; Sat, 21 Jul 2001 11:55:33 -0700
Received: from dea.waldorf-gmbh.de (u-151-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.151])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LItUV28574
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 11:55:30 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6LIt2026575;
	Sat, 21 Jul 2001 20:55:02 +0200
Date: Sat, 21 Jul 2001 20:55:02 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Greg Satz <satz@ayrnetworks.com>, linux-mips@oss.sgi.com
Subject: Re: SHN_MIPS_SCOMMON
Message-ID: <20010721205502.A25928@bacchus.dhis.org>
References: <20010721033019.A22637@bacchus.dhis.org> <B77EA5E8.883E%satz@ayrnetworks.com> <20010721141119.A25053@bacchus.dhis.org> <20010721104144.A17894@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721104144.A17894@lucon.org>; from hjl@lucon.org on Sat, Jul 21, 2001 at 10:41:44AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 10:41:44AM -0700, H . J . Lu wrote:

> > .scommon shouldn't ever be in a kernel object.  It seems that ld started
> > to move .common objects to .scommon from a certain version on, so 2.4.5
> 
> Send me a testcase. I will fix the linker.

There is no linker bug, this is just the GP optimization in action.

  Ralf
