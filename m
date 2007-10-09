Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Oct 2007 10:18:43 +0100 (BST)
Received: from adicia.telenet-ops.be ([195.130.132.56]:46753 "EHLO
	adicia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20025583AbXJIJSf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Oct 2007 10:18:35 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by adicia.telenet-ops.be (Postfix) with SMTP id 75D44230114;
	Tue,  9 Oct 2007 11:18:34 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by adicia.telenet-ops.be (Postfix) with ESMTP id 48D47230111;
	Tue,  9 Oct 2007 11:18:34 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l999IYWP025930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Oct 2007 11:18:34 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l999IXFB025927;
	Tue, 9 Oct 2007 11:18:34 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Tue, 9 Oct 2007 11:18:33 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	kaka <share.kt@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-git@linux-mips.org
Subject: Re: Fwd: Error opening framebuffer device
In-Reply-To: <eea8a9c90710082344r1beebc2bh507a0ba741efd364@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0710091117180.25748@anakin>
References: <eea8a9c90710082258y5bbfc987h83f00d2b48d96fc6@mail.gmail.com>
 <eea8a9c90710082344r1beebc2bh507a0ba741efd364@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 9 Oct 2007, kaka wrote:
> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol unregister_framebuffer

Try `modprobe brcmstfb', which will also load the modules it depends on.

> brcmstfb: Unknown symbol printf

Ugh, printf()? There's no printf() in our kernel.

> brcmstfb: Unknown symbol malloc

There's no malloc() in our kernel.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
