Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jul 2007 15:39:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:14323 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022238AbXGAOjo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Jul 2007 15:39:44 +0100
Received: from localhost (p2185-ipad205funabasi.chiba.ocn.ne.jp [222.146.97.185])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 89525B722; Sun,  1 Jul 2007 23:39:39 +0900 (JST)
Date:	Sun, 01 Jul 2007 23:40:27 +0900 (JST)
Message-Id: <20070701.234027.07645149.anemo@mba.ocn.ne.jp>
To:	david-b@pacbell.net
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH] TXx9 SPI controller driver (take 2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200706301046.20826.david-b@pacbell.net>
References: <200706300953.20156.david-b@pacbell.net>
	<20070701.023414.71085498.anemo@mba.ocn.ne.jp>
	<200706301046.20826.david-b@pacbell.net>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 30 Jun 2007 10:46:20 -0700, David Brownell <david-b@pacbell.net> wrote:
> > The compiler will optimize "1000000000 / 2 / spi->max_speed_hz" into
> > "500000000 / spi->max_speed_hz", so it can be treat as one "/", no?
> 
> Sure it's deterministic.  But that doesn't prevent me from
> needing a double-take to figure what it does ... it's best
> to avoid confusing idioms in code.  At the very least, put
> parentheses there ...

OK, I will use parentheses while I think 1000000000 is important part.
Well, maybe NSEC_PER_SEC would be better.
---
Atsushi Nemoto
