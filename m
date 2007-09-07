Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Sep 2007 08:10:45 +0100 (BST)
Received: from asia.telenet-ops.be ([195.130.137.74]:47045 "EHLO
	asia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20025008AbXIGHKg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Sep 2007 08:10:36 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by asia.telenet-ops.be (Postfix) with SMTP id 3FEE5D416C;
	Fri,  7 Sep 2007 09:10:26 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by asia.telenet-ops.be (Postfix) with ESMTP id F3994D413C;
	Fri,  7 Sep 2007 09:10:12 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-8) with ESMTP id l877ACZA007243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 7 Sep 2007 09:10:12 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l877A0Lu007200;
	Fri, 7 Sep 2007 09:10:00 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Fri, 7 Sep 2007 09:10:00 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org,
	ejka@imfi.kspu.ru, jgarzik@pobox.com, netdev@vger.kernel.org,
	davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
	jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de
Subject: Re: [PATCH][MIPS][7/7] AR7: ethernet
In-Reply-To: <20070906153025.7cb71cb1.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0709070908200.5202@anakin>
References: <200708201704.11529.technoboy85@gmail.com>
 <200709061734.11170.technoboy85@gmail.com> <20070906153025.7cb71cb1.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 6 Sep 2007, Andrew Morton wrote:
> > On Thu, 6 Sep 2007 17:34:10 +0200 Matteo Croce <technoboy85@gmail.com> wrote:
> > Driver for the cpmac 100M ethernet driver.
> > It works fine disabling napi support, enabling it gives a kernel panic
> > when the first IPv6 packet has to be forwarded.
> > Other than that works fine.
> 
> The driver does a lot of open-coded dma_cache_inv() calls (in a way which
> assumes a 32-bit bus, too).  I assume that dma_cache_inv() is some mips

No, even i386 has it ;-)

> thing.  I'd have thought that it would be better to use the dma mapping API
> thoughout the driver, and its associated dma invalidation APIs.

However, Ralf just posted a patch to remove it on all architectures, and
driver writers should consider it gone.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
