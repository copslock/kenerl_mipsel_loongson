Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57Hc9P29260
	for linux-mips-outgoing; Thu, 7 Jun 2001 10:38:09 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57Hc8h29257
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 10:38:08 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id B9E71125BA; Thu,  7 Jun 2001 10:38:07 -0700 (PDT)
Date: Thu, 7 Jun 2001 10:38:07 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Patch: Fix gas/mips testsuite for linux/mips
Message-ID: <20010607103807.A14754@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Since linux/mips is switched to stabs, line number is not longer
supported. I checked in the following patch.

H.J.
----
2001-06-07  H.J. Lu  <hjl@gnu.org>

	* gas/mips/mips.exp: Set xfail for "lineno" on Linux/mips.

Index: gas/mips/mips.exp
===================================================================
RCS file: /cvs/src/src/gas/testsuite/gas/mips/mips.exp,v
retrieving revision 1.10
diff -u -p -r1.10 mips.exp
--- mips.exp	2001/06/07 00:57:10	1.10
+++ mips.exp	2001/06/07 17:16:29
@@ -88,6 +88,8 @@ if { [istarget mips*-*-*] } then {
     run_dump_test "mips4010"
     run_dump_test "mips4650"
     run_dump_test "mips4100"
+    # Linux uses ELF stabs, which doesn't support line number.
+    setup_xfail "mips*-*-*linux*"
     run_dump_test "lineno"
     run_dump_test "sync"
     run_dump_test "mips32"
