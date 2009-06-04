Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 13:06:04 +0100 (WEST)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60437 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022521AbZFDMF5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 13:05:57 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
	id 70CC5F0210; Thu,  4 Jun 2009 14:05:55 +0200 (CEST)
Date:	Thu, 4 Jun 2009 14:05:49 +0200
From:	Pavel Machek <pavel@ucw.cz>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Yan Hua <yanh@lemote.com>, Zhang Fuxin <zhangfx@lemote.com>,
	Wu Zhangjin <wuzj@lemote.com>, Hu Hongbing <huhb@lemote.com>
Subject: Re: [PATCH-v1] Hibernation Support in mips system
Message-ID: <20090604120549.GD22897@elf.ucw.cz>
References: <6b7278ff10d7c4f9d819792de8742f65147c6855.1244038584.git.wuzj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b7278ff10d7c4f9d819792de8742f65147c6855.1244038584.git.wuzj@lemote.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

Hi!

> @@ -0,0 +1,41 @@
> +/*
> + * Suspend support specific for mips.
> + *
> + * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
> + * Author: Hu Hongbing <huhb@lemote.com>
> + *         Wu Zhangjin <wuzj@lemote.com>
> + */

I guess GPL notice there would be nice...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
