Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1LCb3825969
	for linux-mips-outgoing; Thu, 21 Feb 2002 04:37:03 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1LCaw925940
	for <linux-mips@oss.sgi.com>; Thu, 21 Feb 2002 04:36:58 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 21 Feb 2002 11:36:58 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 6087BB46B; Thu, 21 Feb 2002 20:36:56 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id UAA70710; Thu, 21 Feb 2002 20:36:56 +0900 (JST)
Date: Thu, 21 Feb 2002 20:41:20 +0900 (JST)
Message-Id: <20020221.204120.102764790.nemoto@toshiba-tops.co.jp>
To: macro@ds2.pg.gda.pl
Cc: kevink@mips.com, mdharm@momenco.com, ralf@uni-koblenz.de,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <Pine.GSO.3.96.1020215125744.29773B-100000@delta.ds2.pg.gda.pl>
References: <20020215.123124.70226832.nemoto@toshiba-tops.co.jp>
	<Pine.GSO.3.96.1020215125744.29773B-100000@delta.ds2.pg.gda.pl>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Fri, 15 Feb 2002 13:08:20 +0100 (MET), "Maciej W. Rozycki" <macro@ds2.pg.gda.pl> said:
macro> IOW, two consecutive writes separated by a "sync" need not
macro> imply a write-back, but as soon as a read happens a preceding
macro> write-back is a must.

TX39 satisfy this on uncached load/store.  "sync" does not flush a
write buffer, but any uncached load are executed AFTER completion of
pending uncached store.  On combination of cached and uncached
operation, TX39 does not satisfy this order.

macro>  It sounds weird: it looks like "sync" is useless and basically
macro> a "nop".

TX39 has a function called "non-blocking load".  This function is
described on chapter 4.4 of TX39/H2 manual.  "sync" operation is
meaningful with this function.

macro> If this is the case the processors need their own wbflush()
macro> implementation.  Can you point to specific chapters of
macro> specifications that document it?

Chapter 4.9.4 in TX39/H2 Japanese manual describes write buffer.  But
I could not find it in the English manual...

---
Atsushi Nemoto
