Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 00:17:46 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:3571 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225204AbUJUXRh>; Fri, 22 Oct 2004 00:17:37 +0100
Received: from prometheus.mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 096EB1853F; Thu, 21 Oct 2004 16:17:35 -0700 (PDT)
Subject: [PATCH]64-bit PMC yosemite support in 2.6
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.mvista.com
Content-Type: text/plain
Organization: 
Message-Id: <1098400654.4266.32.camel@prometheus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Oct 2004 16:17:35 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Ralf

Attached patch implements 64-bit changes to PMC yosemite board. Please
review 

Thanks
Manish Lachwani

--- arch/mips/pmc-sierra/yosemite/prom.c.orig	2004-10-21
16:02:20.000000000 -0700
+++ arch/mips/pmc-sierra/yosemite/prom.c	2004-10-21 16:07:27.000000000
-0700
@@ -61,6 +61,53 @@
 	prom_cpu0_exit(NULL);
 }
 
+#ifdef CONFIG_MIPS64
+unsigned long signext(unsigned long addr)
+{
+	addr &= 0xffffffff;
+	return (unsigned long)((int)addr);
+}
+
+void *get_arg(unsigned long args, int arc)
+{
+	unsigned long ul;
+	unsigned char *puc, uc;
+
+	args += (arc * 4);
+	ul = (unsigned long)signext(args);
+	puc = (unsigned char *)ul;
+
+	if (puc == 0)
+		return (void *)0;
+
+	/* Big Endian support only */
+	uc = *puc++;
+	ul = ((unsigned long)uc) << 24;
+
+	uc = *puc++;
+	ul |= (((unsigned long)uc) << 16);
+
+	uc = *puc++;
+	ul |= (((unsigned long)uc) << 8);
+
+	uc = *puc++;
+	ul |= ((unsigned long)uc);
+
+	ul = signext(ul);
+	return (void *)ul;
+}
+
+char *arg64(unsigned long addrin, int arg_index)
+{
+	unsigned long args;
+	char *p;
+	args = signext(addrin);
+
+	p = (char *)get_arg(args, arg_index);
+	return p;
+}
+#endif /* CONFIG_MIPS64 */
+
 /*
  * Halt the system
  */
@@ -123,9 +170,56 @@
 #endif /* CONFIG_MIPS32 */
 
 #ifdef CONFIG_MIPS64
+	char *ptr;
+	
+	printk("MIPS 64-bit support for PMC-Sierra Yosemite \n");
+	debug_vectors = (struct callvectors *)signext((unsigned long)cv);
+	arcs_cmdline[0] = '\0';
+	
+	for (i = 1; i < argc; i++) {
+		ptr = (char *)arg64((unsigned long)arg, i);
+		if ((strlen(arcs_cmdline) + strlen(ptr) + 1) >=
+			sizeof(arcs_cmdline))
+				break;
 
-	/* Do nothing for the 64-bit for now. Just implement for the 32-bit */
+		strcat(arcs_cmdline, ptr);
+		strcat(arcs_cmdline, " ");
+	}
 
+	i = 0;
+	while (1) {
+		ptr = (char *)arg64((unsigned long)env, i);
+		if (! ptr)
+			break;
+
+		/* Yosemite OCD base */
+		if (strncmp("yosemite_base", ptr, strlen("yosemite_base")) == 0) {
+			yosemite_base = simple_strtol(ptr + strlen("yosemite_base"),
+							NULL, 16);
+			
+			if ((yosemite_base & 0xffffffff00000000) == 0)
+				yosemite_base = 0xfffffffffb000000;
+
+			printk("yosemite_base is set to 0x%016lx\n", yosemite_base);
+		}
+
+		/* Rm9000 CPU Clock */
+		if (strncmp("cpuclock", ptr, strlen("cpuclock")) == 0) {
+			cpu_clock = simple_strtol(ptr + strlen("cpuclock="),
+						NULL, 10);
+
+			printk("cpu_clock set to %d\n", cpu_clock);
+		}
+
+		/* Yosemite memory size */
+		if (strncmp("memsize", *env, strlen("memsize")) == 0) {
+			memory_size =
+				simple_strtol(*env + strlen("memsize="), NULL,
+						4);
+		}
+
+		i++;
+	}
 #endif /* CONFIG_MIPS64 */
 
 	mips_machgroup = MACH_GROUP_TITAN;
