Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8H3OLr24625
	for linux-mips-outgoing; Sun, 16 Sep 2001 20:24:21 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8H3OCe24621;
	Sun, 16 Sep 2001 20:24:13 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 17 Sep 2001 03:24:12 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 23E13B463; Mon, 17 Sep 2001 12:24:09 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA94151; Mon, 17 Sep 2001 12:24:04 +0900 (JST)
Date: Mon, 17 Sep 2001 12:28:52 +0900 (JST)
Message-Id: <20010917.122852.39150017.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: setup_frame() failure
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010914221455.A2272@dea.linux-mips.net>
References: <20010913031119.B27168@dea.linux-mips.net>
	<20010914.111632.41627160.nemoto@toshiba-tops.co.jp>
	<20010914221455.A2272@dea.linux-mips.net>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for your answer.

>>>>> On Fri, 14 Sep 2001 22:14:55 +0200, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> Certain I/O models use a large number of signals so we're trying
ralf> hard to keep signal latency down.

I agree.

ralf> The current code already can guarantee proper termination in
ralf> case of a stack fault, just not the shortest way.

I can not believe it.  There is a case we can not terminate the
process:

a)  If we installed a signal handler for SIGTRAP,
b)  and a signal queued by a "trap" instruction,
c)  and a stack fault occured.

I will show the reason (again):

1.  "trap" instruction raises a exception.
2.  The exception handler queues SIGTRAP(5).
3.  do_signal() dequeue a signal with LOWEST number.
4.  setup_frame() fails and queues SIGSEGV(11).
5.  returns to user process (without compute_return_epc()).
6.  again from 1. (forever)

In this case, dequeue_signal() always return SIGTRAP and any signal
which has a larger number than SIGTRAP never be processed, isn't it?
Or am I missing something?

Thank you.
---
Atsushi Nemoto
