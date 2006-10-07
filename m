Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Oct 2006 14:53:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:25566 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039147AbWJGNxB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Oct 2006 14:53:01 +0100
Received: from localhost (p8091-ipad29funabasi.chiba.ocn.ne.jp [221.184.75.91])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 48476A737; Sat,  7 Oct 2006 22:52:53 +0900 (JST)
Date:	Sat, 07 Oct 2006 22:55:07 +0900 (JST)
Message-Id: <20061007.225507.41198174.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	sshtylyov@ru.mvista.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] add "depends on BROKEN" to broken boards support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061007064805.5b656556.yoichi_yuasa@tripeaks.co.jp>
References: <20061007005452.45b50d8c.yoichi_yuasa@tripeaks.co.jp>
	<4526A0F3.5090202@ru.mvista.com>
	<20061007064805.5b656556.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 12827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 7 Oct 2006 06:48:05 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> >     There's a patch from Atsushi Nemoto still pending commit, IIRC...
> 
> Is it fixed these errors.
> 
>   LD      .tmp_vmlinux1
> arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `toshiba_rbtx4938_irq_nested':
> : undefined reference to `wbflush'
> arch/mips/tx4938/toshiba_rbtx4938/built-in.o: In function `toshiba_rbtx4938_irq_nested':
> : relocation truncated to fit: R_MIPS_26 against `wbflush'

Yes.  The patch is here.

http://www.linux-mips.org/archives/linux-mips/2006-08/msg00204.html

---
Atsushi Nemoto
