Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8A2dWw03020
	for linux-mips-outgoing; Sun, 9 Sep 2001 19:39:32 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8A2dQd03017;
	Sun, 9 Sep 2001 19:39:26 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 10 Sep 2001 02:39:26 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 92959B458; Mon, 10 Sep 2001 11:39:21 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA74331; Mon, 10 Sep 2001 11:39:18 +0900 (JST)
Date: Mon, 10 Sep 2001 11:44:02 +0900 (JST)
Message-Id: <20010910.114402.41626914.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: setup_frame() failure
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010908013638.A19154@dea.linux-mips.net>
References: <20010907.202652.71083122.nemoto@toshiba-tops.co.jp>
	<20010908013638.A19154@dea.linux-mips.net>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Sat, 8 Sep 2001 01:36:38 +0200, Ralf Baechle <ralf@oss.sgi.com> said:
>> I make a change for do_signal() to check failure of setup_frame()
>> and continue processing pending signals.  It seems work for me.
>> Here is the patch.  Any comments are welcome.

ralf> Nice test case.  Thanks. I decied for a differnet fix attached
ralf> below.

I think your fix is good for Coprocessor Unusable exception.  And same
fix required for Trap or Breakpoint exception.  (Am I right?)

But, does not a debugger confused by skipping the instruction which
cause Trap or Breakpoint exception?  (I do not know much about
communication between kernel and debugger...)

---
Atsushi Nemoto
