Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OD2mT09102
	for linux-mips-outgoing; Wed, 24 Oct 2001 06:02:48 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OD2gD09097;
	Wed, 24 Oct 2001 06:02:42 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 24 Oct 2001 13:02:42 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 45B0DB46B; Wed, 24 Oct 2001 22:02:40 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id WAA18541; Wed, 24 Oct 2001 22:02:40 +0900 (JST)
Date: Wed, 24 Oct 2001 22:07:29 +0900 (JST)
Message-Id: <20011024.220729.39150004.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: pmanolov@Lnxw.COM, linux-mips@oss.sgi.com
Subject: Re: Malta probs
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011024024308.A21460@dea.linux-mips.net>
References: <20011023224718.A6283@dea.linux-mips.net>
	<3BD5E193.BB41A907@lnxw.com>
	<20011024024308.A21460@dea.linux-mips.net>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 24 Oct 2001 02:43:08 +0200, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> It wasn't really changed, the whole lump of arch/mips/mm/ was
ralf> just restructured in a way that allows adding of new CPU types
ralf> and - even more important - get the code maintainable again.  As
ralf> it is right now

In current CVS, All handle_xxx exception handler seems to be complied
with ".set mips3".  Here is a patch.  I think this patch solves the
problem reported by Petko.


diff -urP -x CVS -x .cvsignore linux-sgi-cvs/arch/mips/kernel/entry.S linux.new/arch/mips/kernel/entry.S
--- linux-sgi-cvs/arch/mips/kernel/entry.S	Mon Oct 22 10:29:56 2001
+++ linux.new/arch/mips/kernel/entry.S	Wed Oct 24 21:55:16 2001
@@ -180,6 +180,7 @@
 		END(except_vec3_r4000)
 
 		__FINIT
+		.set    mips0
 
 /*
  * Build a default exception handler for the exceptions that don't need
---
Atsushi Nemoto
