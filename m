Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACJQZr04488
	for linux-mips-outgoing; Mon, 12 Nov 2001 11:26:35 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACJQW004485
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 11:26:32 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fACJRlB14946;
	Mon, 12 Nov 2001 11:27:47 -0800
Message-ID: <3BF02261.CD039BDA@mvista.com>
Date: Mon, 12 Nov 2001 11:26:25 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
CC: linux-mips@oss.sgi.com
Subject: Re: [RFC] generic MIPS RTC driver
References: <20011110231746.B4342@mvista.com> <20011112.104519.126571085.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Atsushi Nemoto wrote:
> 
> >>>>> On Sat, 10 Nov 2001 23:17:46 -0800, Jun Sun <jsun@mvista.com> said:
> jsun> For many MIPS boards that start to use CONFIG_NEW_TIME_C, two
> jsun> rtc operations are implemented, rtc_get_time() and
> jsun> rtc_set_time().
> jsun> It is possible to write a simple generic RTC driver that is
> jsun> based on these two ops and can do simple RTC read&write ops.
> ...
> jsun> This is the idea behind the generic MIPS rtc driver.  See the
> jsun> patch below.
> ...
> jsun> Any comments?
> 
> Good idea.  I hope cvs kernel import this patch.
> 
> I found two small things to fix.  to_tm function sets 1..12 value in
> tm_mon field, so
> 
> 1. in rtc_ioctl (case RTC_RD_TIME), subtracting 1 from rtc_tm.tm_mon
>    is needed.
> 
> 2. in rtc_proc_output, adding 1 to tm.tm_mon is not needed.
> 

Good eye for spotting this. :-)

It turned out that tm_mon in rtc_time struct really should start from 0 to 11
(by definition).  So there is a bug in to_tm().  I sent a patch to Ralf and I
think he applied already.

Jun
