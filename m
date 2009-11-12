Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 20:04:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53866 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493212AbZKLTEH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Nov 2009 20:04:07 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nACJ49b0024997;
	Thu, 12 Nov 2009 20:04:09 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nACJ3wDF024994;
	Thu, 12 Nov 2009 20:03:58 +0100
Date:	Thu, 12 Nov 2009 20:03:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pavel Machek <pavel@ucw.cz>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	yanh@lemote.com, huhb@lemote.com, LenBrown <len.brown@intel.com>,
	"RafaelJ.Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.or
Subject: Re: [PATCH -queue 2/2] [loongson] yeeloong2f: add board specific
	suspend support
Message-ID: <20091112190358.GB2887@linux-mips.org>
References: <cover.1257922151.git.wuzhangjin@gmail.com> <1257922661.2922.98.camel@falcon.domain.org> <20091111103340.GC26423@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091111103340.GC26423@elf.ucw.cz>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 11, 2009 at 11:33:40AM +0100, Pavel Machek wrote:

> > Lemote loongson2f family machines need an external interrupt to wake up
> > the system from the suspend mode.
> > 
> > For the new Fuloong2f and LingLoong2f, they add a button to send the
> > interrupt to the cpu directly, so, there is no need to setup an
> > interrupt for them.
> > 
> > But for YeeLoong2f and Mengloong2f, there is no hardware change, So, we
> > setup the keyboard interrupt as the wakeup interrupt, this patch does
> > it!
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Looks good. ACK.

Thanks folks.  Queued for 2.6.33,

  Ralf
