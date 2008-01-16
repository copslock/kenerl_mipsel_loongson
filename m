Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 15:27:43 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:30416 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024559AbYAPP1f (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jan 2008 15:27:35 +0000
Received: from localhost (p6085-ipad307funabasi.chiba.ocn.ne.jp [123.217.184.85])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 8F0F095A0; Thu, 17 Jan 2008 00:27:27 +0900 (JST)
Date:	Thu, 17 Jan 2008 00:27:23 +0900 (JST)
Message-Id: <20080117.002723.05598602.anemo@mba.ocn.ne.jp>
To:	frank.rowand@am.sony.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] early_printk
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1200436287.4092.33.camel@bx740>
References: <1200436139.4092.30.camel@bx740>
	<1200436287.4092.33.camel@bx740>
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
X-archive-position: 18077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 15 Jan 2008 14:31:27 -0800, Frank Rowand <frank.rowand@am.sony.com> wrote:
> Implement early printk in the serial_txx9 driver, and enable for the
> Toshiba RBTX4927 board.  This is needed for the connect to GDB console
> message.
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> ---
>  arch/mips/Kconfig                                          |    1 	1 +	0 -	0 !
>  arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c |    6 	6 +	0 -	0 !
>  drivers/serial/serial_txx9.c                               |   39 	39 +	0 -	0 !
>  3 files changed, 46 insertions(+)

Please do not add MIPS local prom_putchar() to the serial_txx9 driver.
This driver is used on some powerpc platform too.

---
Atsushi Nemoto
