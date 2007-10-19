Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 03:47:33 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:51243 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20044071AbXJSCrX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 03:47:23 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 19 Oct 2007 11:47:22 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 1A67A42A88;
	Fri, 19 Oct 2007 11:47:18 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 06BE042A26;
	Fri, 19 Oct 2007 11:47:18 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l9J2lHAF063848;
	Fri, 19 Oct 2007 11:47:17 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 19 Oct 2007 11:47:16 +0900 (JST)
Message-Id: <20071019.114716.08075245.nemoto@toshiba-tops.co.jp>
To:	wd@denx.de
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS Makefile not picking up CROSS_COMPILE from environment
 setting
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071018184636.48637242E9@gemini.denx.de>
References: <20071018184636.48637242E9@gemini.denx.de>
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
X-archive-position: 17124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 18 Oct 2007 20:46:36 +0200, Wolfgang Denk <wd@denx.de> wrote:
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 08355eb..caa04a0 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -43,7 +43,7 @@ UTS_MACHINE		:= mips64
>  endif
>  
>  ifdef CONFIG_CROSSCOMPILE
> -CROSS_COMPILE		:= $(tool-prefix)
> +CROSS_COMPILE		?= $(tool-prefix)
>  endif
>  
>  ifdef CONFIG_32BIT

This would not work as expected if CROSS_COMPILE environment variable
did not exist.  The toplevel Makefile always assigns an empty string
to CROSS_COMPILE before this, so $(tool-prefix) would not be used at
all.

If we needed to keep CONFIG_CROSSCOMPILE as is and needed
CROSS_COMPILE environment variable, something like this might work.

ifdef CONFIG_CROSSCOMPILE
ifndef CROSS_COMPILE
CROSS_COMPILE		:= $(tool-prefix)
endif
endif

---
Atsushi Nemoto
