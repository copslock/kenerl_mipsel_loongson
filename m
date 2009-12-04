Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 15:50:43 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39347 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493126AbZLDOuh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 15:50:37 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6EAEAF0463; Fri,  4 Dec 2009 15:50:37 +0100 (CET)
Date:   Fri, 4 Dec 2009 09:14:02 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v7 8/8] Loongson: YeeLoong: add input/hotkey driver
Message-ID: <20091204081402.GD1540@ucw.cz>
References: <cover.1259932036.git.wuzhangjin@gmail.com> <7e96d37889c49c2d6d284e21773aef90dd3aac25.1259932036.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e96d37889c49c2d6d284e21773aef90dd3aac25.1259932036.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

Hi!


> +#define NO_REG		0
> +#define NO_HANDLER	NULL

Don't obfuscate code like that.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
