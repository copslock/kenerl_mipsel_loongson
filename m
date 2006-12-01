Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 10:41:10 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:56417 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037860AbWLAKlG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 10:41:06 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 1 Dec 2006 19:41:04 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id DD2D53EEA7;
	Fri,  1 Dec 2006 19:41:02 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id CAACA20403;
	Fri,  1 Dec 2006 19:41:02 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kB1Af2W0064777;
	Fri, 1 Dec 2006 19:41:02 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 01 Dec 2006 19:41:02 +0900 (JST)
Message-Id: <20061201.194102.89066483.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Is _do_IRQ() not needed anymore ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80612010219p50334a6cj4a797dcd608376ed@mail.gmail.com>
References: <cda58cb80612010206r51d319a1x72105981d900068a@mail.gmail.com>
	<20061201.191049.63741937.nemoto@toshiba-tops.co.jp>
	<cda58cb80612010219p50334a6cj4a797dcd608376ed@mail.gmail.com>
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
X-archive-position: 13286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 1 Dec 2006 11:19:34 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> ok bad example. Why not making the select thing part of the platform
> config like this ?
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5ff94e5..8565533 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -233,6 +233,7 @@ config LASAT
>         select SYS_SUPPORTS_32BIT_KERNEL
>         select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
>         select SYS_SUPPORTS_LITTLE_ENDIAN
> +       select GENERIC_HARDIRQS_NO__DO_IRQ
> 
>  config MIPS_ATLAS
>         bool "MIPS Atlas board"
> @@ -913,6 +914,10 @@ config SYS_SUPPORTS_BIG_ENDIAN
>  config SYS_SUPPORTS_LITTLE_ENDIAN
>         bool
> 
> +config GENERIC_HARDIRQS_NO__DO_IRQ
> +       bool
> +       default n
> +
>  config IRQ_CPU
>         bool

This looks good for me.

Also, if you selected GENERIC_HARDIRQS_NO__DO_IRQ, you can remove .end
handler.  But adding "#ifdef GENERIC_HARDIRQS_NO__DO_IRQ" for each
.end might be slightly ugly...

---
Atsushi Nemoto
