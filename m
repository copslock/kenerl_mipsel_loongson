Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 22:40:13 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:12769 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S3458470AbWAWWj4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 22:39:56 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F1APu-0007Oo-3Y
	for linux-mips@linux-mips.org; Mon, 23 Jan 2006 22:44:06 +0000
Date:	Mon, 23 Jan 2006 22:44:06 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: [PATCH]: Add byteorder/endianess to /proc/cpuinfo
Message-ID: <20060123224406.GG499@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PyMzGVE0NRonI6bs"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is a patch we've been using for some time (originally posted to this list some time ago) which adds the 
byteorder output to /proc/cpuinfo.

i.e.:

byteorder               : big endian

or 

byteorder               : little endian



--Kumba


--
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands do them because they must, while the
eyes of the great are elsewhere." --Elrond



--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="misc-2.6.11-add-byteorder-to-proc.patch"

## 11_byteorder-proc.dpatch by ???
##
## All lines beginning with `## DP:' are a description of the patch.
## DP: Add byteorder info to /proc/cpuinfo

Index: arch/mips/kernel/proc.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/proc.c,v
retrieving revision 1.27.2.17
diff -u -p -u -r1.27.2.17 proc.c
--- arch/mips/kernel/proc.c	27 Apr 2003 23:34:46 -0000	1.27.2.17
+++ arch/mips/kernel/proc.c	21 Sep 2003 00:14:13 -0000
@@ -100,6 +100,11 @@ static int show_cpuinfo(struct seq_file 
 	seq_printf(m, "BogoMIPS\t\t: %lu.%02lu\n",
 	              cpu_data[n].udelay_val / (500000/HZ),
 	              (cpu_data[n].udelay_val / (5000/HZ)) % 100);
+#ifdef __MIPSEB__
+	seq_printf(m, "byteorder\t\t: big endian\n");
+#else
+	seq_printf(m, "byteorder\t\t: little endian\n");
+#endif
 	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
 	seq_printf(m, "microsecond timers\t: %s\n",
 	              cpu_has_counter ? "yes" : "no");

--PyMzGVE0NRonI6bs--
