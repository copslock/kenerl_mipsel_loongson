Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8C44hT30777
	for linux-mips-outgoing; Tue, 11 Sep 2001 21:04:43 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8C44Ze30773;
	Tue, 11 Sep 2001 21:04:36 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 12 Sep 2001 04:04:35 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id C436AB458; Wed, 12 Sep 2001 13:04:33 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id NAA79990; Wed, 12 Sep 2001 13:04:30 +0900 (JST)
Date: Wed, 12 Sep 2001 13:09:14 +0900 (JST)
Message-Id: <20010912.130914.112630116.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: setup_frame() failure
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010910.114402.41626914.nemoto@toshiba-tops.co.jp>
References: <20010907.202652.71083122.nemoto@toshiba-tops.co.jp>
	<20010908013638.A19154@dea.linux-mips.net>
	<20010910.114402.41626914.nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Mon, 10 Sep 2001 11:44:02 +0900 (JST), Atsushi Nemoto <nemoto@toshiba-tops.co.jp> said:
ralf> Nice test case.  Thanks. I decied for a differnet fix attached
ralf> below.

nemoto> I think your fix is good for Coprocessor Unusable exception.
nemoto> And same fix required for Trap or Breakpoint exception.  (Am I
nemoto> right?)

nemoto> But, does not a debugger confused by skipping the instruction
nemoto> which cause Trap or Breakpoint exception?  (I do not know much
nemoto> about communication between kernel and debugger...)

I tried same fix for Trap exception (I inserted compute_return_epc()
before force_sig(SIGTRAP, current) line in do_tr()).  With this fix,
gdb did not work correctly.

So we should take another fix (at least for Trap exception) ?

---
Atsushi Nemoto
