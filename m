Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3P5P3wJ006333
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 22:25:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3P5P3mG006332
	for linux-mips-outgoing; Wed, 24 Apr 2002 22:25:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3P5P0wJ006327
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 22:25:00 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [128.167.58.27]) with SMTP; 25 Apr 2002 05:25:29 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id E6EAEB471; Thu, 25 Apr 2002 14:25:26 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id OAA91327; Thu, 25 Apr 2002 14:25:26 +0900 (JST)
Date: Thu, 25 Apr 2002 14:25:18 +0900 (JST)
Message-Id: <20020425.142518.85417141.nemoto@toshiba-tops.co.jp>
To: jsun@mvista.com
Cc: turcotte@broadcom.com, linux-mips@oss.sgi.com, mturc@broadcom.com
Subject: Re: Linux Shared Memory Issue
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <3CC72BA3.90600@mvista.com>
References: <NDBBKEAAOJECIDBJKLIHOEDDCDAA.turcotte@broadcom.com>
	<3CC72BA3.90600@mvista.com>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 24 Apr 2002 15:03:15 -0700, Jun Sun <jsun@mvista.com> said:
jsun> Looks like the infamous cache aliasing problem.  Steve
jsun> Longerbeam had a patch which may help.  Please try it and let me
jsun> know the results.

jsun> +#define COLOUR_ALIGN(addr)    (((addr)+SHMLBA-1)&~(SHMLBA-1))

Recent sparc64's COLOUR_ALIGN macro have pgoff argument like this.
We should do it same way for MIPS?

#define COLOUR_ALIGN(addr,pgoff)		\
	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))

Thank you.
---
Atsushi Nemoto
