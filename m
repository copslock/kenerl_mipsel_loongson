Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 09:57:52 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:11025 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037861AbWLAJ5s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 09:57:48 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Fri, 1 Dec 2006 18:57:47 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9CEFE25786;
	Fri,  1 Dec 2006 18:57:41 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9122720474;
	Fri,  1 Dec 2006 18:57:41 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kB19vfW0064617;
	Fri, 1 Dec 2006 18:57:41 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 01 Dec 2006 18:57:40 +0900 (JST)
Message-Id: <20061201.185740.03976990.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Is _do_IRQ() not needed anymore ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80612010140y5a95faceybffedbd4dd9900db@mail.gmail.com>
References: <cda58cb80612010140y5a95faceybffedbd4dd9900db@mail.gmail.com>
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
X-archive-position: 13282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 1 Dec 2006 10:40:52 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> Now it seems that __do_IRQ() is not needed anymore. I dunno if it's
> true for all platforms though. Does something like this make sense for
> example ?
> 
> -- >8 --
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5ff94e5..a4c5306 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -913,8 +913,13 @@ config SYS_SUPPORTS_BIG_ENDIAN
>  config SYS_SUPPORTS_LITTLE_ENDIAN
>  	bool
> 
> +config GENERIC_HARDIRQS_NO__DO_IRQ
> +	bool
> +	default n
> +

No, there are irq chips still need __do_IRQ().  Please grep
'set_irq_chip('.

If _all_ irq chip were converted to use flow handler,
GENERIC_HARDIRQS_NO__DO_IRQ will be good.  But we have i8259...

---
Atsushi Nemoto
