Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2006 14:54:21 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:56537 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28643627AbWLUOyQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Dec 2006 14:54:16 +0000
Received: from localhost (p2195-ipad203funabasi.chiba.ocn.ne.jp [222.146.81.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 31A37BE9E; Thu, 21 Dec 2006 23:54:10 +0900 (JST)
Date:	Thu, 21 Dec 2006 23:54:09 +0900 (JST)
Message-Id: <20061221.235409.93018387.anemo@mba.ocn.ne.jp>
To:	vitalywool@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	danieljlaird@hotmail.com
Subject: Re: [PATCH] pnx8550: fix system timer support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061221173439.fc76c832.vitalywool@gmail.com>
References: <20061221173439.fc76c832.vitalywool@gmail.com>
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
X-archive-position: 13505
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 21 Dec 2006 17:34:39 +0300, Vitaly Wool <vitalywool@gmail.com> wrote:
> the patch inlined below restores proper time accounting for
> PNX8550-based boards. It also gets rid of #ifdef in the generic code
> which becomes unnecessary then.
...
> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

This patch obsoletes my patch posted 2 days ago.  Daniel, please
ignore mine and try this.

> --- a/arch/mips/philips/pnx8550/common/time.c
> +++ b/arch/mips/philips/pnx8550/common/time.c
> @@ -29,12 +29,27 @@
>  #include <asm/hardirq.h>
>  #include <asm/div64.h>
>  #include <asm/debug.h>
> +#include <asm/time.h>
>  
>  #include <int.h>
>  #include <cm.h>
>  
>  extern unsigned int mips_hpt_frequency;

Minor comment.  The asm/time.h is already included, isn't it?  And
mips_hpt_frequency is declared in asm/time.h so the "external" line
can be removed.

---
Atsushi Nemoto
