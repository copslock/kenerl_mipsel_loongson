Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2006 16:16:38 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:9446 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28574850AbWL1QQc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2006 16:16:32 +0000
Received: from localhost (p5142-ipad201funabasi.chiba.ocn.ne.jp [222.146.68.142])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3CB25AE30; Fri, 29 Dec 2006 01:16:27 +0900 (JST)
Date:	Fri, 29 Dec 2006 01:16:21 +0900 (JST)
Message-Id: <20061229.011621.05599370.anemo@mba.ocn.ne.jp>
To:	vitalywool@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] pnx8550: fix system timer support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061228171405.b1e3eed8.vitalywool@gmail.com>
References: <20061228171405.b1e3eed8.vitalywool@gmail.com>
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
X-archive-position: 13522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 28 Dec 2006 17:14:05 +0300, Vitaly Wool <vitalywool@gmail.com> wrote:
> --- linux-mips.git.orig/arch/mips/philips/pnx8550/common/time.c
> +++ linux-mips.git/arch/mips/philips/pnx8550/common/time.c
> @@ -29,11 +29,22 @@
>  #include <asm/hardirq.h>
>  #include <asm/div64.h>
>  #include <asm/debug.h>
> +#include <asm/time.h>

As I said before, asm/time.h is already included just before there.
Why double inclusion?

---
Atsushi Nemoto
