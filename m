Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f86ACMG13236
	for linux-mips-outgoing; Thu, 6 Sep 2001 03:12:22 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f86ACHd13233;
	Thu, 6 Sep 2001 03:12:17 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 6 Sep 2001 10:12:17 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id A282CB458; Thu,  6 Sep 2001 19:12:10 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id TAA62330; Thu, 6 Sep 2001 19:12:07 +0900 (JST)
Date: Thu, 06 Sep 2001 19:16:39 +0900 (JST)
Message-Id: <20010906.191639.88494133.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: ret_from_sys_call and signal
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010905220300.A7552@dea.linux-mips.net>
References: <20010831.152310.104026325.nemoto@toshiba-tops.co.jp>
	<20010905220300.A7552@dea.linux-mips.net>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 5 Sep 2001 22:03:00 +0200, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> The changes in entry.S and scall_o32.S were correct; they match the
ralf> changing in the i386 code.  The idea is to avoid the usermode check if
ralf> possible.  I just lost the matching changes to other files.  Untested
ralf> patch below.  Tell me if it helps.

I tried the patch with r4k CPU.  It works fine for me.  Thanks.

---
Atsushi Nemoto
