Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Aug 2008 14:27:44 +0100 (BST)
Received: from wilson.telenet-ops.be ([195.130.132.42]:64220 "EHLO
	wilson.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20030619AbYHZN1m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Aug 2008 14:27:42 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by wilson.telenet-ops.be (Postfix) with SMTP id D36663408D;
	Tue, 26 Aug 2008 15:27:41 +0200 (CEST)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by wilson.telenet-ops.be (Postfix) with ESMTP id 617973406F;
	Tue, 26 Aug 2008 15:27:32 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id m7QDRWw8002884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Aug 2008 15:27:32 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m7QDRVT9002881;
	Tue, 26 Aug 2008 15:27:32 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Tue, 26 Aug 2008 15:27:31 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Probe initrd header only if explicitly specified
In-Reply-To: <20080826.221145.74565971.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64.0808261527070.30735@anakin>
References: <20080826.221145.74565971.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 26 Aug 2008, Atsushi Nemoto wrote:
> +		 * prepended to initrd and is made up by 8 bytes. The fisrt
                                                                      ^^^^^
								      first
(I know this typo existed before)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
