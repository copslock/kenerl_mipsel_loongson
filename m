Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 10:13:36 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60353 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021898AbZEOJNa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 May 2009 10:13:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4F9DJkC001140;
	Fri, 15 May 2009 10:13:20 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4F9DJ1P001138;
	Fri, 15 May 2009 10:13:19 +0100
Date:	Fri, 15 May 2009 10:13:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Randrianasulu <randrik_a@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP32 power button fix for 2.6.30
Message-ID: <20090515091319.GB7706@linux-mips.org>
References: <273990.30979.qm@web65307.mail.ac2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273990.30979.qm@web65307.mail.ac2.yahoo.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 14, 2009 at 11:29:27AM -0700, Andrew Randrianasulu wrote:

> X-Mailer: YahooMailClassic/5.2.20 YahooMailWebService/0.7.289.1

> I think i run into same sort of problem, as described here:
> 
> http://lkml.org/lkml/2009/4/16/24
> http://lkml.org/lkml/2009/4/14/94
> 
> (in my case it was hang after pressing O2's power button)
> 
> this patch fixes it:
> 
> ----
> 
> diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
> index b6cab08..667da93 100644
> --- a/arch/mips/sgi-ip32/ip32-reset.c
> +++ b/arch/mips/sgi-ip32/ip32-reset.c
> @@ -145,7 +145,7 @@ static irqreturn_t ip32_rtc_int(int irq, void *dev_id)
>                         "%s: RTC IRQ without RTC_IRQF\n", __func__);
>         }
>         /* Wait until interrupt goes away */
> -       disable_irq(MACEISA_RTC_IRQ);
> +       disable_irq_nosync(MACEISA_RTC_IRQ);
>         init_timer(&debounce_timer);
>         debounce_timer.function = debounce;
>         debounce_timer.expires = jiffies + 50;

 - no Signed-off-by: line
 - whitespace garbled.  Use a proper mail client such as /bin/mail ;-)

Grumblingly applied,

  Ralf
