Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBDI1Zo14453
	for linux-mips-outgoing; Thu, 13 Dec 2001 10:01:35 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBDI1Lo14447
	for <linux-mips@oss.sgi.com>; Thu, 13 Dec 2001 10:01:23 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id 04CA9590A9; Thu, 13 Dec 2001 11:59:33 -0500 (EST)
Message-ID: <06c701c183f7$d23eb410$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Florian Lohoff" <flo@rfc822.org>, <linux-mips@oss.sgi.com>
References: <20011213163953.GB23023@paradigm.rfc822.org>
Subject: Re: [PATCH] /proc/cpuinfo endianess (autoconf dependencie)
Date: Thu, 13 Dec 2001 12:01:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

For autoconf?  Why need to ask the kernel?  Aren't there other very simple
ways of determining build endianness in userspace?

Regards,
Brad

----- Original Message -----
From: "Florian Lohoff" <flo@rfc822.org>
To: <linux-mips@oss.sgi.com>
Sent: Thursday, December 13, 2001 11:39 AM
Subject: [PATCH] /proc/cpuinfo endianess (autoconf dependencie)

Something like this should be needed for current kernel to make
autoconf happy ...

--- arch/mips/kernel/proc.c 2001/12/12 13:45:58 1.27.2.3
+++ arch/mips/kernel/proc.c 2001/12/13 17:39:19
@@ -51,6 +51,11 @@
  seq_printf(m, "BogoMIPS\t\t: %lu.%02lu\n",
                loops_per_jiffy / (500000/HZ),
                (loops_per_jiffy / (5000/HZ)) % 100);
+#ifdef __MIBSEB__
+ seq_printf(m, "byteorder\t\t: big endian\n");
+#else
+ seq_printf(m, "byteorder\t\t: little endian\n");
+#endif
  seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
  seq_printf(m, "microsecond timers\t: %s\n",
                (mips_cpu.options & MIPS_CPU_COUNTER) ? "yes" : "no");
