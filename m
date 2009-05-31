Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 18:18:19 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:57093 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023908AbZEaRSN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 31 May 2009 18:18:13 +0100
Received: from localhost (p4068-ipad206funabasi.chiba.ocn.ne.jp [222.145.78.68])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6EDC49C08; Mon,  1 Jun 2009 02:18:08 +0900 (JST)
Date:	Mon, 01 Jun 2009 02:18:07 +0900 (JST)
Message-Id: <20090601.021807.250571902.anemo@mba.ocn.ne.jp>
To:	mpm@selenic.com
Cc:	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, linux-kernel@vger.kernel.org,
	herbert@gondor.apana.org.au
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1243789210.22069.23.camel@calx>
References: <20090529162907.9cb1bba2.akpm@linux-foundation.org>
	<20090601.014517.169682203.anemo@mba.ocn.ne.jp>
	<1243789210.22069.23.camel@calx>
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
X-archive-position: 23086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 31 May 2009 12:00:09 -0500, Matt Mackall <mpm@selenic.com> wrote:
> > >From the datasheet:
> > 
> > 	The quality of the random numbers generated immediately after
> > 	reset can be insufficient.  Therefore, do not use random
> > 	numbers obtained from the first and second generations; use
> > 	the ones from the third or subsequent generation.
> 
> Does the datasheet say anything about -how- the random numbers are
> produced? Most physical sources that I'm aware of don't have this sort
> of issue. But some pseudo-RNGs do. So this looks a little worrisome.

Nothing for "how".  If a RNG was actually a pseudo-RNG, does anything
a driver should do?  Any future plan to select one RNG from multiple
sources based on randomness grade?

---
Atsushi Nemoto
