Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 18:05:53 +0100 (BST)
Received: from agave.telenet-ops.be ([195.130.137.77]:24469 "EHLO
	agave.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022999AbXGTRFv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 18:05:51 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by agave.telenet-ops.be (Postfix) with SMTP id A4B1967D48;
	Fri, 20 Jul 2007 19:05:50 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by agave.telenet-ops.be (Postfix) with ESMTP id 4C7A967D57;
	Fri, 20 Jul 2007 19:05:50 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-7) with ESMTP id l6KH5omg020638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jul 2007 19:05:50 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l6KH5nRM020635;
	Fri, 20 Jul 2007 19:05:49 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 20 Jul 2007 19:05:49 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	James Bottomley <James.Bottomley@SteelEye.com>
cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [patch 3/3] scsi: wd33c93 needs <asm/irq.h>
In-Reply-To: <1184950138.3455.42.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0707201905340.18493@anakin>
References: <20070720164043.523003359@mail.of.borg> <20070720164324.097994947@mail.of.borg>
 <1184950138.3455.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 20 Jul 2007, James Bottomley wrote:
> On Fri, 2007-07-20 at 18:40 +0200, Geert Uytterhoeven wrote:
> > plain text document attachment (m68k-wd33c93-needs-asm-irq.diff)
> > wd33c93 SCSI needs <asm/irq.h> on m68k
> > 
> > drivers/scsi/wd33c93.c: In function 'wd33c93_host_reset':
> > drivers/scsi/wd33c93.c:1582: error: implicit declaration of function 'disable_irq'
> > drivers/scsi/wd33c93.c:1603: error: implicit declaration of function 'enable_irq'
> > 
> > The driver still compiles on MIPS (CONFIG_SGIWD93_SCSI=y)
> 
> That's fixed here, isn't it:
> 
> http://git.kernel.org/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commit;h=078dda95c521b1c78d1b5da69ac90d581abc9951

Indeed, thx!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
