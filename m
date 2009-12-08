Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 08:09:27 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41716 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491037AbZLHHJX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 08:09:23 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 96B61F02FE; Tue,  8 Dec 2009 08:09:23 +0100 (CET)
Date:   Tue, 8 Dec 2009 08:09:15 +0100
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
Message-ID: <20091208070915.GC12264@elf.ucw.cz>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
 <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
 <20091206084717.GD2766@ucw.cz>
 <1260147298.3126.2.camel@falcon.domain.org>
 <20091207080446.GB23088@elf.ucw.cz>
 <1260178870.9092.34.camel@falcon.domain.org>
 <20091207094909.GD23088@elf.ucw.cz>
 <1260183663.9092.51.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1260183663.9092.51.camel@falcon.domain.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

> > > > That's certainly better. But... why not return signed value? Current
> > > > flowing from the battery is certainly very different from current
> > > > flowing into it...
> > > 
> > > You are totally right ;)
> > > 
> > > Just test it, when flowing from the battery, the value is negative, and
> > > when flowing into the battery, the value is positive, so, no abs()
> > > needed. thanks!
> > 
> > Make it return -value, then. I believe other code uses >0 values for
> > discharge.
> 
> Done, but any document/standard about it?

Not sure, feel free to patch the documentation, too :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
