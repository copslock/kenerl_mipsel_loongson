Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 05:13:59 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:40631 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20027573AbWJSEN5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 05:13:57 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 19 Oct 2006 13:13:55 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id E44EF41859;
	Thu, 19 Oct 2006 13:13:53 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id CF0FA2057C;
	Thu, 19 Oct 2006 13:13:53 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9J4DrW0068740;
	Thu, 19 Oct 2006 13:13:53 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 19 Oct 2006 13:13:52 +0900 (JST)
Message-Id: <20061019.131352.41630930.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1160743146503-git-send-email-fbuihuu@gmail.com>
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
	<1160743146503-git-send-email-fbuihuu@gmail.com>
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
X-archive-position: 13004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 13 Oct 2006 14:39:05 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> +sanitize:
> +		/*
> +		 * Sanitize initrd addresses. For example firmware
> +		 * can't guess if they need to pass them through
> +		 * 64-bits values if the kernel has been built in pure
> +		 * 32-bit. We need also to switch from KSEG0 to XKPHYS
> +		 * addresses now, so the code can now safely use __pa().
> +		 */
> +		end = __pa(initrd_end);
> +		initrd_end = (unsigned long)__va(end);
> +		initrd_start = (unsigned long)__va(__pa(initrd_start));

At last I tested whole patchset on 64-bit and see this is not enough.

If I passed 0x000000008XXXXXXX instead of 0xffffffff8XXXXXXX to
initrd_start and initrd_end, the result of __pa() is not what I
wanted.  This is a proposal fix.

--- arch/mips/kernel/setup.c.orig	2006-10-19 11:31:12.000000000 +0900
+++ arch/mips/kernel/setup.c	2006-10-19 13:06:39.000000000 +0900
@@ -199,6 +199,14 @@
 		 * 32-bit. We need also to switch from KSEG0 to XKPHYS
 		 * addresses now, so the code can now safely use __pa().
 		 */
+#ifdef CONFIG_64BIT
+		/* HACK: Guess if the sign extension was forgotten */
+		if (initrd_start < XKPHYS) {
+			initrd_end -= initrd_start;
+			initrd_start = (int)initrd_start;
+			initrd_end += initrd_start;
+		}
+#endif
 		end = __pa(initrd_end);
 		initrd_end = (unsigned long)__va(end);
 		initrd_start = (unsigned long)__va(__pa(initrd_start));

With this fix and __pa() fix in my previous mail, your patchset works
well on my 64-bit kernel.  Thanks.

---
Atsushi Nemoto
