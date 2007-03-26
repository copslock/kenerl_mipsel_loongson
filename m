Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2007 11:37:09 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:21255 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20022722AbXCZKhH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Mar 2007 11:37:07 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 26 Mar 2007 19:37:05 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 337D02022A;
	Mon, 26 Mar 2007 19:36:42 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 286C420112;
	Mon, 26 Mar 2007 19:36:42 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l2QAafW0078958;
	Mon, 26 Mar 2007 19:36:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 26 Mar 2007 19:36:41 +0900 (JST)
Message-Id: <20070326.193641.15269037.nemoto@toshiba-tops.co.jp>
To:	kumba@gentoo.org
Cc:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4606C063.1030802@gentoo.org>
References: <4606AA74.3070907@gentoo.org>
	<20070326.020705.63742150.anemo@mba.ocn.ne.jp>
	<4606C063.1030802@gentoo.org>
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
X-archive-position: 14683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 25 Mar 2007 14:33:07 -0400, Kumba <kumba@gentoo.org> wrote:
> Actually, I just realized I didn't rehash my dhcpd, so it booted the wrong 
> kernel.  A kernel built with this patchset won't boot without the following 
> change in include/asm-mips/stackframe.h:
> 
> --- include/asm-mips/stackframe.h.orig	2007-03-25 14:22:04.000000000 -0400
> +++ include/asm-mips/stackframe.h	2007-03-25 14:22:21.000000000 -0400
> @@ -70,7 +70,7 @@
>   #else
>   		MFC0	k0, CP0_CONTEXT
>   #endif
> -#if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
> +#if defined(CONFIG_32BIT) || !defined(KBUILD_64BIT_SYM32)
>   		lui	k1, %hi(kernelsp)
>   #else

It looks very strange.  "lui k1, %hi(kernelsp)" should be enough for
the -msym32 kernel.  What is a version of binutils and gcc you are using?

And could you show me disassembled list of handle_int (or some other
rountines using get_saved_sp) of failed kernel?

If you were using gcc 3.x, does this fix work for you?

#if defined(CONFIG_32BIT) || (defined(KBUILD_64BIT_SYM32) &&  __GNUC__ >= 4)
  		lui	k1, %hi(kernelsp)
#else
...


---
Atsushi Nemoto
