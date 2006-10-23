Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 16:36:30 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:41162 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039492AbWJWPgZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2006 16:36:25 +0100
Received: from localhost (p7236-ipad31funabasi.chiba.ocn.ne.jp [221.189.131.236])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3A3F8B72C; Tue, 24 Oct 2006 00:36:21 +0900 (JST)
Date:	Tue, 24 Oct 2006 00:38:45 +0900 (JST)
Message-Id: <20061024.003845.71086839.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <453CD3ED.8020005@ru.mvista.com>
References: <20061023.033407.104640794.anemo@mba.ocn.ne.jp>
	<453CD3ED.8020005@ru.mvista.com>
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
X-archive-position: 13068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 23 Oct 2006 18:38:37 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > * mips_hpt_mask variable to specify bitmask of hpt value.
> 
>     There's actually no need to introduce more variables. Just make
> clocksource declaration public and override default mask if
> necessary.
>     Also, I don't see much sense in further existence of
> mips_hpt_read() -- it only causes each clocksource read go thru a
> double indirection which is really ugly. The same approach shouyld
> be used here.

I agree with you that it would be a way to go.  For now exporting
clocksource_mips just to override the mask and keep using
mips_hpt_read looks somewhat inconsistent, so I just added
mips_hpt_mask variable.

Replacing mips_hpt_read involves changes for _all_ platform code so I
think it would be better to do it on next -rc1 stage.

---
Atsushi Nemoto
