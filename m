Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1LCuZj10282
	for linux-mips-outgoing; Thu, 21 Feb 2002 04:56:35 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1LCuU910227
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 04:56:30 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 21 Feb 2002 11:56:30 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id AE931B46B; Thu, 21 Feb 2002 20:56:28 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id UAA70757; Thu, 21 Feb 2002 20:56:28 +0900 (JST)
Date: Thu, 21 Feb 2002 21:00:52 +0900 (JST)
Message-Id: <20020221.210052.38718643.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: jgg@debian.org, kevink@mips.com, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <Pine.GSO.3.96.1020215203113.29773Q-100000@delta.ds2.pg.gda.pl>
References: <Pine.LNX.3.96.1020215104857.10921A-100000@wakko.debian.net>
	<Pine.GSO.3.96.1020215203113.29773Q-100000@delta.ds2.pg.gda.pl>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Fri, 15 Feb 2002 20:39:09 +0100 (MET), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
macro>  Well, the "classic" MIPS R2020 and R3220 ones would break PCI
macro> (or actually any I/O) ordering semantics as they return data
macro> from a posted write upon a hit.  The affected read never
macro> appears at the I/O bus in that case.  They never reorder writes
macro> though, as they work as FIFOs (the former is four stage deep
macro> and the latter is six stage deep), so wmb() may be null for
macro> them.

macro>  I've read a suggestion a "bc0f" might be needed for the TX39's
macro> write buffer as a barrier.  That means the buffer behaves as
macro> the "classic" ones.

As I wrote in another mail, TX39's uncached load does NOT return data
from a write buffer.  Uncached load/store always appears on I/O bus in
same order.

The problem of TX39's write buffer is that cached load/store operation
can overtake preceding uncached store operation (even if "SYNC" was
exist between these operations).

---
Atsushi Nemoto
