Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1D2NdY32095
	for linux-mips-outgoing; Tue, 12 Feb 2002 18:23:39 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1D2Na932091
	for <linux-mips@oss.sgi.com>; Tue, 12 Feb 2002 18:23:36 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 13 Feb 2002 01:23:36 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id EF68EB46B; Wed, 13 Feb 2002 10:23:33 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id KAA44828; Wed, 13 Feb 2002 10:23:33 +0900 (JST)
Date: Wed, 13 Feb 2002 10:28:05 +0900 (JST)
Message-Id: <20020213.102805.74755945.nemoto@toshiba-tops.co.jp>
To: kevink@mips.com
Cc: macro@ds2.pg.gda.pl, mdharm@momenco.com, ralf@uni-koblenz.de,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <010601c1b3bd$1da618e0$0deca8c0@Ulysses>
References: <Pine.GSO.3.96.1020212123901.17858B-100000@delta.ds2.pg.gda.pl>
	<010601c1b3bd$1da618e0$0deca8c0@Ulysses>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Tue, 12 Feb 2002 13:02:13 +0100, "Kevin D. Kissell" <kevink@mips.com> said:
kevink> According to the (rather old) Tx39xx specs at my disposal,
kevink> those parts should also support the SYNC instruction.  Does
kevink> anyone know for a fact that some of them do not?

There are two types of TX39: TX39/H and TX39/H2.

To my knowledge, both TX39/H (3904, 3912, etc.) and TX39/H2 (3922,
3927, etc.) have then SYNC instruction.

TX39/H2 also have a write buffer but TX39/H does not.

---
Atsushi Nemoto
