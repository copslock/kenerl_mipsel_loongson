Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 15:03:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:44778 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28583914AbYHTODA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Aug 2008 15:03:00 +0100
Received: from localhost (p7193-ipad203funabasi.chiba.ocn.ne.jp [222.146.86.193])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C4F32C6C0; Wed, 20 Aug 2008 23:02:54 +0900 (JST)
Date:	Wed, 20 Aug 2008 23:02:50 +0900 (JST)
Message-Id: <20080820.230250.90118025.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] vmlinux.lds.S: handle .text.* 
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080805.234514.39153536.anemo@mba.ocn.ne.jp>
References: <20080805.234514.39153536.anemo@mba.ocn.ne.jp>
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
X-archive-position: 20283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 05 Aug 2008 23:45:14 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> The -ffunction-sections puts each text in .text.function_name section.
> Without this patch, most functions are placed outside _text..._etext
> area and it breaks show_stacktrace(), etc.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Ping?

This patch should be required to get better oops message on 2.6.27.

---
Atsushi Nemoto
