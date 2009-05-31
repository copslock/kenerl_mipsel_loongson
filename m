Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 18:01:58 +0100 (BST)
Received: from waste.org ([66.93.16.53]:33331 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023994AbZEaRBw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 31 May 2009 18:01:52 +0100
Received: from [192.168.1.100] ([10.0.0.101])
	(authenticated bits=0)
	by waste.org (8.13.8/8.13.8/Debian-3) with ESMTP id n4VH1Z7l022722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 31 May 2009 12:01:36 -0500
Subject: Re: [PATCH] TXx9: Add TX4939 RNG support
From:	Matt Mackall <mpm@selenic.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
In-Reply-To: <20090601.015755.21367568.anemo@mba.ocn.ne.jp>
References: <1243350141-883-2-git-send-email-anemo@mba.ocn.ne.jp>
	 <20090601.015755.21367568.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Date:	Sun, 31 May 2009 12:01:29 -0500
Message-Id: <1243789289.22069.25.camel@calx>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new
Return-Path: <mpm@selenic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpm@selenic.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-06-01 at 01:57 +0900, Atsushi Nemoto wrote:
> : This is a reply for comments from Matt Mackall via mm-commit mail.
> 
> On Fri, 29 May 2009 19:21:22 -0500, Matt Mackall <mpm@selenic.com> wrote:
> > > +++ a/arch/mips/txx9/generic/setup_tx4939.c
> > > @@ -494,6 +494,24 @@ void __init tx4939_aclc_init(void)
> > >  			       TXX9_IRQ_BASE + TX4939_IR_ACLC, 1, 0, 1);
> > >  }
> > >  
> > > +#define TX4939_RNG_REG	((TX4939_CRYPTO_REG & 0xfffffffffULL) + 0xb0)
> > 
> > This isn't the best place for this define?
> 
> Well, I can move it to include/asm/txx9/tx4939.h.
> 
> > > +++ a/arch/mips/txx9/rbtx4939/setup.c
> > > @@ -501,6 +501,7 @@ static void __init rbtx4939_device_init(
> > >  	tx4939_dmac_init(0, 2);
> > >  	tx4939_aclc_init();
> > >  	platform_device_register_simple("txx9aclc-generic", -1, NULL, 0);
> > > +	tx4939_rng_init();
> > >  }
> > >  
> > >  static void __init rbtx4939_setup(void)
> > 
> > Not clear to me how this works when this is a module?
> 
> This patch add a registration of a platform device for RNG to vmlinux.
> And the other patch add a driver module for the RNG.  This strategy is
> fairly common for SoCs or embedded platforms.

If your driver is built as a module (which your patch allows), the above
won't work, right?

-- 
http://selenic.com : development and support for Mercurial and Linux
