Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 08:03:22 +0100 (BST)
Received: from asia.telenet-ops.be ([195.130.137.74]:1428 "EHLO
	asia.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022471AbXJCHCv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 08:02:51 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by asia.telenet-ops.be (Postfix) with SMTP id 5B97FD41B0;
	Wed,  3 Oct 2007 09:02:50 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by asia.telenet-ops.be (Postfix) with ESMTP id 3CF85D41CB;
	Wed,  3 Oct 2007 09:02:47 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9372kMD019964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Oct 2007 09:02:46 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l9372keA019961;
	Wed, 3 Oct 2007 09:02:46 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 3 Oct 2007 09:02:46 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Ed Stafford <ed.stafford@gmail.com>, linux-mips@linux-mips.org
Subject: Re: What is the current state of the Octane/IP30 support?
In-Reply-To: <47033156.7090703@gentoo.org>
Message-ID: <Pine.LNX.4.64.0710030902110.14583@anakin>
References: <41370a610710021341g749742dejec06b3a38477fd47@mail.gmail.com>
 <47033156.7090703@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 3 Oct 2007, Kumba wrote:
> For the most part, Impact-based systems run great.  You get X, unaccelerated,
> no 3D, and a framebuffer.  VPro, framebuffer, but no X.  USB kinda weorks if
                                   ^^^^^^^^^^^^^^^^^^^^^
What's the reason for not having X? X doesn't support the frame buffer layout?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
