Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f850Pc504857
	for linux-mips-outgoing; Tue, 4 Sep 2001 17:25:38 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f850PZd04852
	for <linux-mips@oss.sgi.com>; Tue, 4 Sep 2001 17:25:36 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 5 Sep 2001 00:25:35 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 6654D54C0E; Wed,  5 Sep 2001 09:25:32 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id JAA58723; Wed, 5 Sep 2001 09:25:29 +0900 (JST)
Date: Wed, 05 Sep 2001 09:30:05 +0900 (JST)
Message-Id: <20010905.093005.112629653.nemoto@toshiba-tops.co.jp>
To: Phil.Thompson@pace.co.uk
Cc: linux-mips@oss.sgi.com
Subject: Re: Signal 11 on Process Termination - Update
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <54045BFDAD47D5118A850002A5095CC30AC576@exchange1.cam.pace.co.uk>
References: <54045BFDAD47D5118A850002A5095CC30AC576@exchange1.cam.pace.co.uk>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Tue, 4 Sep 2001 18:48:33 +0100 , Phil Thompson <Phil.Thompson@pace.co.uk> said:
Phil> The SIGSEGV is being raised because the access_ok() in
Phil> setup_frame() in kernel/signal.c is failing when trying to
Phil> deliver another signal (SIGALRM or SIGCHLD in my cases).

At setup_frame(), sp (regs->regs[29]) is in the kernel kernel stack,
isn't it?

If so, please try a patch for entry.S I posted a couple days ago.

> Subject: Re: segfaults with 2.4.8

Hope this helps.
---
Atsushi Nemoto
