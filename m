Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9R4A7o26382
	for linux-mips-outgoing; Fri, 26 Oct 2001 21:10:07 -0700
Received: from dea.linux-mips.net (a1as06-p216.stg.tli.de [195.252.187.216])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9R49x026365
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 21:10:00 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9R49tI24164
	for linux-mips@oss.sgi.com; Sat, 27 Oct 2001 06:09:55 +0200
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9QDrJ007192
	for <linux-mips@oss.sgi.com>; Fri, 26 Oct 2001 06:53:20 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 26 Oct 2001 13:53:19 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id E5681B485; Fri, 26 Oct 2001 22:53:17 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id WAA24731; Fri, 26 Oct 2001 22:53:17 +0900 (JST)
Date: Fri, 26 Oct 2001 22:58:06 +0900 (JST)
Message-Id: <20011026.225806.63990588.nemoto@toshiba-tops.co.jp>
To: ajob4me@21cn.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp>
References: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Fri, 26 Oct 2001 17:49:26 +0800, 8route <ajob4me@21cn.com> said:
ajob4me>   I'm working on Toshiba TX3927 RISC Processor Reference
ajob4me> board.During development I met a problem.Can someone give me
ajob4me> some good suggestions?
...
ajob4me> and the reset switch on the TX3927 board cann't work anymore.

I have seen TX39 dead on "cfc1" insturuction if STATUS.CU1 bit
enabled.  Such codes were in arch/mips/kernel/process.c.

---
Atsushi Nemoto
