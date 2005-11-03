Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 11:05:30 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:16666 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133388AbVKCLFM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 11:05:12 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA3B5tCO006023;
	Thu, 3 Nov 2005 11:05:56 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA3B5rgR006022;
	Thu, 3 Nov 2005 11:05:53 GMT
Date:	Thu, 3 Nov 2005 11:05:53 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] remove mips_rtc_lock
Message-ID: <20051103110552.GA3149@linux-mips.org>
References: <20051103.010240.41630907.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103.010240.41630907.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 03, 2005 at 01:02:40AM +0900, Atsushi Nemoto wrote:

> The mips_rtc_lock is no longer needed because RTC operations should be
> protected already by other mechanism. (rtc_lock, local_irq_save, etc.)
> 
> Also, locking whole rtc_get_time/rtc_set_time should be avoided while
> some RTC routines might take very long time (a few seconds).
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Applied.  Thanks alot for the janitor work.

And also the function names are clear as mud:

[...]
static inline unsigned int get_rtc_time(struct rtc_time *time)
{
        unsigned long nowtime;

        nowtime = rtc_get_time();
[...]
static inline int set_rtc_time(struct rtc_time *time)
{
        unsigned long nowtime;
        int ret;

        nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
                        time->tm_mday, time->tm_hour, time->tm_min,
                        time->tm_sec);
        ret = rtc_set_time(nowtime);
[...]

The difference between and get_rtc_time and rtc_get_time is less than
obvious.  Same for set_rtc_time and rtc_set_time ...

   Ralf
