Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 14:52:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:38397 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224907AbUJKNwU>; Mon, 11 Oct 2004 14:52:20 +0100
Received: from localhost (p5148-ipad02funabasi.chiba.ocn.ne.jp [61.207.152.148])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5B4DC6F61; Mon, 11 Oct 2004 22:52:16 +0900 (JST)
Date: Mon, 11 Oct 2004 22:53:41 +0900 (JST)
Message-Id: <20041011.225341.59463723.anemo@mba.ocn.ne.jp>
To: ppopov@embeddedalley.com
Cc: macro@linux-mips.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: PATCH
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4169D818.5020802@embeddedalley.com>
	<1097481328.27818.10.camel@localhost.localdomain>
References: <1097452888.4627.25.camel@localhost.localdomain>
	<Pine.LNX.4.58L.0410110126120.4217@blysk.ds.pg.gda.pl>
	<4169D818.5020802@embeddedalley.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sun, 10 Oct 2004 17:47:20 -0700, Pete Popov <ppopov@embeddedalley.com> said:

ppopov> Clearly a buglet, carried over from 2.4. That section of the
ppopov> code wouldn't even be compiled, since CONFIG_MIPS64 is not
ppopov> defined. I'll remove that and send a new patch. Anything else
ppopov> you see that's suspicious :)?

Hi.  I wonder why following change is needed.

> --- include/asm-mips/page.h	20 Aug 2004 12:02:18 -0000	1.44
> +++ include/asm-mips/page.h	19 Sep 2004 22:51:29 -0000
> @@ -32,7 +32,7 @@
>  #ifdef CONFIG_PAGE_SIZE_64KB
>  #define PAGE_SHIFT	16
>  #endif
> -#define PAGE_SIZE	(1UL << PAGE_SHIFT)
> +#define PAGE_SIZE	(1L << PAGE_SHIFT)
>  #define PAGE_MASK	(~(PAGE_SIZE-1))
> 
>  #ifdef __KERNEL__

---
Atsushi Nemoto
