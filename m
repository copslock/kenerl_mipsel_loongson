Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 18:01:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:41205 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20044964AbXJSRBf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Oct 2007 18:01:35 +0100
Received: from localhost (p3184-ipad306funabasi.chiba.ocn.ne.jp [123.217.173.184])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 88BFA9AAC; Sat, 20 Oct 2007 02:00:13 +0900 (JST)
Date:	Sat, 20 Oct 2007 02:02:03 +0900 (JST)
Message-Id: <20071020.020203.112258960.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Kill duplicated setup_irq() for cp0 timer
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071019163840.GA28057@linux-mips.org>
References: <20071020.012625.63132084.anemo@mba.ocn.ne.jp>
	<20071019163840.GA28057@linux-mips.org>
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
X-archive-position: 17135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 19 Oct 2007 17:38:40 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> There's light at the end of this time code rewrite tunnel.  And it's not
> the train :-)

Yes, I suppose generic parts are almost done.  (except for some
garbage, and updating Documentation/mips/time.README ...)

---
Atsushi Nemoto
