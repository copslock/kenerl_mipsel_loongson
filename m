Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Oct 2007 08:06:03 +0100 (BST)
Received: from astra.telenet-ops.be ([195.130.132.58]:50585 "EHLO
	astra.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20022481AbXJCHFy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Oct 2007 08:05:54 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by astra.telenet-ops.be (Postfix) with SMTP id F1F90380E4;
	Wed,  3 Oct 2007 09:05:43 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by astra.telenet-ops.be (Postfix) with ESMTP id D0754380D0;
	Wed,  3 Oct 2007 09:05:43 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.14.1/8.14.1/Debian-9) with ESMTP id l9375h1g019997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Oct 2007 09:05:43 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.1/8.14.1/Submit) with ESMTP id l9375heA019994;
	Wed, 3 Oct 2007 09:05:43 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 3 Oct 2007 09:05:43 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
In-Reply-To: <20071003010053.GA25603@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0710030905030.14583@anakin>
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl>
 <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org>
 <Pine.LNX.4.64N.0710021651490.32726@blysk.ds.pg.gda.pl>
 <20071003010053.GA25603@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 3 Oct 2007, Ralf Baechle wrote:
> Anyway, queued for 2.6.24.  That is if 2.6.23 is ever released ;-)

Any scripts relying on -rcX being single-digit? ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
