Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9Q1X6L25286
	for linux-mips-outgoing; Thu, 25 Oct 2001 18:33:06 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9Q1Ws025275;
	Thu, 25 Oct 2001 18:32:54 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 26 Oct 2001 01:32:54 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 7AC3FB46B; Fri, 26 Oct 2001 10:32:52 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id KAA22743; Fri, 26 Oct 2001 10:32:52 +0900 (JST)
Date: Fri, 26 Oct 2001 10:37:41 +0900 (JST)
Message-Id: <20011026.103741.41627158.nemoto@toshiba-tops.co.jp>
To: jsimmons@transvirtual.com
Cc: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: [PATCH] Various diffs that fix things.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <Pine.LNX.4.10.10110251019420.8950-100000@transvirtual.com>
	<Pine.LNX.4.10.10110251038060.8950-100000@transvirtual.com>
References: <Pine.LNX.4.10.10110251019420.8950-100000@transvirtual.com>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Thu, 25 Oct 2001 10:30:28 -0700 (PDT), James Simmons <jsimmons@transvirtual.com> said:
jsimmons> --- /tmp/linux-sgi/include/asm-mips/processor.h	Fri Oct 19 13:51:06 2001
jsimmons> +++ processor.h	Thu Oct 25 10:15:24 2001

Sorry, this is my fault.  Your patch is correct.

>>>>> On Thu, 25 Oct 2001 10:39:17 -0700 (PDT), James Simmons <jsimmons@transvirtual.com> said:
jsimmons> I get the following errors when compiling. It barfs at
jsimmons> mips/kernel/setup.c.  I would send you a patch but I don't
jsimmons> know what values you want to set these to.

This is my fault too.  Please apply this patch.  Thank you.

diff -urP -x CVS -x .cvsignore linux-sgi-cvs/include/asm-mips/cpu.h linux.new/include/asm-mips/cpu.h
--- linux-sgi-cvs/include/asm-mips/cpu.h	Mon Oct 22 10:30:09 2001
+++ linux.new/include/asm-mips/cpu.h	Fri Oct 26 10:31:19 2001
@@ -55,6 +55,7 @@
 #define PRID_IMP_R4640		0x2200
 #define PRID_IMP_R4650		0x2200		/* Same as R4640 */
 #define PRID_IMP_R5000		0x2300
+#define PRID_IMP_TX49		0x2d00
 #define PRID_IMP_SONIC		0x2400
 #define PRID_IMP_MAGIC		0x2500
 #define PRID_IMP_RM7000		0x2700
@@ -87,6 +88,12 @@
 #define PRID_REV_TX3912 	0x0010
 #define PRID_REV_TX3922 	0x0030
 #define PRID_REV_TX3927 	0x0040
+#define PRID_REV_TX3927B 	0x0041
+#define PRID_REV_TX39H3TEG 	0x0050
+#define PRID_REV_TX4955		0x0011
+#define PRID_REV_TX4955A	0x0020
+#define PRID_REV_TX4927		0x0021
+#define PRID_REV_TX4927R2	0x0022
 
 #ifndef  _LANGUAGE_ASSEMBLY
 /*
---
Atsushi Nemoto
