Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 15:37:10 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:46826 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024769AbXJVOhC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 22 Oct 2007 15:37:02 +0100
Received: from localhost (p4177-ipad307funabasi.chiba.ocn.ne.jp [123.217.182.177])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8019DA8BC; Mon, 22 Oct 2007 23:35:40 +0900 (JST)
Date:	Mon, 22 Oct 2007 23:37:33 +0900 (JST)
Message-Id: <20071022.233733.35469871.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de
Subject: Re: [PATCH] Make c0_compare_int_usable more bullet proof
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071022093139.GA5588@linux-mips.org>
References: <20071020.005445.75183929.anemo@mba.ocn.ne.jp>
	<20071022093139.GA5588@linux-mips.org>
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
X-archive-position: 17154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 22 Oct 2007 10:31:39 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Use write_c0_compare(read_c0_count()) to clear interrupt.
> > And use delta value based on its speed for faster probing.
> 
> Hmm...  This one makes c0_compare_int_usable() fails when I run a malta
> kernel on last week's qemu.

Well, with my qemu-system-mips (0.9.0 and cvs),
c0_compare_int_usable() always return 0 with/without my patch.

But if I made c0_compare_int_usable() always return 1, it works fine
with c0 counter interrupt.  Quite strange...

---
Atsushi Nemoto
