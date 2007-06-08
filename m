Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jun 2007 15:23:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:42966 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022057AbXFHOXc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Jun 2007 15:23:32 +0100
Received: from localhost (p7198-ipad25funabasi.chiba.ocn.ne.jp [220.104.85.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 071A0B6E4; Fri,  8 Jun 2007 23:22:12 +0900 (JST)
Date:	Fri, 08 Jun 2007 23:22:43 +0900 (JST)
Message-Id: <20070608.232243.108308444.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	vagabon.xyz@gmail.com, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time
 crapectomy
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070607154801.GG26047@linux-mips.org>
References: <46680B75.5040809@ru.mvista.com>
	<cda58cb80706070744v21e1bbf3sa28990b4477a8844@mail.gmail.com>
	<20070607154801.GG26047@linux-mips.org>
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
X-archive-position: 15359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 7 Jun 2007 16:48:01 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> But even if so, the basic solution is the same - just ignore the interrupt
> whenever it happens to be triggered.  Or if it isn't shared with an
> active performance counter interrupt, you could even disable_irq() it.

Using disable_irq() on the counter/compare interrupt might make the
WAIT instruction really not wait on some chips.  It is implementation
dependent wheather an assertion of masked interrupt break the WAIT
instruction or not.  Busy looping in cpu_idle() would not preferred,
but I'm not sure this is really a problem yet.  Maybe I should have
closer look at dyntick.

---
Atsushi Nemoto
