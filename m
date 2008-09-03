Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2008 16:53:01 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:14277 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28790943AbYICPw7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2008 16:52:59 +0100
Received: from localhost (p2165-ipad202funabasi.chiba.ocn.ne.jp [222.146.73.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8F948B627; Thu,  4 Sep 2008 00:52:50 +0900 (JST)
Date:	Thu, 04 Sep 2008 00:52:49 +0900 (JST)
Message-Id: <20080904.005249.95062207.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/6] TXx9: Microoptimize interrupt handlers
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48BE6346.4070207@ru.mvista.com>
References: <1220275361-5001-2-git-send-email-anemo@mba.ocn.ne.jp>
	<48BE6346.4070207@ru.mvista.com>
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
X-archive-position: 20410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 03 Sep 2008 14:13:26 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > The IOC interrupt status register on RBTX49XX only have 8 bits.  Use
> > 8-bit version of __fls() to optimize interrupt handlers.
> >   
> 
>    But doesn't the patch also change the result of 
> toshiba_rbtx49{27|38}_irq_nested() if the register reads back as 0?

Yes, now _irq_nested() returns -1 if no interrupts, and it will be
counted as spurious interrupts.  I think this is a little bonus ;)

---
Atsushi Nemoto
