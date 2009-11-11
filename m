Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 11:33:57 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54941 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S2097291AbZKKKdr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 11:33:47 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
	id CF4B3F07B9; Wed, 11 Nov 2009 11:33:46 +0100 (CET)
Date:	Wed, 11 Nov 2009 11:33:40 +0100
From:	Pavel Machek <pavel@ucw.cz>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	yanh@lemote.com, huhb@lemote.com, LenBrown <len.brown@intel.com>,
	"RafaelJ.Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.or
Subject: Re: [PATCH -queue 2/2] [loongson] yeeloong2f: add board specific
 suspend support
Message-ID: <20091111103340.GC26423@elf.ucw.cz>
References: <cover.1257922151.git.wuzhangjin@gmail.com>
 <1257922661.2922.98.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257922661.2922.98.camel@falcon.domain.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

On Wed 2009-11-11 14:57:41, Wu Zhangjin wrote:
> (Add CC to Rafael J. Wysocki, Len Brown and Pavel Machek)
> 
> Lemote loongson2f family machines need an external interrupt to wake up
> the system from the suspend mode.
> 
> For the new Fuloong2f and LingLoong2f, they add a button to send the
> interrupt to the cpu directly, so, there is no need to setup an
> interrupt for them.
> 
> But for YeeLoong2f and Mengloong2f, there is no hardware change, So, we
> setup the keyboard interrupt as the wakeup interrupt, this patch does
> it!
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Looks good. ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
