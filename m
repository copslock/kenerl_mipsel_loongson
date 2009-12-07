Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 10:49:20 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55058 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492978AbZLGJtR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2009 10:49:17 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C6F24F0212; Mon,  7 Dec 2009 10:49:16 +0100 (CET)
Date:   Mon, 7 Dec 2009 10:49:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v8 5/8] Loongson: YeeLoong: add hardware monitoring
 driver
Message-ID: <20091207094909.GD23088@elf.ucw.cz>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
 <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
 <20091206084717.GD2766@ucw.cz>
 <1260147298.3126.2.camel@falcon.domain.org>
 <20091207080446.GB23088@elf.ucw.cz>
 <1260178870.9092.34.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1260178870.9092.34.camel@falcon.domain.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

On Mon 2009-12-07 17:41:10, Wu Zhangjin wrote:
> On Mon, 2009-12-07 at 09:04 +0100, Pavel Machek wrote:
> > > > What is going on here? I thought the value is already in two's
> > > > complement... Is the above equivalent of
> > > > 
> > > > 	      if (value < 0)
> > > > 	      	 value = -value; 
> > > > 
> > > > ? If so, why? If not, can you add a comment?
> > > 
> > > Right, then, will use this instead:
> > > 
> > > static int get_battery_current(void)
> > > { 
> > > 	s16 value;
> > > 
> > > 	value = (ec_read(REG_BAT_CURRENT_HIGH) << 8) |
> > > 		(ec_read(REG_BAT_CURRENT_LOW));
> > > 
> > > 	return abs(value);
> > > }
> > 
> > That's certainly better. But... why not return signed value? Current
> > flowing from the battery is certainly very different from current
> > flowing into it...
> 
> You are totally right ;)
> 
> Just test it, when flowing from the battery, the value is negative, and
> when flowing into the battery, the value is positive, so, no abs()
> needed. thanks!

Make it return -value, then. I believe other code uses >0 values for
discharge.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
