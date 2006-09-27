Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 16:33:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:16891 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039005AbWI0Pdh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2006 16:33:37 +0100
Received: from localhost (p2166-ipad26funabasi.chiba.ocn.ne.jp [220.104.88.166])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 45C41B79A; Thu, 28 Sep 2006 00:33:33 +0900 (JST)
Date:	Thu, 28 Sep 2006 00:35:42 +0900 (JST)
Message-Id: <20060928.003542.21929658.anemo@mba.ocn.ne.jp>
To:	girishvg@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] cleanup hardcoding __pa/__va macros etc. (take-2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <C13FD364.7334%girishvg@gmail.com>
References: <20060927.013553.48803581.anemo@mba.ocn.ne.jp>
	<C13FD364.7334%girishvg@gmail.com>
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
X-archive-position: 12694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 27 Sep 2006 07:06:10 +0900, girish <girishvg@gmail.com> wrote:
> After removing some of the redundant casts, re-submitting the patch.
> Attached the patch in a text file.

Using just plain text and adding Signed-off-by line would be preferred.
Also your patch seems against neither latest lmo nor kernel.org tree...

> In the meantime, I couldn't find the changes suggested for SPARSEMEM support
> in the main source tree. Especially the ones reviewed during month of August
> ([PATCH] do not count pages in holes with sparsemem ...). Could you please
> resend the consolidated patch to the list? Thanks.

August?  I sent the patch with that title in July and applied already.

http://www.linux-mips.org/git?p=linux.git;a=commit;h=239367b4

---
Atsushi Nemoto
