Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 14:31:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50660 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037747AbWJKNbl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2006 14:31:41 +0100
Received: from localhost (p6080-ipad213funabasi.chiba.ocn.ne.jp [124.85.71.80])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 44AE2B70B; Wed, 11 Oct 2006 22:31:36 +0900 (JST)
Date:	Wed, 11 Oct 2006 22:33:52 +0900 (JST)
Message-Id: <20061011.223352.126573442.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 1/5] Make __pa() uses CPHYSADDR() if really needed
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11605685251014-git-send-email-fbuihuu@gmail.com>
References: <1160568525897-git-send-email-fbuihuu@gmail.com>
	<11605685251014-git-send-email-fbuihuu@gmail.com>
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
X-archive-position: 12905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 11 Oct 2006 14:08:41 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> -#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
> +#if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
> +#define __pa(x)			CPHYSADDR(x)
> +#else
> +#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
> +#endif
>  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))

Please do not do this.  CONFIG_BUILD_ELF64=n does not mean we only
have less then 512MB memory.  We can have large flat area at
PAGE_OFFSET (0x9800000000000000) in 64-bit kernel, so __pa() should
accepct a value such as 0x9800000020000000.

---
Atsushi Nemoto
