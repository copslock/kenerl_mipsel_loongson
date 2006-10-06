Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 19:31:49 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:59883 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20039484AbWJFSbp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2006 19:31:45 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id F15213ECA; Fri,  6 Oct 2006 11:31:18 -0700 (PDT)
Message-ID: <4526A0F3.5090202@ru.mvista.com>
Date:	Fri, 06 Oct 2006 22:31:15 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] add "depends on BROKEN" to broken boards support
References: <20061007005452.45b50d8c.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061007005452.45b50d8c.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Yoichi Yuasa wrote:

> This patch has added "depends on BROKEN" to broken boards support.
> These boards cannot build now.

> Yoichi

> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

> @@ -511,6 +517,7 @@ config QEMU
>  
>  config MARKEINS
>  	bool "Support for NEC EMMA2RH Mark-eins"
> +	depends on BROKEN
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
>  	select IRQ_CPU

    What's broken about this board?

> @@ -717,6 +724,7 @@ config SNI_RM200_PCI
>  
>  config TOSHIBA_JMR3927
>  	bool "Toshiba JMR-TX3927 board"
> +	depends on BROKEN
>  	select DMA_NONCOHERENT
>  	select HW_HAS_PCI
>  	select MIPS_TX3927
> @@ -728,6 +736,7 @@ config TOSHIBA_JMR3927
>  
>  config TOSHIBA_RBTX4927
>  	bool "Toshiba TBTX49[23]7 board"
> +	depends on BROKEN
>  	select DMA_NONCOHERENT
>  	select HAS_TXX9_SERIAL
>  	select HW_HAS_PCI

    ... and this one?

> @@ -745,6 +754,7 @@ config TOSHIBA_RBTX4927
>  
>  config TOSHIBA_RBTX4938
>  	bool "Toshiba RBTX4938 board"
> +	depends on BROKEN
>  	select HAVE_STD_PC_SERIAL_PORT
>  	select DMA_NONCOHERENT
>  	select GENERIC_ISA_DMA

    There's a patch from Atsushi Nemoto still pending commit, IIRC...

WBR, Sergei
