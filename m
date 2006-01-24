Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 19:50:22 +0000 (GMT)
Received: from smtp.gentoo.org ([134.68.220.30]:62172 "EHLO smtp.gentoo.org")
	by ftp.linux-mips.org with ESMTP id S8133543AbWAXTuF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2006 19:50:05 +0000
Received: from kumba by smtp.gentoo.org with local (Exim 4.54)
	id 1F1UF9-0001GK-Pz
	for linux-mips@linux-mips.org; Tue, 24 Jan 2006 19:54:19 +0000
Date:	Tue, 24 Jan 2006 19:54:19 +0000
From:	Kumba <kumba@gentoo.org>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Add byteorder/endianess to /proc/cpuinfo
Message-ID: <20060124195419.GB24568@toucan.gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adds an additional field to /proc/cpuinfo that states the byteorder
of the system.  This has been floating around for some time on the
list, so maybe this time is the charm.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---

 proc.c |    5 +++++
 1 file changed, 5 insertions(+)


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="add-byteorder-to-proc.patch"

diff -Naurp mipslinux/arch/mips/kernel/proc.c mipslinux-byteorder/arch/mips/kernel/proc.c
--- mipslinux/arch/mips/kernel/proc.c	2006-01-22 21:14:11.000000000 -0500
+++ mipslinux-byteorder/arch/mips/kernel/proc.c	2006-01-24 13:39:47.000000000 -0500
@@ -114,6 +114,11 @@ static int show_cpuinfo(struct seq_file 
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

--dc+cDN39EJAMEtIO--
