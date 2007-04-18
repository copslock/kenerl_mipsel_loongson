Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2007 13:06:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49888 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021729AbXDRMGV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Apr 2007 13:06:21 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l3IC6KSl021152;
	Wed, 18 Apr 2007 13:06:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l3IC6KY2021151;
	Wed, 18 Apr 2007 13:06:20 +0100
Date:	Wed, 18 Apr 2007 13:06:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	tiansm@lemote.com
Cc:	linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH 3/16] Kconfig update for lemote fulong mini-PC
Message-ID: <20070418120620.GE3938@linux-mips.org>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11766507662638-git-send-email-tiansm@lemote.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Apr 15, 2007 at 11:25:52PM +0800, tiansm@lemote.com wrote:

> @@ -1681,6 +1712,13 @@ config CPU_HAS_SMARTMIPS
>  config CPU_HAS_WB
>  	bool
>  
> +config 64BIT_CONTEXT
> +	bool "Save 64bit integer registers" if CPU_LOONGSON2 && 32BIT
> +	help
> +	  Loongson2 CPU is 64bit , when used in 32BIT mode, its integer registers
> +	  can still be accessed as 64bit, mainly for multimedia instructions. We must have
> +	  all 64bit save/restored to make sure those instructions to get correct result.
> +

Is there anything in implementation of this option Loongson2-specific?
If not then I suggest we make this option loook like:

   bool "Save 64bit integer registers" if CPU_SUPPORTS_64BIT_KERNEL && 32BIT

Somebody else might have a use for it!

  Ralf
