Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 May 2006 12:54:23 +0200 (CEST)
Received: from mo31.po.2iij.net ([210.128.50.54]:57636 "EHLO mo31.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8133864AbWERKyN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 May 2006 12:54:13 +0200
Received: by mo.po.2iij.net (mo31) id k4IAs8IF047465; Thu, 18 May 2006 19:54:08 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox30) id k4IAs4M6097042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 May 2006 19:54:04 +0900 (JST)
Date:	Thu, 18 May 2006 19:54:04 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	dpervushin@ru.mvista.com
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] NEC EMMA2RH support
Message-Id: <20060518195404.663eba86.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <1147946423.8223.4.camel@diimka-laptop>
References: <1147946423.8223.4.camel@diimka-laptop>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 18 May 2006 14:00:23 +0400
dmitry pervushin <dpervushin@ru.mvista.com> wrote:

> Index: linux-malta/arch/mips/emma2rh/markeins/int-handler.S
> ===================================================================
> --- /dev/null
> +++ linux-malta/arch/mips/emma2rh/markeins/int-handler.S

You should rewrite the assembler interrupt handler to C code.

> Index: linux-malta/arch/mips/emma2rh/markeins/setup.c
> ===================================================================
> --- /dev/null
> +++ linux-malta/arch/mips/emma2rh/markeins/setup.c
> @@ -0,0 +1,208 @@

<snip>

> +}
> +
> +early_initcall(platform_setup);

early_initcall() already haven't existed.
You should use plat_setup().

Yoichi
