Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 16:01:31 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:6865 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133655AbWHAPBU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Aug 2006 16:01:20 +0100
Received: from localhost (p2112-ipad209funabasi.chiba.ocn.ne.jp [58.88.113.112])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8D046A616; Wed,  2 Aug 2006 00:01:16 +0900 (JST)
Date:	Wed, 02 Aug 2006 00:02:49 +0900 (JST)
Message-Id: <20060802.000249.41630533.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] Make get_frame_info() more readable.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11544244383201-git-send-email-vagabon.xyz@gmail.com>
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
	<11544244383201-git-send-email-vagabon.xyz@gmail.com>
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
X-archive-position: 12148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue,  1 Aug 2006 11:27:11 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> +static inline int is_ra_save_ins(union mips_instruction *pc)
> +{
> +	/* sw / sd $ra, offset($sp) */
> +	return (pc->i_format.opcode == sw_op || pc->i_format.opcode == sd_op) &&
> +		pc->i_format.rs == 29 &&
> +		pc->i_format.rt == 31;
> +}

Separating these function would be good, but let's play with 80
columns rule.

---
Atsushi Nemoto
