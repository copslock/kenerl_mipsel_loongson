Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAC1ebC04245
	for linux-mips-outgoing; Sun, 11 Nov 2001 17:40:37 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAC1eY004238
	for <linux-mips@oss.sgi.com>; Sun, 11 Nov 2001 17:40:34 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 12 Nov 2001 01:40:34 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 2D035B46B; Mon, 12 Nov 2001 10:40:32 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id KAA77325; Mon, 12 Nov 2001 10:40:31 +0900 (JST)
Date: Mon, 12 Nov 2001 10:45:19 +0900 (JST)
Message-Id: <20011112.104519.126571085.nemoto@toshiba-tops.co.jp>
To: jsun@mvista.com
Cc: linux-mips@oss.sgi.com
Subject: Re: [RFC] generic MIPS RTC driver
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011110231746.B4342@mvista.com>
References: <20011110231746.B4342@mvista.com>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Sat, 10 Nov 2001 23:17:46 -0800, Jun Sun <jsun@mvista.com> said:
jsun> For many MIPS boards that start to use CONFIG_NEW_TIME_C, two
jsun> rtc operations are implemented, rtc_get_time() and
jsun> rtc_set_time().
jsun> It is possible to write a simple generic RTC driver that is
jsun> based on these two ops and can do simple RTC read&write ops.
...
jsun> This is the idea behind the generic MIPS rtc driver.  See the
jsun> patch below.
...
jsun> Any comments?

Good idea.  I hope cvs kernel import this patch.


I found two small things to fix.  to_tm function sets 1..12 value in
tm_mon field, so

1. in rtc_ioctl (case RTC_RD_TIME), subtracting 1 from rtc_tm.tm_mon
   is needed.

2. in rtc_proc_output, adding 1 to tm.tm_mon is not needed.

---
Atsushi Nemoto
