Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2006 15:53:28 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:28649 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28641729AbWLZPxX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2006 15:53:23 +0000
Received: from localhost (p3075-ipad23funabasi.chiba.ocn.ne.jp [220.104.81.75])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3AE5AC8E6; Wed, 27 Dec 2006 00:53:17 +0900 (JST)
Date:	Wed, 27 Dec 2006 00:53:16 +0900 (JST)
Message-Id: <20061227.005316.108307143.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Fix csum_partial_copy_from_user
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061219.011735.35857841.anemo@mba.ocn.ne.jp>
References: <20061219.011735.35857841.anemo@mba.ocn.ne.jp>
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
X-archive-position: 13515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 19 Dec 2006 01:17:35 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I found that asm version of csum_partial_copy_from_user() introduced
> in e9e016815f264227b6260f77ca84f1c43cf8b9bd was less effective.
> 
> For csum_partial_copy_from_user() case, "both_aligned" 8-word copy/sum
> loop block is skipped to handle LOAD failure properly.  So we should
> iterate 4-word copy/sum block for that case, otherwize we will loop at
> ineffective "less_than_4units" block.

Please ignore this patch.  I will send more efficient fix soon.

---
Atsushi Nemoto
