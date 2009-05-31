Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 18:23:47 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:52650 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023994AbZEaRXj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 31 May 2009 18:23:39 +0100
Received: from localhost (p4068-ipad206funabasi.chiba.ocn.ne.jp [222.145.78.68])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7EFBE9DB9; Mon,  1 Jun 2009 02:23:35 +0900 (JST)
Date:	Mon, 01 Jun 2009 02:23:35 +0900 (JST)
Message-Id: <20090601.022335.200392387.anemo@mba.ocn.ne.jp>
To:	mpm@selenic.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] TXx9: Add TX4939 RNG support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1243789289.22069.25.camel@calx>
References: <1243350141-883-2-git-send-email-anemo@mba.ocn.ne.jp>
	<20090601.015755.21367568.anemo@mba.ocn.ne.jp>
	<1243789289.22069.25.camel@calx>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 31 May 2009 12:01:29 -0500, Matt Mackall <mpm@selenic.com> wrote:
> > > Not clear to me how this works when this is a module?
> > 
> > This patch add a registration of a platform device for RNG to vmlinux.
> > And the other patch add a driver module for the RNG.  This strategy is
> > fairly common for SoCs or embedded platforms.
> 
> If your driver is built as a module (which your patch allows), the above
> won't work, right?

No, the rng driver can be used regardless of module or built-in, as
like as other platform drivers.  Any special issue for hw_rng?

---
Atsushi Nemoto
