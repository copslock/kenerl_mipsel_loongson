Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 17:40:32 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:14789 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021844AbXDRQk3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2007 17:40:29 +0100
Received: from localhost (p8009-ipad27funabasi.chiba.ocn.ne.jp [220.107.199.9])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C76C3B65E; Thu, 19 Apr 2007 01:40:24 +0900 (JST)
Date:	Thu, 19 Apr 2007 01:40:24 +0900 (JST)
Message-Id: <20070419.014024.07456941.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Retry {save,restore}_fp_context if failed in atomic
 context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070418.231315.41198460.anemo@mba.ocn.ne.jp>
References: <20070416.233235.75185596.anemo@mba.ocn.ne.jp>
	<20070418113046.GC3938@linux-mips.org>
	<20070418.231315.41198460.anemo@mba.ocn.ne.jp>
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
X-archive-position: 14890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 18 Apr 2007 23:13:15 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I agree this patch is not critical for older kernel.  But
> 2.6.16-stable already applied the broken "Allow CpU exception in
> kernel partially" patch.  This should be reverted.  Just revert the
> commit a0d2a152ec0917b0c1b0c84a00fd95d17090a5f8 should be enough.

I confirmed the reverse-patch can be cleanly applied on 2.6.16-stable
head.

---
Atsushi Nemoto
