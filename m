Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2004 11:31:31 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:19748
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8224948AbUJZKb0>; Tue, 26 Oct 2004 11:31:26 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 26 Oct 2004 10:31:24 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id BE07C239E3F; Tue, 26 Oct 2004 19:31:21 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i9QAVL3i065443;
	Tue, 26 Oct 2004 19:31:21 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 26 Oct 2004 19:30:11 +0900 (JST)
Message-Id: <20041026.193011.35362756.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: socket.h patch (SOCK_XXX break glibc build)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041026015036.GA26841@linux-mips.org>
References: <20041026.101226.70226592.nemoto@toshiba-tops.co.jp>
	<20041026015036.GA26841@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 26 Oct 2004 03:50:36 +0200, Ralf Baechle <ralf@linux-mips.org> said:
>> On 2.6.9, SOCK_DGRAM, etc. in asm-mips/socket.h are visible from
>> userland.  It will break glibc build.  For other archs,
>> include/linux/net.h uses "#ifdef __KERNEL__" for SOCK_XXX
>> definitions, so asm-mips/socket.h should use "#ifdef __KERNEL__"
>> too?

ralf> Ok ...

Sorry, there was a garbage character (':') in my patch.  Please remove
it.  Thank you.

> @@ -68,6 +68,8 @@
>  
>  #define SO_PEERSEC		30
>  
> +#ifdef __KERNEL__
> +:
>  /** sock_type - Socket types
>   *
>   * Please notice that for binary compat reasons MIPS has to

---
Atsushi Nemoto
