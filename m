Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2007 16:06:54 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:62939 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038462AbXBNQGw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Feb 2007 16:06:52 +0000
Received: from localhost (p1218-ipad205funabasi.chiba.ocn.ne.jp [222.146.96.218])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 66626BAEC; Thu, 15 Feb 2007 01:05:31 +0900 (JST)
Date:	Thu, 15 Feb 2007 01:05:31 +0900 (JST)
Message-Id: <20070215.010531.79072528.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80702140034g5f3243c9j333f97ae6fc6986@mail.gmail.com>
References: <20070209.130316.14978798.nemoto@toshiba-tops.co.jp>
	<20070214.170420.85684996.nemoto@toshiba-tops.co.jp>
	<cda58cb80702140034g5f3243c9j333f97ae6fc6986@mail.gmail.com>
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
X-archive-position: 14091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 14 Feb 2007 09:34:53 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > +/* Check and clear pending FPU exceptions in saved CSR */
> > +extern int fpcsr_pending(unsigned int __user *fpcsr);
> > +
> 
> Just my 2 cents: This looks like the wrong place for this fpu
> prototype. I mean shouldn't it belong to a fpu header file or
> something else ?

Well, this is a helper function for signal so signal-common.h is not
so bad, I think.  And adding to kernel/signal-common.h looks less
intrusive than adding to include/asm-mips/fpu.h, in my impression.

---
Atsushi Nemoto
