Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 17:05:23 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:47075 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038618AbXBHRFR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 17:05:17 +0000
Received: from localhost (p4240-ipad301funabasi.chiba.ocn.ne.jp [122.17.254.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3FDD8B3C0; Fri,  9 Feb 2007 02:03:56 +0900 (JST)
Date:	Fri, 09 Feb 2007 02:03:55 +0900 (JST)
Message-Id: <20070209.020355.45178614.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80702080830n44627bafw88b0b6620eefb693@mail.gmail.com>
References: <20070208.120219.96684712.nemoto@toshiba-tops.co.jp>
	<20070209.002323.115905985.anemo@mba.ocn.ne.jp>
	<cda58cb80702080830n44627bafw88b0b6620eefb693@mail.gmail.com>
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
X-archive-position: 13999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 8 Feb 2007 17:30:29 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> >         unsigned int used_math;
> > @@ -112,7 +144,8 @@ restore_sigcontext(struct pt_regs *regs,
> >         if (used_math()) {
> 
> sorry for the stupid question but I don't know fpu code...Here
> used_math() function is used as condition whereas used_math local is
> already defined. Are we sure we want to use the function here ?

Well, used_math() returns condition which are set by preceeding
conditional_used_math().  In this case the condition is used_math :)
Maybe we can use the used_math variable here to optimize a bit.

---
Atsushi Nemoto
