Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 16:07:19 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:30965 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133650AbWHAPHI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Aug 2006 16:07:08 +0100
Received: from localhost (p2112-ipad209funabasi.chiba.ocn.ne.jp [58.88.113.112])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9FA2299A9; Wed,  2 Aug 2006 00:07:04 +0900 (JST)
Date:	Wed, 02 Aug 2006 00:08:37 +0900 (JST)
Message-Id: <20060802.000837.37531064.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] Fix dump_stack()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1154424439852-git-send-email-vagabon.xyz@gmail.com>
References: <11544244373398-git-send-email-vagabon.xyz@gmail.com>
	<1154424439852-git-send-email-vagabon.xyz@gmail.com>
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
X-archive-position: 12149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue,  1 Aug 2006 11:27:16 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> When CONFIG_KALLSYMS is not set stack local is not initialized. Therefore
> show_trace() won't display anything useful. This patch uses
> prepare_frametrace() to setup the stack pointer before calling
> show_trace().

It's not a bug.  The original show_trace() needs an address on stack
and dump_stack() surely give it by taking an address of local
variable.

Eliminating the #ifdef itself looks good, but if you cleared contents
of the "regs" before prepare_frametrace, you will get less false
entries in the output.

---
Atsushi Nemoto
