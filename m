Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 11:09:45 +0100 (BST)
Received: from edna.telenet-ops.be ([195.130.132.58]:9148 "EHLO
	edna.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S20167089AbYIKKDn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Sep 2008 11:03:43 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by edna.telenet-ops.be (Postfix) with SMTP id 97EA3E402F;
	Thu, 11 Sep 2008 12:03:42 +0200 (CEST)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by edna.telenet-ops.be (Postfix) with ESMTP id 0F747E4010;
	Thu, 11 Sep 2008 12:03:41 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id m8BA3fE5002578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Sep 2008 12:03:41 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m8BA3avX002574;
	Thu, 11 Sep 2008 12:03:38 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Thu, 11 Sep 2008 12:03:36 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Jeremy Fitzhardinge <jeremy@goop.org>
cc:	Ingo Molnar <mingo@elte.hu>, Alex Nixon <alex.nixon@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Globally defining phys_addr_t
In-Reply-To: <48C8D76B.10901@goop.org>
Message-ID: <Pine.LNX.4.64.0809111202560.1545@anakin>
References: <48C8D76B.10901@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 11 Sep 2008, Jeremy Fitzhardinge wrote:
> This is a repost of a little 3-patch series which Andrew has been
> carrying in -mm.  It cleans up the definition of phys_addr_t to make it
> kernel-wide rather than x86-specific, and fixes up PFN_PHYS() to use it
> to avoid address truncation.
> 
> We currently have a few workarounds for this problem in the tree, but
> Alex found another bug caused by PFN_PHYS(), so it's probably better if
> you bring these patches into tip.git for now.
> 
> PowerPC also defines a phys_addr_t with the same meaning as x86; the
> powerpc arch maintainers are happy with these patches.

If I'm not mistaking, this is also true for some MIPS machines.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
