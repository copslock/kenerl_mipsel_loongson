Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 18:57:52 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:30699 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039268AbWI2R5u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2006 18:57:50 +0100
Received: from localhost (p6165-ipad210funabasi.chiba.ocn.ne.jp [58.88.125.165])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5C962A61B; Sat, 30 Sep 2006 02:57:46 +0900 (JST)
Date:	Sat, 30 Sep 2006 02:59:56 +0900 (JST)
Message-Id: <20060930.025956.108739154.anemo@mba.ocn.ne.jp>
To:	girishvg@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: PATCH] cleanup hardcoding __pa/__va macros etc. (take-5)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <B3C723F6-A2B3-4A0E-88BB-FF36AB58FFB4@gmail.com>
References: <C140DCAC.7A1C%girishvg@gmail.com>
	<20060928232956.GE3394@linux-mips.org>
	<B3C723F6-A2B3-4A0E-88BB-FF36AB58FFB4@gmail.com>
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
X-archive-position: 12744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 29 Sep 2006 23:45:12 +0900, girish <girishvg@gmail.com> wrote:
> >> Please find attached patch created from 2.6.18 (kernel.org) tree.  
> >> Let me
> >> know if this is alright.
> >>
> >> Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>
> >
> > -#ifdef CONFIG_ISA
> > -	if (low < max_dma)
> > +	if (low < max_dma) }
> >
> > This doesn't quite compile.
> >
> 
> Stupid mistake. Fixed & resending.

Looks good to me, except for page.h part.

---
Atsushi Nemoto
