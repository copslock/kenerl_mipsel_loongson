Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 16:46:40 +0000 (GMT)
Received: from europa.telenet-ops.be ([195.130.137.75]:56535 "EHLO
	europa.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20031830AbXKOQqc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Nov 2007 16:46:32 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by europa.telenet-ops.be (Postfix) with SMTP id 9C13441FA;
	Thu, 15 Nov 2007 17:46:21 +0100 (CET)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by europa.telenet-ops.be (Postfix) with ESMTP id 71B16418B;
	Thu, 15 Nov 2007 17:46:21 +0100 (CET)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id lAFGkLuw003701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Nov 2007 17:46:21 +0100
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id lAFGkIrY003698;
	Thu, 15 Nov 2007 17:46:19 +0100
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Thu, 15 Nov 2007 17:46:18 +0100 (CET)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Introduce __fill_user() and kill __bzero() [take #2]
In-Reply-To: <473C720B.7000100@gmail.com>
Message-ID: <Pine.LNX.4.64.0711151744580.31039@anakin>
References: <473C720B.7000100@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 15 Nov 2007, Franck Bui-Huu wrote:
>  I put the out of line version of memset in kernel/mips_ksym.c. I
>  haven't found a better place. But if you really think we should
>  create a lib/memset.c and rename lib/memset.S into lib/fill_user.S, I
>  can change it.

kernel/mips_ksym.c is not a good place. Adrian `trivial' Bunk is
scanning arch/ for *_ksym.c files and moving the EXPORT_SYMBOL()s to the
source files they belong to.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
