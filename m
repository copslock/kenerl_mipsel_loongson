Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jul 2006 13:47:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:12522 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133711AbWG1MrD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Jul 2006 13:47:03 +0100
Received: from localhost (p7008-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.8])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1B81BB455; Fri, 28 Jul 2006 21:46:59 +0900 (JST)
Date:	Fri, 28 Jul 2006 21:48:29 +0900 (JST)
Message-Id: <20060728.214829.07644540.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44C880A9.1070402@innova-card.com>
References: <44C77D49.90205@innova-card.com>
	<20060727.002153.41632148.anemo@mba.ocn.ne.jp>
	<44C880A9.1070402@innova-card.com>
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
X-archive-position: 12107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 27 Jul 2006 11:00:25 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> I'm suprised that sparsemem code doens't check for holes inside
> sections. I would feel really more confortable to use sparsemem if a
> check like the following patch exists. We could safely use pfn_valid()
> in _any_ cases and if holes exist inside sections then the user have
> to fix up its section sizes.
> 
> what do you think ?

I think holes inside a section is not illegal, just a bit ineffective.
So I feel your patch is too strict.

---
Atsushi Nemoto
