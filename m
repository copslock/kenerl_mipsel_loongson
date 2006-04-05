Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 14:38:09 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:8341 "HELO mail.dev.rtsoft.ru")
	by ftp.linux-mips.org with SMTP id S8133432AbWDENh7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Apr 2006 14:37:59 +0100
Received: (qmail 14343 invoked from network); 5 Apr 2006 17:50:22 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 5 Apr 2006 17:50:22 -0000
Message-ID: <4433CA7E.1010504@ru.mvista.com>
Date:	Wed, 05 Apr 2006 17:47:42 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Geoff Levand <geoffrey.levand@am.sony.com>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/4] fix tx4938 undefined reference
References: <4433122A.1090104@am.sony.com>
In-Reply-To: <4433122A.1090104@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Geoff Levand wrote:

> ------------------------------------------------------------------------
> 
> Fix undefined reference to `txx9_sio_kdbg_rd' when 
> CONFIG_KGDB_8250=y, CONFIG_KGDB_8250=n.

    I'm sorry, where do you see this option? It belongs to cross-arch KGDB 
which AFAIK is not in the Linus' kernel yet. So, NAK.

> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> 
> Index: linux-2.6.16.1/arch/mips/tx4938/common/Makefile
> ===================================================================
> --- linux-2.6.16.1.orig/arch/mips/tx4938/common/Makefile	2006-01-02 19:21:10.000000000 -0800
> +++ linux-2.6.16.1/arch/mips/tx4938/common/Makefile	2006-03-07 11:05:05.000000000 -0800
> @@ -7,5 +7,5 @@
>  #
>  
>  obj-y	+= prom.o setup.o irq.o irq_handler.o rtc_rx5c348.o
> -obj-$(CONFIG_KGDB) += dbgio.o
> +obj-$(CONFIG_KGDB_8250) += dbgio.o

WBR, Sergei
