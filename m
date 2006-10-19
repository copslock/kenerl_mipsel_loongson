Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 05:01:44 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:51328 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20027573AbWJSEBm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 05:01:42 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 19 Oct 2006 13:01:40 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id EB1A820D22;
	Thu, 19 Oct 2006 13:01:34 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id D5F8C2057C;
	Thu, 19 Oct 2006 13:01:34 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9J41XW0068709;
	Thu, 19 Oct 2006 13:01:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 19 Oct 2006 13:01:33 +0900 (JST)
Message-Id: <20061019.130133.108306753.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 2/7] Make __pa() aware of XKPHYS/CKSEG0 address mix for
 64 bit kernels
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1160743146824-git-send-email-fbuihuu@gmail.com>
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
	<1160743146824-git-send-email-fbuihuu@gmail.com>
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
X-archive-position: 13003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 13 Oct 2006 14:39:01 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> +#if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
> +#define __page_offset(x)	((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)

CONFIG_64BIT, not CONFIG_64BITS.  Sorry, my mistake.

Also since CKSEG0 is defined with _LLCONST_ macro, the final type of
__page_offset(), __pa(), __pa_sym() will be "unsigned long long", not
"unsigned long".  This raise a "comparison of distinct pointer types
lacks a cast" warning on this line.

	reserved_end = max(init_initrd(), PFN_UP(__pa_symbol(&_end)));

A qiuck and non-intrusive hack would be cast CKSEG0 with "unsigned
long" here, but it might be preferred to change _LLCONST_ definition
like this.  What do you think?


Subject: Use "long" for _ATYPE64_ and _LLCONST_ on 64-bit kernel.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
index 45c706e..5005555 100644
--- a/include/asm-mips/addrspace.h
+++ b/include/asm-mips/addrspace.h
@@ -23,9 +23,14 @@ #define _LLCONST_(x)	x
 #else
 #define _ATYPE_		__PTRDIFF_TYPE__
 #define _ATYPE32_	int
+#ifdef CONFIG_64BIT
+#define _ATYPE64_	long
+#define _LLCONST_(x)	x ## L
+#else
 #define _ATYPE64_	long long
 #define _LLCONST_(x)	x ## LL
 #endif
+#endif
 
 /*
  *  32-bit MIPS address spaces


---
Atsushi Nemoto
