Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Nov 2005 02:18:52 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:54797 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8134110AbVKQCSe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 Nov 2005 02:18:34 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 17 Nov 2005 02:21:50 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9A9AC20044;
	Thu, 17 Nov 2005 11:21:45 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8F3951F4C5;
	Thu, 17 Nov 2005 11:21:45 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jAH2LjhO047110;
	Thu, 17 Nov 2005 11:21:45 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 17 Nov 2005 11:21:45 +0900 (JST)
Message-Id: <20051117.112144.108306652.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: cpu_idle and cpu_wait
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051116184201.GJ3229@linux-mips.org>
References: <20051117.011906.25910026.anemo@mba.ocn.ne.jp>
	<20051116184201.GJ3229@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 16 Nov 2005 18:42:01 +0000, Ralf Baechle <ralf@linux-mips.org> said:
>> The CPU can surely exit from the WAIT instruction by interrupt even
>> if interrupts disabled?

ralf> That's implementation dependent behaviour, unfortunately.

I checked some MIPS32/MIPS64 datasheets and found that's really
inplementation-dependent.  The answer is YES on (perhaps) all MIPS4K?
processors but NO on 20Kc, 24K ...

And I checked x86 implemetation and found that HLT or MWAIT
instruction also must be used with interrupts enabled.  So IIUC it
seems x86 have same latency problem too.

---
Atsushi Nemoto
