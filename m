Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 12:42:54 +0100 (BST)
Received: from agave.telenet-ops.be ([195.130.137.77]:19948 "EHLO
	agave.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022998AbXJALmp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Oct 2007 12:42:45 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by agave.telenet-ops.be (Postfix) with SMTP id 2F8FD67D69;
	Mon,  1 Oct 2007 13:42:35 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by agave.telenet-ops.be (Postfix) with ESMTP id 11E1167D5A;
	Mon,  1 Oct 2007 13:42:35 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l91BgYuU023078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 1 Oct 2007 13:42:34 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l91BgYxo023075;
	Mon, 1 Oct 2007 13:42:34 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Mon, 1 Oct 2007 13:42:34 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	veerasena reddy <veerasena_b@yahoo.co.in>
cc:	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux cache routines for Write-back cache policy on  MIPS24KE
In-Reply-To: <302271.86305.qm@web8404.mail.in.yahoo.com>
Message-ID: <Pine.LNX.4.64.0710011341320.20679@anakin>
References: <302271.86305.qm@web8404.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, 1 Oct 2007, veerasena reddy wrote:
> In linux-2.6.18 (for MIPS24KE processor):
> suppose if i want to do flush only then which API i
> should use?

`flush' is fuzzy terminology: some people mean invalidate, others mean
write back, others mean both.

> Similarly, if i want to do invalidation only which API
> i should use?

dma_cache_inv().

> --- Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > On Mon, 1 Oct 2007, veerasena reddy wrote:
> > > I have ported Linux-2.6.18 kernel on MIPS24KE
> > > processor. I am using write back cache policy.
> > > 
> > > Could you please guide me under what cases the
> > below
> > > cache API's are being used:
> > > - dma_cache_wback_inv() : Could you explain  what
> > > exactly this function does
> > 
> > It does both write back and invalidate.
> > 
> > > - dma_cache_wback() : This function write back the
> > > cache data to memory
> > > - dma_cache_inv  : This function invalidate the
> > cache
> > > tags. so subsequent access will fetch from memory.
> > 
> > Note that 2.6.18 is old. The above functions are
> > intended to be removed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
