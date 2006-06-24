Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2006 20:08:25 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:47264 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133637AbWFXTIQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 24 Jun 2006 20:08:16 +0100
Received: (qmail 14907 invoked from network); 24 Jun 2006 23:19:48 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 24 Jun 2006 23:19:48 -0000
Message-ID: <449D8D44.70900@ru.mvista.com>
Date:	Sat, 24 Jun 2006 23:06:44 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Domen Puncer <domen@coderock.org>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [patch 5/8] au1xxx: export dbdma functions
References: <20060623095703.GA30980@domen.ultra.si> <20060623100021.GE31017@domen.ultra.si> <20060623103343.GE5896@linux-mips.org> <20060623135202.GA9098@nd47.coderock.org>
In-Reply-To: <20060623135202.GA9098@nd47.coderock.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Domen Puncer wrote:
> These are needed for au1550_ac97 module.

> Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

> Index: linux-mailed/arch/mips/au1000/common/dbdma.c
> ===================================================================
> --- linux-mailed.orig/arch/mips/au1000/common/dbdma.c
> +++ linux-mailed/arch/mips/au1000/common/dbdma.c
> @@ -730,6 +730,8 @@ au1xxx_dbdma_get_dest(u32 chanid, void *
>  	return rv;
>  }
>  
> +EXPORT_SYMBOL_GPL(au1xxx_dbdma_get_dest);
> +
>  void
>  au1xxx_dbdma_stop(u32 chanid)
>  {
> @@ -821,6 +823,8 @@ au1xxx_get_dma_residue(u32 chanid)
>  	return rv;
>  }
>  
> +EXPORT_SYMBOL_GPL(au1xxx_get_dma_residue);
> +
>  void
>  au1xxx_dbdma_chan_free(u32 chanid)
>  {

    I should note that without patch 6 applied (which marks the module as 
GPL), this patch doesn't help. BTW, the other exports in this module are not 
GPL only...

WBR, Sergei
