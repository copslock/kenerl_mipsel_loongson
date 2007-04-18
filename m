Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 15:13:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:12234 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021843AbXDRONU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2007 15:13:20 +0100
Received: from localhost (p8009-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.9])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0F12CA82D; Wed, 18 Apr 2007 23:13:16 +0900 (JST)
Date:	Wed, 18 Apr 2007 23:13:15 +0900 (JST)
Message-Id: <20070418.231315.41198460.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Retry {save,restore}_fp_context if failed in atomic
 context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070418113046.GC3938@linux-mips.org>
References: <20070416.231944.41198415.anemo@mba.ocn.ne.jp>
	<20070416.233235.75185596.anemo@mba.ocn.ne.jp>
	<20070418113046.GC3938@linux-mips.org>
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
X-archive-position: 14882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 18 Apr 2007 12:30:46 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > And this is for 2.6.20-stable.
> 
> Both applied, also to older -stable branches except 2.6.16.  In case of
> 2.6.16 it would have been more time consuming than justifyable and since
> the bug this patch fixes is comparable to what we had before starting the
> whole surgery I have no problem to leave 2.6.16 as it is.  Anybody still
> using 2.6.16 should upgrade anyway ...

I agree this patch is not critical for older kernel.  But
2.6.16-stable already applied the broken "Allow CpU exception in
kernel partially" patch.  This should be reverted.  Just revert the
commit a0d2a152ec0917b0c1b0c84a00fd95d17090a5f8 should be enough.

---
Atsushi Nemoto
