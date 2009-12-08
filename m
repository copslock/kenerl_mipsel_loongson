Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 16:02:42 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33595 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493114AbZLHPCj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 16:02:39 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 97EB8F02F5; Tue,  8 Dec 2009 16:02:36 +0100 (CET)
Date:   Tue, 8 Dec 2009 16:02:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v9 5/8] Loongson: YeeLoong: add hardware monitoring
        driver
Message-ID: <20091208150229.GA1375@ucw.cz>
References: <cover.1260281599.git.wuzhangjin@gmail.com> <5e9acb4cd757075f617daa45cbd6f5fad94678ac.1260281599.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9acb4cd757075f617daa45cbd6f5fad94678ac.1260281599.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

Hi!

> This patch adds hardware monitoring driver, it provides standard
> interface(/sys/class/hwmon/) for lm-sensors/sensors-applet to monitor
> the temperatures of CPU and battery, the PWM of fan, the current,
> voltage of battery.

It is probably ok for now, but in future current/voltage of battery
should be exported as power_supply class (drivers/power)...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
