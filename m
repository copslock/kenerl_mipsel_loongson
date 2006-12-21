Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 16:30:42 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:24266 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28644138AbWLUQah (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2006 16:30:37 +0000
Received: from localhost (p2195-ipad203funabasi.chiba.ocn.ne.jp [222.146.81.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 08D0CC3C1; Fri, 22 Dec 2006 01:30:33 +0900 (JST)
Date:	Fri, 22 Dec 2006 01:30:31 +0900 (JST)
Message-Id: <20061222.013031.89066226.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Fix build_store_reg()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061222.010316.63742169.anemo@mba.ocn.ne.jp>
References: <20061218.003821.96686517.anemo@mba.ocn.ne.jp>
	<20061222.010316.63742169.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 22 Dec 2006 01:03:16 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> BTW, why prefetch is preferred than cache_cdex?  I feel cdex is better
> while it avoids unnecessary load...

Oh, I missed that Pref_StoreStreamed or Pref_PrepareForStore is used
for destination.  Perhaps they would be better than cdex (though not
sure...).

---
Atsushi Nemoto
