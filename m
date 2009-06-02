Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2009 15:13:25 +0100 (WEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:61722 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20022066AbZFBONS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Jun 2009 15:13:18 +0100
Received: from localhost (p7143-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.143])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id F31F5AA7C; Tue,  2 Jun 2009 23:13:11 +0900 (JST)
Date:	Tue, 02 Jun 2009 23:13:11 +0900 (JST)
Message-Id: <20090602.231311.106274589.anemo@mba.ocn.ne.jp>
To:	mpm@selenic.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [PATCH] TXx9: Add TX4939 RNG support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1243791170.22069.28.camel@calx>
References: <1243789289.22069.25.camel@calx>
	<20090601.022335.200392387.anemo@mba.ocn.ne.jp>
	<1243791170.22069.28.camel@calx>
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
X-archive-position: 23176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 31 May 2009 12:32:50 -0500, Matt Mackall <mpm@selenic.com> wrote:
> > No, the rng driver can be used regardless of module or built-in, as
> > like as other platform drivers.  Any special issue for hw_rng?
> 
> I found the source of my confusion: you've given the init function in
> both files exactly the same name. So when I saw .._init at the bottom of
> the second patch, I assumed it was referring to the possibly not loaded
> driver's init code.

OK, I see.  I will rename one of them to avoid such a confusion.
Thanks.

---
Atsushi Nemoto
