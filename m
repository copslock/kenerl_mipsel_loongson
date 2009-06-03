Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 12:24:29 +0100 (WEST)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52012 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022560AbZFCLYX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 12:24:23 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
	id 43BA5F0131; Wed,  3 Jun 2009 13:24:21 +0200 (CEST)
Date:	Wed, 3 Jun 2009 13:24:15 +0200
From:	Pavel Machek <pavel@ucw.cz>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	yan hua <yanh@lemote.com>, Zhang Fuxin <zhangfx@lemote.com>,
	Wu Zhangjin <wuzj@lemote.com>, Hongbing Hu <huhb@lemote.com>
Subject: Re: [PATCH] Hibernation Support in mips system
Message-ID: <20090603112414.GF5084@elf.ucw.cz>
References: <1243956702-16276-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1243956702-16276-1-git-send-email-wuzhangjin@gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

On Tue 2009-06-02 23:31:42, wuzhangjin@gmail.com wrote:
> From: Wu Zhangjin <wuzj@lemote.com>
> 
> This is originally pulled from the to-mips branch of
> http://dev.lemote.com/code/linux_loongson, only a few coding style
> tuning under the support of script/checkpatch.pl
> 
> as the feedback from Atsushi Nemoto,Yanhua and Pavel Machek, some changes
> have been done by Hu Hongbing(the original author of mips-specific STD)
> from Lemote.com. this patch apply the changes, which include:
> 
> Reviewed-by: Pavel Machek <pavel@ucw.cz>

The patch looks ok, but I don't think I offered that tag before. You
can add it now.

> @@ -0,0 +1,31 @@
> +/*
> + * Suspend support specific for mips.

"Hibernation support"? Copyright, GPL, author info?

> +#include <linux/mm.h>
> +#include <linux/suspend.h>
> +#include <asm/mipsregs.h>
> +#include <asm/page.h>
> +#include <asm/suspend.h>
> +#include <asm/ptrace.h>
> +
> +static uint32_t saved_status;

"u32" please.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
