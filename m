Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1M3WIw18895
	for linux-mips-outgoing; Thu, 21 Feb 2002 19:32:18 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1M3WC918892
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 19:32:13 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [216.32.174.27]) with SMTP; 22 Feb 2002 02:32:12 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 5D24EB474; Fri, 22 Feb 2002 11:32:10 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA72359; Fri, 22 Feb 2002 11:32:10 +0900 (JST)
Date: Fri, 22 Feb 2002 11:36:34 +0900 (JST)
Message-Id: <20020222.113634.45519920.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: kevink@mips.com, mdharm@momenco.com, ralf@uni-koblenz.de,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <Pine.GSO.3.96.1020221143103.1033G-100000@delta.ds2.pg.gda.pl>
References: <20020221.204120.102764790.nemoto@toshiba-tops.co.jp>
	<Pine.GSO.3.96.1020221143103.1033G-100000@delta.ds2.pg.gda.pl>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Thu, 21 Feb 2002 15:12:43 +0100 (MET), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
macro>  With respect to cache refills (what is already cached is
macro> irrelevant, obviously, as read accesse to it don't appear
macro> externally), "32-bit RISC Microprocessor TX39 Family Core
macro> Architecture User's Manual" seems to contradict.  In the
macro> description of the "sync" instruction it states:

macro> "Interlocks the pipeline until the load, store or data cache
macro> refill operation of the previous instruction is completed.  The
macro> R3900 Processor Core can continue processing instructions
macro> following a load instruction even if a cache refill is caused
macro> by the load instruction or a load is made from a noncacheable
macro> area.  Executing a SYNC instruction interlocks subsequent
macro> instructions until the SYNC instruction execution is completed.
macro> This ensures that the instructions following a load instruction
macro> are executed in the proper sequence."

The contradiction is came from some confusion about usage of a word
"Core" in TX39 manual.  Maybe a writer of the quoted statements
assumes a write buffer is outside of a "R3900 Processor Core".  So if
he said "operation is completed" it means "data are sent to a write
buffer".  Of course this point of view is not acceptable for software
programmers...

macro> It's clear "sync" is strong on the TX39, stronger then required
macro> by MIPS II.

So unfortunately this is not true.

---
Atsushi Nemoto
