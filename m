Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8E2Bxb19665
	for linux-mips-outgoing; Thu, 13 Sep 2001 19:11:59 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8E2Bre19662;
	Thu, 13 Sep 2001 19:11:54 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 14 Sep 2001 02:11:53 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 1ACF1B460; Fri, 14 Sep 2001 11:11:51 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA84657; Fri, 14 Sep 2001 11:11:47 +0900 (JST)
Date: Fri, 14 Sep 2001 11:16:32 +0900 (JST)
Message-Id: <20010914.111632.41627160.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: setup_frame() failure
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010913031119.B27168@dea.linux-mips.net>
References: <20010910.114402.41626914.nemoto@toshiba-tops.co.jp>
	<20010912.130914.112630116.nemoto@toshiba-tops.co.jp>
	<20010913031119.B27168@dea.linux-mips.net>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Thu, 13 Sep 2001 03:11:19 +0200, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> The actual fix should be skipping over the faulting instruction
ralf> when returning from the signal handler.

Since the signal handler may want to know the faulting instruction,
the "skipping" should be done AFTER the returning from the handler.
On the other hand, the handler may do the "skipping" by itself...

The symptom I reported first ("the process can not be killd by
SIGKILL") does not occur if the signal handler executed successfully
because do_signal() will be called when returning from sys_sygreturn.
The symptom occur if setup_frame() failed.  So I still think there is
a point to check a failure of setup_frame().

---
Atsushi Nemoto
