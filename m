Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 09:17:13 +0200 (CEST)
Received: from edna.telenet-ops.be ([195.130.132.58]:60600 "EHLO
	edna.telenet-ops.be") by lappi.linux-mips.net with ESMTP
	id S1102566AbYDBHRG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Apr 2008 09:17:06 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by edna.telenet-ops.be (Postfix) with SMTP id 6AAFDE400A;
	Wed,  2 Apr 2008 09:16:55 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by edna.telenet-ops.be (Postfix) with ESMTP id 3A2BDE405B;
	Wed,  2 Apr 2008 09:16:55 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.2/8.14.2/Debian-3) with ESMTP id m327GsXj011687
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Apr 2008 09:16:54 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.2/8.14.2/Submit) with ESMTP id m327GrpJ011684;
	Wed, 2 Apr 2008 09:16:54 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Wed, 2 Apr 2008 09:16:52 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
cc:	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-arch@vger.kernel.org
Subject: Re: max_pfn: Uninitialized, or Deprecated?
In-Reply-To: <47F1F349.7010503@mips.com>
Message-ID: <Pine.LNX.4.64.0804020910290.14383@anakin>
References: <47F1F349.7010503@mips.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 1 Apr 2008, Kevin D. Kissell wrote:
> Once upon a time, the global max_pfn value was set up as part of
> bootmem_init(), but this seems to have been dropped in favor of
> establishing max_low_pfn, I suppose to be clear that it's the max
> non-highmem PFN.  However, the global max_pfn gets used in
> the MIPS APRP support code,  and also in places like
> block/blk-settings.c.  Is the use of max_pfn supposed to be
> deprecated, such that we consider blk-settings.c to be broken
> and change arch/mips/kernel/vpe.c to use max_low_pfn, or
> ought we assign  max_pfn = max_low_pfn in bootmem_init()?

I noticed this too when investigating why initrds no longer worked on
m68k (Fix in http://lkml.org/lkml/2007/12/23/36, still not in mainline).

Apparently a value of max_pfn = 0 is OK, as several architectures
(including MIPS and m68k) don't touch it?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
