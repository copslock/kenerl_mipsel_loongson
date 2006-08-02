Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2006 12:25:58 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:4641 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133447AbWHBLZq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Aug 2006 12:25:46 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 2 Aug 2006 20:25:43 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 39A56203CA;
	Wed,  2 Aug 2006 20:25:41 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2DBE81FF0A;
	Wed,  2 Aug 2006 20:25:41 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k72BPeW0020897;
	Wed, 2 Aug 2006 20:25:40 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 02 Aug 2006 20:25:40 +0900 (JST)
Message-Id: <20060802.202540.10544424.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 7/7] Allow unwind_stack() to return ra for leaf function
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44D07C97.2040008@innova-card.com>
References: <cda58cb80608011238q5b0e0eacje28f921d6e1c7700@mail.gmail.com>
	<20060802.105126.88700874.nemoto@toshiba-tops.co.jp>
	<44D07C97.2040008@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 02 Aug 2006 12:21:11 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> does something like this on top of this patch make you feel better ?
> 
> -- >8 --
> 
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 4ceddfa..8a9db45 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -480,7 +480,13 @@ unsigned long unwind_stack(struct task_s
>  		return 0;
>  
>  	if (leaf)
> -		pc = regs->regs[31];
> +		/*
> +		 * For some extreme cases, get_frame_info() can
> +		 * consider wrongly a nested function as a leaf
> +		 * one. In that cases avoid to return always the
> +		 * same value.
> +		 */
> +		pc = pc != regs->regs[31] ? regs->regs[31] : 0;

Yes, it should be safe.  But still I'm not sure unwind_stack() should
take "regs" as its argument...

---
Atsushi Nemoto
