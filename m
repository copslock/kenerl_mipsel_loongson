Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 14:47:01 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:19438 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038825AbXBLOq7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2007 14:46:59 +0000
Received: from localhost (p7240-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 61282A9B5; Mon, 12 Feb 2007 23:45:38 +0900 (JST)
Date:	Mon, 12 Feb 2007 23:45:38 +0900 (JST)
Message-Id: <20070212.234538.25910340.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] clean up ret_from_{irq,exception}
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80702120044o6c434032pc2f3da68a7327097@mail.gmail.com>
References: <45C8A477.8070906@innova-card.com>
	<20070211.004020.79071872.anemo@mba.ocn.ne.jp>
	<cda58cb80702120044o6c434032pc2f3da68a7327097@mail.gmail.com>
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
X-archive-position: 14045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 12 Feb 2007 09:44:33 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> well maybe this one would be more readable:
> 
> -- >8 --
> 
> diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
> index f10b6a1..b5d27d5 100644
> --- a/arch/mips/kernel/entry.S
> +++ b/arch/mips/kernel/entry.S
> @@ -21,23 +21,20 @@
>  #endif
> 
>  #ifndef CONFIG_PREEMPT
> -	.macro	preempt_stop
> -	local_irq_disable
> -	.endm
>  #define resume_kernel	restore_all
> +#else
> +#define _ret_from_irq	ret_from_exception
>  #endif

_ret_from_irq is used by dec/int-handler.S directly, so you should not
remove it (though decstation_defconfig disables CONFIG_PREEMPT).

But looking at dec/int-handler.S again, I can not see why it uses
_ret_from_irq, and why it manipulates TI_REGS($28) in handle_it ...

It seems dec/int-handler.S has been broken for a while.  I'll send a
patch to fix it.  If it was ACKed, I ACK your patch.

---
Atsushi Nemoto
