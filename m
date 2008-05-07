Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 12:49:36 +0100 (BST)
Received: from mx0.towertech.it ([213.215.222.73]:56025 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S20034930AbYEGLte (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2008 12:49:34 +0100
Received: (qmail 16733 invoked from network); 7 May 2008 13:49:31 +0200
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 7 May 2008 13:49:31 +0200
Date:	Wed, 7 May 2008 13:49:30 +0200
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	rtc-linux@googlegroups.com
Cc:	dwmw2@infradead.org, Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] Re: [RFC][PATCH 1/4] RTC: Class device support for
 persistent clock
Message-ID: <20080507134930.47d5ed6d@i1501.lan.towertech.it>
In-Reply-To: <1210148655.25560.825.camel@pmac.infradead.org>
References: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
	<1210148655.25560.825.camel@pmac.infradead.org>
Organization: Tower Technologies
X-Mailer: Sylpheed
X-This-Is-A-Real-Message: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alessandro.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Wed, 07 May 2008 09:24:15 +0100
David Woodhouse <dwmw2@infradead.org> wrote:


> Ooh, shiny -- you saved me the trouble of doing this (and hopefully also
> the trouble of looking through it to check whether all the callers of
> read_persistent_clock() can sleep, etc.?)

 I knew you would have liked that patch :)
 
> One thing I was going to do in rtc_update_persistent_clock() was make it
> use mutex_trylock() for grabbing rtc->lock. We go to great lengths to
> make sure we're updating the clock at the correct time -- we don't want
> to be doing things which delay the update. So we should probably just
> use mutex_trylock() and abort the update (this time) if it fails.

 agreable. 
 
> I was also thinking of holding the RTC_HCTOSYS device open all the time,
> too. If it's a problem that you then couldn't unload the module, perhaps
> a sysfs interface to set/change/clear which device is used for this?

 mm.. let's keep it easy. the chances the rtc is in use
 are usually real low.
 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
