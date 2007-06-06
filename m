Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 18:48:55 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:17339 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027100AbXFFRsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 18:48:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l56HfsRu003195;
	Wed, 6 Jun 2007 18:41:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l56Hfqed003194;
	Wed, 6 Jun 2007 18:41:52 +0100
Date:	Wed, 6 Jun 2007 18:41:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	tiansm@lemote.com
Cc:	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 04/15] TO_PHYS_MASK for loongson2
Message-ID: <20070606174152.GC30017@linux-mips.org>
References: <11811127722019-git-send-email-tiansm@lemote.com> <1181112773336-git-send-email-tiansm@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1181112773336-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 06, 2007 at 02:52:41PM +0800, tiansm@lemote.com wrote:

> diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
> index 964c5ed..a4d9a07 100644
> --- a/include/asm-mips/addrspace.h
> +++ b/include/asm-mips/addrspace.h
> @@ -145,7 +145,7 @@
>  #define TO_PHYS_MASK	_CONST64_(0x000000ffffffffff)	/* 2^^40 - 1 */
>  #endif
>  
> -#if defined (CONFIG_CPU_R10000)
> +#if defined (CONFIG_CPU_R10000) || defined (CONFIG_CPU_LOONGSON2)
>  #define TO_PHYS_MASK	_CONST64_(0x000000ffffffffff)	/* 2^^40 - 1 */
>  #endif

I've already previously rejected this patch, see
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20070418120240.GD3938%40linux-mips.org
for why.

Anyway, I've implemented the suggested fix for the -queue tree, so you
can drop this one from your patch queue.

  Ralf
