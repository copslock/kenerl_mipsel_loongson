Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6IrFR26523
	for linux-mips-outgoing; Thu, 6 Dec 2001 10:53:15 -0800
Received: from ocean.lucon.org ([12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB6IrCo26519
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 10:53:12 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 88F80125C1; Thu,  6 Dec 2001 09:53:10 -0800 (PST)
Date: Thu, 6 Dec 2001 09:53:10 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Why is byteorder removed from /proc/cpuinfo?
Message-ID: <20011206095310.A6933@lucon.org>
References: <20011206093506.A6496@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206093506.A6496@lucon.org>; from hjl@lucon.org on Thu, Dec 06, 2001 at 09:35:06AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 06, 2001 at 09:35:06AM -0800, H . J . Lu wrote:
> The byteorder field is emoved from /proc/cpuinfo in the current 2.4
> kernel in CVS. It breaks config.guess used by all the GNU softwares.
> 
> 

Here is a patch.

H.J.
----
--- arch/mips/kernel/proc.c.endian	Wed Dec  5 08:02:53 2001
+++ arch/mips/kernel/proc.c	Thu Dec  6 09:41:35 2001
@@ -42,6 +42,12 @@ static int show_cpuinfo(struct seq_file 
 	                            mips_cpu.cputype : CPU_UNKNOWN],
 	                           (version >> 4) & 0x0f, version & 0x0f,
 	                           (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
+#if __BIG_ENDIAN
+	seq_printf(m, "byteorder\t\t: big endian\n");
+#endif
+#if __LITTLE_ENDIAN
+	seq_printf(m, "byteorder\t\t: little endian\n");
+#endif
 	seq_printf(m, "BogoMIPS\t\t: %lu.%02lu\n",
 	              (loops_per_jiffy + 2500) / (500000/HZ),
 	              ((loops_per_jiffy + 2500) / (5000/HZ)) % 100);
