Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3Q3AwwJ000718
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Apr 2002 20:10:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3Q3AwN3000717
	for linux-mips-outgoing; Thu, 25 Apr 2002 20:10:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3Q3ArwJ000713
	for <linux-mips@oss.sgi.com>; Thu, 25 Apr 2002 20:10:54 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [128.167.58.27]) with SMTP; 26 Apr 2002 03:11:26 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id C667EB474; Fri, 26 Apr 2002 12:11:15 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA94452; Fri, 26 Apr 2002 12:11:15 +0900 (JST)
Date: Fri, 26 Apr 2002 12:11:07 +0900 (JST)
Message-Id: <20020426.121107.126571593.nemoto@toshiba-tops.co.jp>
To: jsun@mvista.com
Cc: turcotte@broadcom.com, linux-mips@oss.sgi.com, mturc@broadcom.com
Subject: Re: Linux Shared Memory Issue
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <3CC84EEC.8060100@mvista.com>
References: <3CC72BA3.90600@mvista.com>
	<20020425.142518.85417141.nemoto@toshiba-tops.co.jp>
	<3CC84EEC.8060100@mvista.com>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Thu, 25 Apr 2002 11:46:04 -0700, Jun Sun <jsun@mvista.com> said:
>> #define COLOUR_ALIGN(addr,pgoff) \ ((((addr)+SHMLBA-1)&~(SHMLBA-1))
>> + \ (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))

jsun> What is the purpose of adding the pgoff part?  To avoid mapping
jsun> all shared regions into the beginning of cache?

I suppose so.  For example, mmapping offset 0x1000 of /dev/kmem will
return 0xXXXX0000 address if we ignore pgoff.  This can cause aliasing
problem with KSEG0 address (0x80001000).  Adding pgoff, mmap will
return 0xXXXX1000.

In case of IPC shm, pgoff is always 0 so this change does not effect.

---
Atsushi Nemoto
