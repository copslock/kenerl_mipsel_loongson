Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 17:59:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:5062 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20026748AbXJPQ7a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2007 17:59:30 +0100
Received: from localhost (p2111-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.111])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id AA6489AE1; Wed, 17 Oct 2007 01:59:25 +0900 (JST)
Date:	Wed, 17 Oct 2007 02:01:13 +0900 (JST)
Message-Id: <20071017.020113.63743059.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: plat_timer_setup, mips_timer_ack, etc.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071016163610.GA25794@linux-mips.org>
References: <20071017.005211.108739735.anemo@mba.ocn.ne.jp>
	<20071016163610.GA25794@linux-mips.org>
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
X-archive-position: 17072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 16 Oct 2007 17:36:10 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Also I found mips_timer_ack and cycles_per_jiffy are not used now.
> > Can we remove them entirely?
> 
> I think so.  Each clockevent device should rather try to be independent
> of others.  What made the old timer code such a mess is that it was
> desparately trying to share resources giving everybody plenty of rope ...

So all mips_timer_ack users should implement its own clockevent
device, right?

$ git-grep mips_timer_ack arch/mips
arch/mips/dec/time.c:   mips_timer_ack = dec_timer_ack;
arch/mips/jmr3927/rbhma3100/setup.c:    mips_timer_ack = jmr3927_timer_ack;
arch/mips/philips/pnx8550/common/time.c:        mips_timer_ack = timer_ack;
arch/mips/sni/time.c:        mips_timer_ack = sni_a20r_timer_ack;

---
Atsushi Nemoto
