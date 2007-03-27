Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 04:13:02 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:34223 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20021287AbXC0DNA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 04:13:00 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 27 Mar 2007 12:12:59 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2DEDE42044;
	Tue, 27 Mar 2007 12:12:36 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 21B6E418A9;
	Tue, 27 Mar 2007 12:12:36 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2R3CWW0082355;
	Tue, 27 Mar 2007 12:12:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 27 Mar 2007 12:12:32 +0900 (JST)
Message-Id: <20070327.121232.71086507.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, kumba@gentoo.org, linux-mips@linux-mips.org,
	ths@networkno.de
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80703260907g6f349298xf85b2e2954a7b6a7@mail.gmail.com>
References: <cda58cb80703260831t576ff7c5wef1e34e3367e7c45@mail.gmail.com>
	<20070327.004511.31449250.anemo@mba.ocn.ne.jp>
	<cda58cb80703260907g6f349298xf85b2e2954a7b6a7@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 26 Mar 2007 18:07:21 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> ok, I suppose a warning is fine. What about this patch on top of the patchset ?
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 3ec0c12..b886945 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -627,7 +627,12 @@ ifdef CONFIG_64BIT
>    endif
> 
>    ifeq ($(KBUILD_SYM32), y)
> -    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
> +    ifeq ($(call cc-option-yn,-msym32), y)
> +      cflags-y += -msym32 -DKBUILD_64BIT_SYM32
> +    else
> +      $(warning '-msym32' option is not supported by your compiler. \
> +               You should use a new one to get best result)
> +    endif
>    endif
>  endif

Well, I feel even a warning is intrusive, while it is not necessary
optimization.

---
Atsushi Nemoto
