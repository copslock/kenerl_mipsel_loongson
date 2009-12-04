Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 15:40:50 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58682 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492956AbZLDOkr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 15:40:47 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id CDCD4F0497; Fri,  4 Dec 2009 15:40:43 +0100 (CET)
Date:   Fri, 4 Dec 2009 09:04:08 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-laptop@vger.kernel.org
Subject: Re: [PATCH v7 4/8] Loongson: YeeLoong: add battery driver
Message-ID: <20091204080408.GA1540@ucw.cz>
References: <cover.1259932036.git.wuzhangjin@gmail.com> <059fa216d70771a6341edb2db4cc559e958273e9.1259932036.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059fa216d70771a6341edb2db4cc559e958273e9.1259932036.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

On Fri 2009-12-04 21:34:17, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds APM emulated Battery Driver, it provides standard
> interface(/proc/apm) for user-space applications(e.g. kpowersave,
> gnome-power-manager) to manage the battery.

It would be nicer if this went to drivers/power, and used its
interface -- providing not only percentage but also other values.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
