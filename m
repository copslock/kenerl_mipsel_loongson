Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 13:11:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:60374 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021737AbXDRMLm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Apr 2007 13:11:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3ICBeBK021244;
	Wed, 18 Apr 2007 13:11:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3ICBd54021243;
	Wed, 18 Apr 2007 13:11:39 +0100
Date:	Wed, 18 Apr 2007 13:11:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	tiansm@lemote.com
Cc:	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 6/16] define Hit_Invalidate_I to Index_Invalidate_I for loongson2
Message-ID: <20070418121139.GF3938@linux-mips.org>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <11766507661133-git-send-email-tiansm@lemote.com> <11766507661526-git-send-email-tiansm@lemote.com> <11766507662650-git-send-email-tiansm@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11766507662650-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 15, 2007 at 11:25:55PM +0800, tiansm@lemote.com wrote:

> +#if defined(CONFIG_CPU_LOONGSON2)
> +#define Hit_Invalidate_I    	0x00

This #ifdef means Index_Invalidate_I and Hit_Invalidate_I will both be
defined as zero, is that really correct?

(This is the point where I would really like to have a CPU manual ...)

> +#else
>  #define Hit_Invalidate_I	0x10
> +#endif

  Ralf
