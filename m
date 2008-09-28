Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Sep 2008 18:19:26 +0100 (BST)
Received: from harold.telenet-ops.be ([195.130.133.65]:51405 "EHLO
	harold.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S28639782AbYI1RSm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 28 Sep 2008 18:18:42 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by harold.telenet-ops.be (Postfix) with SMTP id 968BB30008;
	Sun, 28 Sep 2008 19:18:41 +0200 (CEST)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by harold.telenet-ops.be (Postfix) with ESMTP id 7EF2130032;
	Sun, 28 Sep 2008 19:18:39 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id m8SHIdeE016780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Sep 2008 19:18:39 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m8SHIa1j016777;
	Sun, 28 Sep 2008 19:18:38 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Sun, 28 Sep 2008 19:18:36 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, bzolnier@gmail.com,
	linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE driver
In-Reply-To: <48DF7DBC.1080804@ru.mvista.com>
Message-ID: <Pine.LNX.4.64.0809281913040.5681@anakin>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com>
 <20080928114711.GB9207@linux-mips.org> <48DF7DBC.1080804@ru.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Sun, 28 Sep 2008, Sergei Shtylyov wrote:
> Ralf Baechle wrote:
> 
> > > > +{
> 
> > > [...]
> 
> > > > +	pdev = platform_device_register_simple(DEV_NAME, -1,
> > > > +		       swarm_ide_resource, ARRAY_SIZE(swarm_ide_resource));
> 
> > >  If you have the resources as static array anyway, why not have the
> > > device in the static variable too and use platform_device_register()?
> 
> > It saves a few lines of code.
> 
>    And wastes few words of static data since platform_device_register_simple()
> will kmalloc() the resources and do a copy from these resources after which
> they are not needed -- so, it's worth making swarm_ide_resource[] __initdata
> at least.
>    If you were using platform_device_register() with static platform device,
> no memory allocation would have happened, and no data would have been wasted.

Indeed, there are different static/dynamic memory usage patterns for the
various ways to register platform devices. Unfortunately (AFAIK) it's not
properly documented which to use when.

E.g. if some devices may be present (as indicated by e.g. firmware),
which one is the most optimal to use?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
