Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1F4R5g06669
	for linux-mips-outgoing; Thu, 14 Feb 2002 20:27:05 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1F4R1906666
	for <linux-mips@oss.sgi.com>; Thu, 14 Feb 2002 20:27:02 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 15 Feb 2002 03:27:01 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 2653AB46B; Fri, 15 Feb 2002 12:26:59 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA50808; Fri, 15 Feb 2002 12:26:58 +0900 (JST)
Date: Fri, 15 Feb 2002 12:31:24 +0900 (JST)
Message-Id: <20020215.123124.70226832.nemoto@toshiba-tops.co.jp>
To: kevink@mips.com
Cc: macro@ds2.pg.gda.pl, mdharm@momenco.com, ralf@uni-koblenz.de,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20020213.102805.74755945.nemoto@toshiba-tops.co.jp>
References: <Pine.GSO.3.96.1020212123901.17858B-100000@delta.ds2.pg.gda.pl>
	<010601c1b3bd$1da618e0$0deca8c0@Ulysses>
	<20020213.102805.74755945.nemoto@toshiba-tops.co.jp>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 13 Feb 2002 10:28:05 +0900 (JST), Atsushi Nemoto <nemoto@toshiba-tops.co.jp> said:
nemoto> TX39/H2 also have a write buffer but TX39/H does not.

Sorry, this is wrong.  TX39/H also have a write buffer.

Note that SYNC on TX39/H and TX39/H2 does not flush a write buffer.
Some operation (for example, bc0f loop) are required to flush a write
buffer.

---
Atsushi Nemoto
