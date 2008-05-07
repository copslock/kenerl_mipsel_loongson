Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 09:24:25 +0100 (BST)
Received: from pentafluge.infradead.org ([213.146.154.40]:14309 "EHLO
	pentafluge.infradead.org") by ftp.linux-mips.org with ESMTP
	id S20024817AbYEGIYX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 May 2008 09:24:23 +0100
Received: from pmac.infradead.org ([2001:8b0:10b:1:20d:93ff:fe7a:3f2c])
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1Jtewi-0000k9-Iy; Wed, 07 May 2008 08:24:16 +0000
Subject: Re: [rtc-linux] [RFC][PATCH 1/4] RTC: Class device support for
	persistent clock
From:	David Woodhouse <dwmw2@infradead.org>
To:	rtc-linux@googlegroups.com
Cc:	Alessandro Zummo <a.zummo@towertech.it>,
	Jean Delvare <khali@linux-fr.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805070015360.16173@cliff.in.clinika.pl>
Content-Type: text/plain
Date:	Wed, 07 May 2008 09:24:15 +0100
Message-Id: <1210148655.25560.825.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.1 (2.22.1-1.fc9) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Return-Path: <SRS0+9d6426c59dd8b4fa22d3+1718+infradead.org+dwmw2@pentafluge.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwmw2@infradead.org
Precedence: bulk
X-list: linux-mips

On Wed, 2008-05-07 at 01:40 +0100, Maciej W. Rozycki wrote:
> 
> +int rtc_update_persistent_clock(struct timespec now)
> +{
> +       struct rtc_device *rtc =
> rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
> +       int err;
> +
> +       if (rtc == NULL) {
> +               printk(KERN_ERR "hctosys: unable to open rtc device (%
> s)\n",
> +                      CONFIG_RTC_HCTOSYS_DEVICE);
> +               err = -ENXIO;
> +               goto out;
>         }
> -       else
> +       err = rtc_set_mmss(rtc, now.tv_sec);
> +       if (err < 0) {
>                 dev_err(rtc->dev.parent,
> -                       "hctosys: unable to read the hardware clock
> \n");
> +                       "hctosys: unable to set the hardware clock
> \n");
> +               goto out_close;
> +       }
>  
> +       err = 0;
> +
> +out_close:
>         rtc_class_close(rtc);
> +out:
> +       return err;
> +}

Ooh, shiny -- you saved me the trouble of doing this (and hopefully also
the trouble of looking through it to check whether all the callers of
read_persistent_clock() can sleep, etc.?)

One thing I was going to do in rtc_update_persistent_clock() was make it
use mutex_trylock() for grabbing rtc->lock. We go to great lengths to
make sure we're updating the clock at the correct time -- we don't want
to be doing things which delay the update. So we should probably just
use mutex_trylock() and abort the update (this time) if it fails.

I was also thinking of holding the RTC_HCTOSYS device open all the time,
too. If it's a problem that you then couldn't unload the module, perhaps
a sysfs interface to set/change/clear which device is used for this?

When we discussed it last week, Alessandro was concerned that the
'update at precisely 500ms past the second' rule was not universal to
all RTC devices, although I'm not entirely sure. It might be worth
moving that logic into a 'default' NTP-sync routine provided by the RTC
class, so that if any strange devices exist which require different
treatment, they can override that.

I wouldn't worry too much about leaving the old
update_persistent_clock() and read_persistent_clock() -- I hope we can
plan to remove those entirely in favour of the RTC class methods.

-- 
dwmw2
