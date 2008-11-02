Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2008 16:02:41 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:36339 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22984251AbYKBQCj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2008 16:02:39 +0000
Received: from localhost (p1247-ipad213funabasi.chiba.ocn.ne.jp [124.85.66.247])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3A7CDB30D; Mon,  3 Nov 2008 01:02:33 +0900 (JST)
Date:	Mon, 03 Nov 2008 01:02:38 +0900 (JST)
Message-Id: <20081103.010238.01917326.anemo@mba.ocn.ne.jp>
To:	ddaney@caviumnetworks.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Return ENOSYS from sys32_syscall on 64bit
 kernels just like everywhere else.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <490B4D0D.9060305@caviumnetworks.com>
References: <490B4D0D.9060305@caviumnetworks.com>
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
X-archive-position: 21166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 31 Oct 2008 11:23:09 -0700, David Daney <ddaney@caviumnetworks.com> wrote:
> When the o32 errno was changed to ENOSYS, we forgot to update the code
> for 64bit kernels.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  arch/mips/kernel/scall64-o32.S |    2 +-

Yes, thanks.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
