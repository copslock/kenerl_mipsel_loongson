Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Aug 2006 17:04:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:18121 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133655AbWHAQDw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Aug 2006 17:03:52 +0100
Received: from localhost (p2112-ipad209funabasi.chiba.ocn.ne.jp [58.88.113.112])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 36AF8A6F2; Wed,  2 Aug 2006 01:03:49 +0900 (JST)
Date:	Wed, 02 Aug 2006 01:05:22 +0900 (JST)
Message-Id: <20060802.010522.11596989.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] Fix dump_stack()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44CF7506.70106@innova-card.com>
References: <1154424439852-git-send-email-vagabon.xyz@gmail.com>
	<20060802.000837.37531064.anemo@mba.ocn.ne.jp>
	<44CF7506.70106@innova-card.com>
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
X-archive-position: 12152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 01 Aug 2006 17:36:38 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > Eliminating the #ifdef itself looks good, but if you cleared contents
> > of the "regs" before prepare_frametrace, you will get less false
> > entries in the output.
> 
> well I don't see why...show_trace() is going to only use regs[29] which
> is setup by prepare_frametrace()...

If CONFIG_KALLSYMS was not set, show_trace() print all possible
entries starting from the sp.  The sp value stored in "regs" by
prepare_frametrace() will be little smaller one than the address of
the "regs" itself.  So if some values like function addresses were in
the "regs", show_trace() will report them.

> One other thing, why did you mark prepare_frametrace() as noinline ?
> I would mark it as always_inline to get one less false entry in the
> output.

Well, I tried some prepare_frametrace() implementations before the
final one.  I wanted to make sure that prepare_frametrace() does
really what desired, and noinline make it a bit easy.

But now I think current prepare_frametrace() is quite safe for
inlining.  So always_inline would be OK.

---
Atsushi Nemoto
