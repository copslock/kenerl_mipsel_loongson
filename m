Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7O92Ci08204
	for linux-mips-outgoing; Fri, 24 Aug 2001 02:02:12 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7O91xd08199;
	Fri, 24 Aug 2001 02:02:00 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 24 Aug 2001 09:01:59 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id EDFA354C16; Fri, 24 Aug 2001 18:01:57 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id SAA91181; Fri, 24 Aug 2001 18:01:56 +0900 (JST)
Date: Fri, 24 Aug 2001 18:06:32 +0900 (JST)
Message-Id: <20010824.180632.39150208.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: carstenl@mips.com, wgowcher@yahoo.com, linux-mips@oss.sgi.com
Subject: Re: Benchmark performance
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010816131422.B17970@bacchus.dhis.org>
References: <20010816111803.A17469@bacchus.dhis.org>
	<3B7BA970.56192BB8@mips.com>
	<20010816131422.B17970@bacchus.dhis.org>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Thu, 16 Aug 2001 13:14:22 +0200, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> I'm just about to put it into CVS.

Please apply this small patch...

--- linux.sgi/arch/mips/math-emu/cp1emu.c	Fri Aug 24 17:57:36 2001
+++ linux/arch/mips/math-emu/cp1emu.c	Fri Aug 24 17:57:48 2001
@@ -1675,7 +1675,7 @@
 	oldepc = xcp->cp0_epc;
 	do {
 		if (current->need_resched)
-			schedule;
+			schedule();
 
 		prevepc = xcp->cp0_epc;
 		insn = mips_get_word(xcp, REG_TO_VA(xcp->cp0_epc), &err);
---
Atsushi Nemoto
