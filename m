Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9V4o7M21163
	for linux-mips-outgoing; Tue, 30 Oct 2001 20:50:07 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9V4o2021157;
	Tue, 30 Oct 2001 20:50:02 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 31 Oct 2001 04:50:02 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 7516AB46D; Wed, 31 Oct 2001 13:50:01 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id NAA39000; Wed, 31 Oct 2001 13:50:01 +0900 (JST)
Date: Wed, 31 Oct 2001 13:54:49 +0900 (JST)
Message-Id: <20011031.135449.21587564.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: small fix for gdb
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

in gdb-low.S, "mfc1" (not "cfc1") is used to get CP1 status/revision.
Here is a patch.

--- linux-sgi-cvs/arch/mips/kernel/gdb-low.S	Fri Oct 26 10:39:13 2001
+++ linux.new/arch/mips/kernel/gdb-low.S	Wed Oct 31 13:44:52 2001
@@ -145,9 +145,9 @@
  * FPU control registers
  */
 
-		mfc1	v0,CP1_STATUS
+		cfc1	v0,CP1_STATUS
 		sw	v0,GDB_FR_FSR(sp)
-		mfc1	v0,CP1_REVISION
+		cfc1	v0,CP1_REVISION
 		sw	v0,GDB_FR_FIR(sp)
 
 /*
---
Atsushi Nemoto
