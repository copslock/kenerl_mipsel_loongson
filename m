Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6D0fXr02176
	for linux-mips-outgoing; Thu, 12 Jul 2001 17:41:33 -0700
Received: from dea.waldorf-gmbh.de (u-43-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.43])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6D0fSV02165
	for <linux-mips@oss.sgi.com>; Thu, 12 Jul 2001 17:41:28 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6D0f8h26640;
	Fri, 13 Jul 2001 02:41:08 +0200
Date: Fri, 13 Jul 2001 02:41:08 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: Phil Thompson <Phil.Thompson@pace.co.uk>,
   "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
Subject: Re: Moving from old-irq.c
Message-ID: <20010713024108.A26493@bacchus.dhis.org>
References: <54045BFDAD47D5118A850002A5095CC30AC548@exchange1.cam.pace.co.uk> <20010713013054.A24695@bacchus.dhis.org> <3B4E38EF.3D3FF73E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B4E38EF.3D3FF73E@mvista.com>; from jsun@mvista.com on Thu, Jul 12, 2001 at 04:55:27PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 12, 2001 at 04:55:27PM -0700, Jun Sun wrote:

> Ralf, I think we should have a common init_IRQ() in arch/mips/kernel, which
> will then call (*setup_irq)().  This way it is easier to build a kernel for
> multiple boards.  It is also more compatible with the current arrangment. 
> What do you think?

Well, do you actually build kernels for multiple boards that need this?  In
practice pretty much nobody seems to be interested; technical problems also
makes this much harder than on other architectures, for example of all my
MIPS systems none could actually share a kernel.

  Ralf
