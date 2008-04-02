Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 14:38:56 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:41196 "EHLO smtp.mba.ocn.ne.jp")
	by lappi.linux-mips.net with ESMTP id S525078AbYDBMiw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2008 14:38:52 +0200
Received: from localhost (p8208-ipad209funabasi.chiba.ocn.ne.jp [58.88.119.208])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5E7419FD3; Wed,  2 Apr 2008 21:37:31 +0900 (JST)
Date:	Wed, 02 Apr 2008 21:38:17 +0900 (JST)
Message-Id: <20080402.213817.74752727.anemo@mba.ocn.ne.jp>
To:	dmitri.vorobiev@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] [MIPS] unexport null_perf_irq() and make it static
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1207094318-21748-6-git-send-email-dmitri.vorobiev@gmail.com>
References: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
	<1207094318-21748-6-git-send-email-dmitri.vorobiev@gmail.com>
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
X-archive-position: 18768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed,  2 Apr 2008 03:58:38 +0400, Dmitri Vorobiev <dmitri.vorobiev@gmail.com> wrote:
> --- a/arch/mips/oprofile/op_model_mipsxx.c
> +++ b/arch/mips/oprofile/op_model_mipsxx.c
> @@ -31,6 +31,8 @@
>  
>  #define M_COUNTER_OVERFLOW		(1UL      << 31)
>  
> +int (*save_perf_irq)(void);

This should be another target of "make it static" patch :-)

---
Atsushi Nemoto
